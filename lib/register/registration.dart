import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_project/home_screen.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/register/text_fields.dart';
import 'package:to_do_project/login/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
class RegisterScreen extends StatelessWidget {

  static String routeName = 'RegisterScreen';
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController confirmpasswordControler = TextEditingController();

  var key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
      Stack(children: [
        Container(color: Themes.primarylight,),
        Image.asset('assets/images/background.png', height: double.infinity,
          width: double.infinity, fit: BoxFit.fill,),
        Scaffold(backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent,
            centerTitle: true, title: Text(AppLocalizations.of(context)!.create_account,style: Theme.of(context).textTheme.titleLarge,),),
          body:
          SingleChildScrollView(
            child: Form(key: key1,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.27,),

                Fields(label:AppLocalizations.of(context)!.user_name , validator: (text) {
                  if (text == null||text.isEmpty) {
                    return AppLocalizations.of(context)!.this_field_cant_be_null;
                  }
                }, controller: usernamecontroller),
                Fields(controller: emailControler,
                    label: AppLocalizations.of(context)!.email,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.this_field_cant_be_null;
                      }
                      else {
                        bool isValid =
                        RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!isValid) {
                          return AppLocalizations.of(context)!.please_enter_avalid_email;
                        }
                        else {
                          text.trim();
                          return null;
                        }
                      }
                    }),
                Fields(controller: passwordControler, label: AppLocalizations.of(context)!.password,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.this_field_cant_be_null;
                      }
                      else {
                        if (text.length < 6) {
                          return AppLocalizations.of(context)!.password_must_be_at_least_6_characters;
                        }
                      }
                    }),
                Fields(label:AppLocalizations.of(context)!.confirm_password, validator: (text) {
                  if (text == null || text.isEmpty) {
                    return AppLocalizations.of(context)!.this_field_cant_be_null;
                  } else {
                    if (text != passwordControler.text) {
                      return "The confirm password doesn't match the password";
                    }else {return null;}
                  }
                }

                , controller: confirmpasswordControler),

                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      checkValidation();
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    }, child: Text(AppLocalizations.of(context)!.create_account, style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,)),
                TextButton(onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Login.routeName);
                }, child: Text(AppLocalizations.of(context)!.already_have_an_account,
                  style: TextStyle(decoration: TextDecoration.underline),))
              ]),
            ),
          ),
        ),

      ],);
  }

  void checkValidation()async {
    if (key1.currentState?.validate() == true) {
     try{ UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailControler.text, password:passwordControler.text);
     print(userCredential.user?.uid);
     print('successful register');}
    on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
        }
    } catch (e) {
    print(e);
     }
    }
  }
}
