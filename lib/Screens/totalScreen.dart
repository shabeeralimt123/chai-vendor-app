import 'package:chai/Screens/homescreen.dart';
import 'package:chai/bloc/NewOrder/neworder_cubit.dart';
import 'package:chai/componants/itemCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalScreen extends StatefulWidget {
//  final  int itemCount;
//  final String date;
//  final String time;
//  final String customername;
//  final String amount;
  final String status;

  const TotalScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<TotalScreen> createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NeworderCubit>(context).getNewOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Total",style: TextStyle(color: Colors.black),),
        elevation: 0,
       bottom: PreferredSize(child: Padding(
         padding: const EdgeInsets.only(bottom:20,right:210),
         child: Text("Transaction History",style :TextStyle(color: Colors.black,fontSize :18, ),
                        ),
       ), preferredSize:Size(12, 60)),
       leading :IconButton(
        icon:  Icon(Icons.arrow_back,color: Colors.black),
        onPressed: () { Navigator.pop(context); },),
      
        backgroundColor: Colors.white,
         actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert,color:Colors.black),
           
            onPressed: () {
              // handle the press
            },
          ),
        ],
       
      
      ),
      body: 
            BlocBuilder<NeworderCubit, NeworderState>(
              builder: (context, state) {
                if(state is NeworderLoaded){
                    if(state.newOrders.purchaseorders!.purchase!.length== 0){
                         return Center(child: Text("currently you have no  orders",style :TextStyle(color : Colors.white)),);
                    }
                return ListView.builder(
                         physics:BouncingScrollPhysics(),
                           itemCount: state.newOrders.purchaseorders!.purchase!.length,
                           // itemCount: 10,
                           
                          shrinkWrap:true,
                           scrollDirection: Axis.vertical,
                           itemBuilder: (context, index) {
                        
                             return ItemCard(amount:  state.newOrders.purchaseorders!.purchase![index].amount.toString(),colors: colors[index % colors.length] ,name:  state.newOrders.purchaseorders!.purchase![index].customername!.toUpperCase().toString(),date:  state.newOrders.purchaseorders!.purchase![index].date.toString(),time:  state.newOrders.purchaseorders!.purchase![index].time.toString(),title: state.newOrders.purchaseorders!.purchase![index].customername![0].toUpperCase().toString() );
                           });
              }
              return Container();},
            ),);
        
  }
}
List colors = [
  Colors.blue,
  Colors.orange,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.pink,
  Colors.greenAccent
];

