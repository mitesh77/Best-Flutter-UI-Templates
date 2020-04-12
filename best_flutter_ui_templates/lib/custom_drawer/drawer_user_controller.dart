import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/custom_drawer/home_drawer.dart';
import 'package:flutter/material.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    Key key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenView,
    this.animationController,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex) onDrawerCall;
  final Widget screenView;
  final Function(AnimationController) animationController;
  final Function(bool) drawerIsOpen;
  final AnimatedIconData animatedIconData;
  final Widget menuView;
  final DrawerIndex screenIndex;

  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  AnimationController iconAnimationController;
  AnimationController animationController;

  double scrolloffset = 0.0;
  bool isSetDawer = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController
      ..addListener(() {
        if (scrollController.offset <= 0) {
          if (scrolloffset != 1.0) {
            setState(() {
              scrolloffset = 1.0;
              try {
                widget.drawerIsOpen(true);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(0.0,
              duration: const Duration(milliseconds: 0), curve: Curves.linear);
        } else if (scrollController.offset > 0 &&
            scrollController.offset < widget.drawerWidth) {
          iconAnimationController.animateTo(
              (scrollController.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(milliseconds: 0),
              curve: Curves.linear);
        } else if (scrollController.offset <= widget.drawerWidth) {
          if (scrolloffset != 0.0) {
            setState(() {
              scrolloffset = 0.0;
              try {
                widget.drawerIsOpen(false);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(1.0,
              duration: const Duration(milliseconds: 0), curve: Curves.linear);
        }
      });
    getInitState();
    super.initState();
  }

  Future<bool> getInitState() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    try {
      widget.animationController(iconAnimationController);
    } catch (_) {}
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    scrollController.jumpTo(
      widget.drawerWidth,
    );
    setState(() {
      isSetDawer = true;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        // scrolloffset == 1.0
        //     ? PageScrollPhysics(parent: ClampingScrollPhysics())
        //     : PageScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Opacity(
          opacity: isSetDawer ? 1 : 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width + widget.drawerWidth,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: widget.drawerWidth,
                  height: MediaQuery.of(context).size.height,
                  child: AnimatedBuilder(
                    animation: iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            scrollController.offset, 0.0, 0.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: widget.drawerWidth,
                          child: HomeDrawer(
                            screenIndex: widget.screenIndex == null
                                ? DrawerIndex.HOME
                                : widget.screenIndex,
                            iconAnimationController: iconAnimationController,
                            callBackIndex: (DrawerIndex indexType) {
                              onDrawerClick();
                              try {
                                widget.onDrawerCall(indexType);
                              } catch (e) {}
                            },
                          ),
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
                          ignoring: scrolloffset == 1 || false,
                          child: widget.screenView == null
                              ? Container(
                                  color: Colors.white,
                                )
                              : widget.screenView,
                        ),
                        scrolloffset == 1.0
                            ? InkWell(
                                onTap: () {
                                  onDrawerClick();
                                },
                              )
                            : SizedBox(),
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
                                child: Center(
                                  child: widget.menuView != null
                                      ? widget.menuView
                                      : AnimatedIcon(
                                          icon: widget.animatedIconData != null
                                              ? widget.animatedIconData
                                              : AnimatedIcons.arrow_menu,
                                          progress: iconAnimationController),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  onDrawerClick();
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
      ),
    );
  }

  void onDrawerClick() {
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
