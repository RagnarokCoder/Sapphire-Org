import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateProject extends StatefulWidget {
  CreateProject({Key key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  String _fecha = '';
  TextEditingController _inputController = new TextEditingController();
  List mockResults = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        title: Text('Nuevo Proyecto'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: colorPrincipal.withOpacity(.9),
        child: ListView(children: [
          Container(
            margin: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titles('Nombre Proyecto'),
                _widgets(_projectInput()),
                _titles('Entrega'),
                _widgets(_crearFecha()),
                _titles('Integrantes'),
                _integrantes(),
                _titles('Tipo Proyecto'),
                _widgets(_projectType()),
                _titles('Lider'),
                _widgets(_projetLeader()),
                _titles('Descripción'),
                _titles('Lenguaje(s)'),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _buildListItem(DocumentSnapshot doc) {
    mockResults.add(doc.get('Nombre'));
    return Text(doc.get('Nombre').toString());
  }

  Widget _titles(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _widgets(Widget widget) {
    return Container(margin: EdgeInsets.only(bottom: 20), child: widget);
  }

  Widget _projectInput() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: TextField(
          //autofocus: true,

          cursorColor: colorPrincipal,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(15), right: Radius.circular(15))),
              hintText: 'Sapphire Landing Page',
              hintStyle: TextStyle(color: colorPrincipal.withOpacity(.7)),
              fillColor: colorPrincipal.withOpacity(.8)),
          style: TextStyle(color: colorPrincipal),
          onChanged: (data) {}),
    );
  }

  _crearFecha() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15))),
          hintText: 'Fecha de nacimiento',
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2021),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        _fecha = picked.toString().substring(0, 10);
        _inputController.text = _fecha;
      });
    }
  }

  Widget _projectType() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: TextField(
          //autofocus: true,

          cursorColor: colorPrincipal,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(15), right: Radius.circular(15))),
              hintText: 'E-Commerce',
              hintStyle: TextStyle(color: colorPrincipal.withOpacity(.7)),
              fillColor: colorPrincipal.withOpacity(.8)),
          style: TextStyle(color: colorPrincipal),
          onChanged: (data) {}),
    );
  }

  Widget _projetLeader() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: ChipsInput(
          chipBuilder: (context, state, profile) {
            return InputChip(
              key: ObjectKey(profile),
              label: Text(profile.name),
              avatar: CircleAvatar(
                backgroundImage: NetworkImage(profile.imageUrl),
              ),
              onDeleted: () => state.deleteChip(profile),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          },
          suggestionBuilder: (context, state, profile) {
            return ListTile(
              key: ObjectKey(profile),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profile.imageUrl),
              ),
              title: Text(profile.name),
              subtitle: Text(profile.email),
              onTap: () => state.selectSuggestion(profile),
            );
          },
          findSuggestions: (String query) {
            if (query.length != 0) {
              var lowercaseQuery = query.toLowerCase();
              return mockResults.where((profile) {
                return profile.name.toLowerCase().contains(query.toLowerCase());
              }).toList(growable: false)
                ..sort((a, b) => a.name
                    .toLowerCase()
                    .indexOf(lowercaseQuery)
                    .compareTo(b.name.toLowerCase().indexOf(lowercaseQuery)));
            } else {
              return const [];
            }
          },
          onChanged: (data) {
            print(data);
          },
        ));
  }

  Widget _integrantes() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Integrantes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data.docs
                    .map<Widget>((doc) => _buildListItem(doc))
                    .toList());
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
