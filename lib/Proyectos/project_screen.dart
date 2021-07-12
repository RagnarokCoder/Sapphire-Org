import 'package:flutter/material.dart';
import 'package:sapphire_org/Calendario/Calendario.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      //backgroundColor: colorPrincipal,
      body: CustomScrollView(slivers: [
        _CustomAppBar(),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
                color: colorPrincipal.withOpacity(.93), child: _TeamMembers()),
            Container(
              color: colorPrincipal.withOpacity(.93),
              child: Text('Tareas:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: textTheme.headline5.fontSize)),
            ),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 51,
                )),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 0,
                )),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 100,
                )),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 99,
                )),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 39,
                )),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 70,
                )),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 70,
                )),
            Container(
                color: colorPrincipal.withOpacity(.93),
                child: _Task(
                  percentage: 70,
                )),
          ]),
        ),
      ]),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 1,
      automaticallyImplyLeading: true,
      backgroundColor: colorPrincipal,
      expandedHeight: 290,
      collapsedHeight: 60,
      floating: false,
      pinned: true,
      snap: false,
      title: Row(children: [
        Spacer(),
        Spacer(),
        Spacer(),
        Opacity(
            opacity: 1,
            child: Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Text('Nombre Proyecto'))),
        Spacer()
      ]),
      actions: [
        Container(
          width: 80,
          height: 30,
          margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.blueGrey),
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(
              ' En desarrollo ',
              style: TextStyle(
                fontSize: 29,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        background: Container(
          height: 100,
          color: colorPrincipal,
          alignment: Alignment.center,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30, left: 60, right: 30),
                  child: Row(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.width * .22,
                          child:
                              Image(image: AssetImage('assets/logoblc.png'))),
                      Container(
                        height: MediaQuery.of(context).size.width * .3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SafeArea(
                              child: Container(
                                margin: EdgeInsets.only(left: 30, top: 25),
                                child: Text(
                                  'Empresa: Jaza',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                'Lenguaje: C++',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                'Lider: Chiles',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Magna officia officia consectetur est nulla minim commodo sint enim. Proident qui velit mollit consequat.Magna officia officia consectetur est nulla minim commodo sint enim. Proident qui velit mollit consequat.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
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
                      margin: EdgeInsets.all(20),
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
                      margin: EdgeInsets.all(20),
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

class _Task extends StatelessWidget {
  final int percentage;
  const _Task({Key key, @required this.percentage, int percetage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: 60,
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10),
              child: _Percentage(percentage: percentage)),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Integrantes de proyecto',
                  style: TextStyle(
                      color: colorPrincipal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text('Responsable: German Jaramillo',
                      style: TextStyle(
                          color: colorPrincipal.withOpacity(.8), fontSize: 12)),
                  SizedBox(
                    width: 20,
                  ),
                  Text('1 day left',
                      style: TextStyle(
                          color: colorPrincipal.withOpacity(.8), fontSize: 12))
                ],
              )
            ],
          ),
          Spacer(),
          Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.api))
        ],
      ),
    );
  }
}

class _Percentage extends StatelessWidget {
  final int percentage;
  const _Percentage({Key key, @required this.percentage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (percentage < 50)
      return CircularPercentIndicator(
        radius: 40.0,
        lineWidth: 5.0,
        percent: percentage / 100,
        center: Text("$percentage%",
            style: TextStyle(color: colorPrincipal, fontSize: 11)),
        progressColor: Colors.redAccent,
      );
    if (percentage <= 99)
      return CircularPercentIndicator(
        radius: 40.0,
        lineWidth: 5.0,
        percent: percentage / 100,
        center: Text("$percentage%",
            style: TextStyle(color: colorPrincipal, fontSize: 11)),
        progressColor: Colors.deepPurpleAccent,
      );
    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 5.0,
      percent: 1.0,
      center: Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      progressColor: Colors.greenAccent,
    );
  }
}
