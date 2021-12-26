import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/layout/shop_layout_screen.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/compoments/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

  var _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context)=>ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context,state){
            if(state is LoginSuccessState){
              if(state.loginModel.status!){
                print(state.loginModel.message);
                print(state.loginModel.data!.token);

                CacheHelper.saveData(
                  key: 'token',
                   value: state.loginModel.data!.token)
                    .then((value) {
                      token=state.loginModel.data!.token!;
                  NavigatAndFinish(context, ShopLayout());
                });
              }
              else{
                print(state.loginModel.message);
                ShowToast(
                    text: state.loginModel.message!,
                    state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style: TextStyle(color: Colors.grey,fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value!.isEmpty)
                              return 'Enter Your email Address';
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(width: 0.8),
                              ),
                             labelText: 'Email address',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value){
                              if(value!.isEmpty)
                              return 'Enter Your Password';
                            },
                            onFieldSubmitted: (value){
                                 if(_formKey.currentState!.validate()){
                                 ShopLoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                   password: passwordController.text,
                                  );}
                            },
                            obscureText: ShopLoginCubit.get(context).ispassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(width: 0.8),
                              ),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: (){
                                 ShopLoginCubit.get(context).ChangePasswordVisibility();
                                },
                                icon: Icon(ShopLoginCubit.get(context).suffix),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context)=> defaultbutton(
                              function: () {
                                if(_formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                password: passwordController.text,
                                );
                                }
                              },
                              text: 'login',
                              isoppercase: true,
                            ),
                            fallback: (context)=> Center(child: CircularProgressIndicator()) ,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              defaultTextButton(
                                function: () {
                                  NavigatTo(context, RegisterScreen());
                                },
                                text: 'register'.toUpperCase(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
