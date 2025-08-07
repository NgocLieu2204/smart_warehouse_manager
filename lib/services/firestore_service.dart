import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_warehouse_manager/models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }

  Future<void> addProduct(Product product) {
    return _db.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(Product product) {
    return _db.collection('products').doc(product.id).update(product.toMap());
  }
  
  Future<void> deleteProduct(String productId) {
      return _db.collection('products').doc(productId).delete();
  }

  Future<void> recordTransaction(String productId, int quantityChange, String type, String user) async {
    final productRef = _db.collection('products').doc(productId);
    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(productRef);
      final newQuantity = snapshot.data()!['quantity'] + quantityChange;
      transaction.update(productRef, {'quantity': newQuantity});
    });
  }
}