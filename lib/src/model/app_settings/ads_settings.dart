
class AdsSettings {
  late String rewardedAdAndroid;
  late String rewardedAdIos;
  late int rewardedValue;
  late bool adsActive;
  late bool rateActive;

  AdsSettings(this.rewardedAdAndroid, this.rewardedAdIos, this.rewardedValue,this.adsActive,this.rateActive);

  AdsSettings.fromJson(Map<String, dynamic> json)
      : this(
          json["rewarded_ad_android"] as String,
          json["rewarded_ad_ios"] as String,
          json["rewarded_value"] as int,
          json["ads_active"] as bool,
           json["rate_active"] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      "rewarded_ad_android": rewardedAdAndroid,
      "rewarded_ad_ios": rewardedAdIos,
      "rewarded_value": rewardedValue,
      "ads_active":adsActive,
      "rate_active":rateActive
    };
  }
}
