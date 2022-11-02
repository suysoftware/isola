
class StatisticsSettings {
  late String statisticsPassword ;
  late bool isActive;

  StatisticsSettings(this.statisticsPassword,this.isActive);

  StatisticsSettings.fromJson(Map<String, dynamic> json)
      : this(
          json["statisticsPassword"] as String,
           json["isActive"] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      "statisticsPassword": statisticsPassword,
      "isActive": isActive,
   
    };
  }
}
