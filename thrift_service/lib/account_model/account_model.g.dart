// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesCategoryAdapter extends TypeAdapter<SalesCategory> {
  @override
  final int typeId = 1;

  @override
  SalesCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SalesCategory.FoodStuff;
      case 1:
        return SalesCategory.Fashion;
      case 2:
        return SalesCategory.Commodities;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, SalesCategory obj) {
    switch (obj) {
      case SalesCategory.FoodStuff:
        writer.writeByte(0);
        break;
      case SalesCategory.Fashion:
        writer.writeByte(1);
        break;
      case SalesCategory.Commodities:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      fields[0] as String,
      fields[1] as num,
      fields[3] as String,
      fields[2] as SalesCategory,
      fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.accountName)
      ..writeByte(1)
      ..write(obj.accountNumber)
      ..writeByte(2)
      ..write(obj.salesCategory)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.accountBalance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
