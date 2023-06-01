import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sporth/utils/utils.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Crea eventos',
              body:
              'Crea todos los eventos deportivos que quieras totalmente gratis, ademas se creara un chat propio del evento',
              image: buildImage("image/tutorial/eventos.png"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Personaliza tus eventos',
              body: 'Puedes subir tus propias fotos para el evento o usar nuestros banners por defecto',
              image: buildImage("image/tutorial/image.png"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Chatea y comparte',
              body:
              'Puedes chatear con los usuarios, tanto en privado o en grupos de eventos',
              image: buildImage("image/tutorial/chat.png"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'No mas chats de un solo uso',
              body:
              'Al finalizar un evento el chat se borrara completamente, para de esta manera evitar los chats innecesarios que quedan en el olvido',
              image: buildImage("image/tutorial/tiempo.png"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Busca tus mejores opciones',
              body:
              'Usa el buscador para encontrar los eventos que mejor se adapten a tus necesidades',
              image: buildImage("image/tutorial/search.png"),
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            Navigator.pushReplacementNamed(context, PERMISOS);
          },
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          isBottomSafeArea: true,
          skip: const Text("Saltar", style: TextUtils.kanit_14_black),
          next: const Icon(Icons.arrow_forward_ios_rounded),
          done: const Text("Vamos", style: TextUtils.kanit_18_black),
          dotsDecorator: getDotsDecorator()),
    );
  }

  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
          imagePath,
          height: 200,
          fit: BoxFit.contain,
        ));
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: ColorsUtils.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: ColorsUtils.black, fontSize: 15),
    );
  }

  DotsDecorator getDotsDecorator() {
    return DotsDecorator(
      spacing: const EdgeInsets.symmetric(horizontal: 2),
      activeColor: ColorsUtils.lightblue,
      color: ColorsUtils.grey,
      activeSize: const Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }
}
