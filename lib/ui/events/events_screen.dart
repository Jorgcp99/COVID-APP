import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/data/booking.dart';
import 'package:covid_app/data/event.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';
import 'package:covid_app/ui/events/events_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> implements EventsView {
  TextEditingController _inputController;
  TextEditingController _outputController;

  EventsPresenter _presenter;
  List<Event> _events;
  HashMap _itemSize;
  HashMap _maxLines;
  HashMap _visibleProfileInfo;
  HashMap _swiperCount;
  HashMap _reservas2;
  List<Booking> _reservas;
  final String _userId = 'id_ejemplo';

  @override
  void initState() {
    super.initState();
    _presenter = EventsPresenter(this, HttpRemoteRepository(Client()));
    _presenter.getFirebaseEvents();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
    _events = [];
    _itemSize = HashMap<int, Size>();
    _maxLines = HashMap<int, int>();
    _visibleProfileInfo = HashMap<int, bool>();
    _swiperCount = HashMap<int, int>();
    _reservas = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventos',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _scan(),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _reservas.isEmpty
                ? Container(
                    color: Colors.red,
                  )
                : buildBookingSwiper(),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      return buildListItem(context, index);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, int index) {
    _itemSize.putIfAbsent(
        index, () => Size(MediaQuery.of(context).size.width * 0.7, 80));
    _maxLines.putIfAbsent(index, () => 2);
    _visibleProfileInfo.putIfAbsent(index, () => false);
    _swiperCount.putIfAbsent(index, () => 0);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: GestureDetector(
        onTap: () => animateEventCard(index),
        child: TweenAnimationBuilder(
          tween: SizeTween(
              begin: Size(MediaQuery.of(context).size.width * 0.60, 80),
              end: _itemSize[index]),
          duration: Duration(milliseconds: 500),
          builder: (_, Size size, __) {
            return Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.5), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _events[index].title,
                              style: TextStyle(fontSize: 19),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(_events[index].date),
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    top: 20,
                    right: 17,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(101, 199, 178, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(60.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _events[index].numEntradas.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 60,
                      bottom: 20,
                      child: _visibleProfileInfo[index]
                          ? AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: _visibleProfileInfo[index] ? 1 : 0,
                              child: Container(
                                  height: 30,
                                  width: 100,
                                  //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                                  child: Swiper(
                                    itemHeight: 2,
                                    itemWidth: 10,
                                    itemCount: 5,
                                    loop: false,
                                    onIndexChanged: (int i) {
                                      setState(() {
                                        _swiperCount[index] = i;
                                      });
                                    },
                                    control: SwiperControl(
                                        size: 20,
                                        iconPrevious: Icons.remove,
                                        iconNext: Icons.add,
                                        color:
                                            Color.fromRGBO(101, 199, 178, 1.0)),
                                    viewportFraction: 0.5,
                                    scale: 0.4,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 7),
                                        child: Text((ind + 1).toString()),
                                      );
                                    },
                                  )),
                            )
                          : Container()),
                  Positioned(
                      bottom: 22,
                      right: 60,
                      child: _visibleProfileInfo[index]
                          ? AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: _visibleProfileInfo[index] ? 1 : 0,
                              child: GestureDetector(
                                onTap: () => onReservaButtonPressed(
                                    _events[index],
                                    _swiperCount[index] + 1,
                                    index),
                                child: Container(
                                  height: 28,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(
                                        width: 1,
                                        color: Color.fromRGBO(101, 199, 178, 1.0),
                                      )),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Text("Reservar",
                                          style: TextStyle(
                                              color: Color.fromRGBO(101, 199, 178, 1.0),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  animateEventCard(int index) {
    setState(() {
      _itemSize[index] == Size(MediaQuery.of(context).size.width * 0.7, 80)
          ? _itemSize[index] =
              Size(MediaQuery.of(context).size.width * 0.7, 140)
          : _itemSize[index] =
              Size(MediaQuery.of(context).size.width * 0.7, 80);
      _visibleProfileInfo[index] == true
          ? _visibleProfileInfo[index] = false
          : _visibleProfileInfo[index] = true;
    });
  }

  onReservaButtonPressed(Event event, int numEntradas, int index) {
    Firestore.instance
        .collection('eventos')
        .document(event.id)
        .collection('reservas')
        .document()
        .setData({
      'id_usuario': 'id_ejemplo',
      'is_checked': false,
      'num_reservas': numEntradas,
      'timestamp': Timestamp.now()
    });
    Firestore.instance
        .collection('eventos')
        .document(event.id)
        .get()
        .then((ev) {
      int num = ev.data['num_entradas'] - numEntradas;
      Firestore.instance
          .collection('eventos')
          .document(event.id)
          .updateData({'num_entradas': num}).catchError((e) {
        print('-------------------');
        print(e);
      });
      setState(() {
        _events[index].numEntradas = num;
      });
    });
    _reservas.add(Booking(event.id, event.title, event.date, numEntradas));
    buildBookingSwiper();
  }

  Widget buildBookingSwiper() {
    return Container(
      height: 400,
      child: Swiper(
        itemCount: _reservas.length,
        viewportFraction: 0.58,
        scale: 0.4,
        loop: false,
        itemBuilder: (context, index) {
          Booking booking = _reservas[index];
          print('---------------------');
          print(booking.title);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color.fromRGBO(240, 240, 240, 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  QrImage(
                    data: booking.id + '/' + _userId,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      booking.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      booking.date,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Número de entradas: ',
                          ),
                          Text(booking.numEntradas.toString())
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        this._outputController.text = barcode;
        print(_outputController.text);
      });
    }
  }

  @override
  showEventsInfo(List<Event> events) {
    setState(() {
      _events = events;
    });
  }
}
