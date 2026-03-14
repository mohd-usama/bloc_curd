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

class DeleteUser extends AddUserEvent{
  final UserModel id;
  DeleteUser(this.id);
}


class UpdateUser extends AddUserEvent{
  final UserModel id;
  UpdateUser(this.id);
}
