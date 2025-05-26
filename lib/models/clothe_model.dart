class ClotheModel {
    String? status;
    String? message;
    List<Clothe>? data;

    ClotheModel({this.status, this.message, this.data});

    ClotheModel.fromJson(Map<String, dynamic> json) {
      status = json['status'];
      message = json['message'];
      if (json['data'] != null) {
        data = <Clothe>[];
        json['data'].forEach((v) {
          data!.add(Clothe.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['status'] = status;
      data['message'] = message;
      if (this.data != null) {
        data['data'] = this.data!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }

  class Clothe {
    int? id;
    String? name, category, brand, material;
    int? price, sold, stock, yearReleased;
    double? rating;

    Clothe({
      this.id,
      this.name,
      this.category,
      this.brand,
      this.material,
      this.price,
      this.sold,
      this.stock,
      this.yearReleased,
      this.rating,

    });

    Clothe.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      name = json['name'];
      category = json['category'];
      brand = json['brand'];
      material = json['material'];
      price= json['price'] as int?;
      sold= json['sold'] as int?;
      // rating = json['rating']as double?;
      rating = json['rating'] != null ? (json['rating'] as num).toDouble() : null;
      stock= json['stock'] as int?;
      yearReleased= json['yearReleased'] as int?;
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = id;
      data['name'] = name;
      data['category'] = category;
      data['brand'] = brand;
      data['material'] = material;
      data['price'] = price;
      data['sold'] = sold;
      data['stock'] = stock;
      data['rating'] = rating;
      data['yearReleased'] = yearReleased;
      data['rating'] = rating;
      return data;
    }
  }
