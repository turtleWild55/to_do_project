import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:to_do_project/bottomsheet.dart';
import 'package:to_do_project/settings_tap/settings.dart';
import 'package:to_do_project/list_tap/list.dart';

class HomeScreen  extends StatefulWidget {

  static const routeName='homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tapedIcon=0;
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('To Do List',style:TextStyle(fontSize: 22,
          fontWeight:FontWeight.bold ,
          color:provider.isLight()?
      Themes.white:Themes.primaryDark)),
        toolbarHeight:MediaQuery.of(context).size.height*0.15,
          backgroundColor:Themes.blue),
    body:(tapedIcon==0)?TasksList():Settings(),
      bottomNavigationBar: BottomAppBar(shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(backgroundColor: Colors.transparent,elevation: 0,
          currentIndex:tapedIcon ,
          items: [
          BottomNavigationBarItem(icon:Icon(Icons.list),label: ''),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: ''),]

     ,onTap:(index){
          tapedIcon=index;
          setState(() {});
          }, ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(backgroundColor: Themes.blue,
        shape: StadiumBorder(
          side: BorderSide(color: Themes.white,width: 4))
        ,onPressed:(){
        showModalBottomSheet(
            context: context, builder: (context)=>BottomShet());
      }
        ,child:Icon(Icons.add,size:30) ,),

    );
  }
}