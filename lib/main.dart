import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/routes/routes.dart';
import 'package:sporth/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Para evitar que la pantalla se voltee
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Firebase
  await Firebase.initializeApp();

  // Mobile Ads
  await MobileAds.instance.initialize();

  AdUtils.instance.configure(test: false);

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeportesProvider()),
        ChangeNotifierProvider(create: (_) => LogrosProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => SingUpProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventosProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => GoogleAutocompleteProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sporth',
      routes: getRoutes,
      initialRoute: INITIAL,
    );
  }
}
