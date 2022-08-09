import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micro_todo/themes/strings.dart';
import 'package:micro_todo/themes/themes.dart';

//--- widget to show stats tab on dashboard navigation bar
class StatsTab extends StatelessWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              statsHere,
              style: regularWhiteText,
            ),
          ),
          Text(
            comingSoon,
            style: regularWhiteText,
          ),
        ],
      ),
    );
  }
}
