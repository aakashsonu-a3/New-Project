import 'package:flutter/material.dart';
import 'package:newproject/detail_page.dart';

class DashboardPage extends StatefulWidget {
    @override
    _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: ClipPath(
          clipper: BackgroundClipper(),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailPage()),
              );
              // Handle tap event
            },
            child: Hero(
              tag: 'background',
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    var roundnessFactor = 50.0; // Adjust this value to control the roundness

    var path = Path();
    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, roundnessFactor * 2);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor * 3, roundnessFactor * 2);
    path.lineTo(roundnessFactor, size.height * 0.33);
    path.quadraticBezierTo(0, size.height * 0.33, 0, size.height * 0.33 + roundnessFactor * 2);
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}