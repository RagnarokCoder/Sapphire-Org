import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:sapphire_org/Detalles/Proximamente.dart';
import 'package:sapphire_org/Login/Authentication_Service.dart';
import 'package:sapphire_org/Menu/HomeScree.dart';
import 'package:sapphire_org/Perfil/Perfil.dart';
import 'package:provider/provider.dart';
import 'package:yudiz_modal_sheet/yudiz_modal_sheet.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBarWithSheet(
      selectedIndex: 0,
      sheetChild: Center(
          child: Text(
        "Proximamente Servicio de Mensajes Sapphire",
        style: TextStyle(color: Colors.white),
      )),
      bottomBarTheme: BottomBarTheme(
          mainButtonPosition: MainButtonPosition.middle,
          selectedItemBackgroundColor: Colors.blue.shade800,
          selectedItemIconColor: Colors.white,
          backgroundColor: colorPrincipal),
      mainActionButtonTheme: MainActionButtonTheme(
        size: 60,
        color: colorPrincipal,
        icon: Icon(
          Icons.message,
          color: Colors.white,
          size: 35,
        ),
      ),
      onSelectItem: (index) {
        if (index == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Perfil(),
              ));
        }
        if (index == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScree(),
              ));
        }
        if (index == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Proximamente(),
              ));
        }
        if (index == 3) {
          YudizModalSheet.show(
              context: context,
              child: Container(
                decoration: BoxDecoration(
                    color: colorPrincipal,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Desea Cerrar Sesión?",
                      style: (TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.asset("assets/tristeaj.png"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton.icon(
                            color: Colors.transparent,
                            elevation: 0,
                            onPressed: () {
                              context.read<AuthenticationService>().signOut();

                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: Color(0xff00cf8d),
                            ),
                            label: Text(
                              "Confirmar",
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        RaisedButton.icon(
                            color: Colors.transparent,
                            elevation: 0,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            label: Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    )
                  ],
                )),
              ),
              direction: YudizModalSheetDirection.BOTTOM);
        }
      },
      items: [
        BottomBarWithSheetItem(icon: Icons.person),
        BottomBarWithSheetItem(icon: Icons.home),
        BottomBarWithSheetItem(icon: Icons.settings),
        BottomBarWithSheetItem(icon: Icons.exit_to_app_rounded),
      ],
    );
  }
}
