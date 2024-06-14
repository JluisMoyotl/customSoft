import 'package:custom_soft/util/json.dart';

class SellerModel{
  int id;
  String name;
  String image;
  String phone;
  String email;
  SellerModel(
    {
      required this.id,
      required this.name,
      required this.image,
      required this.phone,
      required this.email
    }
  );
  factory SellerModel.empty(){
    return SellerModel(
      id: 0, 
      name: "Vendedor 1", 
      image: '', 
      phone: '+52 2225061873', 
      email: 'luismoyotl.p@gmail.com'
    );
  }
  factory SellerModel.fromJson(Map<String,dynamic> json){
    return SellerModel(
      id: jsonField<int>(json, "id", 0), 
      name: jsonField<String>(json, "name", ''), 
      image: jsonField<String>(json, "image", ''), 
      phone: jsonField<String>(json, "phone", ''), 
      email: jsonField<String>(json, "email", '')
    );
  }
}