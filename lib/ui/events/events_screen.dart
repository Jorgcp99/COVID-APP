

import 'package:covid_app/data/event.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';
import 'package:covid_app/ui/events/events_presenter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> implements EventsView{

  TextEditingController _inputController;
  TextEditingController _outputController;

  EventsPresenter _presenter;
  List<Event> _events;

  @override
  void initState() {
    super.initState();
    _presenter = EventsPresenter(this, HttpRemoteRepository(Client()));
    _presenter.getDistrictInfo();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
    _events = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('osmdfosam'),),
    body: Container(
      child: Column(
        children: <Widget>[
          QrImage(
            data: 'Hola soy Jesus',
            size: 250,
          ),
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: ()=> _scan(),
          ),
          Text(_outputController.text),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(_events[index].title),
                      subtitle: Text(_events[index].date),
                    );
                  }),
            ),
          )

        ],
      ),
    ),);
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
      this._outputController.text = barcode;
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
