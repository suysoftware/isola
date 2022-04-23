import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/app_settings/ads_settings.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/service/firebase/storage/tokensystem/single_token_send.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';

enum Availability { loading, available, unavailable }
const int maxFailedLoadAttempts = 3;

class TokenGainPage extends StatefulWidget {
  const TokenGainPage({Key? key, required this.userAll}) : super(key: key);

  final IsolaUserAll userAll;

  @override
  State<TokenGainPage> createState() => _TokenGainPageState();
}

class _TokenGainPageState extends State<TokenGainPage> {
  final InAppReview _inAppReview = InAppReview.instance;

  // ignore: unused_field
  Availability _availability = Availability.loading;
  bool adIsReady = false;
  String _appStoreId = '';
  String adUnitId = "";
  AdsSettings? adsSettings;
  bool adsActive = true;
  bool rateActive = true;
  final BannerAd myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/2934735716",
      listener: BannerAdListener(),
      request: AdRequest());

  // RewardedInterstitialAd? _rewardedInterstitialAd;
  //int _numRewardedInterstitialLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  Future<AdsSettings> getAppSettings() async {
    var settingsRef = FirebaseFirestore.instance
        .collection('app_settings')
        .doc('ads_settings');

    var adSetting;
    await settingsRef.get().then((value) => adSetting = AdsSettings(
        value['rewarded_ad_android'],
        value['rewarded_ad_ios'],
        value['rewarded_value'],
        value['ads_active'],
        value['rate_active']));

    print(adSetting);
    return adSetting;
  }

  void _createRewardedAd() {
    RewardedAd.load(
        //  adUnitId: 'ca-app-pub-5149921241693517/6698302922',

        //  adUnitId: 'ca-app-pub-5149921241693517~7495491222',

        // test
        adUnitId: adUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            setState(() {
              adIsReady = true;
              _rewardedAd = ad;
              _numRewardedLoadAttempts = 0;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            adIsReady = false;
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdShowedFullScreenContent.');
        setState(() {
          adIsReady = false;
        });
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(false);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      FirebaseAuth auth = FirebaseAuth.instance;
      earnToken(auth.currentUser!.uid, 'earn_ads_video');
      widget.userAll.isolaUserMeta.userToken =
          widget.userAll.isolaUserMeta.userToken + 1;
      //tokenı verdi
      //   print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

/*
  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5354046379'
            : 'ca-app-pub-5149921241693517~7495491222',
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(false);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      FirebaseAuth auth = FirebaseAuth.instance;
      earnToken(auth.currentUser!.uid);

      //tokenı verdi
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }
*/
  void _setAppStoreId(String id) => _appStoreId = id;

  @override
  void dispose() {
    //_rewardedInterstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //myBanner.load();
    // _createRewardedInterstitialAd();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (e) {
        setState(() => _availability = Availability.unavailable);
      }
    });

    getAppSettings().then((value) => adsSettings = value).whenComplete(() {
      adUnitId = adsSettings!.rewardedAdIos;
      adsActive = adsSettings!.adsActive;
      rateActive = adsSettings!.rateActive;
      _createRewardedAd();
    });
  }

  Future<void> _requestReview() =>
      _inAppReview.requestReview().whenComplete(() async {
        try {
          final isAvailable = await _inAppReview.isAvailable();

          if (isAvailable == false) {
            FirebaseAuth auth = FirebaseAuth.instance;
            earnToken(auth.currentUser!.uid, 'earn_rate');
            widget.userAll.isolaUserMeta.userToken =
                widget.userAll.isolaUserMeta.userToken + 5;
          }
          setState(() {
            // This plugin cannot be tested on Android by installing your app
            // locally. See https://github.com/britannio/in_app_review#testing for
            // more information.
            _availability = isAvailable && !Platform.isAndroid
                ? Availability.available
                : Availability.unavailable;
          });
        } catch (e) {
          setState(() => _availability = Availability.unavailable);
        }
      });
/*
  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
      );*/

  @override
  Widget build(BuildContext context) {
    print(adUnitId);
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorConstant.milkColor,
        ),
        child: Container(
          width: 100.w,
          color: ColorConstant.themeGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('asset/img/isola_token_large.png'),
              Text(
                '${widget.userAll.isolaUserMeta.userToken}',
                style: StyleConstants.isolaTokenPageStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
/*
              CupertinoTextField(
                onChanged: _setAppStoreId,
              ),
              CupertinoButton(
                onPressed: _requestReview,
                child: const Text('Request Review'),
              ),
              CupertinoButton(
                onPressed: _openStoreListing,
                child: const Text('Open Store Listing'),
              ),
              // SizedBox(height: 10.h, width: 70.w, child: AdWidget(ad: myBanner)),
              CupertinoButton(
                  child: adIsReady == true
                      ? Text(
                          'Reklam Hazır',
                          style: TextStyle(color: CupertinoColors.activeGreen),
                        )
                      : Text(
                          'Reklam Yok',
                          style: TextStyle(color: CupertinoColors.systemRed),
                        ),
                  onPressed: () {
                    //   _showRewardedInterstitialAd();
                    _showRewardedAd();
                  }),*/

              Row(
                children: [
                  CupertinoButton(
                      child: Text('dsds'),
                      onPressed: () {
                        var ref = FirebaseFirestore.instance
                            .collection('create_user_test')
                            .doc();

                        ref.set({
                          'user_mail':'sdsdgfg@tilburguiversity.edu',
                          'active':false,
                          'university_type':'null'

                        });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  adsActive == true
                      ? (adIsReady == true
                          ? _earnTokenCard(adsSettings!.rewardedValue,
                              "Watch Video", _showRewardedAd)
                          : _earnTokenWaitingCard())
                      : SizedBox(),
                  SizedBox(
                    width: 1.w,
                  ),
                  rateActive == true
                      ? (_availability == Availability.available
                          ? _earnTokenCard(5, "App Review", _requestReview)
                          : _earnTokenCard(5, "Rated", () {}))
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget _earnTokenCard(
    int earnAmount, String amountText, Function() buttonFunc) {
  return CupertinoButton(
    onPressed: buttonFunc,
    child: Container(
      height: 12.h,
      width: 40.w,
      decoration: BoxDecoration(
          color: ColorConstant.milkColor,
          border: Border.all(
            width: 0.01,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 5,
                blurRadius: 2.sp,
                // offset: const Offset(0.0, 4.0),
                color: CupertinoColors.systemGrey.withOpacity(0.5))
          ]),
      child: Stack(children: [
        amountText == 'Rated'
            ? SizedBox()
            : Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: amountText == 'App Review'
                      ? Image.asset('asset/img/token_gain_star.png')
                      : Image.asset('asset/img/token_gain_ads.png'),
                ),
              ),
        amountText == 'Rated'
            ? SizedBox()
            : Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 22.sp,
                      width: 22.sp,
                      child: Image.asset('asset/img/isola_token.png')),
                ),
              ),
        amountText == 'Rated'
            ? Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 3.h,
                  ),
                  child: Icon(
                    CupertinoIcons.check_mark_circled,
                    size: 30.sp,
                    color: CupertinoColors.activeGreen,
                  ),
                ))
            : Align(
                alignment: Alignment.center,
                child: Text(
                  '$earnAmount',
                  style: StyleConstants.isolaTokenCardYellowStyle,
                ),
              ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: ColorConstant.isolaTokenColorLight,
              border: Border.all(
                width: 0.01,
              ),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  amountText,
                  style: StyleConstants.isolaTokenCardStyle,
                ),
              ],
            ),
          ),
        )
      ]),
    ),
  );
}

Widget _earnTokenWaitingCard() {
  return CupertinoButton(
    onPressed: () {},
    child: Container(
      height: 12.h,
      width: 40.w,
      decoration: BoxDecoration(
          color: ColorConstant.milkColor,
          border: Border.all(
            width: 0.01,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 5,
                blurRadius: 2.sp,
                // offset: const Offset(0.0, 4.0),
                color: CupertinoColors.systemGrey.withOpacity(0.5))
          ]),
      child: Stack(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('asset/img/token_gain_ads.png'),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
                height: 25.sp,
                width: 25.sp,
                child: Image.asset('asset/img/isola_token.png')),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey4,
              border: Border.all(
                width: 0.01,
              ),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Waiting Ads',
                  style: StyleConstants.isolaTokenCardStyle,
                ),
              ],
            ),
          ),
        )
      ]),
    ),
  );
}
