import 'dart:developer';

import 'package:chai/Exception/loginException.dart';
import 'package:chai/Screens/cashScreen.dart';
import 'package:chai/Screens/profileScreen.dart';
import 'package:chai/Screens/totalScreen.dart';
import 'package:chai/bloc/Dashboard/dashboard_cubit.dart';
import 'package:chai/componants/homecard.dart';
import 'package:chai/Screens/orderScreen.dart';
import 'package:chai/Screens/pendingScreen.dart';
import 'package:chai/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    RefreshController _refreshController =
      RefreshController(initialRefresh: false);

 void _onRefresh() async{
    // monitor network fetch
        await BlocProvider.of<DashboardCubit>(context).getDashBoard();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    
   await BlocProvider.of<DashboardCubit>(context).getDashBoard();
   
    _refreshController.loadComplete();
  }
  late int index;



  @override
  void initState() {
    super.initState();

    //  di();

    BlocProvider.of<DashboardCubit>(context).getDashBoard();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
        BlocProvider.of<DashboardCubit>(context).getDashBoard();

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "DashBoard ",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              })
        ],
      ),
      body: SmartRefresher(
         controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
         enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(builder: (BuildContext context,LoadStatus?mode){
          Widget body;
          if(mode == LoadStatus.idle){
            return  body =  Text("pull up load");

          }
           else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
              else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
             else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }  else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
        },),
        child: Stack(
          children: <Widget>[dashBg, content],
        ),
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Material(  borderRadius: BorderRadius.circular(10),elevation : 200,child: Container(height :100,color: Colors.black)),
            flex: 2,
          ),
          Expanded(
            child: Material(  borderRadius: BorderRadius.circular(10),elevation: 50,child: Container(height : 200,color: Colors.transparent)),
            flex: 5,
          ),
          
        ],
      );

  get content => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if(state is DashboardLoaded){
            return Container(
              margin: EdgeInsets.only(bottom: 210,left : 42, top : 42, right: 42),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        title: "orders",
                        count: state.dashboard.order.toString(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderScreen(
                                      status: "order",
                                      )));
                        },
                      ),
                      HomeCard(
                        title: "pending",
                        count: state.dashboard.pendingpurchase.toString(),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PendingScreen(
                                       status: 'pending',
                                      )));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCard(
                        title: "Cash",
                        count: state.dashboard.cashpurchase.toString(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CashScreen(
                                     status: "cash",
                                      )));
                        },
                      ),
                      HomeCard(
                        title: "Total",
                        count: state.dashboard.total.toString(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TotalScreen(
                                     status: "total",
                                      )));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
           }
           return Container(); },
        ),
      );
}
