import 'package:flutter/material.dart';
import 'package:flutter_base/ui/shared/base/base_page.dart';
import 'package:flutter_base/ui/widgets/text_input_field_themes.dart';

mixin BaseEditPage<Page extends BasePage> on BaseState<Page> {
  final GlobalKey<FormState> _baseEditformKeychild = GlobalKey<FormState>();
  static const double textFieldHeight = 75.0;
  static const double formFieldMarginVertical = 8.0;

  bool isValidated = false;
  bool autoValidate = false;

  String currentSelection;

  bool _buttonEnabled = false;
  bool get buttonEnabled => _buttonEnabled;
  set buttonEnabled(bool enable) => _buttonEnabled = enable;

  @override
  List<Widget> actions() {
    return [
      Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: Text(
              actionTitle(),
              textScaleFactor: 1.5,
              style: _buttonEnabled
                  ? TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    )
                  : TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
            ),
            onTap: _buttonEnabled ? onSubmit : null,
          ),
        ),
      ),
    ];
  }

  @override
  Widget body() => Form(
        key: _baseEditformKeychild,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          children: content(),
        ),
      );

  Widget textField(String title, TextEditingController ctrler,
          FocusNode focusNode, Function onSaved, Function validator,
          {String helperText, Text prefix, TextInputType keyboardType}) =>
      Container(
        height: textFieldHeight,
        margin: const EdgeInsets.symmetric(
          vertical: formFieldMarginVertical,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(color: Colors.black),
            helperText: helperText,
            helperStyle: helperText != null
                ? TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)
                : null,
            prefix: prefix,
            border: textFieldNormalBorder(),
            focusedBorder: textFieldFocusedBorder(),
            focusedErrorBorder: textFieldFocusedErrorBorder(),
          ),
          controller: ctrler,
          focusNode: focusNode,
          keyboardType: keyboardType,
          validator: validator,
          onSaved: onSaved,
        ),
      );

  Widget dropDown(String label, List<String> items, Function onStateChange,
          Function onSaved) =>
      Container(
        height: BaseEditPage.textFieldHeight,
        margin: const EdgeInsets.symmetric(
          vertical: BaseEditPage.formFieldMarginVertical,
        ),
        child: DropdownButtonFormField<String>(
          value: currentSelection,
          items: items.map((String s) {
            return DropdownMenuItem<String>(
              value: s,
              child: Text(s),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
            border: textFieldNormalBorder(),
            focusedBorder: textFieldFocusedBorder(),
            focusedErrorBorder: textFieldFocusedErrorBorder(),
          ),
          validator: (val) => !items.contains(val) ? 'Invalid selection' : null,
          onChanged: onStateChange,
          onSaved: onSaved,
        ),
      );

  Widget radioGroup(radios, String title) => Container(
        margin: const EdgeInsets.symmetric(
          vertical: BaseEditPage.formFieldMarginVertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              childAspectRatio: 5.0,
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              children: radios,
            ),
          ],
        ),
      );

  Widget buildRadio<T>(
          T type, String title, onTypeRadioGroupVal, onTypeRadioChange) =>
      Row(
        children: <Widget>[
          Radio<T>(
            value: type,
            groupValue: onTypeRadioGroupVal,
            onChanged: onTypeRadioChange,
          ),
          Expanded(
            child: Text(
              title,
              softWrap: true,
            ),
          )
        ],
      );

  void onSubmit() {}

  void updateButtonEnabled(bool enabled) {
    _buttonEnabled = enabled;
  }

  void validateForm() {
    var formState = _baseEditformKeychild.currentState;
    if (formState.validate()) {
      formState.save();

      setState(() {
        isValidated = true;
      });
    } else {
      setState(() {
        isValidated = false;
      });
    }
  }

  String actionTitle();
  List<Widget> content() => [];
}
