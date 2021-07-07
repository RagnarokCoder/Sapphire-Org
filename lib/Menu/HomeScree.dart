

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:sapphire_org/Menu/BodyHomeScreen.dart';
import 'package:sapphire_org/Menu/NavBar.dart';

class HomeScree extends StatefulWidget {
  final String usuario;
  HomeScree({Key key, this.usuario}) : super(key: key);

  @override
  _HomeScreeState createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: colorPrincipal,
         elevation: 0,
         leading: IconButton(
           icon: SvgPicture.asset("assets/menu.svg"),
           onPressed: (){},
         ),
       ),
       body: BodyHomeScreen(usuario: widget.usuario,),
       bottomNavigationBar: NavigationBar(),
    );
  }
}

