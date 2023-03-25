import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Utils.dart';


class AllBooking extends StatefulWidget {
  const AllBooking({Key key}) : super(key: key);

  @override
  State<AllBooking> createState() => _AllBookingState();
}

class _AllBookingState extends State<AllBooking> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: false,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text('All Bookings',style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins Medium',
            fontSize: width*0.04
        ),),

        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: width * 0.01),
            child: SvgPicture.asset(
              "images/svgicons/filtersv.svg",
            ),
          )
        ],
      ),
      body: bookinglist(width,height,context),
    ));
  }

  Widget bookinglist(width,height,context){
    return  ListView.builder
      (
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: 3,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,position){
          return  GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AllBooking()),
              );
            },
            child: Container(
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: width * 0.03),
                            child: CircleAvatar(
                              radius: width * 0.07,
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1597466765990-64ad1c35dafc"),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),


                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '839176',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins Semibold',
                                        fontSize: width * 0.04),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(3.0),


                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'images/svgicons/tagbackpn.png',
                                              ),
                                              fit: BoxFit.fitHeight)),
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.all(2.0),
                                          child: Text(
                                            'In Progress',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: width*0.02,
                                                color: Colors.white,
                                                fontFamily: 'Poppins Regular'),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              Text(
                                'Visit on 24 Jun, 10:00 AM',
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              ),
                              Text(
                                'Visit on 24 Jun, 10:00 AM',
                                style: TextStyle(
                                    fontFamily: 'Poppins Regular',
                                    color: Color(
                                        Utils.hexStringToHexInt('C4C4C4')),
                                    fontSize: width * 0.03),
                              )
                            ],
                          )


                        ],
                      ),

                      Column(
                        children: <Widget>[
                          Text(
                            '250',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.02,
                                fontFamily: 'Poppins Regular'),
                          ),
                          Text(
                            'View All',
                            style: TextStyle(
                                color: Color(Utils.hexStringToHexInt('4285F4')),
                                fontSize: width * 0.02,
                                fontFamily: 'Poppins Regular'),
                          ),
                          Container(
                            padding: EdgeInsets.all(width * 0.003),
                            alignment: Alignment.center,
                            width: width * 0.1 + width * 0.09,
                            height: height * 0.05,
                            margin: EdgeInsets.only(right: width * 0.01),
                            decoration: BoxDecoration(
                                color: Color(Utils.hexStringToHexInt('4285F4')),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              '8:00',
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  color: Colors.white,
                                  fontFamily: 'Poppins Regular'),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          );
        });
  }
}
