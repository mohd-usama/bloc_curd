import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../Model/add_qualification_model.dart';
import '../../Model/user_model.dart';
import '../../Suppots/camera_and_gallery.dart';
import '../../Suppots/textfield_mixin.dart';
import 'AddUserBloc/add_user_bloc.dart';
import 'AddUserBloc/add_user_event.dart';
import 'AddUserBloc/add_user_state.dart';

class AddUserDetail extends StatefulWidget {
  int? id;
  UserModel userModel = UserModel();
  AddUserDetail({this.id, required this.userModel});

  @override
  State<AddUserDetail> createState() => _AddUserDetailState();
}

class _AddUserDetailState extends State<AddUserDetail> with CustomTextFieldWidgets {
  List<String> qualificationList = ["Select", "BCA", "B.com", "M.com", "B.tech", "M.tech"];

  List<String> passingYear = ["Select", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026"];

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  String selectedQualification = "Select", imageSelect = "", selectPassingYear = "Select";

  List<AddQualificationModel> addQualificationList = [];

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    ageController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addQualificationList.add(AddQualificationModel(selectedQualification, selectPassingYear, TextEditingController(text: "")));
    context
        .read<AddUserBloC>()
        .add(AddMoreQualificationDetails(selectPassingYear, addQualificationList[0].marks!.text, selectedQualification));
    if (widget.id != -1) {
      // selectedQualification = qualificationList[qualificationList.indexWhere((v) => v == widget.userModel.qualification)];
      nameController.text = widget.userModel.name!;
      mobileController.text = widget.userModel.mobileNo!;
      ageController.text = widget.userModel.age!;
      dobController.text = widget.userModel.dob!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, "refresh");
        return true;
      },
      child: Scaffold(
          appBar: AppBar(title: Text("Add User")),
          body: BlocListener<AddUserBloC, AddUserState>(
            listener: (context, state) {
              if (state.isSuccess) {
                if (widget.id == -1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User Added Successfully")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User Update Successfully")),
                  );
                }

                nameController.clear();
                mobileController.clear();
                ageController.clear();
                dobController.clear();

                setState(() {
                  selectedQualification = "Select";
                  imageSelect = "";
                });
              }

              if (state.isError != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.isError!)),
                );
              }
            },
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: imageSelect == ""
                          ? Icon(Icons.person, size: 100)
                          : Image.memory(gaplessPlayback: true, base64Decode(imageSelect), fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        imageChooseBottomSheet(context);
                      },
                      child: Text("Choose Image")),
                ),
                customTextField(
                  "Name",
                  controller: nameController,
                  TextInputType.name,
                ),
                customTextField(
                  "Mobile No",
                  controller: mobileController,
                  TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                ),
                Row(
                  children: [
                    Expanded(
                        child: customTextField(
                      "Date of Birth",
                      TextInputType.number,
                      controller: dobController,
                      readonly: true,
                      onTap: () async {
                        String value = await selectDate(context);
                        dobController.text = value;
                      },
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: customTextField(
                      "Age",
                      controller: ageController,
                      TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(3), FilteringTextInputFormatter.digitsOnly],
                    )),
                  ],
                ),
                Column(
                    children: List.generate(addQualificationList.length, (index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text("Qualification : ${index + 1}")),
                            if (index + 1 != 1)
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      addQualificationList.removeAt(index);
                                    });
                                  },
                                  child: Icon(Icons.delete))
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 52,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            value: addQualificationList[index].qualification,
                            hint: Text("Select"),
                            items: qualificationList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                addQualificationList[index].qualification = newValue!;
                              });
                            },
                          )),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: 52,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                value: addQualificationList[index].passingYear,
                                hint: Text("Select"),
                                items: passingYear.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    addQualificationList[index].passingYear = newValue!;
                                  });
                                },
                              )),
                            )),
                            SizedBox(width: 10),
                            Expanded(
                                child: customTextField(
                              "Marks",
                              controller: addQualificationList[index].marks,
                              TextInputType.number,
                              inputFormatters: [LengthLimitingTextInputFormatter(3), FilteringTextInputFormatter.digitsOnly],
                            ))
                          ],
                        ),
                        if (index == addQualificationList.length - 1)
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addQualificationList.add(AddQualificationModel(
                                      selectedQualification, selectPassingYear, TextEditingController(text: "")));
                                  context.read<AddUserBloC>().add(AddMoreQualificationDetails(
                                      selectPassingYear, addQualificationList[index].marks!.text, selectedQualification));
                                });
                              },
                              child: Text("Add More Qualification"))
                      ],
                    ),
                  );
                })),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: () {}, child: Text("Reset"))),
                    SizedBox(width: 10),
                    Expanded(child: BlocBuilder<AddUserBloC, AddUserState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (checkValidation(context)) {
                              if (widget.id == -1) {
                                final user = UserModel(
                                  name: nameController.text.trim(),
                                  mobileNo: mobileController.text.trim(),
                                  age: ageController.text.trim(),
                                  dob: dobController.text.trim(),
                                  profileImg: imageSelect,
                                );
                                context.read<AddUserBloC>().add(SubmitUser(user));
                              } else {
                                final user = UserModel(
                                  id: widget.id,
                                  name: nameController.text.trim(),
                                  mobileNo: mobileController.text.trim(),
                                  age: ageController.text.trim(),
                                  dob: dobController.text.trim(),

                                  profileImg: imageSelect,
                                );
                                context.read<AddUserBloC>().add(UpdateUser(user));
                              }
                            }
                          },
                          child: Text(widget.id == -1 ? "Submit" : "Edit"),
                        );
                      },
                    )),
                  ],
                )
              ],
            ),
          )),
    );
  }

  bool checkValidation(BuildContext context) {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter name")));
      return false;
    } else if (mobileController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter mobile no")));
      return false;
    } else if (ageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter age")));
      return false;
    } else if (dobController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select data of birth")));
      return false;
    }
    // else if (selectedQualification == "Select") {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select qualification")));
    //   return false;
    // }

    return true;
  }

  Future<String> selectDate(BuildContext context) async {
    var data = await showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    if (data != null) {
      return DateFormat('dd-MM-yyyy').format(data);
    } else {
      return "";
    }
  }

  void imageChooseBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (c) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  var imageResult = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CameraAndGallery("camera");
                  }));

                  if (imageResult != null) {
                    setState(() {
                      imageSelect = imageResult["image64"];
                    });
                  }
                },
                title: Text("Camera"),
                trailing: Icon(Icons.camera),
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  var imageResult = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CameraAndGallery("gallery");
                  }));

                  if (imageResult != null) {
                    setState(() {
                      imageSelect = imageResult["image64"];
                    });
                  }
                },
                title: Text("Gallery"),
                trailing: Icon(Icons.photo),
              ),
            ],
          );
        });
  }
}
