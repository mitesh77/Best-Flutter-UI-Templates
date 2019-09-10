import 'package:best_flutter_ui_templates/appTheme.dart';
import 'package:best_flutter_ui_templates/homeDrawer.dart';
import 'package:flutter/material.dart';
import 'homeListView.dart';
import 'model/homelist.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController iconAnimationController;
  AnimationController animationController;
  List<HomeList> homeList = HomeList.homeList;
  bool multiple = true;
  ScrollController scrollController;

  double scrolloffset = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    iconAnimationController.animateTo(1.0,
        duration: Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);

    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (scrollController == null) {
      setState(() {
        scrollController = ScrollController(
            initialScrollOffset: MediaQuery.of(context).size.width * 0.75,
            keepScrollOffset: true);
        scrollViewNotify();
      });
    }
    return true;
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void scrollViewNotify() {
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        if (scrolloffset != 1) {
          setState(() {
            scrolloffset = 1;
          });
        }
        iconAnimationController.animateTo(0.0,
            duration: Duration(milliseconds: 0), curve: Curves.linear);
      } else if (scrollController.offset > 0 &&
          scrollController.offset < MediaQuery.of(context).size.width * 0.75) {
        iconAnimationController.animateTo(
            (scrollController.offset *
                    100 /
                    (MediaQuery.of(context).size.width * 0.75)) /
                100,
            duration: Duration(milliseconds: 0),
            curve: Curves.linear);
      } else if (scrollController.offset <=
          MediaQuery.of(context).size.width * 0.75) {
        if (scrolloffset != 0) {
          setState(() {
            scrolloffset = 0;
          });
        }
        iconAnimationController.animateTo(1.0,
            duration: Duration(milliseconds: 0), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
            return SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: PageScrollPhysics(parent: ClampingScrollPhysics()),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width +
                    MediaQuery.of(context).size.width * 0.75,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: <Widget>[
                          AnimatedBuilder(
                            animation: iconAnimationController,
                            builder: (BuildContext context, Widget child) {
                              return new Transform(
                                transform: new Matrix4.translationValues(
                                    scrollController.offset, 0.0, 0.0),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width *
                                      0.75,
                                  child: HomeDrawer(
                                    screenIndex: DrawerIndex.HOME,
                                    iconAnimationController:
                                        iconAnimationController,
                                    callBackIndex: (DrawerIndex indexType) {
                                      onDrawerCall();
                                      //naviget your way
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
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
                            Padding(
                              padding: EdgeInsets.only(
                                  top: AppBar().preferredSize.height +
                                      MediaQuery.of(context).padding.top),
                              child: IgnorePointer(
                                ignoring: scrolloffset == 1 ? true : false,
                                child: FutureBuilder(
                                  future: getData(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return SizedBox();
                                    } else {
                                      return GridView(
                                        padding: EdgeInsets.only(
                                            top: 0, left: 12, right: 12),
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        children: List.generate(
                                          homeList.length,
                                          (index) {
                                            var count = homeList.length;
                                            var animation =
                                                Tween(begin: 0.0, end: 1.0)
                                                    .animate(
                                              CurvedAnimation(
                                                parent: animationController,
                                                curve: Interval(
                                                    (1 / count) * index, 1.0,
                                                    curve:
                                                        Curves.fastOutSlowIn),
                                              ),
                                            );
                                            animationController.forward();
                                            return HomeListView(
                                              animation: animation,
                                              animationController:
                                                  animationController,
                                              listData: homeList[index],
                                              callBack: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        homeList[index]
                                                            .navigateScreen,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: multiple ? 2 : 1,
                                          mainAxisSpacing: 12.0,
                                          crossAxisSpacing: 12.0,
                                          childAspectRatio: 1.5,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            scrolloffset == 1
                                ? InkWell(
                                    onTap: () {
                                      onDrawerCall();
                                    },
                                  )
                                : SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top),
                              child: appBar(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      new BorderRadius.circular(AppBar().preferredSize.height),
                  child: Center(
                    child: AnimatedIcon(
                        icon: AnimatedIcons.arrow_menu,
                        progress: iconAnimationController),
                  ),
                  onTap: () {
                    onDrawerCall();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Flutter UI",
                  style: new TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      new BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onDrawerCall() {
    if (scrollController.offset != 0.0) {
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController.animateTo(
        MediaQuery.of(context).size.width * 0.75,
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
