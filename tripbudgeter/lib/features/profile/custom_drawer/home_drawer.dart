import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tripbudgeter/common/app_theme.dart';
import 'package:tripbudgeter/features/auth/views/pages/login_page.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
    this.screenIndex,
    this.iconAnimationController,
    this.callBackIndex,
  }) : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  late final String userName;
  late final String avatarUrl;

  @override
  void initState() {
    setDrawerListArray();
    _getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? name = await secureStorage.read(key: 'userName');
    String? avatar = await secureStorage.read(key: 'avatarUrl');

    setState(() {
      userName = name ?? 'User';
      avatarUrl = avatar ?? '';
    });
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
          index: DrawerIndex.HOME, labelName: 'Home', icon: Icon(Icons.home)),
      DrawerList(
          index: DrawerIndex.PLANNING,
          labelName: 'Planning',
          icon: Icon(Icons.beach_access)),
      DrawerList(
          index: DrawerIndex.FeedBack,
          labelName: 'FeedBack',
          icon: Icon(Icons.help)),
      DrawerList(
          index: DrawerIndex.Invite,
          labelName: 'Invite Friend',
          icon: Icon(Icons.group)),
      DrawerList(
          index: DrawerIndex.Share,
          labelName: 'Rate the app',
          icon: Icon(Icons.share)),
      DrawerList(
          index: DrawerIndex.About,
          labelName: 'About Us',
          icon: Icon(Icons.info)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 63, 81, 181).withOpacity(0.9), // Màu nền
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.withOpacity(0.8),
                Colors.blue.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: widget.iconAnimationController ??
                            kAlwaysCompleteAnimation,
                        builder: (BuildContext context, Widget? child) {
                          final animationValue =
                              widget.iconAnimationController?.value ?? 1.0;
                          return ScaleTransition(
                            scale: AlwaysStoppedAnimation<double>(
                                1.0 - animationValue * 0.2),
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation<double>(
                                Tween<double>(begin: 0.0, end: 24.0)
                                        .animate(CurvedAnimation(
                                          parent:
                                              widget.iconAnimationController ??
                                                  kAlwaysCompleteAnimation,
                                          curve: Curves.fastOutSlowIn,
                                        ))
                                        .value /
                                    360,
                              ),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 188, 191, 194)
                                          .withOpacity(0.7),
                                      offset: const Offset(2.0, 4.0),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60.0)),
                                  child: Image.network(avatarUrl.isNotEmpty
                                      ? avatarUrl
                                      : 'default_avatar_url'), // Avatar mặc định
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          userName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white, // Màu chữ
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.6)), // Đường kẻ trắng
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0.0),
                  itemCount: drawerList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return inkwell(drawerList![index]);
                  },
                ),
              ),
              Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.6)), // Đường kẻ trắng
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: Icon(Icons.power_settings_new, color: Colors.red),
                    onTap: () {
                      onTapped();
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ],
          ),
        ));
  }

  void onTapped() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Icon(listData.icon?.icon, color: Colors.white), // Màu icon
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white, // Màu chữ
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  PLANNING,
  FeedBack,
  Share,
  About,
  Invite,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
