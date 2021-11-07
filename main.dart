import 'dart:async';
import 'package:flutter/material.dart';
import 'currencycalcpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (content) => const CurrencyCalcPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome To Currency Converter App", 
                style: TextStyle(fontSize: 32, 
                fontWeight: FontWeight.bold, 
                fontStyle: FontStyle.italic, 
                color: Colors.indigo), 
                textAlign: TextAlign.center,),
            const SizedBox(height: 20.0),
            Image.asset('assets/images/logo.png', scale: 1),
          ],
        ),
      ),     
    );
  }
}