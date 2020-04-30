
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  List<Container> _messages2 = <Container>[];
  List<String> suggestions = [];
  bool save = false;
  bool fiebre = false;
  String key = "";
  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    _messages2.add(
      Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  //Wrapping the container with flexible widget
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(17.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 2.5), //(x,y)
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              //We only want to wrap the text message with flexible widget
                              child: Text(
                                "¿En que te puedo ayudar?",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Response2("que es el covid"),
                    child: Container(
                      height: 45,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xCC000000),
                            const Color(0x00000000),
                            const Color(0x00000000),
                            const Color(0xCC000000),
                          ],
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/covid.jpg"),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.5), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "COVID-19",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                    child: GestureDetector(
                      onTap: () => Response2("sintomas del covid"),
                      child: Container(
                        height: 45,
                        width: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/resfriado.jpg"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 2.5), //(x,y)
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Síntomas",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Response2("medidas de higiene"),
                    child: Container(
                      height: 45,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/manos.jpg"),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.5), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Higiene",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height - 100,
                        child: ListView.builder(
                          padding: new EdgeInsets.fromLTRB(0, 130, 0, 80),
                          shrinkWrap: false,
                          itemBuilder: (_, int index) => _messages2[index],
                          itemCount: _messages2.length,
                        ),
                      ),
                    ],
                  ),
                  _buildAppbarComposer(),
                  _buildTextComposer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Padding(
      padding:
      EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height - 135, 0, 0),
      child: Center(
        child: new ClipRect(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              height: 60,
              color: Color.fromRGBO(0, 0, 0, 0.0),
              //margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Container(
                        height: 38,
                        width: MediaQuery.of(context).size.width * 0.77,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: TextField(
                            controller: _textController,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "¿Que dudas tienes?"),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: () => _textController.text.isNotEmpty
                            ? _handleSubmitted2(_textController.text)
                            : null,
                        child: Image.asset(
                          'assets/send2.png',
                          height: 37,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppbarComposer() {
    return Center(
      child: new ClipRect(
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.0),
              //margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Center(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 23.0,
                          backgroundImage: NetworkImage(
                              "https://media.idownloadblog.com/wp-content/uploads/2016/03/Generic-profile-image-002.png"),
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text("CovidBot"),
                        ),
                      ],
                    )),
              )),
        ),
      ),
    );
  }

  void Response2(query) async {

    if(query == "si tengo fiebre"){
      fiebre = true;
    }
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/credenciales.json").build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.spanish);
    AIResponse response = await dialogflow.detectIntent(query);

    if (response.getMessage() == "¿tienes fiebre?") {
      save = true;
      key = "fiebre";
    }
    if (response.getMessage() == "¿Tienes tos seca o cansancio general?") {
      save = true;
      key = "tos seca y cansancio";
    }
    if (response.getMessage() == "¿Sufres dolor o presión persistente en el pecho, Confusión o dificultad para estar alerta que no haya tenido antes o coloración azulada en los labios o el rostro?") {
      save = true;
      fiebre = false;
      key = "sintomas graves";
    }

    Container message = new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            //Wrapping the container with flexible widget
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              margin: EdgeInsets.fromLTRB(10, 10, 50, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(17.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.5), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    //We only want to wrap the text message with flexible widget
                    child: Text(
                      response.getMessage() ??
                          new CardDialogflow(response.getListMessage()[0])
                              .title,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    setState(() {
      _messages2 = _messages2.reversed.toList();
      _messages2.insert(0, message);
      save ? _messages2.insert(0, containerDecision(key)) : save = false;
      _messages2 = _messages2.reversed.toList();
      save = false;
    });
  }

  void _handleSubmitted2(String text) {
    _textController.clear();
    Container message = new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            //Wrapping the container with flexible widget
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              margin: EdgeInsets.fromLTRB(50, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(17.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.5), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    //We only want to wrap the text message with flexible widget
                    child: Container(
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    setState(() {
      _messages2 = _messages2.reversed.toList();
      _messages2.insert(0, message);
      _messages2 = _messages2.reversed.toList();
    });
    Response2(text);
  }

  Widget containerDecision(String key) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => fiebre ? Response2("si tengo " + key + " y fiebre") :  Response2("si tengo " + key),
            child: Container(
              padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
              margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(17.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.5), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    //We only want to wrap the text message with flexible widget
                    child: Container(
                      child: Text(
                        "Si",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>  fiebre ?  Response2("no tengo " + key + "pero si fiebre") :  Response2("no tengo " + key),
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(17.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.5), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    //We only want to wrap the text message with flexible widget
                    child: Container(
                      child: Text(
                        "No",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Text('B')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
            child: new Text(
              this.name[0],
              style: new TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
