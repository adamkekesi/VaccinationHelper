import 'package:async_redux/async_redux.dart';
import 'package:vaccination_helper/core/redux/app_state.dart';
import 'package:vaccination_helper/helpers/exceptions/base_exception.dart';
import 'package:vaccination_helper/helpers/exceptions/unknown_exception.dart';

var store = new Store(initialState: new AppState.initial());
