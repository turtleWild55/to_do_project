import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsModeSheet extends StatefulWidget {

  @override
  State<SettingsModeSheet> createState() => _SettingsModeSheetState();
}

class _SettingsModeSheetState extends State<SettingsModeSheet> {
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
     provider=Provider.of<AppConfigProvider>(context);
    return
      Container(margin: EdgeInsets.all(7),
        padding:EdgeInsets.all(20),decoration:
      BoxDecoration(color: (provider.isLight()?Themes.white:Themes.sheetsBlack)),
        child: Column(children:[
        InkWell(onTap: (){
          provider.changeTheme(ThemeMode.light);
          provider.setPrefTheme(true);
        },
            child: (provider.isLight()) ?
            getSelected(AppLocalizations.of(context)!.light) :
            getUnselected(AppLocalizations.of(context)!.light)
           ,
        ),
          SizedBox(height: 15,)

              ,InkWell(onTap: (){
    provider.changeTheme(ThemeMode.dark);
    provider.setPrefTheme(false);
    },
                  child:  (provider.isLight()) ?
                  getUnselected(AppLocalizations.of(context)!.dark) :
                  getSelected(AppLocalizations.of(context)!.dark)),
                ],),
      );

  }
  Widget getSelected(String text){
    return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children:[Text(text,style:
    Theme.of(context).textTheme.titleLarge?.copyWith(color: Themes.blue))

      ,Icon(Icons.check,color:(Themes.blue))]);

  }
  Widget getUnselected(String text){
    return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children:[Text(text,style:(provider.isLight())?
    Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black):
    Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white))

      ,Icon(Icons.check,color:(provider.isLight()?Colors.black:Colors.white))]);
  }


}
class SettingsLangSheet extends StatefulWidget {

  @override
  State<SettingsLangSheet> createState() => _SettingsLangSheetState();
}

class _SettingsLangSheetState extends State<SettingsLangSheet> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(margin:EdgeInsets.all(7),
        decoration: BoxDecoration(
        color:provider.isLight()?Themes.white:Themes.sheetsBlack) ,
        padding: EdgeInsets.all(20),
        child: Column(
            children: [InkWell(onTap: () {
                  provider.changeLang('en');

                    provider.setPreflang();

                },
                    child: (provider.lang == 'en') ?
                    getSelected(AppLocalizations.of(context)!.english) :
                    getUnselected(AppLocalizations.of(context)!.english))
                  , SizedBox(height: 15)
                  ,
                  InkWell(onTap: () {
                    provider.changeLang('ar');
                   provider.setPreflang();
                  },
                      child: (provider.lang == 'ar') ? getSelected(
                          AppLocalizations.of(context)!.arabic) :
                      getUnselected(AppLocalizations.of(context)!.arabic)),

            ]));
  }

Widget getSelected(String text){
    return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children:[Text(text,style:
    Theme.of(context).textTheme.titleLarge?.copyWith(color: Themes.blue))

      ,Icon(Icons.check,color:(Themes.blue))]);

}
Widget getUnselected(String text){
  return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children:[Text(text,style:(provider.isLight())?
  Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black):
  Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white))

    ,Icon(Icons.check,color:(provider.isLight()?Colors.black:Colors.white))]);
}}
