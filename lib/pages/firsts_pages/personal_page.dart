import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImageRepository _imageRepository = ImageRepository();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final ImagePicker _pickerImage = ImagePicker();

  File? _imageFile;
  DateTime _time = DateTime.now();

  Future<void> _pickImageFromGallery() async {
    final pickedfile = await _pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) setState(() => _imageFile = File(pickedfile.path));
  }

  Future<void> _pickImageFromCamera() async {
    final pickedfile = await _pickerImage.pickImage(source: ImageSource.camera);
    if (pickedfile != null) setState(() => _imageFile = File(pickedfile.path));
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      initialDate: _time,
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _time) setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    _timeController.text = DateFormat('dd/MM/yyyy').format(_time);
    final singUPProvider = Provider.of<SingUpProvider>(context);

    continuar() async {
      if (_formKey.currentState!.validate()) {
        String imagen = '';

        if (_imageFile != null) imagen = await _imageRepository.uploadFile(_imageFile!);

        singUPProvider.addPersonal(_nombreController.text, _apellidosController.text, imagen, _time, _telefonoController.text);

        Navigator.pushReplacementNamed(context, 'gustos');
      }
    }

    addImage() => showModalBottomSheet(
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: ColorsUtils.white,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: addImage,
                  child: CircleAvatar(
                    backgroundColor: (_imageFile == null) ? ColorsUtils.blue : null,
                    backgroundImage: (_imageFile != null) ? FileImage(_imageFile!) : null,
                    radius: 60.0,
                    child: (_imageFile == null)
                        ? const Icon(
                            Icons.add,
                            color: ColorsUtils.black,
                            size: 30.0,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: const Text(
                    'Perfil y datos personales',
                    style: TextUtils.kanit_16_black,
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: FormInput(
                    icon: const Icon(
                      Icons.person,
                      color: ColorsUtils.black,
                    ),
                    controller: _nombreController,
                    placeholder: 'Nombre',
                    fillColor: ColorsUtils.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ponga un valor';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: FormInput(
                    icon: const Icon(
                      Icons.person,
                      color: ColorsUtils.black,
                    ),
                    placeholder: 'Apellido',
                    controller: _apellidosController,
                    fillColor: ColorsUtils.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ponga un valor';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: FormInput(
                    icon: const Icon(
                      Icons.phone,
                      color: ColorsUtils.black,
                    ),
                    placeholder: 'Telefono',
                    controller: _telefonoController,
                    textInputType: TextInputType.phone,
                    fillColor: ColorsUtils.white,
                    validator: (p0) => null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: FormInput(
                    icon: const Icon(
                      Icons.calendar_month,
                      color: ColorsUtils.black,
                    ),
                    controller: _timeController,
                    placeholder: 'Fecha de nacimiento',
                    onTap: () => _selectTime(context),
                    fillColor: ColorsUtils.white,
                    textInputType: TextInputType.none,
                    validator: (p0) => null,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonInput(
                    text: 'CONTINUAR',
                    funcion: continuar,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
