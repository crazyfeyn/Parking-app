import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';
import 'package:flutter_application/features/payment_screen/presentation/data/models/list_payment_methods.dart';

class FetchPaymentMethodListUsecase extends Usecase {
  HomeRepositories homeRepositories;

  FetchPaymentMethodListUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, List<ListPaymentMethods>>> call(params) {
    return homeRepositories.fetchPaymentMethods();
  }
}
