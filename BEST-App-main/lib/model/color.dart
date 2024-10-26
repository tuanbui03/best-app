class Colorss {
  final int id;
  final String name;

  Colorss(this.id, this.name);

  static Map<String, dynamic> toJson(Colorss color) {
    return {
      'id': color.id,
      'name': color.name,
    };
  }
}
