// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) => TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) => json.encode(data.toJson());

class TransactionHistoryModel {
  String? typename;
  List<GetTransactionHistory>? getTransactionHistory;

  TransactionHistoryModel({
    this.typename,
    this.getTransactionHistory,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => TransactionHistoryModel(
    typename: json["__typename"],
    getTransactionHistory: json["Get_Transaction_History"] == null ? [] : List<GetTransactionHistory>.from(json["Get_Transaction_History"]!.map((x) => GetTransactionHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Transaction_History": getTransactionHistory == null ? [] : List<dynamic>.from(getTransactionHistory!.map((x) => x.toJson())),
  };
}

class GetTransactionHistory {
  String? typename;
  String? id;
  DateTime? processDate;
  String? receiverName;
  String? transactionAmount;
  String? transactionMessage;
  String? transactionType;

  GetTransactionHistory({
    this.typename,
    this.id,
    this.processDate,
    this.receiverName,
    this.transactionAmount,
    this.transactionMessage,
    this.transactionType,
  });

  factory GetTransactionHistory.fromJson(Map<String, dynamic> json) => GetTransactionHistory(
    typename: json["__typename"],
    id: json["id"],
    processDate: json["process_date"] == null ? null : DateTime.parse(json["process_date"]),
    receiverName: json["receiver_name"],
    transactionAmount: json["transaction_amount"],
    transactionMessage: json["transaction_message"],
    transactionType: json["transaction_type"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "process_date": processDate?.toIso8601String(),
    "receiver_name": receiverName,
    "transaction_amount": transactionAmount,
    "transaction_message": transactionMessage,
    "transaction_type": transactionType,
  };
}
