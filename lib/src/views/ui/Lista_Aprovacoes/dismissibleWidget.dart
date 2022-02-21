import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;
  const DismissibleWidget(
      {required this.item, required this.child, required this.onDismissed});

  @override
  Widget build(BuildContext context) => Dismissible(
        direction: DismissDirection.endToStart,
        key: ObjectKey(item),
        child: child,
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(context),
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: Icon(
          Icons.archive_sharp,
          color: Colors.white,
          size: 32,
        ),
      );

  Widget buildSwipeActionRight(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width - 400, top:40),
        color: Colors.grey[50],
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Aprovar'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Reprovar'),
            ),
          ],
        ),
      );
}
