import 'package:bloc_curd/Model/add_qualification_model.dart';
import 'package:equatable/equatable.dart';

import '../../../Model/user_model.dart';

abstract class AddUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitUser extends AddUserEvent {
  final UserModel user;
  SubmitUser(this.user);
}

class DeleteUser extends AddUserEvent {
  final UserModel id;
  DeleteUser(this.id);
}

class UpdateUser extends AddUserEvent {
  final UserModel id;
  UpdateUser(this.id);
}

class AddMoreQualificationDetails extends AddUserEvent {
  final String selectPassingYear;
  final String text;
  final String selectedQualification;

  AddMoreQualificationDetails(
    this.selectPassingYear,
    this.text,
    this.selectedQualification,
  );
}
