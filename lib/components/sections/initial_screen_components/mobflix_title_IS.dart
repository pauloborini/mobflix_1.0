import 'package:flutter/material.dart';

import '../../utilities/colors_and_vars.dart';

class MobflixTitle extends StatelessWidget {
    const MobflixTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 76,
      color: appBarFront,
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 8),
        child: Center(
          child: Text(
            titleFlix,
            style: TextStyle(
                fontSize: 32, color: titleColor, fontFamily: 'BebasNeue'),
          ),
        ),
      ),
    );
  }
}
