import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Home extends StatefulWidget {
  @override
  _home createState() => _home();
}

class _home extends State<Home> {
  final _nameFocus = FocusNode();
  final _cardNumberFocus = FocusNode();
  final _cardPinFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      // keyboardBarColor: Colors.grey,

      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _nameFocus,
          onTapAction: () => {print('done clicked !!')},
        ),
        KeyboardActionsItem(
          focusNode: _cardNumberFocus,
        ),
        KeyboardActionsItem(
          focusNode: _cardPinFocus,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    return KeyboardActions(
      config: _buildKeyboardActionsConfig(context),
      child: Stack(children: [
        Column(children: [
          SizedBox(height: 10),
          Text('Drop Validation'),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: DropdownSearch<String>(
              items: ['asd'],
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (item) => {print('selected => ${item}')},
              // validator: (int? i) {
              //   if (i == null) return 'Required Filed';
              //   // else if (i >= 5) return 'value should be < 5';
              //   return null;
              // },
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // labelText: 'Users *',
                  // filled: true,
                  // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  hintText: "Select...",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.zero,
                  // contentPadding: EdgeInsets.only(top: 12, left: 10),
                  prefixIcon: Icon(Icons.access_alarm),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: false,
              ),
              clearButtonProps: ClearButtonProps(isVisible: true),
            ),
          ),
          SizedBox(height: 60),
          Text('Keyboard Test Validation'),
          TextField(
            decoration: const InputDecoration(labelText: "Name"),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            focusNode: _nameFocus,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Card Number"),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _cardNumberFocus,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Card Pin"),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            focusNode: _cardPinFocus,
          ),
        ]),
      ]),
    );
  }
}
