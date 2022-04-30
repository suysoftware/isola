class PartnersModel {
  late String fullName;
  late int universityValue;
  late String activityNo;
  late String mailType;
  late bool isActive;
  late String whichCountry;

  PartnersModel(this.fullName, this.universityValue, this.activityNo,
      this.mailType, this.isActive, this.whichCountry);

  PartnersModel.fromJson(Map<String, dynamic> json)
      : this(
          json["fullName"] as String,
          json["universityValue"] as int,
          json["activityNo"] as String,
          json["mailType"] as String,
          json["isActive"] as bool,
          json["whichCountry"] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "universityValue": universityValue,
      "activityNo": activityNo,
      "mailType": mailType,
      "isActive": isActive,
      "whichCountry": whichCountry,
    };
  }
}
