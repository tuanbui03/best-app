class Sizes {
  final int id;
  final int size;

  Sizes(this.id, this.size);

  static Map<String, dynamic> toJson(Sizes size) {
    return {
      'id': size.id,
      'size': size.size,
    };
  }
}
