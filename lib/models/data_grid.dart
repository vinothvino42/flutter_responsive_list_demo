class DataGrid {
  DataGrid({
    required this.label,
    required this.key,
    required this.value,
    required this.type,
  });

  final String label;
  final String key;
  final String type;
  final dynamic value;

  static DataGrid fromJson(String key, dynamic value) {
    final String type = getType(value.runtimeType, value);
    // final String type = 'type';
    final String label = key.capitalizeFirstLetter;

    return DataGrid(
      key: key,
      label: label,
      type: type,
      value: value,
    );
  }

  static String getType(Type runtimeType, dynamic value) {
    switch (runtimeType) {
      case String:
        final date = DateTime.tryParse(value);
        if (date != null) return 'date';
        return 'string';
      case int:
        return 'int';
      case double:
        return 'double';
      case bool:
        return 'bool';
      default:
        return 'dynamic';
    }
  }
}

extension CapitalizeX on String {
  String get capitalizeFirstLetter {
    String result = '';
    result = this[0].toUpperCase();

    for (int i = 1; i < length; i++) {
      result += this[i].toLowerCase();
    }
    return result;
  }
}
