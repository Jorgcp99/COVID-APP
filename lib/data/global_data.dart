
class GlobalData{
  int timestamp;
  int casosConfirmados;
  int fallecidos;
  int recuperados;
  int hospitalizados;

  GlobalData(this.timestamp, this.casosConfirmados, this.fallecidos, this.recuperados, this.hospitalizados);


  factory GlobalData.fromMap(Map<String, dynamic> map){
    int timestamp =  map['Fecha'];
    int casosConfirmados =  map['CasosConfirmados'];
    int fallecidos = map['Fallecidos'];
    int recuperados = map['Recuperados'];
    int hospitalizados = map['Hospitalizados'];
    return GlobalData(timestamp, casosConfirmados, fallecidos, recuperados, hospitalizados);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['Fecha'] = this.timestamp;
    map['CasosConfirmados'] = this.casosConfirmados;
    map['Fallecidos'] = this.fallecidos;
    map['Recuperados'] = this.recuperados;
    map['Hospitalizados'] = this.hospitalizados;
    return map;
  }

}
