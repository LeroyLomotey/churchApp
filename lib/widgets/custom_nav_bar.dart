import 'package:flutter/material.dart';

import '../themes.dart';

class NavBar extends StatefulWidget {
  final Function changeTabFunction;
  const NavBar({super.key, required this.changeTabFunction});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final Map<String, IconData> iconData = {
    '/home': Icons.home,
    '/calendar': Icons.calendar_month,
    '/flyers': Icons.collections,
    '/livestream': Icons.videocam
  };

  Widget buildIcon(MapEntry i) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: IconButton(
        onPressed: () {
          widget.changeTabFunction(i.key);
        },
        icon: Icon(i.value, color: ThemeClass.darkmodeBackground, size: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        //------------------------Background
        Container(
          padding: const EdgeInsets.only(top: 0),
          color: Colors.transparent,
          width: screenSize.width,
          height: 80,
          child: CustomPaint(
            size: Size(screenSize.width, 80),
            painter: BNBCustomPainter(),
          ),
        ),
        SizedBox(
          width: screenSize.width,
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (MapEntry e in iconData.entries) buildIcon(e)
              // for (int i = 0; i < iconData.length; i++) buildIcon(iconData[i])
            ],
          ),
        ),
      ]),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, size.height);

    /*
    path.quadraticBezierTo(0,0, size.width * .50, size.height);
    path.quadraticBezierTo(size.width * .50, size.height, size.width, 20);
    */

    path.arcToPoint(Offset(size.width, size.height),
        radius: const Radius.elliptical(1.2, 0.5));
    path.close();
    canvas.drawShadow(path, Colors.black, 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
