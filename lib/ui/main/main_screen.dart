import 'package:covid_app/data/district.dart';
import 'package:covid_app/data/district_data.dart';
import 'package:covid_app/data/global_show_info.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';
import 'package:covid_app/ui/chat_bot/chat_bot_screen.dart';
import 'package:covid_app/ui/main/main_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> implements MainView {
  MainPresenter _presenter;
  List<District> _districts;
  TextEditingController _typeAheadController = TextEditingController();
  String _selectedDistrictName;
  IconButton _sufixIcon;
  WebViewController _controller;
  double _chartMaxWidth;
  Size _districtInfoSize;
  DistrictData _selectedDistrict;
  GlobalShowInfo _globalData;

  @override
  void initState() {
    _presenter = MainPresenter(this, HttpRemoteRepository(Client()));
    _presenter.getDistrictList();
    _districts = [];
    _selectedDistrictName = 'Buscar un distrito';
    _selectedDistrict = DistrictData('', '', 0, 0, 0.0);
    _globalData = GlobalShowInfo(0, 0, 0, 0, 0, 0, 0, 0);
    _sufixIcon = IconButton(
      icon: Icon(Icons.search),
    );
    _districtInfoSize = Size(0, 0);
    _presenter.getGlobalData();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _chartMaxWidth = MediaQuery.of(context).size.width;
    });
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'CO',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(0, 120, 185, 1.0),
                            fontFamily: GoogleFonts.archivoNarrow().fontFamily),
                      ),
                      Text(
                        'VID-A',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(101, 199, 178, 1.0),
                            fontFamily: GoogleFonts.archivoNarrow().fontFamily),
                      ),
                      Text(
                        'PP',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(0, 120, 185, 1.0),
                            fontFamily: GoogleFonts.archivoNarrow().fontFamily),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color.fromRGBO(238, 244, 243, 1.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(
                            'assets/covidWorld.png',
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "COVID-19",
                                  style: TextStyle(
                                      color: Color.fromRGBO(61, 94, 86, 1.0),
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Síntomas mas frecuentes",
                                    style: TextStyle(
                                        color: Color.fromRGBO(61, 94, 86, 1.0),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 20, 0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatBotScreen()),
                                    ),
                                    child: Container(
                                      height: 28,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Color.fromRGBO(61, 94, 86, 1.0),
                                          )),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Text("Consultar",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      61, 94, 86, 1.0),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    _presenter.getFormattedDate(),
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        )),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Form(
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: _typeAheadController,
                              decoration: InputDecoration(
                                labelText: _selectedDistrictName,
                                suffixIcon: _sufixIcon,
                                border: InputBorder.none,
                              )),
                          suggestionsCallback: (pattern) {
                            return getDistrictClue(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            District dis = suggestion as District;
                            return ListTile(
                              title: Text(dis.name),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            District dist = suggestion as District;
                            _presenter.getDistrictInfo(dist.id);
                            _typeAheadController.text = dist.name;
                            expandDistrictInfo();
                            setState(() {
                              _sufixIcon = IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _typeAheadController.clear();
                                  minimizeDistrictInfo();
                                  setState(() {
                                    _sufixIcon = IconButton(
                                      icon: Icon(Icons.search),
                                    );
                                  });
                                },
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    districtInfo(),
                  ],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Center(
                          child: Text(
                            'Situación en Madrid',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: 300,
                              child: WebView(
                                initialUrl:
                                    'https://datawrapper.dwcdn.net/tWpPl',
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated:
                                    (WebViewController webViewController) {
                                  _controller = webViewController;
                                  _controller.loadUrl(
                                      'https://datawrapper.dwcdn.net/tWpPl/5/');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          color: Color.fromRGBO(251, 251, 251, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 105,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  child: Text("Última información",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "+" +
                                                  _globalData.todayCases
                                                      .toString(),
                                            ),
                                            Text("Positivos PCR")
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "+" +
                                                  _globalData.tadayFallecidos
                                                      .toString(),
                                            ),
                                            Text("Fallecidos")
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "+" +
                                                  _globalData.todayRecuperados
                                                      .toString(),
                                            ),
                                            Text("Recuperados")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.93,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(251, 251, 251, 1.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 18, 25, 23),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Recuento total Comunidad Madrid',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  buildChart(0),
                                  buildChart(1),
                                  buildChart(2),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Últimas noticias',
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Container(
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.all(
//                                  Radius.circular(20.0),
//                                ),
//                              ),
//                              width: MediaQuery.of(context).size.width * 0.95,
//                              height: 1200,
//                              child: WebView(
//                                initialUrl: 'https://twitter.com/sanidadgob',
//                                javascriptMode: JavascriptMode.unrestricted,
//                                onWebViewCreated:
//                                    (WebViewController webViewController) {
//                                  _controller = webViewController;
//                                  _controller.loadUrl(
//                                      'https://twitter.com/sanidadgob');
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget districtInfo() {
    return TweenAnimationBuilder(
      tween: SizeTween(
          begin: Size(MediaQuery.of(context).size.width * 0.9, 0),
          end: _districtInfoSize),
      duration: Duration(milliseconds: 600),
      builder: (_, Size size, __) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 5, 18, 15),
            child: Card(
              elevation: 3.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: size.height,
                color: Color.fromRGBO(251, 251, 251, 1.0),
                child: _selectedDistrict.todayNewCases == null
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'Hoy',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      _selectedDistrict.todayNewCases
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.red),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: showProgressPercentage(
                                          _selectedDistrict
                                              .differencePercentage),
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      'Ayer',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        _selectedDistrict.yesterdayNewCases
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.red),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Text showProgressPercentage(double percentage) {
    int per = percentage.floor();
    if (per.isNegative) {
      per = per * (-1);
      return Text(
        '+' + per.toString() + '%',
        style: TextStyle(color: Colors.red, fontSize: 17),
      );
    } else {
      return Text(
        '-' + per.toString() + '%',
        style: TextStyle(color: Colors.green, fontSize: 17),
      );
    }
  }

  expandDistrictInfo() {
    setState(() {
      _districtInfoSize = Size(MediaQuery.of(context).size.width, 80);
    });
  }

  minimizeDistrictInfo() {
    setState(() {
      _districtInfoSize = Size(MediaQuery.of(context).size.width, 0);
    });
  }

  Widget buildChart(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                index == 0
                    ? 'Infectados'
                    : index == 1 ? 'Fallecidos' : 'Recuperados',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                index == 0
                    ? _globalData.totalCases.toString()
                    : index == 1
                        ? _globalData.fallecidos.toString()
                        : _globalData.recuperados.toString(),
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: TweenAnimationBuilder(
                tween: SizeTween(
                    begin: Size(0, 5),
                    end: Size(
                        _chartMaxWidth *
                            (index == 0 ? 1 : index == 1 ? 0.15 : 0.36),
                        5)),
                duration: Duration(milliseconds: 1600),
                builder: (_, Size size, __) {
                  return Container(
                    decoration: BoxDecoration(
                        color: index == 0
                            ? Colors.yellow
                            : index == 1 ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    width: size.width,
                    height: 9,
                  );
                }),
          )
        ],
      ),
    );
  }

  List<District> getDistrictClue(String query) {
    List<District> districts = [];
    _districts.forEach((district) {
      if (district.name.toLowerCase().contains(query.toLowerCase())) {
        districts.add(district);
      }
      if (query == '') {
        return _districts;
      } else {
        return districts;
      }
    });
    return districts;
  }

  @override
  showDistrictList(List<District> districts) {
    setState(() {
      _districts = districts;
    });
  }

  @override
  showSelectedDistrict(DistrictData district) {
    setState(() {
      _selectedDistrict = district;
    });
  }

  @override
  showGlobalData(GlobalShowInfo data) {
    setState(() {
      _globalData = data;
    });
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.lineTo(sw, 0);
    path.lineTo(sw, sh);
    path.cubicTo(sw, sh * 0.7, 0, sh * 0.8, 0, sh * 0.55);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
