

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:yudiz_modal_sheet/yudiz_modal_sheet.dart';


class Tareas extends StatefulWidget {
  final String usuario;
  Tareas({Key key, this.usuario}) : super(key: key);

  @override
  _TareasState createState() => _TareasState();
}
int numTareas=0;
List<String> nombresTareas = [];
final TextEditingController passwordController = TextEditingController();
class _TareasState extends State<Tareas> {
  
  @override
  void initState() {
    nombresTareas = []; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        title: Text("Tareas",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
      ),
      backgroundColor: colorPrincipal,
       body: ListView(
         children: [
           
           Container(
             height: MediaQuery.of(context).size.height*0.1,
             
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                   height: MediaQuery.of(context).size.height*0.08,
                   width: MediaQuery.of(context).size.width*0.8,
                   child: TextFormField(
    cursorColor: Colors.black,
    controller: passwordController,
    decoration: new InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        
        contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        hintText: "Tarea...",
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
  )
                 ),
             IconButton(
             icon: Icon(Icons.add, color: Colors.blue,),
             onPressed: (){
               if(passwordController.text=="")
               {
                 buildAlert(context);
               }
               else
               {
                 setState(() {
                 
                 numTareas+=1;
                 
                 nombresTareas.add(passwordController.text.toString());
                 
                 passwordController.text = "";
                 
               });
               }
               
             },
           ),
               ],
             ),
           ),
           Container(
             margin: EdgeInsets.all(15),
             height: MediaQuery.of(context).size.height*0.5,
             child: ListView(
               children: [
                 for(int i=0;i<numTareas;i++)
           Text("${i+1}.-"+"${nombresTareas[i]}",
           style: TextStyle(
             color: Colors.white,
             fontSize: 16,
             fontWeight: FontWeight.bold
           ),
           )
               ],
             ),
           ),
           
           Container(
             height: MediaQuery.of(context).size.height*0.3,
             color: colorPrincipal,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Container(
                   height: MediaQuery.of(context).size.height*0.1,
                   decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
               ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       FlatButton.icon(
                         icon: Icon(Icons.delete, color: Colors.red.shade900,),
                         label: Text("Limpiar",
           style: TextStyle(
             color: colorPrincipal,
             fontSize: 16,
             fontWeight: FontWeight.bold
           ),
           ),
           onPressed: (){
             setState(() {
               nombresTareas.clear();
               numTareas=0;
             });
           },
                       ),
                       FlatButton.icon(
                         icon: Icon(Icons.done, color: Colors.green.shade800,),
                         label: Text("Generar Reporte",
           style: TextStyle(
             color: colorPrincipal,
             fontSize: 16,
             fontWeight: FontWeight.bold
           ),
           ),
           onPressed: (){
             FirebaseFirestore.instance.collection("Tareas").add({
               for(int i=0;i<numTareas;i++)
               "Tarea ${i+1}": nombresTareas[i],
               "Usuario": widget.usuario,
               "Mes": DateTime.now().month,
               "Dia": DateTime.now().day,
               "Año": DateTime.now().year,
             }).then((value) => {
              nombresTareas.clear(),
              numTareas=0,
             setState(() {
               
             }),
              buildAlertCorrect(context),
             });
             
           },
                       )
                     ],
                   ),
                 )
               ],
             ),
           )
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
   buildAlertCorrect(BuildContext context)
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
            Text("Gracias Por Subir Tus Tareas!", style: (
                                      TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      )
                                    ),),
            SizedBox(height: 40,),
            Container(
              height:  MediaQuery.of(context).size.height*0.2,
              child: Image.asset("assets/correctoaj.png"),
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