import 'package:dio/dio.dart';
import 'package:flutter_responsive_list_demo/models/data_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_repository.g.dart';

/// The provider for accessing the [DataRepository]
@riverpod
DataRepository dataRepository(DataRepositoryRef ref) {
  return DataRepository();
}

class DataRepository {
  Future<List<List<DataGrid>>> getAllGridItems(String api) async {
    try {
      final response = await Dio().get(api);
      final json = response.data as Map<String, dynamic>?;
      if (json == null) return [];
      final jsonList = json['data'] as List<dynamic>?;
      if (jsonList == null) return [];
      final keys = jsonList.map((e) => e.keys.toList()).toList().first;
      final multiValues = jsonList.map((e) => e.values.toList()).toList();
      List<List<DataGrid>> multiGrids = [];

      multiValues.asMap().forEach((objectIndex, value) {
        List<DataGrid> dataGrids = [];
        keys.asMap().forEach((keyIndex, key) {
          dataGrids
              .add(DataGrid.fromJson(key, multiValues[objectIndex][keyIndex]));
        });
        multiGrids.add(dataGrids);
      });

      return multiGrids;
    } catch (_) {
      rethrow;
    }
  }
}
