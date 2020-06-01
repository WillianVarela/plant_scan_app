import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:scan/app/modules/result/result_bloc.dart';
import 'package:scan/app/modules/result/result_page.dart';

class ResultModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => ResultBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ResultPage();

  static Inject get to => Inject<ResultModule>.of();
}
