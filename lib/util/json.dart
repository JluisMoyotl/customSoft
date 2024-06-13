import 'dart:developer';

dynamic jsonField <T> (Map<String,dynamic>? json,String field,T? defaultValue){
  dynamic retval = json ?? {};
  try{
    retval = retval[field];
    if(retval == null){
      return defaultValue;
    }else{
      if(retval is T){
      return retval;
      } else {
        switch (T) {
          case DateTime:
            return DateTime.parse(retval.toString());
          case String:
            return retval.toString();
          case int:
            return int.parse(retval.toString());
          case double:
            return double.parse(retval.toString());
          default:
          return retval.toString();
        }
      }
    }
  }catch(e){
    log("::: Catch jsonField ${e.toString()}");
    return defaultValue;
  }
}