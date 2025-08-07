import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  int quantity;
  final String unit;
  final String barcode;
  final DateTime expiryDate;
  final String location;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.quantity,
    required this.unit,
    this.barcode = '',
    required this.expiryDate,
    this.location = '',
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      quantity: data['quantity'] ?? 0,
      unit: data['unit'] ?? '',
      barcode: data['barcode'] ?? '',
      expiryDate: (data['expiryDate'] as Timestamp).toDate(),
      location: data['location'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'barcode': barcode,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'location': location,
    };
  }
}