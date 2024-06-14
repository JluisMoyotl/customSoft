import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_soft/models/seller.dart';
import 'package:custom_soft/services/anuncio.dart';
import 'package:custom_soft/styles/colors.dart';
import 'package:custom_soft/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Seller extends StatelessWidget{
  final SellerModel current;
  Seller({super.key,required this.current});

  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();

  void _sendEmail() async {
    bool formComplete = formKey.currentState!.validate();

    if(formComplete){
    await sendEmailServices
      (email: email.text, name: name.text, message: description.text).then((answer){
        if(answer.error){
          Fluttertoast.showToast(
            msg: answer.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else{
          Fluttertoast.showToast(
            msg: "Correo enviado correctamente.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      });
    }
  }
  Future<void> _openPhone() async {
    if (current.phone.isNotEmpty) {
      await launchUrlString("tel: ${current.phone}");
    } else {
      Fluttertoast.showToast(
            msg: "No es posible realizar la llamada",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendedor")
      ),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }
  Widget _body(){
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _avatar(),
            const SizedBox(height: 10),
            Text(current.name),
            const SizedBox(height: 20),
            _label(icon: Icons.phone,label: "Call"),
            _data(label: "Mobile", value: current.phone,ontap: _openPhone),
            _label(icon: Icons.mail_outline,label: "Mail"),
            _label(label: "Nombre"),
            _textField(controller: name),
            _label(label: "Correo contacto"),
            _textField(controller: email,email: true),
            _label(label: "Texto correo"),
            _textField(controller: description,maxLines: 6),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(UIColors.black)
                ),
                onPressed: _sendEmail, 
                child: const Text(
                  "Enviar correo",
                  style: TextStyle(color: UIColors.white)
                )
              ),
            )
          ]
        ),
      )
    );
  }
  Widget _avatar(){
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(current.image),
          fit: BoxFit.cover
        ),
        border: Border.all(color: UIColors.black),
        shape: BoxShape.circle,
      ),
    );
  }
  Widget _label({IconData? icon,required String label}){
    return Row(
      children: [
        icon != null ? Icon(icon) : const SizedBox.shrink(),
        const SizedBox(width: 10),
        Text(label)
      ],
    );
  }
  Widget _data({required String label,required String value, Function? ontap}){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10,bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: UIColors.greyBottomBar
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextButton(
            onPressed: ontap != null ? ()=> ontap() : (){},
            child: Text(value)
          )
        ],
      ),
    );
  }
  Widget _textField({required TextEditingController controller,int maxLines = 1,bool email = false}){
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines,
      style: textTheme.bodyMedium!,
      validator: (value) {
        const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
        final regex = RegExp(pattern);
          if((value?.isEmpty ?? false) || (email && !regex.hasMatch(value!))) {
            return email && (value!.isNotEmpty ?? false)  
              ? "Ingresa un email valido" : "Campo obligatorio";
          }
          return null;
        },
    );
  }
}