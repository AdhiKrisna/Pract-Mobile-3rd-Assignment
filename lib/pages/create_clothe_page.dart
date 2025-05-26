import 'package:asisten_tpm_8/models/clothe_model.dart';
import 'package:asisten_tpm_8/pages/home_page.dart';
import 'package:asisten_tpm_8/services/clothe_service.dart';
import 'package:flutter/material.dart';

class CreateClothePage extends StatefulWidget {
  const CreateClothePage({super.key});

  @override
  State<CreateClothePage> createState() => _CreateClothePageState();
}

class _CreateClothePageState extends State<CreateClothePage> {
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

  Future<void> _createUser(BuildContext context) async {
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Semua field harus diisi")));
        return;
      }
      Clothe newUser = Clothe(
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
      final response = await ClotheApi.createClothe(newUser);
      if (response["status"] == "Success") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Berhasil menambah user baru")));
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      } else {
        throw Exception(response["message"]);
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Clothe"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: name,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: category,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Category",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: brand,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Brand",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: material,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Material",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: price,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Price",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: sold,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Sold",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: stock,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Stock",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: year,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Year Released",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: rating,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Rating",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () {
                _createUser(context);
              },
              child: const Text("Create Clothe"),
            ),
          ],
        ),
      ),
    );
  }
}
