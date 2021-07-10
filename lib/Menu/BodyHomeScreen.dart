import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:sapphire_org/Proyectos/proyectos.dart';
import 'package:sapphire_org/Tareas/Tareas.dart';

class BodyHomeScreen extends StatefulWidget {
  final String usuario;
  BodyHomeScreen({Key key, this.usuario}) : super(key: key);

  @override
  _BodyHomeScreenState createState() => _BodyHomeScreenState();
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          height: size.height * 0.2,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 25, right: 15, bottom: 36),
                height: size.height * 0.2 - 27,
                decoration: BoxDecoration(
                    color: colorPrincipal,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    )),
                child: Row(
                  children: [
                    Text(
                      "Menu Principal",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Image.asset("assets/logoblc.png")
                  ],
                ),
              ),
            ],
          ),
        ),
        //body
        Recomendado(usuario: widget.usuario, size: size),
        Container(
          height: size.height * 0.3,
          width: 50,
        )
      ],
    );
  }
}

class Recomendado extends StatelessWidget {
  final String usuario;
  const Recomendado({
    Key key,
    @required this.size,
    this.usuario,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
      child: ListView(
        children: [
          Column(
            children: [
              Text(
                "Recomendado",
                style: Theme.of(context).textTheme.headline5.copyWith(
                    color: colorPrincipal, fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MenuCard(
                      image: "assets/calendarioaj.png",
                      title: "Calenadario",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Calendario(),
                            ));
                      },
                    ),
                    MenuCard(
                      image: "assets/tareasaj.png",
                      title: "Tareas",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tareas(usuario: usuario),
                            ));
                      },
                    ),
                    MenuCard(
                      image: "assets/poyectosaj.png",
                      title: "Proyectos",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Proyectos(),
                            ));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        top: 10,
        bottom: 15 * 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: colorPrincipal,
      ),
      width: size.width * 0.4,
      child: Column(
        children: [
          Image.asset(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: colorPrincipal.withOpacity(0.23))
                  ]),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "$title".toUpperCase(),
                          style: Theme.of(context).textTheme.button)
                    ]),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.next_plan,
                      color: colorPrincipal,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
