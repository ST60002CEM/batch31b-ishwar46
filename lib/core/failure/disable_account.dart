import 'package:age_care/core/failure/failure.dart';

class AccountDisabledFailure extends Failure {
  final String message;

  AccountDisabledFailure({this.message = 'Your Account is Disabled'})
      : super(error: message);
}
