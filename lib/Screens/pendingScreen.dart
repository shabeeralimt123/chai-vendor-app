import 'dart:developer';

import 'package:chai/Screens/homescreen.dart';
import 'package:chai/bloc/NewOrder/neworder_cubit.dart';
import 'package:chai/bloc/acceptreject/acceptreject_cubit.dart';
import 'package:chai/models/NewOrders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../utils/functions.dart';

class PendingScreen extends StatefulWidget {
//  final  int? itemCount;
//  final String? date;
//  final String? time;
  final String status;


  const PendingScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await BlocProvider.of<NeworderCubit>(context).getNewOrders(widget.status);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

 

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<PendingCubit>(context).getPendingPurchase(purchase);
    BlocProvider.of<NeworderCubit>(context).getNewOrders(widget.status);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<NeworderCubit>(context).getNewOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
         leading :IconButton(
        icon:  Icon(Icons.arrow_back,color: Colors.black),
        onPressed: () { Navigator.pop(context); },),
      
        title: Text("Pending", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Container(
           
            child: BlocBuilder<NeworderCubit, NeworderState>(
          builder: (context, state) {
            if (state is NeworderLoaded) {
              if(state.newOrders.purchaseorders!.purchase!.length== 0){
                   return Center(child: Text("currently you have no pending orders",style :TextStyle(color : Colors.white)),);
              }
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: state.newOrders.purchaseorders!.purchase!.length,
                    // itemCount: 10,
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var purchaseId =
                          state.newOrders.purchaseorders!.purchase![index].id!;
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 5, top: 5),
                        child: Material(
                          elevation: 22,
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
                                            // widget.purchaseList[index]
                                            //     .customername!,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BlocBuilder<AcceptrejectCubit,
                                          AcceptrejectState>(
                                        builder: (context, state) {
                                          return InkWell(
                                            onTap: () {
                                              log(purchaseId.toString());
                                              BlocProvider.of<
                                                          AcceptrejectCubit>(
                                                      context)
                                                  .getAcceptReject(
                                                      "rejected", purchaseId);
                                              
                                                showMessage(context,
                                                    message: 'Payment rejected'
                                                        );
                                              
                                              // BlocProvider.of<PendingCubit>(context).getPendingPurchase(reload: true,purchase: purchase);
                                            },
                                            child: Material(
                                              child: Container(
                                                width: 63,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffE21212),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Reject",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xffFFFFFF)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      BlocBuilder<AcceptrejectCubit, AcceptrejectState>(
                                        builder: (context, state) {
                                          return InkWell(
                                            onTap: () {
                                             log(purchaseId.toString());
                                              BlocProvider.of<
                                                          AcceptrejectCubit>(
                                                      context)
                                                  .getAcceptReject(
                                                      "accepted", purchaseId);
                                              if (state is AcceptrejectLoaded) {
                                                showMessage(context,
                                                    message: "Payment accepted"
                                                        );
                                              }

                                              
                                            },
                                            child: Material(
                                              child: Container(
                                                width: 63,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff2BA54D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Accept",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xffFFFFFF)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )),
      ),
    );
  }

  showMessage(BuildContext context,
      {required String? message, VoidCallback? onCompleted}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(
                "Success",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              content: Text(
                message!,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    _onRefresh();
                     Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
