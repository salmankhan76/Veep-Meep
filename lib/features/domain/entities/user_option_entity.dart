enum UserOptionType { PEACH, MANGO, TRY, POTATO, PUMPKIN }

class UserOptionEntity {
  final UserOptionType userOptionType;
  final String optionName;
  final bool? hasAmount;
  final double? amount;
  final int? numberOfWeeks;
  final bool? hasWeeks;
  final int? numberOfContents;
  bool isSelected;

  UserOptionEntity(
      {required this.optionName,
      required this.userOptionType,
      this.hasAmount = false,
      this.amount,
      this.numberOfWeeks,
      this.hasWeeks = false,
      this.isSelected = false,
      this.numberOfContents});
}
