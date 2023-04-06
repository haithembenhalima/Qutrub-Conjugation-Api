import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qutrub_conjugation_api/colors.dart';
import 'appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String verb = "سحب"; // The verb initialize with the value 'سحب'
  Map ResultData = {}; // the result of the request
  bool status = false; // a variable allow to switch between active voice and passive voice 
  int counter = 0; //  for the bottom navigation var (counter = 0 => active voice) or (counter = 1 => passive voice)
  bool activeVoice = true; // the data displating on active voice by default 


  /* 
  ****************
  ** Get the results from the API using the http package 
  ****************
  */

  Future<void> SendData() async {
    try {
      // Set url
      var url_post =
          Uri.parse("https://qutrub.arabeyes.org/api?verb=$verb&trans=1");
      // Set header as the request data is json format
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      // send reuqest and wait for response
      var response = await http.get(url_post);
      // // convert json data to dictonary [Map in dart]
      var responseData = jsonDecode(response.body);
      print(responseData);
      // check if reponse status is 200 == success
      print(response.statusCode);
      if (response.statusCode == 200) {
        ResultData = responseData;
        status = true;
        print(ResultData);
      } else {
        responseData = {};
      }
      setState(() {});
    } catch (_) {
      print("No internet connection");
    }
  }
  /*
  // Widgets to display the results from the API (In active voice and passive voice)
  */
  // Widget to display the results of the active voice
  Widget activeResult() {
    int select = 0;
    return Container(
      child: Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 7,
            itemBuilder: (context, index) {
              select++;
              return Column(
                children: [
                  ExpansionTile(
                    title: Text(
                      "${ResultData['result']['0']['$select']}",
                      style: TextStyle(fontSize: 19),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Display the prounouns
                          Container(
                            child: Column(children: [
                              SizedBox(
                                height: 4,
                              ),
                              for (var i = 1; i < 13; i++)
                                Text(
                                  "${ResultData['result']['$i']['0']}",
                                  style: TextStyle(fontSize: 19),
                                ),
                              SizedBox(
                                height: 4,
                              ),
                            ]),
                          ),
                          // Display the conjugations result
                          Container(
                            child: Column(children: [
                              SizedBox(
                                height: 4,
                              ),
                              for (var i = 1; i < 13; i++)
                                Text(
                                  "${ResultData['result']['$i']['$select']}",
                                  style: TextStyle(fontSize: 19),
                                ),
                              SizedBox(
                                height: 4,
                              ),
                            ]),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  // Widget to display the results of the passive voice
  Widget passiveResult() {
    int select = 7;
    bool NotEmpty = true;
    return Container(
      child: Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              select++;
              // check if the verb have a conjugation in the passive voice
              // if it has display his conjugation, else don't display anything
              if (ResultData['result']['0']['8'] == null) {
                NotEmpty = false;
              } else {
                NotEmpty = true;
              }
              return Column(
                children: [
                  NotEmpty
                      ? ExpansionTile(
                          title: Text(
                            "${ResultData['result']['0']['$select']}",
                            style: TextStyle(fontSize: 19),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Display of pronouns
                                Container(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    for (var i = 1; i < 13; i++)
                                      Text(
                                        "${ResultData['result']['$i']['0']}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ]),
                                ),
                                // Display of the conjugations result
                                Container(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    for (var i = 1; i < 13; i++)
                                      Text(
                                        "${ResultData['result']['$i']['$select']}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ]),
                                ),
                              ],
                            )
                          ],
                        )
                      : Text("")
                ],
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(appBar: AppBar()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: counter,
        selectedItemColor: primaryColor,
        backgroundColor: backgroundColor,
        items: [
          BottomNavigationBarItem(
            label: "مبني للمعلوم",
            icon: Icon(Icons.check_circle_outline),
            activeIcon: Icon(Icons.check_circle),
          ),
          BottomNavigationBarItem(
            label: "مبني للمجهول",
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
          ),
        ],
        onTap: (value) {
          setState(() {
            counter = value;
            if (counter == 1) {
              activeVoice = false;
            } else if (counter == 0) {
              activeVoice = true;
            }
          });
        },
      ),
      body: Column(children: [
        SizedBox(
          height: 15,
        ),

        /* 
        *******************************
        *******************************
        *******************************
         */
        // input field for the verb

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          child: TextField(
            //   controller: controller,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide(color: primaryColor, width: 1.5)),
                prefixIcon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 2)),
            onSubmitted: (value) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              verb = value;
            },
          ),
        ),

        //****************************
        //****************************
        //*****************************/
        // Searching button

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: MaterialButton(
              minWidth: double.infinity,
              padding: EdgeInsets.only(top: 7, bottom: 7),
              onPressed: (() async {
                await SendData();
              }),
              child: Text(
                "تصريف الفعل",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0))),
        ),

        /*
        ***************************
        * Display results
        ***************************
        */

        if (ResultData.isNotEmpty && activeVoice == true)
          activeResult()
        else if (ResultData.isNotEmpty && activeVoice == false)
          passiveResult(),
      ]),
    );
  }
}
