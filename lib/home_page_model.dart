import 'package:bethesda_2/main.dart';
import 'package:flutter/material.dart';


class HomePageModel extends HomePageWidget {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  TextEditingController? textController5;
  TextEditingController? registrationController1;
  TextEditingController? registrationController2;
  TextEditingController? registrationController3;
  TextEditingController? registrationController4;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  //TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  //HomePageModel(super.olvasottszoveg, {super.key});

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    textController5 = TextEditingController();

    /*
    registrationController1 = TextEditingController();
    registrationController2 = TextEditingController();
    registrationController3 = TextEditingController();
    registrationController4 = TextEditingController();

    textController1?.addListener(_onTextChanged);
    textController2?.addListener(_onTextChanged);

    */
  }

  /*
  void _onTextChanged() {
    if (_speechToText.isListening){
      if (_lastWords != myController.text) {
        setState(() { myController.text = _lastWords;});
      }
    }
  }
   */

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    registrationController1?.dispose();
    registrationController2?.dispose();

    textFieldFocusNode2?.dispose();
    //textController2?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.

}

