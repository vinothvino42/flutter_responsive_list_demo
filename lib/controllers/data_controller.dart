import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_responsive_list_demo/models/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../repositories/data_repository.dart';

part 'data_controller.freezed.dart';

final dataController = StateNotifierProvider.autoDispose
    .family<DataController, DataState, String>((ref, url) {
  final dataRepository = ref.watch(dataRepositoryProvider);
  return DataController(url, dataRepository);
});

@freezed
class DataState with _$DataState {
  const factory DataState.loading() = DataStateLoading;
  const factory DataState.success(List<Transaction> transactions) =
      _DataStateSuccess;
  const factory DataState.error(String error) = DataStateError;
}

class DataController extends StateNotifier<DataState> {
  DataController(String url, this._dataRepository)
      : super(const DataState.loading()) {
    getTransactions(url);
  }

  final DataRepository _dataRepository;

  Future<void> getTransactions(String api) async {
    try {
      state = const DataState.loading();
      final interests = await _dataRepository.getAllTransactions(api);
      state = DataState.success(interests);
    } catch (err) {
      state = DataState.error(err.toString());
    }
  }
}
