class DataModel {
  final List<String> location;
  final List<String> todo;

  DataModel({required this.location, required this.todo});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      location: List<String>.from(json['location']),
      todo: List<String>.from(json['todo']),
    );
  }
}
