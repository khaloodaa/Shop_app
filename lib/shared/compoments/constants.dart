
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void SignOut(BuildContext context){
  CacheHelper.removeData(key: 'token').then((value) {
    NavigatAndFinish(context, ShopLoginScreen());
  });
}

void PrintFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String token='';