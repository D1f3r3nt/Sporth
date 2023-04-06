import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final imagePersona = 'https://m8p8m9h3.stackpathcdn.com/wp-content/uploads/2021/11/que-tipo-de-persona-te-gustaria-ser-730x411-SP.jpg';
  final namePersona = 'msantisteban';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('image/banners/badminton.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                child: PopButton(
                  text: 'Atras',
                  onPressed: () => Navigator.pop(context),
                  colorWhite: true,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 35.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(imagePersona),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              namePersona,
                              style: TextUtils.kanitBold_18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        const Text(
                          'Partido de badminton',
                          style: TextUtils.kanitItalic_24_black,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.access_time),
                                SizedBox(width: 10),
                                Text(
                                  '10:00 AM',
                                  style: TextUtils.kanit_18_black,
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(Icons.location_on_outlined),
                                SizedBox(width: 10),
                                Text(
                                  'Palma de Mallorca',
                                  style: TextUtils.kanit_18_black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  '15',
                                  style: TextUtils.kanitItalic_24_blue,
                                ),
                                Text(
                                  'Julio',
                                  style: TextUtils.kanit_16_grey,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Free',
                                  style: TextUtils.kanitItalic_24_blue,
                                ),
                                Text(
                                  'Precio',
                                  style: TextUtils.kanit_16_grey,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  '20',
                                  style: TextUtils.kanitItalic_24_blue,
                                ),
                                Text(
                                  'Maximo',
                                  style: TextUtils.kanit_16_grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ToastCard(
                              nombre: 'Badminton',
                              active: true,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.person),
                                SizedBox(width: 5.0),
                                Text(
                                  '2',
                                  style: TextUtils.kanit_16_black,
                                ),
                                SizedBox(width: 10.0),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: ListView(
                            children: const [
                              Text(
                                'Hola csobves vsdv svdv sdv s dv s dv s dv  s dvs dv    sdvdsvsdv sdv sdv sdv sdvaswdefew vsdvds dsv',
                                style: TextUtils.kanit_16_black,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80.0,
                          child: Row(
                            children: [
                              Expanded(
                                child: ButtonInput(
                                  text: 'Seguir',
                                  funcion: () {},
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              IconButton(
                                onPressed: () {
                                  print('Enviar');
                                },
                                icon: const Icon(Icons.share),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
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
