import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyCalcPage extends StatefulWidget {
  const CurrencyCalcPage({ Key? key }) : super(key: key);

  @override
  State<CurrencyCalcPage> createState() => _CurrencyCalcPageState();
}

class _CurrencyCalcPageState extends State<CurrencyCalcPage> {
  TextEditingController valueEditingController = TextEditingController();

  List<String> currencies = [
    "MYR",
    "CNY", 
    "USD", 
    "KRW", 
    "SGD",
  ];

  String fromCurrency = "CNY";
  String toCurrency = "MYR";
  double value = 0.0, rate = 0.0, valueiInput = 0.0;
  String result = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.indigo,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.asset('assets/images/logo.png', scale: 2)),
                  const SizedBox(height:10.0),
                  const Text("Currency Converter", style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                  ),
                  const SizedBox(height:10.0),
                  Flexible(
                    flex: 8,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(                           
                            controller: valueEditingController,
                            keyboardType: const TextInputType.numberWithOptions(),
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "Enter a value",
                              hintStyle: const TextStyle(fontSize: 20.0, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20.0),
                            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton(
                          itemHeight: 60,
                          value: fromCurrency,
                          onChanged: (newValue) {
                          setState(() {
                            fromCurrency = newValue.toString();
                          });
                        },
                        items: currencies.map((fromCurrency) {
                          return DropdownMenuItem(
                            child: Text(
                              fromCurrency,
                              style: const TextStyle(fontSize: 20),
                            ),
                            value: fromCurrency,
                          );
                        }).toList(),
                      ),

                    FloatingActionButton(
                      onPressed: (){
                        String data = fromCurrency;
                        setState(() {
                          fromCurrency = toCurrency;
                          toCurrency = data;
                        });
                      }, 
                      child: const Icon(Icons.swap_horiz, color: Colors.blue), 
                        elevation: 0.0, 
                        backgroundColor: Colors.lime,
                    ),
                                       
                    DropdownButton(
                        itemHeight: 60,
                        value: toCurrency,
                        onChanged: (newValue) {
                        setState(() {
                          toCurrency = newValue.toString();
                        });
                      },
                      items: currencies.map((toCurrency) {
                        return DropdownMenuItem(
                          child: Text(
                            toCurrency,
                            style: const TextStyle(fontSize: 20),
                          ),
                          value: toCurrency,
                        );
                      }).toList(),
                    ),
                  ],),
                  const SizedBox(height:15.0),

                  ElevatedButton(onPressed: _loadCal, child: const Text("Convert", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))),                          

                  const SizedBox(height:15.0),
                    Container(
                      width: double.infinity,
                      padding:const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      ),
                                  
                      child: SingleChildScrollView(
                        child: Column(
                        children: [
                          const Text("Result: ", style: TextStyle(color: Colors.blueAccent, fontSize: 36, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                          Text((valueiInput.toString() + " " + fromCurrency + " = " + result + " " + toCurrency), style: const TextStyle(color: Colors.black, fontSize: 26)),
                        ],),
                      ),
                    ),
                  ],))
                  ), 
                ],
              ),
            ),
          ),
    );
  }     

Future<void> _loadCal() async {
    var apiid = "e565cd70-3885-11ec-a1c0-b95473718f80";
    var url = Uri.parse(
        'https://freecurrencyapi.net/api/v2/latest?apikey=$apiid&base_currency=$fromCurrency');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      value = parsedJson['data'][toCurrency];
      setState(() {
        valueiInput = double.parse(valueEditingController.text);
        result = (valueiInput * parsedJson['data'][toCurrency]).toStringAsFixed(2);
      });
    } else {
      print("Failed");
    }
  }
}
 
