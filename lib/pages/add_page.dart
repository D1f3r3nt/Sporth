import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _pickerImage = ImagePicker();

  File? _imageFile;
  bool _precio = false;
  bool _privado = false;

  Future<void> _pickImageFromGallery() async {
    final pickedfile = await _pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) setState(() => _imageFile = File(pickedfile.path));
  }

  Future<void> _pickImageFromCamera() async {
    final pickedfile = await _pickerImage.pickImage(source: ImageSource.camera);
    if (pickedfile != null) setState(() => _imageFile = File(pickedfile.path));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deportesProvider = Provider.of<DeportesProvider>(context);
    final listDeportes = deportesProvider.deportesSelect;
    File? _imageFile = null;

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
                left: 5,
                child: PopButton(
                  text: 'Atras',
                  onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
                ),
              ),
              Positioned(
                width: size.width,
                height: size.height * 0.3,
                child: GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return SelectImageBottom(
                        onTapCamera: () => _pickImageFromCamera(),
                        onTapGallery: () => _pickImageFromGallery(),
                      );
                    },
                  ),
                  child: Column(
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
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.2,
                height: size.height * 0.8,
                width: size.width,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsUtils.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 30.0,
                            right: 20.0,
                          ),
                          child: ListView(
                            children: [
                              const TextInput(placeholder: 'Nombre'),
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
                                controller: TextEditingController(),
                                fillColor: ColorsUtils.white,
                                styleText: TextUtils.kanit_18_black,
                                validator: (p0) => null,
                              ),
                              const SizedBox(height: 20.0),
                              FormInput(
                                icon: const Icon(
                                  Icons.access_time,
                                ),
                                placeholder: 'Buscar',
                                controller: TextEditingController(),
                                fillColor: ColorsUtils.white,
                                styleText: TextUtils.kanit_18_black,
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
                                controller: TextEditingController(),
                                fillColor: ColorsUtils.white,
                                styleText: TextUtils.kanit_18_grey,
                                validator: (p0) => null,
                              ),
                              const SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                                child: ButtonInput(
                                  text: 'Mi ubicacion',
                                  color: ColorsUtils.lightblue,
                                  style: TextUtils.kanit_18_whtie,
                                  funcion: () {},
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
                                controller: TextEditingController(),
                                fillColor: ColorsUtils.white,
                                styleText: TextUtils.kanit_18_black,
                                validator: (p0) => null,
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Precio',
                                    style: TextUtils.kanit_18_black,
                                  ),
                                  Switch(
                                    value: _precio,
                                    onChanged: (value) => setState(() {
                                      _precio = value;
                                    }),
                                  ),
                                ],
                              ),
                              if (_precio)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: FormInput(
                                    icon: const Icon(Icons.euro),
                                    placeholder: 'Precio',
                                    controller: TextEditingController(),
                                    fillColor: ColorsUtils.white,
                                    validator: (p0) => null,
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Privado',
                                    style: TextUtils.kanit_18_black,
                                  ),
                                  Switch(
                                    value: _privado,
                                    onChanged: (value) => setState(() {
                                      _privado = value;
                                    }),
                                  ),
                                ],
                              ),
                              if (_privado)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: FormInput(
                                    icon: const Icon(Icons.lock),
                                    placeholder: 'Contraseña',
                                    controller: TextEditingController(),
                                    fillColor: ColorsUtils.white,
                                    validator: (p0) => null,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: ButtonInput(
                          text: 'SUBIR',
                          funcion: () {
                            print('Subir');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectActivity(List<DeportesDto> listDeportes, int index) {
    return setState(() {
      listDeportes.forEach((element) => element.selected = false);
      listDeportes[index].selected = !listDeportes[index].selected;
    });
  }
}
