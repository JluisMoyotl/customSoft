import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_soft/models/anuncio.dart';
import 'package:custom_soft/screens/anuncio/details.dart';
import 'package:custom_soft/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnuncioCard extends StatelessWidget{
  final AnuncioModel current;
  AnuncioCard({super.key,required this.current});
  final format = NumberFormat("\$ #,##0.00", "en_US");
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (builder)=> 
        DetailAnuncio(current: current))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              _image(),
              const SizedBox(width: 10),
              Expanded(child: _body())
            ],
          )
        ),
      ),
    );
  }
  Widget _image(){
    return CachedNetworkImage(
      imageUrl: current.image,
      width: 80,
      height: 100,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => 
        Image.asset(
          "assets/images/default.png",
          width: 90,
          height: 100,
          fit: BoxFit.cover,
        ),
    );
  }
  Widget _body(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(current.title),
            const SizedBox(height: 10),
            Text(format.format(current.price))
          ],
        ),
        Text(current.description,style: textTheme.bodySmall,)
      ],
    );
  }
}