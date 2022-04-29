import 'package:flutter/material.dart';
import 'package:tourism/widgets/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}



class _MapPageState extends State<MapPage> {

  void _showProgressDialogue(BuildContext context){
    showDialog(context: context, builder: (_) => ProgressDialog(message: "LOADING..."));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: WebView(
        onPageStarted: (_) => _showProgressDialogue(context),
        onPageFinished: (_) => Navigator.of(context).pop(),
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            "https://www.google.com/maps/d/embed?mid=1nq8Su07ACbyVJtSjQUR6yFTE3HqO4APz&ehbc=2E312F",
      ),
    );
  }
}
