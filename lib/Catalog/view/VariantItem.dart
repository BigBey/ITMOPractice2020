import 'package:flutter/cupertino.dart';
import 'package:flutterapp/liquid_progress_indicator/src/liquid_custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class VariantItem extends StatefulWidget {
  final double value;
  final Color color;



  VariantItem(this.value, this.color);

  @override
  State<StatefulWidget> createState() =>
      VariantItemState(value, color);
}

class VariantItemState
    extends State<VariantItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  final double value;
  final Color color;


  VariantItemState(this.value, this.color);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (value * 100).toInt();
    return Center(
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: LiquidCustomProgressIndicator(
        value: value,
        direction: Axis.vertical,
        backgroundColor: color,
        valueColor: AlwaysStoppedAnimation(color),
        shapePath: _buildHeartPath(),
        center: Text(
          "$percentage%",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      )
    );
  }

  Path _buildHeartPath() {
    Path path = new Path();
    path.addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, 100, 100), Radius.circular(10)));
    return path;
  }
}