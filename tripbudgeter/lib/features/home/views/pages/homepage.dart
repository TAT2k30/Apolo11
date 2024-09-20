import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/home/views/pages/SecondPage.dart';
import 'package:tripbudgeter/features/home/views/widgets/trip_item.dart';

ThemeData appTheme = ThemeData(
    primaryColor: Colors.purple,
    /* Colors.tealAccent,*/
    secondaryHeaderColor: Colors.blue /* Colors.teal*/
    // fontFamily:
    );
int sel = 0;
double? width;
double? height;
final bodies = [
  const HomeScreen(),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2)); // Giả lập tải dữ liệu
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("More Info :"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                          ),
                          child: Image.asset('assets/images/gmail.png'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: appTheme.primaryColor.withOpacity(.5),
        child: const Icon(Icons.add),
      ),

      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const HomeTop(),
              homeDown2(context, "fails"),
              homeDown2(context, "success"),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> locs = ['Kerman (KER)', 'Mashhad (MASH)'];

class HomeTop extends StatefulWidget {
  const HomeTop({super.key});

  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {
  TextEditingController c = TextEditingController(text: locs[1]);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            height: 400,
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              appTheme.primaryColor,
              appTheme.secondaryHeaderColor
            ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.settings,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 16,
                ),
                const Text(
                  'Welcome to Trip Budgeter',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: c,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            child: InkWell(
                              child: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SecondPage(toloc: c.text);
                                }));
                              },
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height! * 0.025,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Clipper08 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    // ignore: non_constant_identifier_names
    var End = Offset(size.width / 2, size.height - 30.0);
    // ignore: non_constant_identifier_names
    var Control = Offset(size.width / 4, size.height - 50.0);

    path.quadraticBezierTo(Control.dx, Control.dy, End.dx, End.dy);
    // ignore: non_constant_identifier_names
    var End2 = Offset(size.width, size.height - 80.0);
    // ignore: non_constant_identifier_names
    var Control2 = Offset(size.width * .75, size.height - 10.0);

    path.quadraticBezierTo(Control2.dx, Control2.dy, End2.dx, End2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Choice08 extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final bool? selected;
  const Choice08({super.key, this.icon, this.text, this.selected});
  @override
  _Choice08State createState() => _Choice08State();
}

class _Choice08State extends State<Choice08>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.selected!
          ? BoxDecoration(
              color: Colors.white.withOpacity(.30),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(
            width: width! * .025,
          ),
          Text(
            widget.text!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}
