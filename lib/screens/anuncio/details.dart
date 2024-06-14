import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_soft/models/anuncio.dart';
import 'package:custom_soft/screens/anuncio/seller.dart';
import 'package:custom_soft/styles/colors.dart';
import 'package:custom_soft/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailAnuncio extends StatelessWidget{
  final AnuncioModel current;
  DetailAnuncio({super.key,required this.current});
  final format = NumberFormat("\$ #,##0.00", "en_US");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle Anuncio")
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _carousel(context),
            _header(),
            const SizedBox(height: 20),
            Text(current.description)
          ],
        )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .15,
          right: MediaQuery.of(context).size.width * .15,
          bottom: kBottomNavigationBarHeight
        ),
        child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(UIColors.black)
              ),
              onPressed: ()=> Navigator.push(context, 
                MaterialPageRoute(builder: (builder)=> Seller(current: current.seller))), 
              child: const Text(
                "Contactar vendedor",
                style: TextStyle(color: UIColors.white)
              )
            ),
      ),
    );
  }
  Widget _carousel(BuildContext context){
    return CarouselSlider(
      items: [Image.network(current.image)],
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.3,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
      ),
    );
  }
  Widget _header(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              current.title,
              style: textTheme.bodyLarge
            ),
            Text(format.format(current.price))
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.star_border_outlined),
                Text(current.stars.toString()),
                const SizedBox(width: 5),
                Text(
                  current.reviews > 0 ? "Sin reviews" : "${current.reviews} reviews",
                  style: textTheme.bodyMedium!.copyWith(color: UIColors.textGreyColor),
                )
              ],
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(UIColors.black)
              ),
              onPressed: (){}, 
              child: const Text("Mapa",style: TextStyle(color: UIColors.white))
            )
          ],
        )
      ],
    );
  }
}