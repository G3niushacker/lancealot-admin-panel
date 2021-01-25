import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lancealot_admin_panel/views/guards/guard_profile.dart';

class TotalGuards extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Guard's"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: firestore.collection('guards').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: getExpenseItems(snapshot, context),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, context) {
    return snapshot.data.docs
        .map((doc) => InkWell(
              onTap: () {
                var frstName = doc['firstName'];
                var lstName = doc['lastName'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GuardProfile(
                              firstName: frstName,
                              lastName: lstName,
                              uid: doc.id,
                            )));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          doc['image'].toString(),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(doc['firstName'].toString(), style: name),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                doc['lastName'].toString(),
                                style: name,
                              ),
                            ],
                          ),
                          Text(
                            doc['phone'],
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Text(doc['city'].toString())
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  final name = TextStyle(fontSize: 22);
}
