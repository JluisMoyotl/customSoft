import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_soft/models/anuncio.dart';
import 'package:custom_soft/styles/texts.dart';
import 'package:flutter/material.dart';

class AnuncioCard extends StatelessWidget{
  final AnuncioModel current;
  const AnuncioCard({super.key,required this.current});
  
  @override
  Widget build(BuildContext context) {
    return Card(
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
            Text(current.price.toString())
          ],
        ),
        Text(current.description,style: textTheme.bodySmall,)
      ],
    );
  }
}