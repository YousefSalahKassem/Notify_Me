import 'package:flutter/material.dart';

class TextFieldApp extends StatefulWidget {
  TextEditingController? controller;
  String? hint;
  Icon? icon;
  TextInputType? textInputType;
  TextFieldApp({Key? key,this.icon,required this.controller,this.hint,this.textInputType}) : super(key: key);

  @override
  State<TextFieldApp> createState() => _TextFieldAppState();
}

class _TextFieldAppState extends State<TextFieldApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: TextFormField(
        controller: widget.controller!,
        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.3)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
              )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
              )
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red
              )),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
              )
          ),
        ),
      ),
    );
  }
}
