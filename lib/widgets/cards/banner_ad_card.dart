import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sporth/utils/utils.dart';

class BannerAdCard extends StatefulWidget {
  final double width;
  final double height;

  const BannerAdCard({
    Key? key,
    this.width = 320,
    this.height = 200,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerAdCard();
  }
}

class _BannerAdCard extends State<BannerAdCard> {
  late final BannerAd _bannerAd;
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bannerAd = BannerAd(
      size: AdSize(height: widget.height.toInt(), width: widget.width.toInt()),
      adUnitId: AdUtils.instance.bannerAdId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ready = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          _ready = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (_ready) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignCenter,
            width: 2.0,
            color: ColorsUtils.grey,
          ),
        ),
        child: AdWidget(ad: _bannerAd),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
}
