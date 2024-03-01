
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/firebase_functions/firebase-utils.dart';
import 'package:to_do_project/firebase_functions/task.dart';
import 'package:flutter/material.dart';
import 'package:to_do_project/my_theme.dart';

class DialogBox extends StatefulWidget {
  Task task;
  DialogBox({required this.task});


  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
late DateTime? userDate=widget.task.date!;

 var key1=GlobalKey<FormState>();


  late String title=widget.task.title!;

  late String desc=widget.task.desc!;
  TextEditingController titlecontroler=TextEditingController();
  TextEditingController desccontroler=TextEditingController();
late AppConfigProvider provider;


  @override
  Widget build(BuildContext context) {
     provider=Provider.of<AppConfigProvider>(context);


    titlecontroler.text=widget.task.title??'';
    desccontroler.text=widget.task.desc??'';

    return
       Dialog(child: Container(margin: EdgeInsets.all(0),
           padding: EdgeInsets.all(10),
           height:MediaQuery.of(context).size.height*0.60,

           decoration: BoxDecoration(color:(provider.isLight()?Themes.white:Themes.sheetsBlack),
        ),

           child: Column(children: [
             Padding(padding: EdgeInsets.all(20),

                 child:Form(key: key1,
                   child: Column(children: [
                     Text(AppLocalizations.of(context)!.edit_task,
                       style:Theme.of(context).textTheme.titleLarge?.copyWith(color:
                       provider.isLight()?Themes.sheetsBlack:Themes.white ),),
                      TextFormField(style: TextStyle(color:provider.isLight()?Themes.sheetsBlack:Themes.white),
                          onChanged:(text){title=text;
                     widget.task.title=title;

                     ;},controller:titlecontroler,
                       validator:(string){
                         if(string==null||string.isEmpty){
                           return AppLocalizations.of(context)!.this_field_cant_be_null;
                         }
                       },decoration:
                       InputDecoration(
                          hintStyle:
                       TextStyle(color: provider.isLight()?Themes.sheetsBlack:Themes.white),
                           hintText:AppLocalizations.of(context)!.enter_task_title)
                      )

                       ,


                 SizedBox(height: 15),

                    TextFormField(style: TextStyle(color:provider.isLight()?Themes.sheetsBlack:Themes.white),
                      onChanged: (text){desc=text;
                     widget.task.desc=desc;

                      ;},
                        controller:desccontroler,
                     validator:(string){
                       if(string==null||string.isEmpty){
                         return AppLocalizations.of(context)!.this_field_cant_be_null;
                       }

                     } ,
                     maxLines: 3,
                     decoration: InputDecoration(hintStyle:
                     TextStyle(color:provider.isLight()?Themes.sheetsBlack:Themes.white),
                         hintText:AppLocalizations.of(context)!.enter_task_desc),),

                 SizedBox(height: 15,),
                 Column(crossAxisAlignment:CrossAxisAlignment.stretch,
                   children: [Text(AppLocalizations.of(context)!.select_date,style:
                   Theme.of(context).textTheme.titleLarge?.copyWith(
                       color:provider.isLight()?Themes.sheetsBlack:Themes.white),)],),

                 InkWell(onTap: (){
                   createCalender(context);},
                   child: Text('${userDate?.day}/${userDate?.month}/${userDate?.year}',
                     style: Theme.of(context).textTheme.titleLarge?.copyWith(color:
                     provider.isLight()?Themes.sheetsBlack:Themes.white),),
                 ),
                 SizedBox(height:50),
               ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Themes.blue,
                   shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ),
                   onPressed: (){
                 checkValidity();

                 }, child:Container(padding:EdgeInsets.all(15)
               ,
                   child: Text(AppLocalizations.of(context)!.save_changes)))
    ]),
               ),
             )
     ]),));
  }

  void createCalender(BuildContext context)async{
    DateTime ? chosen= await showDatePicker(
        context: context,
        initialDate:DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    userDate=chosen??userDate;
    widget.task.date=userDate;
    setState(() {});
  }
  void checkValidity(){
    if(key1.currentState?.validate()==true){
     ///void updateTask(){
       FirebaseUtils.createCollection().doc(widget.task.id).update(
           {'title':title,'desc':desc,'date':userDate?.millisecondsSinceEpoch}).timeout(Duration(milliseconds: 500),
           onTimeout: (){
             print('saved');
             provider.getTasks();
             Navigator.pop(context);
             ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(backgroundColor: Themes.blue,behavior:SnackBarBehavior.floating,
                         content:Text('changes saved successfully',
                      style: TextStyle(fontWeight: FontWeight.bold))));

           }).onError((error, stackTrace) => null);

    /// }
    }



  }
}
