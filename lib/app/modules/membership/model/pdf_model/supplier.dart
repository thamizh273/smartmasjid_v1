import 'dart:ui';

class Supplier {
  final String name;
  final String address;
  final String paymentInfo;
  final FontWeight? weight;
  final Color? color;

  const Supplier(  {
    this.color,
    this.weight,
    required this.name,
    required this.address,
    required this.paymentInfo,
  });
}
