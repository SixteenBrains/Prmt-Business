import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/loading_indicator.dart';
import '/constants/constants.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/preview-ad/preview_ad.dart';
import '/models/ad_model.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class DemoGraphics extends StatefulWidget {
  const DemoGraphics({Key? key}) : super(key: key);

  @override
  State<DemoGraphics> createState() => _DemoGraphicsState();
}

class _DemoGraphicsState extends State<DemoGraphics> {
  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    final _authBloc = context.read<AuthBloc>();

    final _formKey = GlobalKey<FormState>();

    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        print('Cities --- ${state.stateCities}');
        return Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressContainer(progress: state.progress),
                    const SizedBox(height: 20.0),
                    Text(
                      'Your State',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Select your state',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // ),

                    FormField<String>(
                      builder: (FormFieldState<String> _) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            hintText: 'Your state name',
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 20.0,
                            ),
                          ),
                          isEmpty: state.state == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: state.state,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isDense: true,
                              onChanged: (value) => context
                                  .read<CreateAdCubit>()
                                  .stateChanged(value!),
                              items: states.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      'Your City',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Select your city',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    state.status == CreateAdStatus.initial
                        ? SizedBox(
                            height: _canvas.height * 0.4,
                            //height: 300.0,
                            child: ListView.builder(
                              itemCount: state.stateCities.length,
                              itemBuilder: (context, index) {
                                // final city = state.selectedCities[index];

                                final city = state.stateCities[index];
                                final isSelected = state.selectedCities
                                    .contains(state.stateCities[index]);

                                return ListTile(
                                  title: Text(city),
                                  trailing: Checkbox(
                                    value: isSelected,
                                    onChanged: (value) {
                                      if (isSelected) {
                                        context
                                            .read<CreateAdCubit>()
                                            .removeCity(
                                                state.stateCities[index]);
                                      } else {
                                        context
                                            .read<CreateAdCubit>()
                                            .addCity(state.stateCities[index]);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : state.status == CreateAdStatus.loading
                            ? const LoadingIndicator()
                            : const SizedBox.shrink(),

                    // SizedBox(height: _canvas.height * 0.1),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 2.0,
              right: 2.0,
              left: 2.0,
              child: BottomNavButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    // context.read<CreateAdCubit>().addProgress(
                    //     state.progress < 10 ? 10 : state.progress);
                    final result = await Navigator.of(context).pushNamed(
                      PreviewAdScreen.routeName,
                      arguments: PreviewAdArgs(
                        adModel: AdModel(
                          adType: state.mediaType,
                          mediaFile: state.adMedia,
                          title: state.adName,
                          description: state.description,
                          targetLink: state.targetLink,
                          budget: state.budget,
                          author: _authBloc.state.user,
                          // ageGroup: state.ageGroup,
                          // adId: '1',
                          // adImage: state.adImage,
                          // adVideo: state.adVideo,
                          state: state.state,
                          cities: state.selectedCities,
                          startDate: state.startDate,
                          endDate: state.endDate,
                          // incomeRange: state.incomeRange,
                          // interests: state.interests,
                        ),
                      ),
                    );
                    print('Result $result');
                    if (result == true) {
                      context
                          .read<CreateAdCubit>()
                          .changePage(AdCurrentPage.adName);
                    }
                  }
                },
                label: 'CONTINUE',
                isEnabled:
                    state.state.isNotEmpty && state.stateCities.isNotEmpty,
              ),
            ),
          ],
        );
      },
    );
  }
}
