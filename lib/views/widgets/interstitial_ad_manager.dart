import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  void interstitialAd() {
    String adUnitId;
    if (kReleaseMode) {
      // リリースモードのとき
      adUnitId = Platform.isAndroid ? 'ca-app-pub-1282226807235434/6226480157': 'ca-app-pub-1282226807235434/2341159744';   // 本番用の広告ユニットID
    } else {
      // デバッグモードのとき
      adUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712': 'ca-app-pub-3940256099942544/4411468910';  // テスト用の広告ユニットID
    }
    InterstitialAd.load(
      adUnitId: adUnitId, // テスト用ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          print('Interstitial ad loaded.');
        },
        onAdFailedToLoad: (error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_isAdLoaded) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('Ad was dismissed.');
          interstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('Ad failed to show with error: $error');
        },
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          print('Ad showed.');
        },
      );
      _interstitialAd?.show();
    } else {
      print('Interstitial ad is not yet loaded.');
    }
  }
}
