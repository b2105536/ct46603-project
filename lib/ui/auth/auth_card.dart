import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/dialog_utils.dart';

import 'auth_manager.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, dynamic> _authData = {
    'mobile': '',
    'password': '',
    'peradd': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await context.read<AuthManager>().login(
              _authData['mobile']!,
              _authData['password']!,
            );
      } else {
        // Sign user up
        await context.read<AuthManager>().signup(
              _authData['mobile']!,
              _authData['password']!,
              _authData['peradd']!,
            );
        _switchAuthMode();
      }
    } catch (error) {
      log('$error');
      if (mounted) {
        showErrorDialog(context, error.toString());
      }
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
        _mobileController.text = _authData['mobile'] ?? '';
        _passwordController.text = _authData['password'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.signup ? 400 : 270,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signup ? 400 : 270),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.signup) _buildPerAddField(),
                _buildmobileField(),
                _buildPasswordField(),
                if (_authMode == AuthMode.signup) _buildPasswordConfirmField(),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildSubmitButton();
                  },
                ),
                _buildAuthModeSwitchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child:
          Text('HÃY ${_authMode == AuthMode.login ? 'ĐĂNG KÝ' : 'ĐĂNG NHẬP'}'),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      ),
      child: Text(_authMode == AuthMode.login ? 'ĐĂNG NHẬP' : 'ĐĂNG KÝ'),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      enabled: _authMode == AuthMode.signup,
      decoration: const InputDecoration(labelText: 'Xác nhận mật khẩu'),
      obscureText: true,
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Mật khẩu không khớp!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Mật khẩu'),
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 8) {
          return 'Mật khẩu quá ngắn!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildPerAddField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Địa chỉ thường trú'),
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Địa chỉ không thể để trống!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['peradd'] = value!;
      },
    );
  }

  Widget _buildmobileField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Số điện thoại'),
      keyboardType: TextInputType.phone,
      controller: _mobileController,
      validator: (value) {
        if (value!.isEmpty || value.length != 10 || !value.startsWith('0')) {
          return 'Số điện thoại không hợp lệ!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['mobile'] = value!;
      },
    );
  }
}
