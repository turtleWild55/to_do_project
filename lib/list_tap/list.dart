import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_project/firebase_functions/firebase-utils.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/list_tap/task_item.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

import '../firebase_functions/task.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {



  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);


   /* getId()async{
      SharedPreferences pref =await SharedPreferences.getInstance();
      List<String>ids= pref.getStringList('IDS')??[];
      for(int i=0;i<ids.length;i++){
        if(ids[i]==provider.tasks[i].id){

          provider.tasks[i].isdone=true;

        }
      }

    }*/



    if(provider.tasks.isEmpty){
     provider.getTasks();
    }
      return Column(
        children: [
          EasyDateTimeLine(locale: provider.lang,
            initialDate: provider.initialDate,
            onDateChange: (selectedDate) {
            provider.changeDate(selectedDate);
              //`selectedDate` the new date selected.
              ///provider.getTasks();
            },
            activeColor:  Color(0xff5D9CEC),
            headerProps:  EasyHeaderProps(showHeader: true,showMonthPicker: true,
              monthStyle: TextStyle(fontWeight: FontWeight.bold,
                  color: provider.isLight()?Themes.sheetsBlack:Themes.white)
              ,selectedDateStyle:
              TextStyle(fontWeight: FontWeight.bold,
                  color: provider.isLight()?Themes.sheetsBlack:Themes.white),
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDayAsStrMY(),
            ),
            dayProps:  EasyDayProps(
              activeDayStyle: DayStyle(dayStrStyle: TextStyle(
                  color: provider.isLight()?Themes.sheetsBlack:Themes.white),
                monthStrStyle:
                TextStyle(color:(provider.isLight()?Themes.sheetsBlack:Themes.white),
                    fontSize: 15,fontWeight: FontWeight.bold)
                ,dayNumStyle:
                TextStyle(color:(provider.isLight())?Themes.sheetsBlack:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                borderRadius: 32.0,
              ),
              inactiveDayStyle: DayStyle(decoration:BoxDecoration(color: Color(0xffFFFFFF))
                ,dayStrStyle:
                TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ,
                monthStrStyle:TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ,
                borderRadius: 32.0,
              ),
            ),
            timeLineProps: const EasyTimeLineProps(
              hPadding: 16.0, // padding from left and right
              separatorPadding: 16.0, // padding between days
            ),
          ),

          Expanded(
            child: ListView.builder(itemBuilder:( context,index){
              getId()async{
                SharedPreferences pref =await SharedPreferences.getInstance();
                List<String>ids= pref.getStringList('IDS')??[];
                for(int i=0;i<ids.length;i++){
                  if(ids[i]==provider.tasks[index].id){

                    provider.tasks[index].isdone=true;
                    FirebaseFirestore.instance.collection('Task').doc(provider.tasks[index].id).update(
                        {'isdone':true}).timeout(Duration(milliseconds:500)).onError(
                            (error, stackTrace) => null);

                  }
                }

              }
              return

                TaskItem(task: provider.tasks[index],);},
              itemCount:provider.tasks.length,
            ),
          )




        ],);
    }


  }

