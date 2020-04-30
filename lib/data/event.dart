

class Event{
  String id;
  String title;
  String date;
  String eventLocation;
  String streetAddress;
  int numEntradas;

  Event(this.id, this.title, this.date, this.eventLocation, this.streetAddress, this.numEntradas);

  factory Event.fromMap(Map<String, dynamic> map){
    String title =  map['title'];
    String date =  map['dtstart'];
    String eventLocation = map['event-location'];
    String streetAddress = map['street-addres'];
    return Event('',title, date, eventLocation, streetAddress, 0);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['title'] = this.title;
    map['dtstart'] = this.date;
    map['event-location'] = this.eventLocation;
    map['address']['area']['street-address'] = this.streetAddress;
    return map;
  }

}