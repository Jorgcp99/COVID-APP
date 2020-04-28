

class Event{
  String title;
  String date;
  String eventLocation;
  String streetAddress;

  Event(this.title, this.date, this.eventLocation, this.streetAddress);

  factory Event.fromMap(Map<String, dynamic> map){
    String title =  map['title'];
    String date =  map['dtstart'];
    String eventLocation = map['event-location'];
    String streetAddress = map['street-addres'];
    return Event(title, date, eventLocation, streetAddress);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['title'] = this.title;
    map['dtstart'] = this.date;
    map['event-location'] = this.eventLocation;
    map['street-addres'] = this.streetAddress;
    return map;
  }

}