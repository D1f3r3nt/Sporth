import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sporth/preferences/preferences.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/routes/routes.dart';
import 'package:sporth/utils/utils.dart';

// Background Handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Para evitar que la pantalla se voltee
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Firebase
  await Firebase.initializeApp();

  // Mobile Ads
  await MobileAds.instance.initialize();
  AdUtils.instance.configure(test: true); // Cambiar a false en PRO
  
  // Preferences
  Preferences.init();
  
  // Cloud Messaging
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print(await FirebaseMessaging.instance.getToken());

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
