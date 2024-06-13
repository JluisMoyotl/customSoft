import 'package:custom_soft/models/enum/anuncio.dart';
import 'package:custom_soft/util/json.dart';

class AnuncioModel {
  int id;
  double lat;
  double lng;
  double price;
  String title;
  String image;
  String description;
  TypeAnuncio type;
  AnuncioModel(
    {
      required this.id,
      required this.lat,
      required this.lng,
      required this.price,
      required this.title,
      required this.image,
      required this.description,
      required this.type
    }
  );
  factory AnuncioModel.empty(){
    return AnuncioModel(
      id: 0, 
      lat: 0, 
      lng: 0, 
      price: 1, 
      title: 'Anuncio de prueba', 
      image: '', 
      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      type: TypeAnuncio.inmuebles
    );
  }
  factory AnuncioModel.fromJson(Map<String,dynamic> json){
    return AnuncioModel(
      id: jsonField<int>(json, 'id', 0), 
      lat: jsonField<double>(json, 'latitude', 0), 
      lng: jsonField<double>(json, 'longitude', 0), 
      price: jsonField<double>(json, 'price', 0), 
      title: jsonField<String>(json, 'title', 'Sin titulo'), 
      image: jsonField<String>(json, 'image', ''), 
      description: jsonField<String>(json, 'description', ''), 
      type: getType(jsonField(json, 'type', ''))
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