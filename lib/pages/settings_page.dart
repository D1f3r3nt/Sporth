import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sporth/models/dto/user_dto.dart';

import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final ImagePicker _pickerImage = ImagePicker();
  final String NAME_PROYECT_FIREBASE = "sporth-c3c47";

  File? _imageFile;
  DateTime? _time;

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
      initialDate: _time ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _time) setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    final EmailAuth emailAuth = EmailAuth();
    final GoogleAuth googleAuth = GoogleAuth();
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);
    final DatabaseUser databaseUser = DatabaseUser();
    final ImageRepository imageRepository = ImageRepository();

    if (_time == null) {
      _timeController.text = DateFormat('dd/MM/yyyy').format(userProvider.currentUser!.nacimiento);
    } else {
      _timeController.text = DateFormat('dd/MM/yyyy').format(_time!);
    }

    logout() async {
      emailAuth.logOut(context);
      googleAuth.logout();
      Navigator.pushReplacementNamed(context, INITIAL);
    }

    guardar() async {
      UserDto updateUser = userProvider.currentUser!;
      if (_nombreController.text.trim().isNotEmpty) {
        updateUser = updateUser.copyOf(nombre: _nombreController.text);
        await databaseUser.updateUser(updateUser);
      }

      if (_usernameController.text.trim().isNotEmpty) {
        updateUser = updateUser.copyOf(username: _usernameController.text);
        await databaseUser.updateUser(updateUser);
      }

      if (_telefonoController.text.trim().isNotEmpty) {
        updateUser = updateUser.copyOf(telefono: _telefonoController.text);
        await databaseUser.updateUser(updateUser);
      }

      if (_time != null) {
        updateUser = updateUser.copyOf(nacimiento: _time);
        await databaseUser.updateUser(updateUser);
      }

      if (_imageFile != null) {
        String newUrl = await imageRepository.uploadFile(_imageFile!);
        if (updateUser.imagen.isNotEmpty && updateUser.imagen.contains(NAME_PROYECT_FIREBASE)) {
          await imageRepository.deleteImage(updateUser.imagen);
        }
        updateUser = updateUser.copyOf(imagen: newUrl);
        await databaseUser.updateUser(updateUser);
      }

      userProvider.currentUser = updateUser;

      // Para traer los eventos del usuario
      eventosProvider.getEventosByUser(userProvider.currentUser!.idUser);
      
      Navigator.pushReplacementNamed(context, HOME);
    }

    atras() {
      // Para traer los eventos del usuario
      eventosProvider.getEventosByUser(userProvider.currentUser!.idUser);

      Navigator.pushReplacementNamed(context, HOME);
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
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                PopButton(
                  text: 'Atras',
                  onPressed: atras,
                ),
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: addImage,
                  child: CircleAvatar(
                    backgroundColor: (_imageFile == null) ? ColorsUtils.blue : null,
                    backgroundImage: (_imageFile != null) ? FileImage(_imageFile!) : NetworkImage(userProvider.currentUser!.urlImagen) as ImageProvider,
                    radius: 60.0,
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
                    placeholder: 'Nombre: ${userProvider.currentUser!.nombre}',
                    styleText: TextUtils.kanit_18_grey,
                    fillColor: ColorsUtils.white,
                    validator: (value) {
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
                    placeholder: 'Usuario: ${userProvider.currentUser!.username}',
                    styleText: TextUtils.kanit_18_grey,
                    controller: _usernameController,
                    fillColor: ColorsUtils.white,
                    validator: (value) {
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
                    placeholder: 'Telefono: ${userProvider.currentUser!.telefono}',
                    styleText: TextUtils.kanit_18_grey,
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonIconInput(
                    icono: const Icon(
                      Icons.save,
                      color: ColorsUtils.white,
                    ),
                    text: 'Guardar',
                    funcion: guardar,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonIconInput(
                    icono: const Icon(
                      Icons.logout,
                      color: ColorsUtils.white,
                    ),
                    text: 'Salir',
                    color: ColorsUtils.red_google,
                    funcion: logout,
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
