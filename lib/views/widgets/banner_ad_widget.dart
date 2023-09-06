import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    String adUnitId;
    if (kReleaseMode) {
      // リリースモードのとき
      adUnitId = Platform.isAndroid ? 'ca-app-pub-1282226807235434/1165725161': 'ca-app-pub-1282226807235434/4198286450';   // 本番用の広告ユニットID
    } else {
      // デバッグモードのとき
      adUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111': 'ca-app-pub-3940256099942544/2934735716';  // テスト用の広告ユニットID
    }

    _bannerAd = BannerAd(
      adUnitId: adUnitId, // テスト用ID、実際には自分の広告ユニットIDを使用してください
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
            child: AdWidget(ad: _bannerAd),
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
          )
        : Container();
  }
}
