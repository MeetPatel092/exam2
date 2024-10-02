import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.deepPurpleAccent,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome To The My Auction ",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 55,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/");
                  },
                  child: const Text(
                    "Get Start",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
