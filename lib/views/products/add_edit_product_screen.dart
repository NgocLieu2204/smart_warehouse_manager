import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:smart_warehouse_manager/models/product_model.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;

  const AddEditProductScreen({super.key, this.product});

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _barcodeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _barcodeController.text = widget.product!.barcode;
      _selectedDate = widget.product!.expiryDate;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              
              ListTile(
                  title: Text("Expiry Date: ${DateFormat.yMd().format(_selectedDate)}"),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () {},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save Product'),
              )
            ],
          ),
        ),
      ),
    );
  }
}