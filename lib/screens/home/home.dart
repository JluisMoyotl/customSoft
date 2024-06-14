import 'package:custom_soft/components/widgets/anuncio.dart';
import 'package:custom_soft/models/anuncio.dart';
import 'package:custom_soft/models/enum/anuncio.dart';
import 'package:custom_soft/services/anuncio.dart';
import 'package:custom_soft/styles/colors.dart';
import 'package:custom_soft/styles/texts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget{
  static const String routeName = "/home";
  const Home({super.key});
  
  @override
  State<StatefulWidget> createState()=> _Home();
}
class _Home extends State<Home>{
  List<AnuncioModel> _anuncios = [];
  TypeAnuncio typeCurrent = TypeAnuncio.autos;
  TextEditingController searchTo = TextEditingController();
  ScrollController scroll = ScrollController();
  int page = 1;
  bool loading = false;

  @override
  void initState(){
    super.initState();
    Future.microtask(_fecthInfo);
    scroll.addListener(() {
      if (scroll.position.pixels >= scroll.position.maxScrollExtent && !loading) {
        page = 2;
        _fecthInfo();
      }
    });
  }

  _updateType(TypeAnuncio current){
    setState(() {
      typeCurrent = current;
    });
    _fecthInfo();
  }
  Future<void> _fecthInfo()async{
    setState(()=> loading = true);
    await workListServices().then((answer){
      if(answer.error){
        setState(()=> loading = false);
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
          List<AnuncioModel> list = List.from((answer.body.map((item)=> 
            AnuncioModel.fromJson(item)).toList())
              .where((anuncio) => anuncio.type == typeCurrent));
        setState(() {
          if(list.length >= page * 5){
            _anuncios = list.sublist(0,page * 5);
          }else{
            _anuncios = list;
          }
          setState(()=> loading = false);
        });
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _typesButton(),
          _searchTo(),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  controller: scroll,
                  children: _anuncios.where((anuncio) => anuncio.type == typeCurrent 
                    && (searchTo.text.isEmpty || anuncio.title.contains(searchTo.text)))
                      .map((e) => AnuncioCard(current: e)).toList()
                ),
                Visibility(
                  visible: loading,
                  child: const Center(
                    child: CircularProgressIndicator()
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
  Widget _typesButton(){
    return IntrinsicHeight( 
      child: Container( 
        decoration: BoxDecoration(border: Border.all(color: UIColors.black)),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            InkWell(
              onTap: ()=> _updateType(TypeAnuncio.autos),
              child: Container(
                color: typeCurrent == TypeAnuncio.autos ? UIColors.black : null,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .3,
                child: Text(
                  TypeAnuncio.autos.name,
                  style: TextStyle(
                    color: typeCurrent == TypeAnuncio.autos ? UIColors.white : null,
                  ),
                )
              ),
            ),
            const VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 1,
              ),
            InkWell(
              onTap: ()=> _updateType(TypeAnuncio.inmuebles),
              child: Container(
                color: typeCurrent == TypeAnuncio.inmuebles ? UIColors.black : null,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width * .31,
                child: Text(
                  TypeAnuncio.inmuebles.name,
                  style: TextStyle(
                    color: typeCurrent == TypeAnuncio.inmuebles ? UIColors.white : null,
                  ),
                )
              ),
            ),
            const VerticalDivider(
                color: UIColors.black,
                thickness: 1,
                width: 1,
              ),
            InkWell(
              onTap: ()=> _updateType(TypeAnuncio.electronicos),
              child: Container(
                color: typeCurrent == TypeAnuncio.electronicos ? UIColors.black : null,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .3,
                child: Text(
                  TypeAnuncio.electronicos.name,
                  style: TextStyle(
                    color: typeCurrent == TypeAnuncio.electronicos ? UIColors.white : null,
                  ),
                )
              ),
            )
          ],
        )
      )
    );
  }
  Widget _searchTo(){
    return TextFormField(
      controller: searchTo,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      style: textTheme.bodyMedium!,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: UIColors.black),
        hintText: 'Search',
        hintStyle: Theme.of(context).textTheme.bodyMedium!
          .copyWith(color: Colors.blueGrey[200]),  
      ),
    );
  }
}