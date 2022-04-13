import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String? title;
  final String? date;
  final String? time;
   final Color? colors;
   final String? name;

  final VoidCallback? onTap;
  final String? amount;
  const ItemCard({Key? key, this.title, this.onTap, this.amount,this.date,this.time,this.colors,this.name })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:12, top:8,right:8,bottom:8),
      child: Container(
        height : 75,
        width : 450,
        child: Row(
         
          children :[
          Padding(
            padding: const EdgeInsets.only(left:10),
            child: Column(children:[Center(child: Container(child : Center(child : Text(title!,style: TextStyle(color: Colors.white,fontSize: 19))),height : 42, width : 42,decoration : BoxDecoration(color :colors!,borderRadius :BorderRadius.circular(22))))]),
          ),
           Padding(
             padding: const EdgeInsets.only(left:22),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               
               children:[Text(name!,style :TextStyle(color :Colors.black,fontWeight :FontWeight.bold,fontSize :15)),
               Padding(
                 padding: const EdgeInsets.only(top: 4),
                 child: Text("${date!}  at  " +"${time!}",style : TextStyle(color : Colors.black,fontSize :13)),
               )]),
           ),
            Padding(
              padding: const EdgeInsets.only(left: 115),
              child: Column(children:[
               
                
                Text(amount!)]),
            ),

        ]),
        
      ),
    );
  }
}
