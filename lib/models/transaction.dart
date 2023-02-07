import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Transaction {
  Transaction(
    this.id,
    this.accountId,
    this.amount,
    this.name,
    this.type,
    this.date,
    this.category,
    this.createdAt,
  );

  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: 0)
  final int accountId;

  @JsonKey(defaultValue: 0.0)
  final double amount;

  @JsonKey(defaultValue: 'Not Found')
  final String name;

  @JsonKey(defaultValue: 'Not Found')
  final String type;

  @JsonKey(defaultValue: 'Not Found')
  final String date;

  @JsonKey(defaultValue: 'Not Found')
  final String category;

  @JsonKey(defaultValue: 'Not Found')
  final String createdAt;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
