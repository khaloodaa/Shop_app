import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/getfavorites_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaulttextfield({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  Function? ontap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressd,
  bool isEnable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      obscureText: isPassword,
      onChanged: (s) {
        onChange!(s);
      },
      validator: (s) {
        validate(s);
      },
      enabled: isEnable,
      onTap: () {
        ontap!();
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0.8),
        ),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressd!();
                },
                icon: Icon(suffix))
            : null,
      ),
    );

Widget defaultTextButton({
  required Function? function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function!();
      },
      child: Text(text),
    );

Widget defaultbutton({
  double width = double.infinity,
  Color backgroundcolor = Colors.blue,
  required Function? function,
  double radius = 0,
  required String text,
  bool isoppercase = true,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isoppercase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundcolor,
      ),
    );

Widget MyDivider() => Padding(
      padding: EdgeInsets.only(left: 15),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

void NavigatTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void NavigatAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void ShowToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChoseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color ChoseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget BuildProItems(model, context,{bool isoldprice=true}) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  height: 100,
                  width: 120,
                ),
                if(model.discount != 0 && isoldprice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15, height: 1.2, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}' + ' \$',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: DefaultColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(model.discount != 0 && isoldprice)
                      Text(
                        '${model.oldPrice}' + ' \$',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: DefaultColor,
                        maxRadius: 17,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .SaveFavorites(model.id);
                          },
                          icon: Icon(Icons.favorite_border),
                          color: Colors.white,
                          iconSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
