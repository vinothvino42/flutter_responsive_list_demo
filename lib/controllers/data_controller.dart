import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/data_grid.dart';
import '../repositories/data_repository.dart';

part 'data_controller.freezed.dart';
part 'data_controller.g.dart';

final firstItemProvider = StateProvider<int>((_) => 0);
final secondItemProvider = StateProvider<int>((_) => 0);
final keyListProvider = StateProvider<List<DataGrid>>((_) => []);

@freezed
class DataState with _$DataState {
  const factory DataState.loading() = DataStateLoading;
  const factory DataState.success(List<List<DataGrid>> transactions) =
      DataStateSuccess;
  const factory DataState.error(String error) = DataStateError;
}

@riverpod
class DataController extends _$DataController {
  @override
  DataState build(String api) {
    getDataGrids(api);
    return const DataState.loading();
  }

  Future<void> getDataGrids(String api) async {
    try {
      state = const DataState.loading();
      final dataRepo = ref.read(dataRepositoryProvider);
      final dataGrids = await dataRepo.getAllGridItems(api);
      state = DataState.success(dataGrids);
    } catch (err) {
      state = DataState.error(err.toString());
    }
  }
}
