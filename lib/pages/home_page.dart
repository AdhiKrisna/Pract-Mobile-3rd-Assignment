import 'package:asisten_tpm_8/models/clothe_model.dart';
import 'package:asisten_tpm_8/pages/create_clothe_page.dart';
import 'package:asisten_tpm_8/pages/detail_clothe_page.dart';
import 'package:asisten_tpm_8/pages/edit_clothe_page.dart';
import 'package:asisten_tpm_8/services/clothe_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Clothes", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 12,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(12),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (BuildContext context) => const CreateClothePage(),
                    ),
                  );
                },
                child: Text(
                  "Input Clothes",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Expanded(child: _clothesContainer()),
          ],
        ),
      ),
    );
  }

  _clothesContainer() {
    return FutureBuilder(
      future: ClotheApi.getClothes(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error.toString()}");
        } else if (snapshot.hasData) {
          ClotheModel response = ClotheModel.fromJson(snapshot.data!);
          return _clotheList(context, response.data!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _clotheList(BuildContext context, List<Clothe> clothes) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: clothes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                        DetailClothePage(id: clothes[index].id!),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.symmetric( vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              color: const Color.fromARGB(255, 236, 232, 211),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    clothes[index].name!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Rp. ${clothes[index].price}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 1,
                  color: Colors.blue,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                                    EditClothePage(id: clothes[index].id!),
                          ),
                        );
                      },
                    ),
                    // Tombol delete
                    IconButton(
                      icon: Icon(Icons.delete),
                         style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(12),
                      ),
                      color: Colors.red,
                      onPressed: () {
                        //confirm dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete clothe"),
                              content: Text(
                                "Are you sure you want to delete this clothe?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _deleteclothe(clothes[index].id!);
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk menghapus clothe ketika tombol "Delete clothe" diklik
  void _deleteclothe(int id) async {
    try {
      final response = await ClotheApi.deleteClothe(id);
      if (response["status"] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Clothe Deleted Sucessfully"),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh tampilan (Supaya data yg dihapus ilang dari layar)
        setState(() {});
      } else {
        throw Exception(response["message"]);
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal: $error")));
    }
  }
}
