class Task {
  final String name;
  final String createDate;
  final bool isDone;
  final int? pk;

  Task(
      {required this.name,
      required this.createDate,
      required this.isDone,
      required this.pk});
}
