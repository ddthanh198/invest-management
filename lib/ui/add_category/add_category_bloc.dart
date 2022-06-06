import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_category/add_category_event.dart';
import 'package:invest_management/ui/add_category/add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState>{
  final AssetRepository? repository;

  AddCategoryBloc({@required this.repository}) : super(AddCategoryState()) {
    on<SaveCategoryEvent>((event, emit) => _handleSaveCategoryEvent(event, emit));
    on<EditCategoryEvent>((event, emit) => _handleEditCategoryEvent(event, emit));
    on<RefreshColorOrImage>((event, emit) => _handleRefreshColorOrImage(event, emit));
  }

  void _handleSaveCategoryEvent(SaveCategoryEvent event, Emitter<AddCategoryState> emit) async {
    repository!.saveCategory(event.category!);
    emit(SaveCategorySuccess());
  }

  void _handleEditCategoryEvent(EditCategoryEvent event, Emitter<AddCategoryState> emit) async {
    repository!.updateCategory(event.category!);
    emit(UpdateCategorySuccess());
  }

  void _handleRefreshColorOrImage(RefreshColorOrImage event, Emitter<AddCategoryState> emit) async {
    emit(RefreshColorOrImageState());
  }
}