import 'package:dartz/dartz.dart';
import 'package:super_ecommerce/core/constants/api_endpoints.dart';
import 'package:super_ecommerce/core/errors/exception_handler.dart';
import 'package:super_ecommerce/core/services/api_service.dart';
import 'package:super_ecommerce/main.dart';
import '../models/category_model.dart';

abstract class CategoryRepository with ExceptionHandler {
  CustomResultAsync<List<CategoryModel>> getMainCategories();
  CustomResultAsync<List<CategoryModel>> getChildrenOfCategory(int categoryId);
}

class CategoryRepositoryImpWithHttp extends CategoryRepository {
  final ApiService apiService;
  CategoryRepositoryImpWithHttp({required this.apiService});
  @override
  CustomResultAsync<List<CategoryModel>> getChildrenOfCategory(
      int categoryId) async {
    return handleExceptionAsync(() async {
      final data =
          await apiService.get(ApiEndpoint.childrenOfCategory(categoryId));
      return Right(CategoryModel.fromMapList(data));
    });
  }

  @override
  CustomResultAsync<List<CategoryModel>> getMainCategories() async {
    return handleExceptionAsync(() async {
      final data = await apiService.get(ApiEndpoint.mainCategories);
      return Right(CategoryModel.fromMapList(data));
    });
  }
}
