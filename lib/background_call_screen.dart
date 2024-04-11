import 'package:flutter/material.dart';
import 'symbol_background.dart';

class BackgroundCallScreen extends StatelessWidget {
  final Key key;

  BackgroundCallScreen({required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(213, 198, 198, 198),
      appBar: AppBar(centerTitle: true,
        title: Text('Background Demo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
      backgroundColor: Color.fromARGB(212, 147, 144, 144),),
      body: SymbolBackground(
        key: key,
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Background Screen ',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
