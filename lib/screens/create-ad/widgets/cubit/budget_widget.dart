import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/create-ad/widgets/cubit/budget_cubit.dart';
import '/constants/constants.dart';

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetCubit, BudgetState>(
      builder: (context, state) {
        print('Custom value  ${state.budget}');
        return state.showCustom
            ? Row(
                children: [
                  Chip(
                    label: const Text(
                      'Custom',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 16.0,
                    ),
                    backgroundColor: const Color(0xff18a1fd).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: const BorderSide(color: Colors.blue, width: 1.5),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) =>
                          context.read<BudgetCubit>().budgetChanged(value),
                      // controller: _customBudgetController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabled: true,
                        prefixIcon: const Icon(Icons.currency_rupee),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            context.read<BudgetCubit>().changeShowCustom(false);
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Wrap(
                spacing: 16.0,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: dailyBudget.map((budget) {
                  bool isSelected = state.budget == budget;
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        context.read<BudgetCubit>().budgetChanged(null);
                        // context.read<CreateAdCubit>().budgetChanged(null);
                      } else {
                        context.read<BudgetCubit>().budgetChanged(budget);
                        //context.read<CreateAdCubit>().budgetChanged(budget);
                      }
                    },
                    child: Chip(
                      label: Text(
                        '₹ $budget',
                        // budget != 'Custom' ? '₹ $budget' : 'Custom',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 10.0),
                      backgroundColor: isSelected
                          ? const Color(0xff18a1fd).withOpacity(0.4)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                    ),
                  );
                }).toList()
                  ..add(
                    GestureDetector(
                      onTap: () =>
                          context.read<BudgetCubit>().changeShowCustom(true),
                      child: Chip(
                        label: const Text(
                          'Custom',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 10.0),
                        backgroundColor: state.showCustom
                            ? const Color(0xff18a1fd).withOpacity(0.4)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(
                            color: state.showCustom
                                ? Colors.blue
                                : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
              );
      },
    );
  }
}
