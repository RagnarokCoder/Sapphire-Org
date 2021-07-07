

import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';


class Proximamente extends StatefulWidget {
  Proximamente({Key key}) : super(key: key);

  @override
  _ProximamenteState createState() => _ProximamenteState();
}

class _ProximamenteState extends State<Proximamente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
      ),
       body: Container(
         color: colorPrincipal,
         child: Column(
           children: [
             Image.asset("assets/proximamenteaj.png"),
             Text("Proximamente...",
             style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
             )
           ],
         ),
       ),
    );
  }
}