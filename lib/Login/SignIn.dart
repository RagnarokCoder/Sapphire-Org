


import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapphire_org/HexaColors/HexaColors.dart';
import 'package:sapphire_org/Login/Authentication_Service.dart';
import 'package:yudiz_modal_sheet/yudiz_modal_sheet.dart';


class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

Color colorPrincipal = HexColor("#121212");
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      backgroundColor: colorPrincipal,
       body: BodyLogin(),
    );
  }
}

class BodyLogin extends StatelessWidget {
  const BodyLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
     Container(
       height: MediaQuery.of(context).size.height*0.05,
       color: colorPrincipal,
       child: Center(
         child: Text("Iniciar Sesión",
         style: TextStyle(
           color: Colors.white,
           fontSize: 20,
           fontWeight: FontWeight.bold
         ),
         ),
       ),
     ),
     Container(
       height: MediaQuery.of(context).size.height*0.4,
       child: Image.asset("assets/bienvenidoaj.png"),
     ),
     Container(
       height: MediaQuery.of(context).size.height*0.5,
       decoration: BoxDecoration(
           color: colorPrincipal,
           borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             
               SizedBox(height: 20,),
             Padding(
               
               padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 15),
               child: BeautyTextfield(
                 
     width: double.maxFinite,
     height: 60,
     duration: Duration(milliseconds: 300),
     inputType: TextInputType.text,
     prefixIcon: Icon(Icons.person_rounded, color: Colors.white,),
     placeholder: "Correo:",
     backgroundColor: colorPrincipal,
     textColor: Colors.white,
     accentColor: colorPrincipal.withOpacity(0.5),
     onTap: () {
      print('Click');
     },
     onChanged: (text) {
       emailController.text = text.toString();
      print("Email: "+ emailController.text);
     },
     onSubmitted: (data) {
      
     },
    ),
             ),
             Padding(
               
               padding: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 40),
               child: BeautyTextfield(
     width: double.maxFinite,
     height: 60,
     duration: Duration(milliseconds: 300),
     inputType: TextInputType.text,
     prefixIcon: Icon(Icons.lock, color: Colors.white,),
     placeholder: "Contraseña:",
      backgroundColor: colorPrincipal,
      
     textColor: Colors.white,
     accentColor: colorPrincipal.withOpacity(0.5),
     onTap: () {
      print('Click');
     },
     onChanged: (text) {
       passwordController.text = text.toString();
      print("Password: "+passwordController.text);
     },
     onSubmitted: (data) {
      
     
     },
    ),
             ),
           ],
         ),
     ),
      ],
    );
  }
}


class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: colorPrincipal,
        boxShadow: [
          
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
  height: 50.0,
  child: RaisedButton(
    onPressed: () async{
                print(passwordController.text);
                print(emailController.text);
                if(passwordController.text.isEmpty || emailController.text.isEmpty)
                {
                  buildAlert(context);
                }
                context.read<AuthenticationService>().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()
                );
                var user = FirebaseAuth.instance.currentUser;
                print("Current User:"+ user.isAnonymous.toString());
                if (!user.emailVerified) {
  await user.sendEmailVerification();
}
              },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    padding: EdgeInsets.all(0.0),
    
    child: Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [colorPrincipal, Color(0xFFEC407A)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
        alignment: Alignment.center,
        child: Text(
          "Iniciar Sesión",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ),
  ),
),
         
          
        ],
      ),
    );
  }


  buildAlert(BuildContext context)
  {
    YudizModalSheet.show(
    context: context,
    child: Container(
      decoration: BoxDecoration(
                 color: colorPrincipal,
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
               ),
      height: MediaQuery.of(context).size.height*0.4,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Text("No dejes Campos Vacios", style: (
                                      TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      )
                                    ),),
            SizedBox(height: 40,),
            Container(
              height:  MediaQuery.of(context).size.height*0.2,
              child: Image.asset("assets/erroraj.png"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton.icon(
                color: Colors.transparent,
                elevation: 0,
                onPressed: (){
                  
                 
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.check_circle, color: Color(0xff00cf8d),), 
                label: Text("Confirmar", style: TextStyle(color: Colors.white),)),
                
              ],
            )
          ],
        )
      ),
    ),
    direction: YudizModalSheetDirection.TOP);
  }

}