import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String? title;

  final VoidCallback? onTap;
  final String? count;
  const HomeCard({Key? key, this.title, this.onTap, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 30,
          child: Container(
            // width :130,
            width: MediaQuery.of(context).size.width*0.30,
            height: 170,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             const   SizedBox(
                  height: 3,
                ),
                Text(
                  title!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  count.toString(),
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
