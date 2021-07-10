import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:sapphire_org/main.dart';

class ProjectDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _CustomAppBar(
        height: 380,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: colorPrincipal.withOpacity(.95),
        child: Column(children: [
          _TeamMembers(),
          _Tasks(),
        ]),
      ),
    );
  }
}

class _CustomAppBar extends PreferredSize {
  final double height;

  _CustomAppBar({this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      elevation: 2,
      child: Container(
        height: preferredSize.height,
        color: colorPrincipal,
        alignment: Alignment.center,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                  Spacer(),
                  Container(
                    height: 30,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff00cf8d)),
                    child: FittedBox(
                      child: Text(
                        ' En desarrollo ',
                        style: TextStyle(
                          fontSize: 29,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.width * .3,
                        child: Image(image: AssetImage('assets/logoblc.png'))),
                    Container(
                      height: MediaQuery.of(context).size.width * .3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Text(
                              'Fugiat et proident consectetur qui consequat sit ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textTheme.headline5.fontSize),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              'Lider de proyecto: Chiles',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textTheme.subtitle2.fontSize),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Magna officia officia consectetur est nulla minim commodo sint enim. Proident qui velit mollit consequat.Magna officia officia consectetur est nulla minim commodo sint enim. Proident qui velit mollit consequat.',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: textTheme.subtitle2.fontSize - 1),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.all(10),
                    child: FittedBox(
                      child: Text(
                        'Inicio: fechaIProject',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Entrega: fechaIProject',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int len = 5;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Integrantes:',
              style: TextStyle(
                  color: Colors.white, fontSize: textTheme.headline5.fontSize)),
          Container(
            height: 120,
            width: double.infinity,
            child: ListView.builder(
              itemCount: len + 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if (index < len) {
                  return _Member();
                }
                return _AddMember();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Member extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image(
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                image: AssetImage('assets/correctoaj.png'),
              ),
            )),
        Text('chiles', style: TextStyle(color: Colors.white))
      ],
    );
  }
}

class _AddMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              alignment: Alignment.center,
              color: colorPrincipal,
              width: 70,
              height: 70,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tareas:',
              style: TextStyle(
                  color: Colors.white, fontSize: textTheme.headline5.fontSize)),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * .98,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return _Task();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image(
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                image: AssetImage('assets/correctoaj.png'),
              ),
            )),
        Text('chiles', style: TextStyle(color: Colors.white))
      ],
    );
  }
}
