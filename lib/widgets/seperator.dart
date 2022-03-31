import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final bool isLast;

  const Separator({Key? key, this.isLast = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 12, child: Container(color: Colors.grey.shade300,),),
          if(!isLast) SizedBox(height: 24,),
        ],
      ),
    );
  }
}
