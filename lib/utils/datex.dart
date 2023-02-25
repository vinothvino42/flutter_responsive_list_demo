import 'package:intl/intl.dart';

extension DateX on String {
  String get formatDate {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(this);
    DateTime inputDate = DateTime.parse(parseDate.toString());
    DateFormat outputFormat = DateFormat('MMM-dd-yyyy');
    String outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String get formatDateTime {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(this);
    DateTime inputDate = DateTime.parse(parseDate.toString());
    DateFormat outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    String outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
