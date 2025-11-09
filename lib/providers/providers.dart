


import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:history_identifier/config/data.dart';
import 'package:history_identifier/model/model.dart';

final contentProvider = StateProvider<List<ContentModel>>((ref) => []);

final photoTakenProvider = StateProvider<File?>((ref) => null,);

final apiOperationsController = Provider<ApiOperations>((ref) {
  return ApiOperations();
});