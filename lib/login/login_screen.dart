import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/login/text_field.dart';
import 'package:to_do_project/register/registration.dart';
import 'package:to_do_project/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
 static String routeName='loginScreen';
TextEditingController emailControler=TextEditingController();
TextEditingController passwordControler=TextEditingController();
var key1=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return
    /*Scaffold(appBar:AppBar(backgroundColor:Color(0xff3597DAFF),title: Text('Login'),),
        backgroundColor:Colors.transparent,
    body: Container(color:Themes.primarylight,
        child: Image.asset('assets/images/background.png',
          height: double.infinity,
          width: double.infinity,fit: BoxFit.fill,)));*/
      Stack(children: [
      Container(color:Themes.primarylight,),
    Image.asset('assets/images/background.png',height: double.infinity,
      width: double.infinity,fit: BoxFit.fill,),
        Scaffold(backgroundColor:Colors.transparent ,
        appBar: AppBar(backgroundColor: Colors.transparent,
    centerTitle: true,title: Text(AppLocalizations.of(context)!.login,style: Theme.of(context).textTheme.titleLarge,),),
        body:
    SingleChildScrollView(
      child: Form(key: key1,
        child: Column(crossAxisAlignment:CrossAxisAlignment.stretch,children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.27,),
          Text(AppLocalizations.of(context)!.welcome_back,style: Theme.of(context).textTheme.titleLarge,),
          TextFields(controller:emailControler ,label:AppLocalizations.of(context)!.email,
              validator: (text){
            if(text==null||text.isEmpty){
              return AppLocalizations.of(context)!.this_field_cant_be_null;}
            else{
              bool isValid=
              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
              if(!isValid){return AppLocalizations.of(context)!.please_enter_avalid_email;}
              else{text.trim();
              return null;
            }
          }}),
                  TextFields(controller: passwordControler, label:AppLocalizations.of(context)!.password,
                      validator: (text){
                    if(text==null||text.isEmpty){
                    return AppLocalizations.of(context)!.this_field_cant_be_null ;}
                    else{
                      if(text.length<6){
                      return AppLocalizations.of(context)!.password_must_be_at_least_6_characters;}
                    }
                  }),
          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
          ElevatedButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              onPressed: (){
            checkValidation(context);
              }, child:Text(AppLocalizations.of(context)!.login,style: Theme.of(context).textTheme.titleLarge,)),
          TextButton(onPressed:(){
            Navigator.of(context).pushNamed(RegisterScreen.routeName);
          }, child:Text(AppLocalizations.of(context)!.dont_have_account,
            style: TextStyle(decoration:TextDecoration.underline ),))
                 ]),
      ),
    ),
        ),

    ],);


  }
  void checkValidation(BuildContext context)async{
  try{  if(key1.currentState?.validate()==true) {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailControler.text, password: passwordControler.text);
print('successful register');
print(userCredential.user?.uid??'no id');
Navigator.of(context).pushNamed(HomeScreen.routeName);
    }}
  on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print(e.toString());
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print(e.toString());
      print('Wrong password provided for that user.');
    }

  }
  catch(e){
print(e);
  }
  }
}
