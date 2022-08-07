import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_world/services/model/trip.dart';

@immutable
abstract class CubitState extends Equatable {}

class InitialState extends CubitState {
  @override
  List<Object> get props => [];
}

class WelcomeState extends CubitState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CubitState {
  @override
  List<Object> get props => [];
}

@immutable
class LoadedState extends CubitState {
  final List<TripModel> trips;

  LoadedState(this.trips);

  @override
  List<Object> get props => [trips];
}

class ErrorState extends CubitState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class DetailState extends CubitState {
  final int id;
  DetailState(this.id);
  @override
  List<Object> get props => [id];
}
