import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurantapp/restaurantmodel.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurantapp/widget.dart';
import 'package:geolocator/geolocator.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.userData});
  final Restaurant userData;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Position? myPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children:[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Container(
                  width: 500,
                  height: 300,
                  child: Image.asset("assets/images/restaurant.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(widget.userData.name.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Customwidget(rating: '4.3',),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(widget.userData.neighborhood.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.restaurant_menu,color: Colors.grey.shade600,),
                      SizedBox(width: 5,),
                      Text(widget.userData.cuisineType.toString(),style: TextStyle(fontSize: 13,color:Colors.grey.shade600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.place_outlined,color: Colors.grey.shade600,),
                      SizedBox(width: 5,),
                      Text(widget.userData.address.toString(),style: TextStyle(fontSize: 13,color:Colors.grey.shade600)),
                    ],
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.access_time_filled,color: Colors.grey.shade600,),
                      SizedBox(width: 5,),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Raiting & Reviews",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.userData.reviews.length,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Customwidget(rating: widget.userData.reviews[index].rating.toString()),
                                ),
                                Text(widget.userData.reviews[index].name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          ReadMoreText(widget.userData.reviews[index].comments,style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal),
                            trimLines: 2,
                            colorClickableText: Colors.blueGrey,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Read less',
                          ),
                          SizedBox(height: 10,),
                          Text(widget.userData.reviews[index].date.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                        ],


                      ),
                    );
                  },),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.orange.shade600,
                    onPressed: () async{
                      final result=await Geolocator.getCurrentPosition();
                      print(result);
                      setState(() {
                        myPosition=result;
                      });
                    },child: IconButton(icon: Icon(Icons.directions,color: Colors.white,), onPressed: () {  },))
              ],
                        ),
            ),]
        ),
      ),
    );
  }
}
