import 'package:hive/hive.dart';
part 'account_model.g.dart';

const String accountBoxName = "accounts";
@HiveType(typeId: 1)
enum SalesCategory {
  @HiveField(0)
  FoodStuff,
  @HiveField(1)
  Fashion,
  @HiveField(2)
  Commodities
}
const salesCategories = <SalesCategory, String>{
  SalesCategory.FoodStuff: "foodstuff",
  SalesCategory.Fashion: "fashion",
  SalesCategory.Commodities: "commodities",
};

@HiveType(typeId: 0)
class Account {
  @HiveField(0)
  String accountName;
  @HiveField(1)
  num accountNumber;
  @HiveField(2)
  SalesCategory salesCategory;
  @HiveField(3)
  String phoneNumber;
  @HiveField(4)
  double accountBalance;

  Account(this.accountName, this.accountNumber, this.phoneNumber,
      this.salesCategory, this.accountBalance);
}
