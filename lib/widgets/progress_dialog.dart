import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(gradient: AppTheme.gradientLR),
            height: 64,
            width: width,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 12.0,
                  ),
                  child: SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "LOADING...",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
