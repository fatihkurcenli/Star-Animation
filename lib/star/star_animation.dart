import 'dart:math';

import 'package:flutter/material.dart';

class StarBackGround extends StatefulWidget {
  StarBackGround({Key key}) : super(key: key);

  @override
  _StarBackGroundState createState() => _StarBackGroundState();
}

class _StarBackGroundState extends State<StarBackGround>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  Animation animatedStar1,animatedStar2,animatedStar3,animatedStar4;
  AnimationController _animationController;
  List<WhereStar> listStar = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    final animationCurve = CurvedAnimation(
        curve: Curves.easeInExpo,
        reverseCurve: Curves.easeIn,
        parent: _animationController);
    _animation = Tween<double>(begin: 5, end: 6).animate(animationCurve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    animatedStar1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Interval(0.0, 0.25)));
    animatedStar1.addListener(() {
      setState(() {});
    });
    animatedStar2 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Interval(0.25, 0.5)));
    animatedStar2.addListener(() {
      setState(() {});
    });
    animatedStar3 = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Interval(0.75, 0.80)));
    animatedStar3.addListener(() {
      setState(() {});
    });
    animatedStar4 = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Interval(0.8, 1.0)));
    animatedStar4.addListener(() {
      setState(() {});
    });

    for (int i = 0; i < 100; i++) {
      listStar.add(WhereStar(
          left: Random().nextDouble() * 500,
          bottom: Random().nextDouble() * 500,
          top: Random().nextDouble() * 500,
          extraSize: Random().nextDouble() * 4,
          angle: Random().nextDouble(),
          typeFade: Random().nextInt(4)));
    }
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: buildGroupStar(),
        )
      ],
    ));
  }

  Widget buildStar(double left, double top, double extraSize, double angle,
      double bottom, int typeFade) {
    return Positioned(
      child: Container(
        child: Transform.rotate(
          child: Transform.translate(
            offset: Offset(_animation.value, 100.0),
            child: Opacity(
              child: Icon(
                Icons.star,
                color: Colors.black,
                size: _animation.value * 1.5 + extraSize,
              ),
              opacity: (typeFade == 1)
                  ? animatedStar1.value
                  : (typeFade == 2)
                      ? animatedStar2.value
                      : (typeFade == 3)
                          ? animatedStar3.value
                          : animatedStar4.value,
            ),
          ),
          angle: angle,
        ),
        alignment: FractionalOffset.center,
      ),
      bottom: bottom,
      left: left,
      top: top,
    );
  }

  Widget buildGroupStar() {
    List<Widget> list = [];
    for (int i = 0; i < 100; i++) {
      list.add(buildStar(
        listStar[i].left,
        listStar[i].top,
        listStar[i].extraSize,
        listStar[i].angle,
        listStar[i].bottom,
        listStar[i].typeFade,
      ));
    }
    return Stack(children: list);
  }
}

class WhereStar {
  double left;
  double top;
  double extraSize;
  double angle;
  double bottom;
  int typeFade;

  WhereStar({
    @required this.left,
    @required this.top,
    @required this.extraSize,
    @required this.angle,
    @required this.bottom,
    @required this.typeFade,
  });
}
