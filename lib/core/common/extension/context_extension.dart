import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  T themeDetection<T> ({required T darkAction, required T lightAction}){

    return darkAction;
  }
}