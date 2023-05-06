class AdUtils {
  AdUtils._();

  static AdUtils? _instance;

  bool _test = true;

  static AdUtils get instance {
    return _instance ??= AdUtils._();
  }

  void configure({final bool? test}) {
    if (test == null) return;
    _test = test;
  }

  String get bannerAdId {
    if (_test) return 'ca-app-pub-3940256099942544/6300978111';
    return 'ca-app-pub-5475010456455777/2584727667';
  }
}
