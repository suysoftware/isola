class ChaosGroupDisplay {
  late bool group1IsHere;
  late bool group2IsHere;
  late bool groupIsActive;
  late bool groupIsNonBinary;
  late bool groupIsValid;
  late bool groupSex;
  late String groupNo;

  ChaosGroupDisplay(this.group1IsHere, this.group2IsHere, this.groupIsActive,
      this.groupIsNonBinary, this.groupIsValid, this.groupSex, this.groupNo);

  factory ChaosGroupDisplay.fromJson(Map<dynamic, dynamic> json) {
    return ChaosGroupDisplay(
        json["group_1_is_here"] as bool,
        json["group_2_is_here"] as bool,
        json["group_is_active"] as bool,
        json["group_is_nonbinary"] as bool,
        json["group_is_valid"] as bool,
        json["group_sex"] as bool,
        json["group_no"] as String);
  }
}
