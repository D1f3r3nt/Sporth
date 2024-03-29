import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/service/service.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final ImagePicker _pickerImage = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleDetailsService _googleDetailsProvider = GoogleDetailsService();
  final ImageService _imageRepository = ImageService();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _ubicacionesController = TextEditingController();
  final TextEditingController _maxPersonasController = TextEditingController();
  final TextEditingController _precioController = TextEditingController(text: '0');
  final TextEditingController _privadoController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  File? _imageFile;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  GeograficoDto? _geo;
  GeograficoDto? _miGeo;
  bool _precio = false;
  bool _privado = false;
  bool _waitingSubida = false;
  bool _waitingLocation = false;

  Future<void> _pickImageFromGallery() async {
    final pickedfile = await _pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) setState(() => _imageFile = File(pickedfile.path));
  }

  Future<void> _pickImageFromCamera() async {
    final pickedfile = await _pickerImage.pickImage(source: ImageSource.camera);
    if (pickedfile != null) setState(() => _imageFile = File(pickedfile.path));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      initialDate: _date,
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _date) setState(() => _date = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) setState(() => _time = picked);
  }

  selectActivity(List<DeportesDto> listDeportes, int index) {
    setState(() {
      for (var element in listDeportes) {
        element.selected = false;
      }
      listDeportes[index].selected = !listDeportes[index].selected;
      
      _maxPersonasController.text = listDeportes[index].players.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final DeportesProvider deportesProvider = Provider.of<DeportesProvider>(
        context);
    final UserRequest currentUser = Provider
        .of<UserProvider>(context)
        .currentUser!;
    final GoogleAutocompleteProvider googleAutocompleteProvider = Provider.of<
        GoogleAutocompleteProvider>(context);
    final PositionService positionProvider = PositionService();
    final List<DeportesDto> listDeportes = deportesProvider.deportesAdd;
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(
        context);
    final AnalyticsUtils analyticsUtils = AnalyticsUtils();

    _dateController.text = DateFormat('dd/MM/yyyy').format(_date);
    _timeController.text =
    '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(
        2, '0')}';

    subirEvento() async {
      if (_formKey.currentState!.validate()) {
        var list = listDeportes.where((element) => element.selected).toList();
        if (list.isEmpty) {
          Snackbar.errorSnackbar(context, 'Ponga un deporte');
        } else {
          setState(() {
            _waitingSubida = true;
          });
          try {
            String imagen = "";
            if (_imageFile != null) {
              imagen = await _imageRepository.uploadFile(_imageFile!);
            } else {
              imagen = list.first.imagen;
            }

            final now = DateTime.now();

            EventRequest evento = EventRequest(
              name: _nombreController.text,
              hora: DateTime(
                  now.year, now.month, now.day, _time.hour, _time.minute),
              dia: _date,
              ubicacion: _ubicacionesController.text,
              precio: double.parse(_precioController.text),
              maximo: int.parse(_maxPersonasController.text),
              deporte: list.first.id,
              imagen: imagen,
              descripcion: _descripcionController.text,
              anfitrion: UserRequest.only(
                  idUser: currentUser.idUser, nacimiento: DateTime.now()),
              participantes: [],
              geo: _geo!,
              privado: _privadoController.text.isEmpty
                  ? null
                  : _privadoController.text,
            );

            await eventosProvider.saveEvent(evento, currentUser);

            analyticsUtils.registerEvent('Event_create', {
              "deporte": list.first.nombre,
              "privado": _privadoController.text,
              "precio": _precioController.text,
            });

            Navigator.pushReplacementNamed(context, HOME);
          } catch (e) {
            Toast.error(e.toString().replaceFirst('Exception: ', ''));
            setState(() {
              _waitingSubida = false;
            });
            return;
          }
        }
        setState(() {
          _waitingSubida = false;
        });
      }
    }

    scrollTo(double position) {
      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }


    atras() {
      Navigator.pushReplacementNamed(context, HOME);
    }

    addImage() =>
        showModalBottomSheet(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (context) {
            return SelectImageBottom(
              onTapCamera: () => _pickImageFromCamera(),
              onTapGallery: () => _pickImageFromGallery(),
            );
          },
        );

    tapLocalizacion() {
      scrollTo(300);
    }

    tapMaxPersonas() {
      scrollTo(450);
    }

    tapDescription() {
      scrollTo(550);
    }

    tapPrecio() {
      scrollTo(650);
    }

    tapPassword() {
      scrollTo(800);
    }

    tapOnAutocomplete(GooglePlaceAutocomplete lugar) async {
      _ubicacionesController.text = lugar.terms[0].value;
      _geo = await _googleDetailsProvider.getData(lugar.placeId);
      googleAutocompleteProvider.cleanData();
    }

    onChangedUbicacion(String value) async {
      _miGeo ??= await positionProvider.getPosition(context);
      googleAutocompleteProvider.getData(value);
    }

    miUbicacion() async {
      setState(() {
        _waitingLocation = true;
      });
      
      _geo = _miGeo ?? await positionProvider.getPosition(context);
      if (_geo == null) {
        setState(() {
          _waitingLocation = false;
        });
        return;
      }
      
      _ubicacionesController.text = await _googleDetailsProvider.getNameByGeolocation(_geo!);
      setState(() {
        _waitingLocation = false;
      });
    }

    String subtitle(List<Term> terms) {
      String text = '';

      for (int i = 1; i < terms.length; i++) {
        text += terms[i].value;
        if (i != terms.length - 1) text += ', ';
      }

      return text;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: EffectUtils.linearBlues,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                width: size.width,
                height: size.height * 0.3,
                child: Container(
                  decoration: _imageFile != null
                      ? BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_imageFile!), fit: BoxFit.cover),
                        )
                      : null,
                  child: GestureDetector(
                    onTap: addImage,
                    child: _imageFile == null
                        ? Column(
                            children: const [
                              SizedBox(height: 45.0),
                              Icon(
                                Icons.add_circle_outline,
                                size: 45,
                              ),
                              Text(
                                'Añadir foto',
                                style: TextUtils.kanit_18_black,
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
              ),
              Positioned(
                left: 5,
                child: PopButton(
                  text: 'Atras',
                  onPressed: atras,
                ),
              ),
              Positioned(
                top: size.height * 0.2,
                height: size.height * 0.8,
                width: size.width,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsUtils.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 30.0,
                              right: 20.0,
                            ),
                            child: ListView(
                              controller: _scrollController,
                              children: [
                                TextInput(
                                  placeholder: 'Nombre',
                                  controller: _nombreController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty)
                                      return 'Ponga un valor';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Actividad',
                                  style: TextUtils.kanit_18_black,
                                ),
                                const SizedBox(height: 20.0),
                                SizedBox(
                                  height: 48,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listDeportes.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: GestureDetector(
                                          onTap: () => selectActivity(listDeportes, index),
                                          child: ToastCard(
                                            active: listDeportes[index].selected,
                                            nombre: listDeportes[index].nombre,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Dia y hora',
                                  style: TextUtils.kanit_18_black,
                                ),
                                const SizedBox(height: 20.0),
                                FormInput(
                                  icon: const Icon(
                                    Icons.calendar_month,
                                  ),
                                  placeholder: 'Buscar',
                                  controller: _dateController,
                                  onTap: () => _selectDate(context),
                                  fillColor: ColorsUtils.white,
                                  styleText: TextUtils.kanit_18_black,
                                  textInputType: TextInputType.none,
                                  validator: (p0) => null,
                                ),
                                const SizedBox(height: 20.0),
                                FormInput(
                                  icon: const Icon(
                                    Icons.access_time,
                                  ),
                                  placeholder: 'Buscar',
                                  controller: _timeController,
                                  onTap: () => _selectTime(context),
                                  fillColor: ColorsUtils.white,
                                  styleText: TextUtils.kanit_18_black,
                                  textInputType: TextInputType.none,
                                  validator: (p0) => null,
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Localización',
                                  style: TextUtils.kanit_18_black,
                                ),
                                const SizedBox(height: 20.0),
                                const SizedBox(height: 5.0),
                                FormInput(
                                  icon: const Icon(
                                    Icons.search,
                                    color: ColorsUtils.grey,
                                  ),
                                  placeholder: 'Buscar',
                                  controller: _ubicacionesController,
                                  fillColor: ColorsUtils.white,
                                  styleText: TextUtils.kanit_18_grey,
                                  onTap: tapLocalizacion,
                                  onChanged: (value) => onChangedUbicacion(value),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Ponga un valor';
                                    if (_geo == null)
                                      return 'Seleccione un valor';
                                    return null;
                                  },
                                ),
                                if (googleAutocompleteProvider
                                    .lugares.isNotEmpty)
                                  ...googleAutocompleteProvider.lugares
                                      .map((lugar) {
                                    return ListTile(
                                      leading: const Icon(Icons.map_outlined),
                                      title: Text(lugar.terms[0].value),
                                      subtitle: Text(subtitle(lugar.terms)),
                                      onTap: () => tapOnAutocomplete(lugar),
                                    );
                                  }),
                                const SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 20.0),
                                  child: _waitingLocation 
                                      ? const Center(child: CircularProgressIndicator(color: ColorsUtils.lightblue,))
                                      : ButtonInput(
                                    text: 'Mi ubicacion',
                                    color: ColorsUtils.lightblue,
                                    style: TextUtils.kanit_18_whtie,
                                    funcion: miUbicacion,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Máximo de personas',
                                  style: TextUtils.kanit_18_black,
                                ),
                                const SizedBox(height: 20.0),
                                FormInput(
                                  icon: const Icon(
                                    Icons.people,
                                  ),
                                  placeholder: 'Max. Personas',
                                  controller: _maxPersonasController,
                                  fillColor: ColorsUtils.white,
                                  onTap: tapMaxPersonas,
                                  styleText: TextUtils.kanit_18_black,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Ponga un valor';
                                    if (value.contains('-') ||
                                        value.contains(',') ||
                                        value.contains('.'))
                                      return 'Ponga numero enteros';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Descripcion',
                                  style: TextUtils.kanit_18_black,
                                ),
                                const SizedBox(height: 20.0),
                                FormInput(
                                  icon: const Icon(Icons.text_fields_rounded),
                                  placeholder: 'Descripcion',
                                  controller: _descripcionController,
                                  fillColor: ColorsUtils.white,
                                  styleText: TextUtils.kanit_18_black,
                                  onTap: tapDescription,
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Ponga un valor';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Precio',
                                      style: TextUtils.kanit_18_black,
                                    ),
                                    Switch.adaptive(
                                      value: _precio,
                                      onChanged: (value) => setState(() {
                                        _precio = value;
                                      }),
                                    ),
                                  ],
                                ),
                                if (_precio)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: FormInput(
                                      icon: const Icon(Icons.euro),
                                      placeholder: 'Precio',
                                      controller: _precioController,
                                      onTap: tapPrecio,
                                      fillColor: ColorsUtils.white,
                                      inputFormatters: [DecimalFormatter(decimalRange: 2)],
                                      textInputType: const TextInputType.numberWithOptions(decimal: true),
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return 'Ponga un valor';
                                        return null;
                                      },
                                    ),
                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Privado',
                                      style: TextUtils.kanit_18_black,
                                    ),
                                    Switch.adaptive(
                                      value: _privado,
                                      onChanged: (value) => setState(() {
                                        _privado = value;
                                      }),
                                    ),
                                  ],
                                ),
                                if (_privado)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: FormInput(
                                      icon: const Icon(Icons.lock),
                                      placeholder: 'Contraseña',
                                      onTap: tapPassword,
                                      controller: _privadoController,
                                      fillColor: ColorsUtils.white,
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return 'Ponga un valor';
                                        return null;
                                      },
                                    ),
                                  ),
                                const SizedBox(height: 200.0),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0, bottom: 70.0),
                          child: _waitingSubida
                          ? const Center(child: CircularProgressIndicator(color: ColorsUtils.black,))
                          : ButtonInput(
                            text: 'SUBIR',
                            funcion: subirEvento,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
