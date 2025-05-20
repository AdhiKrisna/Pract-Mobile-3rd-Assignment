import 'package:asisten_tpm_8/models/clothe_model.dart';
import 'package:asisten_tpm_8/services/clothe_service.dart';
import 'package:flutter/material.dart';

class DetailClothePage extends StatelessWidget {
  final int id;

  const DetailClothePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clothe Detail", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(padding: EdgeInsets.all(20), child: _clotheDetail()),
    );
  }

  Widget _clotheDetail() {
    return FutureBuilder(
      future: ClotheApi.getClotheById(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error.toString()}");
        } else if (snapshot.hasData) {
          Clothe clothe = Clothe.fromJson(snapshot.data!["data"]);
          return _clothe(clothe);
        }
        // Jika masih loading, tampilkan loading screen di tengah layar
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _clothe(Clothe clothe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Center(
          child: Text(
            clothe.name!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              clothe.category!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              " | ",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              clothe.price != null ? "Rp. ${clothe.price.toString()}" : "No price",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          "Brand: ${clothe.brand!}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          clothe.material != null ? "Material: ${clothe.material!}" : "No material",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          clothe.sold != null ? "Sold: ${clothe.sold.toString()}" : "No sold",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          clothe.stock != null ? "Stock: ${clothe.stock.toString()}" : "No stock",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          clothe.rating != null ? "★ ${clothe.rating!.toStringAsFixed(1)}" : "No rating",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          clothe.yearReleased != null ? "Released: ${clothe.yearReleased.toString()}" : "No year released",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        
      ],
    );
  }
}
