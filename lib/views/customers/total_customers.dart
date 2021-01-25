import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lancealot_admin_panel/views/customers/customer_profile.dart';

class TotalCustomers extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Customers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: firestore.collection('customers').snapshots(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerProfiles(
                      uid: doc.id,
                      name: doc['name'],
                    ),
                  ),
                );
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
                      // CircleAvatar(
                      //   radius: 40,
                      //   backgroundImage: NetworkImage(
                      //     doc['image'].toString(),),
                      // ),
                      Column(
                        children: [
                          Text(doc['name'].toString() ?? "Loading...",
                              style: name),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            doc['phone'] ?? "Loading...",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Text(doc['city'].toString() ?? "Loading...")
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  final name = TextStyle(fontSize: 22);
}
