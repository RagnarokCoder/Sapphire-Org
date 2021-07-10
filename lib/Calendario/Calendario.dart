import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sapphire_org/HexaColors/HexaColors.dart';
import 'package:sapphire_org/Menu/HomeScree.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yudiz_modal_sheet/yudiz_modal_sheet.dart';
import 'package:intl/intl.dart';

class Calendario extends StatefulWidget {
  Calendario({Key key}) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();
}

TimeOfDay picked;
int minute, hour;
int dia = int.parse(DateFormat('dd').format(DateTime.now())),
    mes = int.parse(DateFormat('MM').format(DateTime.now())),
    year = int.parse(DateFormat('yyyy').format(DateTime.now()));
bool fechaSeleccionada;
int diaSel, mesSel, yearSel;
final myController = TextEditingController();
final myControllerDes = TextEditingController();
String hora;
bool cargando = false;
Color colorPrincipal = HexColor("#121212");

class _CalendarioState extends State<Calendario> {
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  CalendarController _controller;
  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: colorPrincipal, fontWeight: fontWeight);
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScree(),
                ));
          },
        ),
        centerTitle: true,
        title: Text(
          'Agenda',
          style: GoogleFonts.oswald(),
        ),
        backgroundColor: colorPrincipal,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarController: _controller,
              calendarStyle: CalendarStyle(
                weekdayStyle: dayStyle(FontWeight.normal),
                weekendStyle: dayStyle(FontWeight.normal),
                selectedColor: Color(0xff30374b),
                todayColor: Colors.red,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                color: colorPrincipal,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: colorPrincipal,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: colorPrincipal,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: colorPrincipal,
                  )),
              onDaySelected: (date, events, holidays) {
                dia = date.day;
                mes = date.month;
                year = date.year;
                if (date.day ==
                        int.parse(DateFormat('dd').format(DateTime.now())) &&
                    date.month ==
                        int.parse(DateFormat('MM').format(DateTime.now())) &&
                    date.year ==
                        int.parse(DateFormat('yyyy').format(DateTime.now()))) {
                  fechaSeleccionada = true;
                } else {
                  fechaSeleccionada = false;
                }
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                  color: colorPrincipal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: fechaSeleccionada == true
                            ? Text("Hoy",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30))
                            : Text("$dia / $mes / $year",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Agenda')
                            .where('Dia', isEqualTo: dia)
                            .where('Mes', isEqualTo: mes)
                            .where('Año', isEqualTo: year)
                            .where('Pendiente', isEqualTo: true)
                            .limit(5)
                            .snapshots(),
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
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showBottomModal(context);
        },
        label: Text(
          'Agregar',
          style: TextStyle(color: Colors.black),
        ),
        icon: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }

  //builder citas
  _buildListItem(DocumentSnapshot doc) {
    bool pendiente = doc.data();
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    pendiente == true
                        ? Icons.circle_notifications
                        : Icons.check_circle,
                    color: pendiente == true ? Colors.red : Color(0xff00cf8d),
                    size: 30,
                  ),
                  onPressed: () {
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
                                "Cita Completada?",
                                style: (TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ignore: deprecated_member_use
                                  RaisedButton.icon(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("Agenda")
                                            .doc(doc.id)
                                            .update({"Pendiente": false});
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
                                  // ignore: deprecated_member_use
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
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 2, right: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${doc.data()}",
                        style: (TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${doc.data()}",
                        style: (TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Text(
                          "${doc.data()}",
                          style: (TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red.shade900),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("Agenda")
                                .doc(doc.id)
                                .delete();
                          },
                        )
                      ],
                    ))
              ],
            ),
            Divider(height: 12, color: Colors.white)
          ],
        ));
  }

  _showBottomModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              // height: 800,
              color: Colors.transparent,
              child: new Container(
                decoration: new BoxDecoration(
                  color: colorPrincipal,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius:
                          10.0, // has the effect of softening the shadow
                      spreadRadius:
                          0.0, // has the effect of extending the shadow
                    )
                  ],
                ),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            'Nueva Cita',
                            style: GoogleFonts.oswald(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                        cargando == false
                            ? Container(
                                margin: EdgeInsets.only(top: 5, right: 5),
                                child: RaisedButton.icon(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    onPressed: () {
                                      cargando = true;
                                      FirebaseFirestore.instance
                                          .collection("Agenda")
                                          .add({
                                        "Nombre": myController.text,
                                        "Descripcion": myControllerDes.text,
                                        "Dia": dia,
                                        "Mes": mes,
                                        "Año": year,
                                        "Pendiente": true,
                                        'Hora': hora,
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 1), () {
                                        setState(() {
                                          cargando = false;
                                          myController.text = "";
                                          myControllerDes.text = "";
                                          hora = null;
                                          Navigator.pop(context);
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.save_alt,
                                      color: Color(0xff00B8D4),
                                    ),
                                    label: Text(
                                      "Guardar",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            : SizedBox(
                                child: CircularProgressIndicator(
                                  backgroundColor: colorPrincipal,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                                height: 20.0,
                                width: 20.0,
                              ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: const Color(0xfff8f8f8),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //input para subir nuevas citas
                          _buildTextField(
                            Icons.person_add,
                            "Nombre",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _buildTextFieldDesc(
                              Icons.description_sharp, "Descripción"),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      showPicker(
                                        context: context,
                                        value: _time,
                                        onChange: onTimeChanged,
                                        minuteInterval: MinuteInterval.FIVE,
                                        disableHour: false,
                                        disableMinute: false,
                                        minMinute: 0,
                                        maxMinute: 59,
                                        is24HrFormat: true,
                                        sunAsset: Image.asset(
                                            "assets/ajoloteday.gif"),
                                        moonAsset: Image.asset(
                                            "assets/ajolotenight.gif"),
                                        okText: "Confirmar",
                                        cancelText: "Cancelar",
                                        accentColor: colorPrincipal,
                                        barrierColor: Colors.white,
                                        unselectedColor: Colors.red,
                                        // Optional onChange to receive value as DateTime
                                        onChangeDateTime: (DateTime dateTime) {
                                          hora = "${dateTime.hour}:" +
                                              "${dateTime.minute}";
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.hourglass_empty,
                                      color: Colors.white),
                                  label: Text(
                                    "Seleccione Hora",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                hora == null
                                    ? SizedBox()
                                    : Text(
                                        "Hora Seleccionada: \n$hora",
                                        style: TextStyle(color: Colors.white),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  _buildTextField(IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: colorPrincipal, border: Border.all(color: Colors.white)),
      child: TextField(
        controller: myController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  _buildTextFieldDesc(IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: colorPrincipal, border: Border.all(color: Colors.white)),
      child: TextField(
        controller: myControllerDes,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
