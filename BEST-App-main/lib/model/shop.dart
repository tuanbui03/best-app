class Shop {
  final int id;
  final String name;
  final String image;
  final String address;
  final String email;
  final String phone;

  Shop(this.id, this.name,this.image ,this.address, this.email, this.phone);

  static Map<String, dynamic> toJson(Shop shop) {
    return {
      'id': shop.id,
      'name': shop.name,
      'image': shop.image,
      'address': shop.address,
      'email': shop.email,
      'phone': shop.phone
    };
  }
}
