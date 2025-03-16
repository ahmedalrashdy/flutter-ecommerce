class CategoryModel {
  final int id;
  final String name;
  final String? description;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        image: map['image']);
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, image: $image';
  }

  static List<CategoryModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((map) => CategoryModel.fromMap(map)).toList();
  }
}
