import 'package:flutter/material.dart';
import 'package:tripbudgeter/common/app_theme.dart';
import 'package:tripbudgeter/config/routes/routes.dart';
import 'package:tripbudgeter/features/home/views/pages/homepage.dart';
import 'package:tripbudgeter/features/profile/custom_drawer/home_drawer.dart';
import 'package:tripbudgeter/features/trips/views/pages/add_trips.dart';

class DrawerUserController extends StatefulWidget {
  DrawerUserController({
    Key? key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex)? onDrawerCall;
  Widget? screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;
  DrawerIndex? screenIndex;

  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController
      ?..animateTo(1.0,
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController!.addListener(() {
      _handleScrollListener();
    });
    // Thiết lập màn hình mặc định là Home khi khởi tạo
    widget.screenIndex ??= DrawerIndex.HOME;
    widget.screenView = HomeScreen();
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
  }

  Future<void> getInitState() async {
    scrollController?.jumpTo(widget.drawerWidth);
  }

  void _handleScrollListener() {
    if (scrollController!.offset <= 0) {
      if (scrollOffset != 1.0) {
        setState(() {
          scrollOffset = 1.0;
          widget.drawerIsOpen?.call(true);
        });
      }
      iconAnimationController?.animateTo(0.0);
    } else if (scrollController!.offset > 0 &&
        scrollController!.offset < widget.drawerWidth) {
      iconAnimationController?.animateTo(
          (scrollController!.offset / widget.drawerWidth),
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn);
    } else {
      if (scrollOffset != 0.0) {
        setState(() {
          scrollOffset = 0.0;
          widget.drawerIsOpen?.call(false);
        });
      }
      iconAnimationController?.animateTo(1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController!,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          scrollController!.offset, 0.0, 0.0),
                      child: HomeDrawer(
                        screenIndex: widget.screenIndex ?? DrawerIndex.HOME,
                        iconAnimationController: iconAnimationController,
                        callBackIndex: (DrawerIndex indexType) {
                          onDrawerClick(indexType);
                          widget.onDrawerCall?.call(indexType);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.6),
                          blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      IgnorePointer(
                        ignoring: scrollOffset == 1,
                        child: widget.screenView,
                      ),
                      if (scrollOffset == 1.0)
                        InkWell(
                          onTap: () {
                            onDrawerClick(DrawerIndex.About);
                          },
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                onDrawerClick(DrawerIndex.PLANNING);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDrawerClick(DrawerIndex indexType) {
    final targetOffset =
        scrollController!.offset != 0.0 ? 0.0 : widget.drawerWidth;

    scrollController
        ?.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    )
        .then((_) {
      _updateScreen(indexType);
    });
  }

  void _updateScreen(DrawerIndex indexType) {
    setState(() {
      widget.screenIndex = indexType;
      switch (indexType) {
        case DrawerIndex.HOME:
          widget.screenView = HomeScreen();
          break;
        case DrawerIndex.PLANNING:
          widget.screenView = TripStepper();
          break;
        case DrawerIndex.About:
          // widget.screenView = AboutScreen(); // Uncomment and implement
          break;
        case DrawerIndex.FeedBack:
          // widget.screenView = FeedbackScreen(); // Uncomment and implement
          break;
        case DrawerIndex.Share:
          // widget.screenView = ShareScreen(); // Uncomment and implement
          break;
        case DrawerIndex.Invite:
          // widget.screenView = InviteScreen(); // Uncomment and implement
          break;
        default:
          break;
      }
    });
  }
}
