import 'package:custom_soft/models/enum/anuncio.dart';
import 'package:custom_soft/models/seller.dart';
import 'package:custom_soft/util/json.dart';

class AnuncioModel {
  int id;
  int reviews;
  double lat;
  double lng;
  double price;
  double stars;
  String title;
  String image;
  String description;
  TypeAnuncio type;
  SellerModel seller;
  AnuncioModel(
    {
      required this.id,
      required this.reviews,
      required this.lat,
      required this.lng,
      required this.price,
      required this.stars,
      required this.title,
      required this.image,
      required this.description,
      required this.type,
      required this.seller
    }
  );
  factory AnuncioModel.empty(){
    return AnuncioModel(
      id: 0, 
      reviews: 0,
      lat: 0, 
      lng: 0, 
      price: 1,
      stars: 4.8, 
      title: 'Anuncio de prueba', 
      image: '', 
      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      type: TypeAnuncio.inmuebles,
      seller: SellerModel.empty()
    );
  }
  factory AnuncioModel.fromJson(Map<String,dynamic> json){
    return AnuncioModel(
      id: jsonField<int>(json, 'id', 0), 
      reviews: jsonField<int>(json, 'reviews', 0), 
      lat: jsonField<double>(json, 'latitude', 0), 
      lng: jsonField<double>(json, 'longitude', 0), 
      price: jsonField<double>(json, 'price', 0), 
      stars: jsonField<double>(json, 'stars', 0),
      title: jsonField<String>(json, 'title', 'Sin titulo'), 
      image: jsonField<String>(json, 'image', ''), 
      description: jsonField<String>(json, 'description', ''), 
      type: getType(jsonField(json, 'type', '')),
      seller: SellerModel.fromJson(jsonField(json, "seller", {}))
    );
  }
}
TypeAnuncio getType(String type){
  switch (type){
    case 'auto':
      return TypeAnuncio.autos;
    case 'inmueble': 
      return TypeAnuncio.inmuebles;
    case 'electronico':
      return TypeAnuncio.electronicos;
    default:
      return TypeAnuncio.inmuebles;
  }
}