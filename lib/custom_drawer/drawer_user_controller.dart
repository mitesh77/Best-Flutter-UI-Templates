import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../custom_drawer/home_drawer.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController(
      {required this.onDrawerCall,
      required this.screenView,
      this.menuView,
      this.drawerIsOpen,
      this.animatedIconData = AnimatedIcons.arrow_menu,
      this.drawerWidth = 250,
      this.screenIndex = DrawerIndex.home,
      Key? key})
      : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex) onDrawerCall;
  final Widget screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData animatedIconData;
  final Widget? menuView;
  final DrawerIndex screenIndex;

  @override
  State<DrawerUserController> createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  double scrolloffset = 0.0;

  late final ScrollController scrollController;
  late final AnimationController animationController;
  late final AnimationController iconAnimationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController =
        AnimationController(vsync: this, duration: const Duration());
    iconAnimationController.animateTo(1.0,
        duration: const Duration(), curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        if (scrolloffset != 1.0) {
          if (mounted) {
            setState(() {
              scrolloffset = 1.0;
              try {
                final Function(bool)? function = widget.drawerIsOpen;
                if (function != null) function(true);
              } catch (_) {}
            });
          }
        }
        iconAnimationController.animateTo(0.0,
            duration: const Duration(), curve: Curves.fastOutSlowIn);
      } else if (scrollController.offset < widget.drawerWidth.floor()) {
        iconAnimationController.animateTo(
            (scrollController.offset * 100 / (widget.drawerWidth)) / 100,
            duration: const Duration(),
            curve: Curves.fastOutSlowIn);
      } else {
        if (scrolloffset != 0.0) {
          if (mounted) {
            setState(() {
              scrolloffset = 0.0;
              try {
                final Function(bool)? function = widget.drawerIsOpen;
                if (function != null) function(false);
              } catch (_) {}
            });
          }
        }
        iconAnimationController.animateTo(1.0,
            duration: const Duration(), curve: Curves.fastOutSlowIn);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    iconAnimationController.dispose();
    super.dispose();
  }

  Future<bool> getInitState() async {
    scrollController.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          //we use with as screen width and add drawerWidth (from navigation_home_screen)
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.drawerWidth,
                //we divided first drawer Width with HomeDrawer and second full-screen Width with all home screen, we called screen View
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController,
                  builder: (BuildContext context, _) {
                    return Transform(
                      //transform we use for the stable drawer  we, not need to move with scroll view
                      transform: Matrix4.translationValues(
                          scrollController.offset, 0.0, 0.0),
                      child: HomeDrawer(
                        screenIndex: widget.screenIndex,
                        iconAnimationController: iconAnimationController,
                        callBackIndex: (DrawerIndex indexType) {
                          onDrawerClick();
                          try {
                            widget.onDrawerCall(indexType);
                          } catch (e) {
                            debugPrint('drawer_user_controller?.dart: $e');
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //full-screen Width with widget.screenView
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
                      //this IgnorePointer we use as touch(user Interface) widget.screen View, for example scrolloffset == 1 means drawer is close we just allow touching all widget.screen View
                      IgnorePointer(
                        ignoring: scrolloffset == 1 || false,
                        child: widget.screenView,
                      ),
                      //alternative touch(user Interface) for widget.screen, for example, drawer is close we need to tap on a few home screen area and close the drawer
                      if (scrolloffset == 1.0)
                        GestureDetector(
                          onTap: () => onDrawerClick(),
                        ),

                      // this just menu and arrow icon animation
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
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                onDrawerClick();
                              },
                              child: Center(
                                // if you use your own menu view UI you add form initialization
                                child: widget.menuView ??
                                    AnimatedIcon(
                                        icon: widget.animatedIconData,
                                        progress: iconAnimationController),
                              ),
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

  void onDrawerClick() {
    //if scrollcontroller?.offset != 0.0 then we set to closed the drawer(with animation to offset zero position) if is not 1 then open the drawer
    if (scrollController.offset != 0.0) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
