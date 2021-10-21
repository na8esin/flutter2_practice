import 'dart:math' as math;

import 'package:flutter/material.dart';

// 参考ソース
// https://github.com/flutter/gallery/blob/master/lib/studies/rally/charts/pie_chart.dart

class MyChart extends StatelessWidget {
  const MyChart(
      {Key? key,
      required this.total,
      required this.rest,
      required this.outerRPerParentHeightHalf,
      this.percentageFontSize})
      : super(key: key);

  final int total;
  final int rest;
  final double outerRPerParentHeightHalf; // 外側の半径 / 親の高さの半分
  final double? percentageFontSize;

  int get percentage => (total == 0 ? 0 : (rest / total * 100).toInt());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: constraints,
        child: DecoratedBox(
          decoration: MyDecoration(
              percentage: percentage,
              outerRPerParentHeightHalf: outerRPerParentHeightHalf),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$percentage%',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: percentageFontSize,
                    color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '$rest/$total',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class MyDecoration extends Decoration {
  const MyDecoration(
      {required this.percentage, required this.outerRPerParentHeightHalf});

  final int percentage;
  final double outerRPerParentHeightHalf;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return MyBoxPainter(
        amount: percentage,
        outerRPerParentHeightHalf: outerRPerParentHeightHalf);
  }
}

class MyBoxPainter extends BoxPainter {
  MyBoxPainter({required this.amount, required this.outerRPerParentHeightHalf});
  final double outerRPerParentHeightHalf;
  late double outerR;

  final int amount;

  double get innerR => outerR * 0.75;
  double get centerR => (outerR - innerR) / 2 + innerR;
  double get circleR => (outerR - innerR) / 2;

  // 100%=360度 としたときの角度にまずは直す
  double get endAngle => amount * 360 / 100;
  double get endRadian => -endAngle * math.pi / 180;

  // configuration.sizeは謎のpaddingを引いた分
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    outerR = configuration.size!.height / 2 * outerRPerParentHeightHalf;

    // まずはドーナッツのうす水色を作る
    drawRest(canvas, offset, configuration);
    // 有効なところは青く
    drawAnswer(canvas, offset, configuration);

    // 端を滑らかにするための円
    drawStartCircle(canvas, offset, configuration);
    drawEndCircle(canvas, offset, configuration);
  }

  drawRest(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()..color = Colors.blue[50]!;
    canvas.drawArc(
        Rect.fromCircle(
            center: configuration.size!.center(offset), radius: outerR),
        0.0,
        360 * math.pi / 180,
        true,
        paint);

    final paint2 = Paint()..color = Colors.white;
    canvas.drawArc(
        Rect.fromCircle(
            center: configuration.size!.center(offset), radius: innerR),
        0.0,
        360 * math.pi / 180,
        true,
        paint2);
  }

  drawAnswer(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()..color = Colors.blue;
    final startRad = -90 * math.pi / 180;

    canvas.drawArc(
        Rect.fromCircle(
            center: configuration.size!.center(offset), radius: outerR),
        startRad,
        endRadian,
        true,
        paint);

    final paint2 = Paint()..color = Colors.white;
    canvas.drawArc(
        Rect.fromCircle(
            center: configuration.size!.center(offset), radius: innerR),
        startRad,
        endRadian,
        true,
        paint2);
  }

  drawStartCircle(
      Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final centerOffset = configuration.size!.center(offset);
    final centerOffsetDy = centerOffset.dy;
    final circleOffsetDy = centerOffsetDy - centerR;
    final paint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(centerOffset.dx, circleOffsetDy), circleR, paint);
  }

  drawEndCircle(
      Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // drawArcと座標系が違う
    final radian = (270 - endAngle) * math.pi / 180;

    final x = centerR * math.cos(radian);
    final y = centerR * math.sin(radian);

    final centerOffset = configuration.size!.center(offset);
    final paint = Paint()..color = Colors.blue;
    canvas.drawCircle(
        // xはプラスで右、yはマイナスで上
        Offset(centerOffset.dx + x, centerOffset.dy + y),
        circleR,
        paint);
  }
}
