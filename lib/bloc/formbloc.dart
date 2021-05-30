import 'package:blocflut/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class FormBloC with Validators {
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  ///Getters (who get data) (listen stream)
  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(passwordValidator);

  Stream<bool> get isValidForm => Rx.combineLatest4(
      name, email, password, confirmPassword, (a, b, c, d) => true);

  ///Setters (Who is doing changes) (put input in stream)
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

  ///Transformer
  //these transformers on validators page
  ///`To match the password`
  Stream<bool> get passwordMatch =>
      Rx.combineLatest2(password, confirmPassword, (pass, confPass) {
        if (pass != confPass) {
          return false;
        } else {
          return true;
        }
      });

  void submit(){
    print(_name.value);
    print(_email.value);
    print(_password.value);
    print(_confirmPassword.value);
  }

  void dispose() {
    _name.close();
    _email.close();
    _password.close();
    _confirmPassword.close();
  }
}
