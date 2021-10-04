import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pagination.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget(
      {Key? key,
      required this.lastPage,
      required this.nowPage,
      required this.gotoPage})
      : super(key: key);

  final int lastPage;
  final int nowPage;
  final void Function(int) gotoPage;

  @override
  Widget build(BuildContext context) {
    final pagination = Pagination.pagination(nowPage, lastPage);
    return Row(children: [
      if (nowPage != 1)
        GoToFirstButton(
          onPressed: () => gotoPage(1),
        ),
      ...pagination.map((i) {
        return _PaginationButton(
          onPressed: nowPage == i ? null : () => gotoPage(i),
          isSelected: nowPage == i,
          exampleNumber: i,
          key: ValueKey(i),
        );
      }).toList(),
      if (nowPage != lastPage)
        DoubleArrowTextButton(
          onPressed: () => gotoPage(lastPage),
        )
    ]);
  }
}

class _PaginationButton extends StatelessWidget {
  final bool isSelected;
  final int exampleNumber;
  final void Function()? onPressed;

  const _PaginationButton({
    required Key key,
    required this.isSelected,
    required this.exampleNumber,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0, left: 1.0),
      child: TextButton(
        onPressed: onPressed == null ? null : () => onPressed!(),
        child: Text('$exampleNumber'),
        style: _squareButtonStyleFrom(),
      ),
    );
  }
}

class GoToFirstButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoToFirstButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: DoubleArrowTextButton(
          onPressed: onPressed,
        ));
  }
}

class DoubleArrowTextButton extends StatelessWidget {
  const DoubleArrowTextButton({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Icon(
        Icons.double_arrow,
        size: 16.0,
      ),
      style: _squareButtonStyleFrom(),
      onPressed: onPressed,
    );
  }
}

ButtonStyle _squareButtonStyleFrom() {
  return TextButton.styleFrom(
      primary: Colors.grey[800],
      maximumSize: const Size.square(32),
      minimumSize: const Size.square(32),
      shape: const BeveledRectangleBorder());
}
