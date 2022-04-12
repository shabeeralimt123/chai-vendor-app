import 'package:chai/Screens/homescreen.dart';
import 'package:chai/bloc/NewOrder/neworder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashScreen extends StatefulWidget {
//  final  int itemCount;
//  final String date;
//  final String time;
//  final String customername;
  final String status;

  const CashScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NeworderCubit>(context).getNewOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
      
      
        title: Text("Cash", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<NeworderCubit, NeworderState>(
        builder: (context, state) {
          if(state is NeworderLoaded){
              if(state.newOrders.purchaseorders!.purchase!.length== 0){
                   return Center(child: Text("Currently you have no cash found",style :TextStyle(color : Colors.white)),);
              }
          return Container(
              child: ListView.builder(
                  itemCount:  state.newOrders.purchaseorders!.purchase!.length,
                  // itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 5),
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          // width: 100,
                          width: MediaQuery.of(context).size.width,
                          // height: 110,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 27, 20, 20)
                                      .withOpacity(.1)),
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                        
                                          state.newOrders.purchaseorders!.purchase![index].customername.toString(),
                                          // '',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.9)),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          state.newOrders.purchaseorders!.purchase![index].amount.toString(),
                                          // '',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.9)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                           state.newOrders.purchaseorders!.purchase![index].date.toString(),
                                          // '',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.6)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                         state.newOrders.purchaseorders!.purchase![index].time.toString(),
                                          // ''
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.6)),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
         } return Container(); },
      ),
    );
  }
}
