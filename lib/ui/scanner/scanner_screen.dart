

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  Text _statusText;
  TextEditingController _outputController;

  @override
  void initState() {
    super.initState();
    _statusText = Text('Status');
    _outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanner'),),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Center(
            child: RaisedButton(
              child: Text('Scan'),
              onPressed: ()=> _scan(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: _statusText,
          )
        ],
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

        List<String> codes = barcode.split('/');
        print('x-x-x-x-x-x-x-x-x-x-x');
        print(codes[0]);
        print(codes[1]);
        Firestore.instance.collection('eventos').document(codes[0]).collection('reservas').getDocuments().then((reservasList){
          reservasList.documents.forEach((reserva){
            if(reserva.data['id_usuario']==codes[1] && reserva.data['is_checked']==false){
              Firestore.instance.collection('eventos').document(codes[0]).collection('reservas').document(reserva.documentID).updateData({
                'is_checked': true
              });
              setState(() {
              _statusText = Text('Todo correcto', style: TextStyle(fontSize: 20, color: Colors.greenAccent),);
              });
            }else{
              setState(() {
              _statusText = Text('Algo no va bien', style: TextStyle(fontSize: 20, color: Colors.red),);

              });
            }
          });
        });
        //Firestore.instance.collection('eventos').document()
      });
    }
  }
}
