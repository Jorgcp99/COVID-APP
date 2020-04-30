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
      appBar: AppBar(
        title: Text(
          'Scanner',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 90,
          ),
          Center(
            child: GestureDetector(
              onTap: () => _scan(),
              child: Container(
                height: 158,
                width: 158,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(101, 199, 178, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text("Scan",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.78,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 2.5), //(x,y)
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: Center(child: _statusText),
              ),
            ),
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
        Firestore.instance
            .collection('eventos')
            .document(codes[0])
            .collection('reservas')
            .getDocuments()
            .then((reservasList) {
          reservasList.documents.forEach((reserva) {
            if (reserva.data['id_usuario'] == codes[1] &&
                reserva.data['is_checked'] == false) {
              Firestore.instance
                  .collection('eventos')
                  .document(codes[0])
                  .collection('reservas')
                  .document(reserva.documentID)
                  .updateData({'is_checked': true});
              setState(() {
                _statusText = Text(
                  'Todo correcto',
                  style: TextStyle(fontSize: 20, color: Colors.greenAccent),
                );
              });
            } else {
              setState(() {
                _statusText = Text(
                  'Algo no va bien',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                );
              });
            }
          });
        });
        //Firestore.instance.collection('eventos').document()
      });
    }
  }
}
