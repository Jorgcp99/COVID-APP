

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/data/event.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';

class EventsPresenter{
  EventsView _view;
  HttpRemoteRepository _remoteRepository;

  EventsPresenter(this._view, this._remoteRepository);

  getFirebaseEvents(){
    List<Event> eventList = [];
    Firestore.instance.collection('eventos').getDocuments().then((events){
      events.documents.forEach((event){
        Event ev = Event(event.data['nombre'], event.data['fecha'], event.data['lugar'], event.data['direccion'], event.data['num_entradas']);
        eventList.add(ev);
        _view.showEventsInfo(eventList);
      });
    });
  }


}


abstract class EventsView{
  showEventsInfo(List<Event> events);
}