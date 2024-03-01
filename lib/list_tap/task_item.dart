import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_project/firebase_functions/firebase-utils.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/list_tap/dialog_box.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import '../firebase_functions/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
   /// late bool isPressed = widget.task.isdone!;
    ///
   /*getId()async{
      SharedPreferences pref =await SharedPreferences.getInstance();
   List<String>ids= pref.getStringList('IDS')??[];
   for(int i=0;i<ids.length;i++){
     if(ids[i]==widget.task.id){

      // widget.task.isdone=true;
       return;
     }
   }

    }*/





/*  getDone()async {
    SharedPreferences pref =await SharedPreferences.getInstance();

    widget.task.isdone=pref.getBool('task')??true;
  }*/


    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (context) {
                FirebaseUtils.deleteTasks(widget.task)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  provider.getTasks();
                  print('deleted successfully');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('deleted'),
                        );
                      });
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content:Text('Task deleted successfully',
                  //     style: TextStyle(fontWeight: FontWeight.bold),),
                  //     duration: Duration(seconds: 3),
                  //     backgroundColor: Themes.blue,
                  //     behavior: SnackBarBehavior.floating,),
                  //
                  // );
                  print('after snack bar');
                }).onError((error, stackTrace) => null);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.height * 0.5,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
                color: (provider.isLight()) ? Themes.white : Themes.sheetsBlack,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: (widget.task.isdone!) ? Themes.green : Themes.blue,
                        borderRadius: BorderRadius.circular(7)),
                    width: 7),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.task.title ??= '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: (widget.task.isdone!)
                                          ? Themes.green
                                          : Themes.blue),
                            ),
                            InkWell(
                              child: Container(
                                child: Icon(Icons.edit,
                                    color: provider.isLight()
                                        ? Themes.paleGrey
                                        : Themes.white),
                                margin: EdgeInsets.only(left: 10),
                              ),
                              onTap: () {
                                openDialog();
                              },
                            )
                          ],
                        ),
                        Text(widget.task.desc??='',
                            style: TextStyle(
                                color: (provider.isLight())
                                    ? Colors.black
                                    : Themes.white)),
                      ]),
                ),
                InkWell(
                  onTap: () {

                   /* FirebaseFirestore.instance.collection('Task').doc(widget.task.id).update(
                        {'isdone':true}).timeout(Duration(milliseconds:500)).onError(
                            (error, stackTrace) => null);*/

                        provider.setId(widget.task.id!);
                    widget.task.isdone=true;
                    setState(() {});
                  },
                     child: Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: (widget.task.isdone!) ? Themes.white : Themes.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: (widget.task.isdone!)
                          ? Text(
                              'Done!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Themes.green, fontSize: 20),
                            )
                          : Icon(
                              Icons.check,
                              color: Themes.white,
                            )),
                ),
              ],
            )),
      ),
    );
  }

  void openDialog() {
    showDialog(
        context: context,
        builder: (context) => DialogBox(
              task: widget.task,
            ));
  }
}
