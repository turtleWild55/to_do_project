import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_functions/firebase-utils.dart';
import '../firebase_functions/task.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppConfigProvider extends ChangeNotifier{
  List<Task>tasks=[];
  ThemeMode appTheme=ThemeMode.light;
  String lang='en';
  DateTime initialDate=DateTime.now();
  List<String>ids=[];


 setPreflang()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString('language', lang);
await pref.reload();


}

 setPrefTheme(bool value)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
 pref.setBool('theme', value);
 await pref.reload();

}


 getPreflang()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
 lang= preferences.getString('language')??'en';


}
  getPrefTheme()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  bool theme= preferences.getBool('theme')??true;
  theme==true? appTheme=ThemeMode.light:appTheme=ThemeMode.dark;


 }
 setId(String id)async{
   SharedPreferences preferences=await SharedPreferences.getInstance();

   ids.add(id);
   preferences.setStringList('IDS', ids);
  await preferences.reload();
 }

  setDone({required bool value})async {
    SharedPreferences pref = await SharedPreferences
        .getInstance();
    pref.setBool('isdone',value);
   await pref.reload();

  }


  void changeDate(DateTime selectedDate){
    initialDate=selectedDate;
   getTasks();

  }

  void getTasks ()async{
    QuerySnapshot<Task>documents=await FirebaseUtils.createCollection().get();
    tasks= documents.docs.map((e)=>e.data()).toList();

   tasks= tasks.where((task){
      if(task.date!.day==initialDate.day &&
          task.date!.month==initialDate.month &&
          task.date!.year==initialDate.year
      ){
        return true;
      }return false;
    }).toList();

   tasks.sort((task1,task2){return task1.date!.compareTo(task2.date!);});
    notifyListeners();
  }

  void changeLang(String newLang){
    if(lang!=newLang){
      lang=newLang;
    }
    notifyListeners();
  }

  void changeTheme (ThemeMode newTheme){
    if(appTheme!=newTheme){
      appTheme=newTheme;
    }
    notifyListeners();
  }

  bool isLight(){
    if(appTheme==ThemeMode.light){
     return true;
    }else{
      return false;

    }
}
}