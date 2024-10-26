class Categories {
  final int id;
  final String name;
  final String description;
  final String image;

  Categories(this.id, this.name, this.description, this.image);

  static Map<String, dynamic> toJson(Categories categories) {
    return {
      'id': categories.id,
      'name': categories.name,
      'description': categories.description,
      'image': categories.image
    };
  }
}
