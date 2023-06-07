import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_it/get_it.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_item_controller.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      this.hintText,
      this.onSubmitted,
      this.onChanged,
      this.controller,
      this.hasSuggestions = false});
  final String? hintText;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool hasSuggestions;

  @override
  Widget build(BuildContext context) {
    final shoppingListItemController =
        GetIt.I.get<ShoppingListItemController>();

    return hasSuggestions
        ? TypeAheadFormField<ItemEntity>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            suggestionsCallback: (pattern) {
              return shoppingListItemController.search(pattern).getOrThrow();
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.name),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              if (controller == null) {
                throw Exception('controller must be setted!');
              }
              controller!.text = suggestion.name;
            },
            onSaved: (value) => {},
          )
        : TextField(
            onChanged: onChanged,
            controller: controller,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
  }
}
