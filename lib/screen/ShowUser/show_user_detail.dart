import 'dart:convert';

import 'package:bloc_curd/Model/user_model.dart';
import 'package:bloc_curd/screen/AddUser/add_user_detail.dart';
import 'package:bloc_curd/screen/ShowUser/ShowUserBloc/show_user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Suppots/textfield_mixin.dart';
import '../AddUser/AddUserBloc/add_user_bloc.dart';
import '../AddUser/AddUserBloc/add_user_event.dart';
import 'ShowUserBloc/show_user_event.dart';
import 'ShowUserBloc/show_user_state.dart';

class GetUserDetails extends StatefulWidget {
  const GetUserDetails({super.key});

  @override
  State<GetUserDetails> createState() => _GetUserDetailsState();
}

class _GetUserDetailsState extends State<GetUserDetails> with CustomTextFieldWidgets {
  @override
  void initState() {
    super.initState();
    context.read<ShowUserBloc>().add(FetchUserList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get User Details"),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserDetail(id: -1,userModel: UserModel(),)));
                  if (result != null) {
                    context.read<ShowUserBloc>().add(FetchUserList());
                  }
                },
                child: Text("Add User"))
          ],
        ),
        body: BlocBuilder<ShowUserBloc, ShowUserState>(builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.showUserList.isEmpty) {
            return Center(child: Text("No Users Found"));
          }
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: state.showUserList.length,
            itemBuilder: (BuildContext context, int index) {
              final user = state.showUserList[index];
              return Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow()]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (user.profileImg!.isNotEmpty)
                      CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: SizedBox(
                              height: 100, width: 100, child: Image.memory(base64Decode(user.profileImg!), fit: BoxFit.cover)),
                        ),
                      ),
                    Row(
                      children: [
                        Text("Name : ", style: customTextStyle),
                        Text(user.name ?? "", style: customTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Mobile No : ", style: customTextStyle),
                        Text(user.mobileNo ?? "", style: customTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        Text("DOB : ", style: customTextStyle),
                        Text(user.dob ?? "", style: customTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Age : ", style: customTextStyle),
                        Text(user.age ?? "", style: customTextStyle),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Text("Qualification : ", style: customTextStyle),
                    //     Text(user.qualification ?? "", style: customTextStyle),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            child: Text("Edit", style: TextStyle(color: Colors.white)),
                            onPressed: () async {
                              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserDetail(id: user.id,userModel:user)));
                              if (result != null) {
                                context.read<ShowUserBloc>().add(FetchUserList());
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          )),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                                child: Text("Delete", style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  state.showUserList.removeAt(index);
                                  context.read<AddUserBloC>().add(DeleteUser(user));
                                  setState(() {

                                  });
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }));
  }
}
