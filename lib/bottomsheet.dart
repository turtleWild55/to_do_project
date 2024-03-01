import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/firebase_functions/firebase-utils.dart';
import 'package:to_do_project/firebase_functions/task.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_project/list_tap/list.dart';


class BottomShet extends StatefulWidget {
  @override
  State<BottomShet> createState() => _BottomShetState();
}

class _BottomShetState extends State<BottomShet> {
DateTime userDate=DateTime.now();
var key1=GlobalKey<FormState>();
late AppConfigProvider provider;
 late String title;
 late String desc;

  @override
  Widget build(BuildContext context) {
     provider=Provider.of<AppConfigProvider>(context);
  return
    Container(margin: EdgeInsets.all(6),
    padding:EdgeInsets.all(10),color: provider.isLight()?Themes.white:Themes.sheetsBlack,
             child: Column(children: [
               Text(AppLocalizations.of(context)!.add_new_task,
                 style:Theme.of(context).textTheme.titleLarge,),
                Form(key: key1,
                  child: Column(
                    children: [
                      TextFormField(style:TextStyle(color:provider.isLight()?Themes.sheetsBlack:Themes.white),
                        onChanged:(text){title=text;},
                         validator:(string){
                       if(string==null||string.isEmpty){
                         return'please enter the task title';
                       }
               },decoration:
               InputDecoration(
                   hintStyle:
               TextStyle(color:provider.isLight()?Themes.sheetsBlack:Themes.white)
                         ,hintText:AppLocalizations.of(context)!.enter_task_title),),



               SizedBox(height: 15),
                      TextFormField(style: TextStyle(color: provider.isLight()?Themes.sheetsBlack:Themes.white)
                        ,onChanged: (text){desc=text;},
                          validator:(string){
                          if(string==null||string.isEmpty){
                            return'please enter the task description';
                          }

                        } ,
                          maxLines: 3,
                          decoration: InputDecoration(

                              hintStyle:
                          TextStyle(color:provider.isLight()?Themes.sheetsBlack:Themes.white),
                              hintText:AppLocalizations.of(context)!.enter_task_desc),),
    ] ),),
                      SizedBox(height: 15,),
                     Column(crossAxisAlignment:CrossAxisAlignment.stretch,
                       children: [Text(AppLocalizations.of(context)!.select_date,style:
                       Theme.of(context).textTheme.titleLarge,)],),

                      InkWell(onTap: (){
                        createCalender(context);
                        },
                        child: Text('${userDate.day}/${userDate.month}/${userDate.year}',
                          style: Theme.of(context).textTheme.titleLarge,),
                      ),
                  SizedBox(height:50),
                  InkWell(onTap: (){
                    checkValidity();
                    },child: CircleAvatar(child: Icon(Icons.check),))
                 ],
               ),
           );
  }

  void createCalender(BuildContext context)async{
  DateTime ?chosen= await showDatePicker(
        context: context,
        initialDate:DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
  userDate=chosen??userDate;
  setState(() {});
  }
  void checkValidity(){
    if(key1.currentState?.validate()==true){
      Task task=Task(title: title, desc: desc, date: userDate);
      FirebaseUtils.addToFirestore(task).timeout(Duration(milliseconds: 500),onTimeout: (){
        print('data stored successfully');
        provider.getTasks();
        print('showed');
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Data stored successfully',
              style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Themes.blue,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),));
       /* showDialog(context: context, builder: (context){return
        AlertDialog(title:Text('Data saved successfully,Do you want to edit ?'),
          actions: [TextButton(onPressed: (){}, child:Text('yes')),
            TextButton(onPressed: (){}, child:Text('No')) ],);});*/
      }).onError((error, stackTrace) => null);


      /*Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );*/


    }

    }
  }

