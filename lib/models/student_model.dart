class Student {
  final String? id;
  final String name;
  final String semester;
  final String image;

  Student({
    this.id,
    required this.name,
    required this.semester,
    required this.image,
  });

  Student.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          semester: json['semester'],
          image: json['image'],
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'semester': semester,
      'image': image,
    };
  }
}
