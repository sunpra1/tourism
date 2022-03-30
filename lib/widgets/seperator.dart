import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 12, child: Container(color: Colors.grey.shade300,),),
          SizedBox(height: 24,),
        ],
      ),
    );
  }
}
