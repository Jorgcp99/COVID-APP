

import 'package:covid_app/data/event.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';

class EventsPresenter{
  EventsView _view;
  HttpRemoteRepository _remoteRepository;

  EventsPresenter(this._view, this._remoteRepository);

  getDistrictInfo()async{
    var events = await _remoteRepository.getEventsInfo();
    _view.showEventsInfo(events);
  }

}


abstract class EventsView{
  showEventsInfo(List<Event> events);
}