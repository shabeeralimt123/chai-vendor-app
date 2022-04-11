
import 'package:chai/resources/styleResources.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final double? height;
  final BorderRadius? borderRadius;
  final VoidCallback? onPressed;
  final bool isDisabled;
  const GradientButton({Key? key, this.icon,this.title, this.onPressed, this.height, this.borderRadius,this.isDisabled:false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled?null:onPressed,
      child: Container(
        width: double.infinity,
        height: height ?? 48,
        decoration: isDisabled?BoxDecoration(color: Colors.grey,borderRadius: this.borderRadius):BoxDecoration(borderRadius: this.borderRadius),
        child: Center(
          child: icon != null
              ? (title != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          title!,
                          style: StyleResources.buttonPrimaryTextStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          icon,
                          color: StyleResources.primaryColorText,
                        )
                      ],
                    )
                  : Center(
                      child: Icon(
                      icon,
                      color: Colors.white,
                    )))
              : Center(
                  child: Text(
                    title!,
                    style: StyleResources.buttonPrimaryTextStyle,
                  ),
                ),
        ),
      ),
    );
  }
}
