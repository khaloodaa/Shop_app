
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/compoments/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var _formKey= GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            if(state.loginModel.status!){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token)
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(color: Colors.grey,fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'Enter Your Username';
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person),
                          ),
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
                          obscureText: ShopRegisterCubit.get(context).ispassword,
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
                                ShopRegisterCubit.get(context).ChangePasswordVisibility();
                              },
                              icon: Icon(ShopRegisterCubit.get(context).suffix),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'Enter Your Phone Number';
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context)=> defaultbutton(
                            radius: 15,
                            function: () {
                              if(_formKey.currentState!.validate()){
                          ShopRegisterCubit.get(context).UserRegister(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phoneController.text,
                          );
                          }
                            },
                            text: 'Register',
                            isoppercase: true,
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()) ,
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
