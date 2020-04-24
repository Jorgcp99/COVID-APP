import 'package:covid_app/data/district.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';
import 'package:covid_app/ui/main/main_presenter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> implements MainView{

  MainPresenter _presenter;
  String dropdownValue = 'One';
  List<District> _districts;

  @override
  void initState() {
    _presenter = MainPresenter(this, HttpRemoteRepository(Client()));
    _presenter.getDistrictList();
    _districts = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://www.lugaresconhistoria.com/wp-content/uploads/2013/03/gran_vc3ada_madrid_desde_callao-felipe-gabaldc3b3n.jpg'),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.35),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'CO',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(248, 248, 248, 1.0),
                          fontFamily: GoogleFonts.archivoNarrow().fontFamily),
                    ),
                    Text(
                      'VID-A',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(101, 199, 178, 1.0),
                          fontFamily: GoogleFonts.archivoNarrow().fontFamily),
                    ),
                    Text(
                      'PP',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(248, 248, 248, 1.0),
                          fontFamily: GoogleFonts.archivoNarrow().fontFamily),
                    ),
                  ],
                ),
              ),

                Positioned(
                  top: 220,
                  left: 20,
                  child: Text(_presenter.getFormattedDate(), style: TextStyle(fontSize: 27),),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: _districts.length,
                    itemBuilder: (context, index){
                    return ListTile(
                      title: Text(_districts[index].name),
                      subtitle: Text(_districts[index].fechaInforme),
                    );
                    }),
              ),
            )
          ],
        )),
      ),
    );
  }

  @override
  showDistrictList(List<District> districts) {
   setState(() {
     _districts = districts;
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
