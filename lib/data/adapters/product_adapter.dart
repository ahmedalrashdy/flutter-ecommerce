import 'package:hive_flutter/adapters.dart';

import '../models/product_model.dart';

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    return ProductModel(
      id: reader.readInt(),
      name: reader.readString(),
      description: reader.readString(),
      price: reader.readDouble(),
      discount: reader.readDouble(),
      categoryId: reader.readInt(),
      mainImage: reader.readString(),
      additionalImages: reader.readStringList(),
      rating: reader.readDouble(),
      isFavorite: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description ?? "");
    writer.writeDouble(obj.price);
    writer.writeDouble(obj.discount);
    writer.writeInt(obj.categoryId);
    writer.writeString(obj.mainImage);
    writer.writeStringList(obj.additionalImages);
    writer.writeDouble(obj.rating);
    writer.writeBool(obj.isFavorite);
  }
}
