

class District{
  String id;
  String name;
  int numCasos;
  int numCasosUlt14Dias;
  String fechaInforme;

  District(this.id, this.name, this.numCasos, this.numCasosUlt14Dias, this.fechaInforme);


  factory District.fromMap(Map<String, dynamic> map){
    String id =  map['codigo_geometria'];
    String name =  map['municipio_distrito'];
    int numCasos = map['casos_confirmados_totales'];
    int numCasosUlt14Dias = map['casos_confirmados_ultimos_14dias'];
    String fechaInforme = map['fecha_informe'];
    return District(id, name, numCasos, numCasosUlt14Dias, fechaInforme);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['codigo_geometria'] = this.id;
    map['municipio_distrito'] = this.name;
    map['casos_confirmados_totales'] = this.numCasos;
    map['casos_confirmados_ultimos_14dias'] = this.numCasosUlt14Dias;
    map['fecha_informe'] = this.fechaInforme;
    return map;
  }


}

