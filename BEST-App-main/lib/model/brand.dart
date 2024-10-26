class Brand {
  final int id;
  final String name;
  final String description;
  final String image;
  Brand(this.id, this.name, this.description, this.image);

  static Map<String, dynamic> toJson(Brand brand) {
    return {
      'id': brand.id,
      'name': brand.name,
      'description': brand.description,
      'image': brand.image
    };
  }
}
