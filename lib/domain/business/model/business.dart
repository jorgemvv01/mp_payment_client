class Business {
  int id;
  String name;
  String description;

  Business({
    required this.id,
    required this.name,
    required this.description
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["ID"],
    name: json["Name"],
    description: json["Description"],
  );
}