import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool mySwitch = false;
  Color womenColor = Colors.pink;
  Color manColor = Colors.blue;
  int selectedRadio = 3;

  double theHeight = 100;
  var theWeight = "";
  double theActivity = 0.0;
  int theAge = 0;

  Future<void> displayDate() async {
    DateTime? birthday = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData(
                primarySwatch: (mySwitch) ? Colors.blue : Colors.pink,
              ),
              child: child as Widget);
        },
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime.now());
    if (birthday != null) {
      setState(() {
        theAge = DateTime.now().year - birthday.year;
      });
    }
  }

  List<Widget> provideRadio() {
    Map activities = {"Sedentary": 1.1, "Moderate": 1.3, "Intense": 1.5};
    List<Column> result = [];
    int counter = 0;

    activities.forEach((key, value) {
      var column = Column(
        children: [
          Radio(
              value: counter,
              groupValue: selectedRadio,
              activeColor: (mySwitch) ? manColor : womenColor,
              onChanged: (i) {
                setState(() {
                  selectedRadio = i as int;
                  theActivity = value;
                });
              }),
          Text(
            key,
            style: TextStyle(color: (mySwitch) ? manColor : womenColor),
          )
        ],
      );
      result.add(column);
      counter += 1;
    });
    return result;
  }

  Future<void> alert() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: (mySwitch) ? manColor : womenColor,
                  fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "All information need to be filled !",
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(color: (mySwitch) ? manColor : womenColor),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("What Is Your Need For Calories"),
        elevation: 0,
        backgroundColor: (mySwitch) ? manColor : womenColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Welcome !\nFill in all the fields to get your daily calorie "
                "need.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 20.0,
                child: Container(
                  width: width / 1.1,
                  height: height / 1.5,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Woman",
                          style: TextStyle(color: Colors.pink),
                        ),
                        Switch(
                          value: mySwitch,
                          onChanged: (bool b) {
                            setState(() {
                              mySwitch = b;
                            });
                          },
                          inactiveTrackColor: Colors.pinkAccent,
                          inactiveThumbColor: womenColor,
                        ),
                        const Text(
                          "Man",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: displayDate,
                      style: ElevatedButton.styleFrom(
                        primary: (mySwitch) ? manColor : womenColor,
                      ),
                      child: (theAge == 0)
                          ? const Text("Press to enter your age")
                          : Text("You are $theAge years old"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Your height is : ${theHeight.toInt()} cm",
                      style: TextStyle(
                          color: (mySwitch)
                              ? Colors.blueAccent
                              : Colors.pinkAccent),
                    ),
                    const SizedBox(height: 10),
                    Slider(
                        value: theHeight,
                        min: 100,
                        max: 215,
                        activeColor: (mySwitch) ? manColor : womenColor,
                        onChanged: (double d) {
                          setState(() {
                            theHeight = d;
                          });
                        }),
                    const SizedBox(height: 20),
                    // For the TextField, if the application is for ios, we need
                    // to wrap the Scaffold on a GestureDetector, because ios
                    // don't have a validate button on their keyboard.
                    TextField(
                      cursorColor: (mySwitch) ? manColor : womenColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter your weight (Kg)",
                        labelStyle: TextStyle(
                          color: (mySwitch) ? manColor : womenColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: (mySwitch) ? manColor : womenColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: (mySwitch) ? manColor : womenColor)),
                      ),
                      onSubmitted: (String s) {
                        setState(() {
                          theWeight = s;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "How is your sports activity ?",
                      style:
                          TextStyle(color: (mySwitch) ? manColor : womenColor),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: provideRadio(),
                    )
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (theHeight == 100 ||
                        theWeight == "" ||
                        theActivity == 0.0 ||
                        theAge == 0)
                    ? alert
                    : () {
                        print("The Age : $theAge, The Height : $theHeight, "
                            "The Weight : $theWeight, Activity : $theActivity");
                      },
                style: ElevatedButton.styleFrom(
                  primary: (mySwitch) ? manColor : womenColor,
                ),
                child: const Text("Calculate"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
