

import 'dart:convert';

import 'package:flutter/material.dart';

class AddUserDetail extends StatelessWidget {
  const AddUserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add User")),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
        CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: SizedBox(
            width: 140,
            height: 140,
            child: provider.imageData.isEmpty
                ? Image.asset("assets/user.png", fit: BoxFit.cover)
                : Image.memory(base64Decode(provider.imageData), fit: BoxFit.cover),
          ),
        ),
      ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
                onPressed: () async {
                  provider.imageChooseBottomSheet(context);
                },
                child: Text("Choose Image")),
          ),
          customTextField(provider.nameCtr, "Name", provider.nameFocus, TextInputType.name),
          customTextField(provider.mobileNoCtr, "Mobile No", provider.mobileNoFocus, TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly]),
          customTextField(provider.ageCtr, "Age", provider.ageFocus, TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(3), FilteringTextInputFormatter.digitsOnly]),
          Row(
            children: [
              Expanded(
                child: customTextField(readonly: true, provider.dobCtr, "Date of Birth", provider.dobFocus, TextInputType.number, onTap: () async {
                  provider.selectDate(context).then((value) {
                    provider.dobCtr.text = value;
                  });
                }),
              ),
              SizedBox(width: 10),
              Expanded(child: Consumer<UserProvider>(builder: (context, provider1, child) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: provider1.qualificationValue.isNotEmpty ? provider1.qualificationValue : null,
                      hint: Text("Select"),
                      items: provider1.qualificationList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value, // Fix: Use the correct value
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        provider1.getSetQualificationData(newValue);
                      },
                    ),
                  ),
                );
              })),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        provider.reset();
                      },
                      child: Text("Reset"))),
              SizedBox(width: 10),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {

                        // if (widget.updateID != null) {
                        //   if (provider.checkValidation(context)) {
                        //     await provider.userUpdateData(
                        //         UserModel(
                        //             id: widget.updateID,
                        //             mobileNo: provider.mobileNoCtr.text,
                        //             age: provider.ageCtr.text,
                        //             dob: provider.dobCtr.text,
                        //             name: provider.nameCtr.text,
                        //             profileImg: provider.imageData,
                        //             qualification: provider.qualificationValue),
                        //         context);
                        //
                        //     await provider.getUserDetails();
                        //     Navigator.pop(context);
                        //   }
                        // } else {
                        //   if (provider.checkValidation(context)) {
                        //     await provider.addUserData(
                        //         UserModel(
                        //             mobileNo: provider.mobileNoCtr.text,
                        //             age: provider.ageCtr.text,
                        //             dob: provider.dobCtr.text,
                        //             name: provider.nameCtr.text,
                        //             profileImg: provider.imageData,
                        //             qualification: provider.qualificationValue),
                        //         context);
                        //   }
                        // }
                      },
                      child: Text(widget.updateID != null ? "Update" : "Submit"))),
            ],
          )
        ],
      ),
    );
  }
}
