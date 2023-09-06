import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  void interstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // テスト用ID
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
