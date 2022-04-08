import 'package:flutter/material.dart';

import '../widgets/progress_dialog.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressDialog(
        message: "INITIALIZING...",
      ),
    );
  }
}
