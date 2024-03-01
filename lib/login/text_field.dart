import 'package:flutter/material.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
typedef MyFunction = String?Function(String?);
class TextFields extends StatelessWidget {
 String label;
 MyFunction validator;
 TextEditingController controller;
TextFields({required this.label,required this.validator,required this.controller});
  @override
  Widget build(BuildContext context) {
    return
       Padding(
         padding:  EdgeInsets.all(8.0),
         child: TextFormField(controller: controller,
           validator:validator,
           decoration:InputDecoration(errorBorder:
         OutlineInputBorder(borderSide: BorderSide(color:Colors.red),
             borderRadius:BorderRadius.circular(10)),
         focusedErrorBorder:
         OutlineInputBorder(borderSide: BorderSide(color:Colors.red),
             borderRadius:BorderRadius.circular(10)),focusedBorder:
         OutlineInputBorder(borderSide: BorderSide(color: Themes.blue),
             borderRadius:BorderRadius.circular(10)) ,
              enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Themes.blue),
                  borderRadius:BorderRadius.circular(10))
              ,label:Text(label) ),),
       );


  }
}
