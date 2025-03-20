import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../../domain/repositories/profile_repository.dart';
import '../cubit/edit_name_cubit.dart';

class EditNameView extends StatelessWidget {
  static const String routeName = '/edit_name_view';
  const EditNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: const Text('Edit Name'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.kWhiteColor),
          onPressed: () {
            navigateBack(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.s20),
        child: BlocProvider(
          create: (context) => EditNameCubit(
            ProfileRepository(
              Supabase.instance.client,
            ),
          ),
          child: BlocConsumer<EditNameCubit, EditNameState>(
            listener: (context, state) {
              if (state is EditNameSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Name updated successfully')),
                );
                navigateBack(context);
              } else if (state is EditNameError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final nameController =
                  context.read<EditNameCubit>().nameController;

              return Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: AppStrings.name,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppSizes.s20),
                  if (state is EditNameLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.s15, horizontal: AppSizes.s30),
                      ),
                      onPressed: () {
                        context.read<EditNameCubit>().updateName();
                      },
                      child: Text(AppStrings.update,
                          style: getBoldStyle(
                            color: AppColors.kWhiteColor,
                            fontSize: AppSizes.s16,
                          )),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
