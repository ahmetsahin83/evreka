extension DateTimeExtensions on DateTime {
  String get formattedDate => "$day/$month/$year";
  String get formattedTime => "$hour:$minute";
  String get formattedDateTime => "$formattedDate $formattedTime";
}
