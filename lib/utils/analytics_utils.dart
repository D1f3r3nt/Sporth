import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsUtils {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  
  void registerEvent(String name, Map<String, Object?> parameters) async {
    log('Register');
    await analytics.logEvent(name: name, parameters: parameters);
  }
}