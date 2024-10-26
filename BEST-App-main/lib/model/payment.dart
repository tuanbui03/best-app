class Payment {
  final int id;
  final String name;
  final String description;

  Payment(this.id, this.name, this.description);

  static Map<String, dynamic> toJson(Payment payment) {
    return {
      'id': payment.id,
      'name': payment.name,
      'description': payment.description
    };
  }
}
