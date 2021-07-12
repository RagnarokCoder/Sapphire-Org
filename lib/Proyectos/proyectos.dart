import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapphire_org/Proyectos/create_project.dart';
import 'package:sapphire_org/Proyectos/project_screen.dart';

class Proyectos extends StatefulWidget {
  Proyectos({Key key}) : super(key: key);

  @override
  _ProyectosState createState() => _ProyectosState();
}

class _ProyectosState extends State<Proyectos> {
  Map<String, _ProjectCards> projects = {};
  int i = 3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        title: Text('hola'),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * .9,
        child: ListView.builder(
          itemCount: projects.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, int index) {
            String id = projects.keys.elementAt(index);
            return projects[id];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrincipal,
        onPressed: () {
          setState(() {
            _addProject(i.toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CreateProject()));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _ProjectCards _projectCards(String id) {
    if ((id.length % 2) == 0)
      return (_ProjectCards(
        color: Colors.green,
        delete: () => setState(() => projects.remove(id)),
      ));
    return (_ProjectCards(color: Colors.red));
  }

  void _addProject(String id) {
    i++;
    projects[id] = _ProjectCards(
      color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255)),
      delete: () => setState(() => projects.remove(id)),
    );
  }
}

class _ProjectCards extends StatelessWidget {
  final Color color;
  final Function delete;
  const _ProjectCards({Key key, this.color, this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final TextStyle style = TextStyle(color: Colors.white);
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      direction: Axis.horizontal,
      actionExtentRatio: .25,
      secondaryActions: [
        Container(
          margin: EdgeInsetsDirectional.all(5),
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red.shade500),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 120,
              child: IconSlideAction(
                onTap: () {
                  delete();
                },
                icon: Icons.delete,
                color: Colors.red.shade500,
              ),
            ),
          ]),
        ),
        Container(
          margin: EdgeInsetsDirectional.all(5),
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff00cf8d)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
            color: Colors.white,
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.all(5),
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: colorPrincipal),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 120,
              child: IconSlideAction(
                onTap: () {},
                icon: Icons.edit,
                color: colorPrincipal,
              ),
            ),
          ]),
        ),
      ],
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetails(),
                ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 150,
            padding: EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: colorPrincipal,
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/ajoloteday.gif'),
                      fadeInDuration: Duration(milliseconds: 500),
                      image: AssetImage('assets/logoblc.png'),
                      fit: BoxFit.fill,
                      height: 80,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                        'Nombre.proyecto',
                        style: style,
                      ),
                      Spacer(),
                      Text(
                        'nombre.empresa',
                        style: style,
                      ),
                      Spacer(),
                      Text(
                        'lider: Chiles',
                        style: style,
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                        'Integrantes: 3',
                        style: style,
                      ),
                      Spacer(),
                      Text(
                        'Lenguaje: C++',
                        style: style,
                      ),
                      Spacer(),
                      Text(
                        'tipo: LandPage',
                        style: style,
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
