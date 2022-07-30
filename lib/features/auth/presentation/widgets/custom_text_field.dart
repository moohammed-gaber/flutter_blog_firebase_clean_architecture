import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitledTextField extends StatelessWidget {
  const CustomTitledTextField(
      {Key? key, required this.name, required this.textField})
      : super(key: key);
  final String name;
  final Widget textField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        SizedBox(height: 10.h),
        textField,
        SizedBox(height: 20.h),
      ],
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTitledTextField(
      name: 'البريد الالكتروني',
      textField: TextFormField(validator: (value) {}),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.text,
    required this.validator,
    this.onChanged,
  }) : super(key: key);
  final String text;
  final String? Function(String? input) validator;
  final ValueChanged<String?>? onChanged;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomTitledTextField(
      name: widget.text,
      textField: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          TextFormField(
              // name: widget.keyName,
              onChanged: widget.onChanged,
              validator: (_) => widget.validator(_),
              obscureText: isVisible,
              decoration: InputDecoration()),
          IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
          ),
        ],
      ),
    );
  }
}

/*
class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTitledTextField(
      name: '',
      textField: TextField(),
    );
  }
}
*/
