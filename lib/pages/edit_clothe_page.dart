import 'package:asisten_tpm_8/models/clothe_model.dart';
import 'package:asisten_tpm_8/pages/home_page.dart';
import 'package:asisten_tpm_8/services/clothe_service.dart';
import 'package:flutter/material.dart';

class EditClothePage extends StatefulWidget {
  final int id;
  const EditClothePage({super.key, required this.id});

  @override
  State<EditClothePage> createState() => _EditClothePageState();
}

class _EditClothePageState extends State<EditClothePage> {
  final name = TextEditingController();
  final category = TextEditingController();
  final brand = TextEditingController();
  final material = TextEditingController();
  final price = TextEditingController();
  final sold = TextEditingController();
  final stock = TextEditingController();
  final year = TextEditingController();
  final rating = TextEditingController();
  String? gender;

  bool _isDataLoaded = false;

  Future<void> _updateClothe(BuildContext context) async {
    try {
      if (name.text.isEmpty ||
          category.text.isEmpty ||
          brand.text.isEmpty ||
          material.text.isEmpty ||
          price.text.isEmpty ||
          sold.text.isEmpty ||
          stock.text.isEmpty ||
          year.text.isEmpty ||
          rating.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Semua field harus diisi")),
        );
        return;
      }

      Clothe updatedClothe = Clothe(
        name: name.text,
        category: category.text,
        brand: brand.text,
        material: material.text,
        price: int.parse(price.text),
        sold: int.parse(sold.text),
        stock: int.parse(stock.text),
        yearReleased: int.parse(year.text),
        rating: double.parse(rating.text),
      );

      final response = await ClotheApi.updateClothe(updatedClothe, widget.id);

      if (response["status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Berhasil mengubah clothe ${updatedClothe.name}")),
        );

        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else {
        throw Exception("INI RESPONSE: ${response["message"]}");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Clothe"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _clotheEdit(),
      ),
    );
  }

  Widget _clotheEdit() {
    return FutureBuilder(
      future: ClotheApi.getClotheById(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          if (!_isDataLoaded) {
            _isDataLoaded = true;
            Clothe clothe = Clothe.fromJson(snapshot.data!["data"]);
            name.text = clothe.name ?? "";
            category.text = clothe.category ?? "";
            brand.text = clothe.brand ?? "";
            material.text = clothe.material ?? "";
            price.text = clothe.price?.toString() ?? "";
            sold.text = clothe.sold?.toString() ?? "";
            stock.text = clothe.stock?.toString() ?? "";
            year.text = clothe.yearReleased?.toString() ?? "";
            rating.text = clothe.rating?.toString() ?? "";
          }

          return ListView(
            children: [
              _buildTextField(name, "Name"),
              _buildTextField(category, "Category"),
              _buildTextField(brand, "Brand"),
              _buildTextField(material, "Material"),
              _buildTextField(price, "Price", isNumber: true),
              _buildTextField(sold, "Sold", isNumber: true),
              _buildTextField(stock, "Stock", isNumber: true),
              _buildTextField(year, "Year Released", isNumber: true),
              _buildTextField(rating, "Rating", isNumber: true),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
                onPressed: () {
                  _updateClothe(context);
                },
                child: const Text("Update Clothe"),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.blue,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
