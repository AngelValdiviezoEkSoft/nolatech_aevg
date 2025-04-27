
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  
  String _pin = '';

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SubmitLicenseKey>(_onSubmitLicenseKey);
    on<SubmitPin>(_onSubmitPin);
    on<ConfirmPin>(_onConfirmPin);
    on<SubmitUsername>(_onSubmitUsername);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    bool result = await InternetConnectionChecker().hasConnection;
    
    if(!result){
      emit(AuthNoInternet());
    }
    else {
      emit(AuthAuthenticated());      
    }
    
  }

  void _onSubmitLicenseKey(
      SubmitLicenseKey event, Emitter<AuthState> emit) async {
    try {
      /*
      final isValidLicenseKey =
          await authRepository.validateLicenseKey(event.licenseKey);
      if (isValidLicenseKey) {
        _licenseKey = event.licenseKey;
        await userPreferences.setLicense(_licenseKey);
        emit(ValidLicenseKey());
      } else {
        emit(InvalidLicenseKey());
      }
      */
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSubmitPin(SubmitPin event, Emitter<AuthState> emit) async {
    if (event.pin.length == 4) {
      _pin = event.pin;
      emit(PinCompleted());
    } else {
      emit(PinSubmitted());
    }
  }

  void _onConfirmPin(ConfirmPin event, Emitter<AuthState> emit) async {
    if (event.pin != _pin) {
      emit(InvalidPin());
    } else {
      //await userPreferences.setPin(_pin);
      //await storage.write(key: objEnvironmentProd.pin, value: _pin);
      emit(ValidPin());
    }
  }

  void _onSubmitUsername(SubmitUsername event, Emitter<AuthState> emit) async {
    try {
      /*
      final User registeredUser =
          await authRepository.registerUser(event.username, _licenseKey, _pin);

      await userPreferences.setUserId(registeredUser.id);
      await userPreferences.setUsername(registeredUser.name);
      */

      //await storageAuthBloc.write(key: environmentAuthBloc.tokenApp, value: registeredUser.token);

      emit(AuthRegistered());
    } catch (e) {
      emit(AuthError("Ocurrió un error durante el registro"));
    }
  }
}
