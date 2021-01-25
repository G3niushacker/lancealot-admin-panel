import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lancealot_admin_panel/constants.dart';
import 'package:lancealot_admin_panel/routes/routes_names.dart';
import 'package:lancealot_admin_panel/views/online_guards/online_guards.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var guardsLenght;
  var customersLength;
  var onlineGuards;

  void getInit(){
    firestore.collection('guards').get().then((value){
      setState(() {
        guardsLenght = value.docs.length;
        print(guardsLenght);
      });
    });
    firestore.collection('customers').get().then((value){
      setState(() {
        customersLength = value.docs.length;
        print(customersLength);
      });
    });
    firestore.collection('onlineGuards').get().then((value){
      setState(() {
        onlineGuards = value.docs.length;
        print(onlineGuards);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, totalGuards);
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Guards",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.white),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$guardsLenght",style: kNumTextStyle),
                                Icon(Icons.security,size: 50,color: Colors.white,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, totalCustomers);
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Customers",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.white),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$customersLength",style:kNumTextStyle),
                                Icon(Ionicons.ios_person,size: 50,color: Colors.white,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Today's Files",style: TextStyle(fontSize: 18,color: Colors.white),),
                          Text("86",style: kNumTextStyle,)
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue
                        ),
                        child: Icon(Ionicons.md_analytics,color: Colors.white,),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            StreamBuilder(
              stream: firestore.collection('onlineGuards').snapshots(),
              builder: (context,snapshot){
                return Expanded(
                  child: InkWell(
                    onTap: (){
                      // Navigator.pushNamed(context, onlineGuards);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => OnlineGuards()
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Online Guards",style: TextStyle(fontSize: 18,color: Colors.white),),
                                Text("${snapshot.data.docs.length.toString()}",style: kNumTextStyle,)
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.green
                              ),
                              child: Icon(AntDesign.checkcircle,color: Colors.white,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                           Colors.grey,
                           Colors.black,
                          ]
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Today's\nRevenue",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                          Text("\$ 160",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.lightBlue,
                              Colors.blue,
                            ]
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Feedback",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                          Text("9",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.amberAccent,
                              Colors.deepOrange,
                            ]
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Guard's\nReports",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                          Text("12",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
