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
        title: const Text("Clothe Detail", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _clotheDetail(),
      ),
    );
  }

  Widget _clotheDetail() {
    return FutureBuilder(
      future: ClotheApi.getClotheById(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        } else if (snapshot.hasData) {
          Clothe clothe = Clothe.fromJson(snapshot.data!["data"]);
          return _clothe(clothe);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _clothe(Clothe clothe) {
    return ListView(
      children: [
        Center(
          child: Text(
            clothe.name ?? 'No name',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow("Category", clothe.category),
                const Divider(),
                _infoRow("Price", clothe.price != null ? "Rp. ${clothe.price}" : null),
                const Divider(),
                _infoRow("Brand", clothe.brand),
                const Divider(),
                _infoRow("Material", clothe.material),
                const Divider(),
                _infoRow("Sold", clothe.sold?.toString()),
                const Divider(),
                _infoRow("Stock", clothe.stock?.toString()),
                const Divider(),
                _infoRow("Rating", clothe.rating != null ? "★ ${clothe.rating}" : null),
                const Divider(),
                _infoRow("Year Released", clothe.yearReleased?.toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value ?? "N/A",
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
