import 'package:flutter/material.dart';
import 'package:restaurantapp/LoginPage.dart';
import 'package:restaurantapp/details.dart';
import 'package:restaurantapp/restaurantmodel.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:restaurantapp/widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Future<Restaurantmodel> getdata()async {
    Response response = await get(
        Uri.parse("https://firstflight-web.ipixsolutions.net/api/getRestaurants"));
    if (response.statusCode == 200) {
      var body = Restaurantmodel.fromJson(jsonDecode(response.body));

      return body;
    } else {
      throw "error";
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RESTAURANTS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        actions: [
          TextButton.icon(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
          }, label: Text("Logout",style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.logout,color: Colors.white,),
          )
        ],
        backgroundColor: Colors.orange.shade600,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getdata(),
            builder: (context,snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasData){

                List<Restaurant>? restaurant=snapshot.data!.restaurants;
                return ListView.separated(
                    itemCount: restaurant!.length,
                    itemBuilder: (context,index) {
                      var data = snapshot.data!.restaurants[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Details(userData: data),));
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Container(
                                  width: 500,
                                   height: 300,
                                   child: Image.asset("assets/images/restaurant.jpg"),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(restaurant![index].name.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black)),
                                      Customwidget(rating: '4.3',)
                                    ],
                                  ),
                                ),
                        
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.restaurant_menu,color: Colors.grey.shade600,),
                                      SizedBox(width: 5,),
                                      Text(restaurant![index].cuisineType,style: TextStyle(fontSize: 13,color:Colors.grey.shade600)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.place_outlined,color: Colors.grey.shade600,),
                                      SizedBox(width: 5,),
                                      Text(restaurant![index].address,style: TextStyle(fontSize: 13,color:Colors.grey.shade600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                },
                );
              } else{
                return Center(child: Text("error found"),);
              }


            }
        ),
      ),
    );
  }
}
