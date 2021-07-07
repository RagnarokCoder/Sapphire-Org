

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sapphire_org/Menu/Menu.dart';

class ProyectosEnCurso extends StatefulWidget {
  ProyectosEnCurso({Key key}) : super(key: key);

  @override
  _ProyectosEnCursoState createState() => _ProyectosEnCursoState();
}

class _ProyectosEnCursoState extends State<ProyectosEnCurso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
       appBar: AppBar(
         elevation: 0,
         backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Text("Proyectos",style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  ),)),
          ],
        )
      ),
      backgroundColor: Color.fromRGBO(250, 145, 155, 100),
       body: Stack(
         alignment: Alignment.center,
         children: [
          Positioned(
            top: 50,
            child: Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                          
            stream: FirebaseFirestore.instance.collection('Proyectos').snapshots(),
            builder: (context, snapshot) {
             if(!snapshot.hasData){
                return Container(
                  height: 50,
                  width: 50,
                  child: SizedBox(height: 50, width: 50,
                  child: LinearProgressIndicator(),
                ),
                );
              }
              int length = snapshot.data.docs.length;
              return GridView.builder(
                
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, //columnas
                  mainAxisSpacing: 15, //espacio entre cards
                  childAspectRatio: 0.8,// largo de la card

                ),
                itemCount: length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (_, int index){
                  
                  final DocumentSnapshot doc = snapshot.data.docs[index];
                  String integrante1 = doc.data()['Integrante 1'].toString();
                  String integrante2 = doc.data()['Integrante 2'].toString();
                  String integrante3 = doc.data()['Integrante 3'].toString();
                  String integrante4 = doc.data()['Integrante 4'].toString();
                  print(integrante1);
                  print(integrante2);
                  return new Container(
                    height: 250,
                    width: 200,
                    child:  Padding(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            child: Container(
            height: 20.0,
            width: 20.0,
            child: Image.network(
        
        'https://firebasestorage.googleapis.com/v0/b/sapphireorg-3ccaf.appspot.com/o/logoblc.png?alt=media&token=ebeb5c6b-81b6-404e-93de-c7872d7a7fb3',
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
          ),
          ),
          
          
          
          Positioned(
            top: 5.0,
            left: 50.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${doc.data()['Titulo']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ),
                
                
               
                SizedBox(height: 12),
                
              ],
              
            )
            
          ),
          Positioned(
            top: 60.0,
            left: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                integrante1!="null"?
                Text("1. ${doc.data()['Integrante 1']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ):SizedBox(),
                SizedBox(height: 2,),
                integrante2!="null"?
                Text("2. ${doc.data()['Integrante 2']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ):SizedBox(),
                SizedBox(height: 2,),
                integrante3!="null"?
                Text("3. ${doc.data()['Integrante 3']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ):SizedBox(),
                SizedBox(height: 2,),
                integrante4!="null"?
                Text("4. ${doc.data()['Integrante 4']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ):SizedBox()
                
              ],
              
            )
            
          ),
          Positioned(
            left: 30,
            top: 20,
            child: Text("${doc.data()['FechaInicio']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: RaisedButton.icon(onPressed: (){
              openAlertBoxDetalles(doc);
            }, icon: Icon(Icons.next_plan_outlined, color: Colors.white, size: 20.0,), 
            label: Text("Detalles",  style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )), color: Colors.black.withOpacity(0.6),),
          )
        ]
        
      )
       
    ),
       
    
                  );

                    
                 
                  

                },
              );
            },
            
          ),
            )
          )
         ],
       ),
    );
  }
  //build
  openAlertBoxDetalles(DocumentSnapshot doc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              height: 400,
              width: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Detalles",
                        style: TextStyle(
             fontWeight: FontWeight.w900,
             color: Colors.black,
             fontSize: 18
                    ),
                      ),
                     
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    
                  
                  
                  child: Container(
                    
                decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                                      height: 300.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Text(
                        "- ${doc.data()['Lenguaje']}",
                        style: TextStyle(
             fontWeight: FontWeight.w900,
             color: Colors.black,
             fontSize: 18
                    ),
                      ),
                      Text(
                        "- Detalles\n ${doc.data()['Detalles']}",
                        style: TextStyle(
             fontWeight: FontWeight.w400,
             color: Colors.black,
             fontSize: 14
                    ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "- Info\n ${doc.data()['Info']}",
                        style: TextStyle(
             fontWeight: FontWeight.w400,
             color: Colors.black,
             fontSize: 14
                    ),
                      ),
                                        ],
                                      )),
          
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     
                      SizedBox(width: 15,),
                      Container(
                        height: 35,
                        width: 100,
                        child: RaisedButton.icon(
                       shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white),
                                        ),
                       elevation: 5.0,
                        label: Text("Cerrar",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.0,
                                                textStyle: TextStyle(
                                                    color: Colors.black))),
                        icon:
                            Icon(Icons.close, color: Colors.red),
                        
                        onPressed: () {
                           Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                      )
                    ],
                  )
                  
                ],
              ),
            ),
          );
        });

        
}
}


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 300,
        color: Colors.pink,
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              
                color: Colors.pink,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/logoblc.png'))),
          ),
          ListTile(
            leading: Icon(Icons.home_filled, color: Colors.white,),
            title: Text('Menu', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
            onTap: (){
              Route route = MaterialPageRoute(builder: (bc) => Menu());
                                                Navigator.of(context).push(route);
            },
          ),
          ListTile(
            leading: Icon(Icons.storage, color: Colors.white,),
            title: Text('Proyectos', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
            onTap: (){
              Route route = MaterialPageRoute(builder: (bc) => ProyectosEnCurso());
                                                Navigator.of(context).push(route);
            },
          ),
          ListTile(
            leading: Icon(Icons.home_work, color: Colors.white,),
            title: Text('Tareas', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
            onTap: (){
              Route route = MaterialPageRoute(builder: (bc) => ProyectosEnCurso());
                                                Navigator.of(context).push(route);
            },
          ),
          ListTile(
            leading: Icon(Icons.storage, color: Colors.white,),
            title: Text('Proyectos', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
            onTap: (){
              Route route = MaterialPageRoute(builder: (bc) => ProyectosEnCurso());
                                                Navigator.of(context).push(route);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.white,),
            title: Text('Salir', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
      )
    );
  }
}