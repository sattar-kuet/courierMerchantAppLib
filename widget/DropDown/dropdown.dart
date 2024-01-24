import 'package:awesome_select/awesome_select.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DropDown extends StatelessWidget {
  const DropDown(
      {super.key,
      required this.value,
      this.width,
      this.data,
      this.items,
      required this.onChangeAction});
  final String value;
  final List<dynamic>? data;
  final double? width;
  final List<DropdownMenuItem<String>>? items;
  final Function(String? value) onChangeAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 80.w,
      height: 6.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: DropdownButton(
        autofocus: true,
        underline: SizedBox(),
        isExpanded: true,
        value: value,
        items: items != null
            ? items
            : data
                ?.map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                          value: value.id.toString(),
                          child: BodyText(
                            text: value.name.toString(),
                          ),
                        ))
                .toList(),
        onChanged: onChangeAction,
      ),
    );
  }
}

Widget dropDownField(BuildContext context,
    {required String selectItem,
    required Function(String value) onChange,
    required String title,
    required String placeholder,
    required List<S2Choice<String?>> data,
    double? width}) {
  return Container(
    width: width ?? 80.w,
    height: 6.h,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 10.sp),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.sp),
        color: Theme.of(context).colorScheme.primaryContainer),
    child: SmartSelect<String?>.single(
      title: '',
      placeholder: placeholder,
      selectedValue: selectItem,
      onChange: (selected) => onChange(selected.value.toString()),
      choiceItems: data,
      choiceGrouped: false,
      modalFilter: true,
      modalFilterAuto: true,
      modalTitle: title,
      choiceStyle: S2ChoiceStyle(
          titleStyle:
              Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15.sp)),
      choiceActiveStyle: S2ChoiceStyle(
          titleStyle:
              Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15.sp)),
      tileBuilder: (context, S2SingleState<String?> state) {
        return S2Tile.fromState(
          state,
          hideValue: true,
          isTwoLine: false,
          padding: EdgeInsets.zero,
          leading: BodyText(text: state.selected.toString()),
        );
      },
    ),
  );
}
