import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Proyectos extends StatefulWidget {
  Proyectos({Key key}) : super(key: key);

  @override
  _ProyectosState createState() => _ProyectosState();
}

class _ProyectosState extends State<Proyectos> {
  List<_ProjectCards> projects = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projects.add(_projectCards(1));
    projects.add(_projectCards(3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        title: Text('hola'),
      ),
      body: ListView(
        //MediaQuery.of(context).size.height * .7,
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * .81,
            child: ListView.builder(
              itemCount: projects.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, int index) {
                return projects[index];
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrincipal,
        onPressed: () {
          setState(() {
            print('object');
            _addProject();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _ProjectCards _projectCards(int i) {
    if ((i % 2) == 0) return (_ProjectCards(color: Colors.green));
    return (_ProjectCards(color: Colors.red));
  }

  void _addProject() {
    print('object');
    return projects.add(_ProjectCards(color: Colors.yellow));
  }
}

class _CrearNuevoProyecto extends StatelessWidget {
  const _CrearNuevoProyecto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      color: Colors.white, //colorPrincipal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                color: colorPrincipal,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.create,
                    color: Colors.blue.shade900,
                  ),
                  label: Text(
                    "Crear Proyecto",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.done,
                    color: Colors.green.shade800,
                  ),
                  label: Text(
                    "Cerrar Proyecto",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ProjectCards extends StatelessWidget {
  final Color color;

  const _ProjectCards({Key key, this.color}) : super(key: key);

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
              color: Colors.blue.shade800),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.close),
            color: Colors.white,
          ),
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
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            color: Colors.white,
          ),
        ),
      ],
      child: GestureDetector(
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
