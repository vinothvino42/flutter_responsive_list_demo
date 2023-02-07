import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_responsive_list_demo/models/transaction.dart';

part 'data_repository.g.dart';

/// The provider for accessing the [DataRepository]
@riverpod
DataRepository dataRepository(DataRepositoryRef ref) {
  return DataRepository();
}

class DataRepository {
  Future<List<Transaction>> getAllTransactions(String api) async {
    try {
      final response = await Dio().get(api);
      final json = response.data as Map<String, dynamic>?;
      if (json == null) return [];
      final jsonList = json['data'] as List<dynamic>?;
      if (jsonList == null) return [];
      final transactions = jsonList
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
      return transactions;
    } catch (_) {
      rethrow;
    }
  }
}
