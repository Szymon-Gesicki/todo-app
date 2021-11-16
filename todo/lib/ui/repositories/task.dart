class Task {
  final String name;
  final DateTime createDate;
  final bool isDone;
  final int? pk;

  Task({
    required this.name,
    required this.createDate,
    required this.isDone,
    this.pk,
  });
}
