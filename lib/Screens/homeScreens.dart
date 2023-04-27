import 'package:flutter/material.dart';
import 'package:projectv1/Screens/dataScreen.dart';
import 'package:projectv1/api/api.dart';
import 'package:projectv1/models/apimodel.dart';

import 'package:projectv1/provider/providerhs.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data>? posts;
  getData() {
    posts = dataFromJson(jsonString);
  }


  TextEditingController gender = TextEditingController();
  TextEditingController age = TextEditingController();

  show(BuildContext context, int index) {
    var provider2 = Provider.of<Hsprovider>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              TextField(
                controller: age,
                
                decoration: const InputDecoration(
                  hintText: "Enter your Age",
                  
                  //  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  // enabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide()); ,
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
              TextField(
                controller: gender,
                decoration:const InputDecoration(
                  hintText: "Enter your Gender",
                  // enabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide()); ,
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
              TextButton(
                  onPressed: () {
                    provider2.genderList[index] = gender.text;
                    provider2.ageList[index] = age.text;
                    provider2.fill[index] = true;
                    gender.clear();
                    age.clear();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataScreen(
                                name: posts![0].users[index].name.toString(),
                                gender: provider2.genderList[index],
                                age: provider2.ageList[index],
                              )),
                    );
                   
                  },
                  child: Text('Submit'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  

  @override
  Widget build(BuildContext context) {
    var providerI = Provider.of<Hsprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('RestApi'),
      ),
      body: ListView.builder(
          itemCount: posts![0].users.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (providerI.fill[index] == false) {
                                  show(context, index);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DataScreen(
                                              name: posts![0]
                                                  .users[index]
                                                  .name
                                                  .toString(),
                                              gender:
                                                  providerI.genderList[index],
                                              //gender: providerI.genderList[index],
                                              age: providerI.ageList[index],
                                            )),
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: Text(
                                posts![0].users[index].name.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (providerI.mybox.get(index) == null) {
                                    providerI.mybox.put(index, "logged in");
                                  } else {
                                    providerI.mybox.delete(index);
                                  }

                                  //providerI.listener();
                                  providerI.addListener(() {});
                                },
                                icon: providerI.mybox.get(index) == null
                                    ? Icon(
                                        Icons.login,
                                      )
                                    : Icon(Icons.logout))
                          ],
                        ),
                        Text(
                          posts![0].users[index].id.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
