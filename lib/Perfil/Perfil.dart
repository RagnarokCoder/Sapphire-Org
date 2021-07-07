


import 'package:flutter/material.dart';
import 'package:sapphire_org/Menu/NavBar.dart';

class Perfil extends StatefulWidget {
  Perfil({Key key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}



class _PerfilState extends State<Perfil> {
  
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color(0xff30384c),
         elevation: 0,
         leading: IconButton(
           icon: Icon(Icons.arrow_back_ios, size: 20,),
           onPressed: (){},
         ),

       ),
      backgroundColor: Color(0xff30384c),
      body: ListView(
        children: [
          Container(
            height: size.height*0.35,
            child: Column(
              children: [
                                Container(
                  padding: EdgeInsets.all(15),
                  height: size.height*0.10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("https://scontent.fgdl10-1.fna.fbcdn.net/v/t1.0-9/151489857_3949166601772616_7253134300686931841_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeGF1Y9si3D95xVkVuJfooTmMiWq87epTegyJarzt6lN6KZKoyICUovbm-zOS2YJ6RE9pA6XImvxzNRcL1Xl8WHh&_nc_ohc=866gpwaEOMcAX-HbLLI&_nc_ht=scontent.fgdl10-1.fna&oh=cf35b4018b2fba04f81771522d8a7bb1&oe=607594DE"),
                        ),
                      ),
                    
                      Column(
                        children: [
                          Text("Christian Ramirez",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                      ),
                      Text("Edad: 35",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                      ),
                      )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.all(15),
                  height: size.height*0.10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     
                      Column(
                        children: [
                          Text("Tareas:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                      ),
                      Text("56",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                      ),
                      )
                        ],
                      ),
                      Column(
                        children: [
                          Text("Horas:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                      ),
                      Text("34",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                      ),
                      )
                        ],
                      ),

                      FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
              color: Colors.white,
              onPressed: () {
               
              },
              child: Text("Editar Perfil",
              style: TextStyle(
                color: Color(0xff30384c),
                fontSize: 16
              ),
              ),
            ),


                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: size.height-300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
            height: size.height *0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)),
              color: Colors.white
            ),
          )
              ],
            ),
          )
        ],
      ),
       bottomNavigationBar: NavigationBar(),
    );
  }
}