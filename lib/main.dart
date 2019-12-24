import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: DemoApp()));

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(body: Signature());
}

class Signature extends StatefulWidget {
  SignatureState createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];
  Color color_yello=Colors.yellow;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                //_points.clear();
                RenderBox referenceBox = context.findRenderObject();
                Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);
                _points = List.from(_points)..add(localPosition);
              });

            },
            onPanEnd: (DragEndDetails details) => _points.add(null),
            child: CustomPaint(
              size: Size.fromHeight(500),
              foregroundPainter: SignaturePainter(_points),
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RaisedButton(

              child: Text(
                'Undo',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: (){
                print("pressed");
                setState(() {
                  for(var x in _points){
                    _points.remove(x);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SignaturePainter extends CustomPainter  {

  SignaturePainter(this.points);
  final List<Offset> points;
  void setSignList(List<Offset> points){
    this.points.addAll(points);
  }
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null){
        canvas.drawLine(points[i], points[i + 1], paint);
      }

    }
    //canvas.drawCircle(new Offset(size.width/3, size.height/2), size.width/2, paint);
    //print("size is : "+size.toString()+points.toString());
  }
  bool shouldRepaint(SignaturePainter other) => other.points != points;
}