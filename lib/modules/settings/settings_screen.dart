import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/compoments/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey=GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        if (cubit.shopLoginModel != null) {
          nameController.text = cubit.shopLoginModel!.data!.name!;
          emailController.text = cubit.shopLoginModel!.data!.email!;
          phoneController.text = cubit.shopLoginModel!.data!.phone!;
        }
        return cubit.shopLoginModel != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text(
                          'EDIT PROFIL',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                         Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(cubit.shopLoginModel!.data!.image!),
                             ),
                         ),
                         IconButton(
                         onPressed: (){},
                         icon: CircleAvatar(
                         radius: 15,
                         backgroundColor: DefaultColor.withOpacity(0.5),
                         child: Icon(Icons.add,color: Colors.white,size: 20,)),
                          ),
                         ],
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) return 'Enter Your Name';
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            labelText: 'User Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) return 'Enter Your Email Address';
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) return 'Enter Your Phone';
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                         SizedBox(
                         height: 15,
                          ),
                        if(state is ShopLoadingUpdateUserDataState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                        defaultbutton(
                          backgroundcolor: DefaultColor,
                          function: () {
                            if(formkey.currentState!.validate()){
                              ShopCubit.get(context).UpdateProfil(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                           );
                           }
                        },
                          text: 'UPDATE',
                          radius: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultbutton(
                          backgroundcolor: DefaultColor,
                          function: () {
                            SignOut(context);
                            ShopCubit.get(context).Currentindex = 0;
                          },
                          text: 'LOGOUT',
                          radius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
