import 'package:flutter/material.dart';

class MobflixTitle extends StatelessWidget {
  const MobflixTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 86,
      color: const Color(0xFF19191A),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 8),
        child: Center(
          child: Text(
            'MOBFLIX',
            style: TextStyle(
                fontSize: 32,
                color: Color(0xFF2478DF),
                fontFamily: 'BebasNeue'),
          ),
        ),
      ),
    );
  }
}
