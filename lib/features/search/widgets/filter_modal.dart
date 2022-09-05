import 'package:flutter/material.dart';

import 'package:e_commerce/common/widgets/custom_button.dart';
import 'package:e_commerce/common/widgets/custom_textfield.dart';

class FilterModal extends StatefulWidget {
  final Function(double minPrice, double maxPrice, bool searchDiscount, bool hasDiscounts)
      onApplyFilter;

  const FilterModal({
    Key? key,
    required this.onApplyFilter,
  }) : super(key: key);

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  bool hasDiscounts = false;
  bool searchDiscount = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: maxPriceController,
            title: "Max Price",
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            controller: minPriceController,
            title: "Min Price",
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Checkbox(
                value: searchDiscount,
                onChanged: (value) {
                  if (value != null) {
                    searchDiscount = value;
                    setState(() {});
                  }
                },
              ),
              const Text('Search by discount'),
              const SizedBox(width: 5),
              if (searchDiscount) const Icon(Icons.arrow_forward),
              const SizedBox(width: 5),
              if (searchDiscount)
                Row(
                  children: [
                    Checkbox(
                      value: hasDiscounts,
                      onChanged: (value) {
                        if (value != null) {
                          hasDiscounts = value;
                          setState(() {});
                        }
                      },
                    ),
                    const Text('Has discounts')
                  ],
                ),
            ],
          ),
          CustomButton(
            // height: 40,
            text: 'Apply',
            onTap: () {
              double maxPrice = 100000000.0;
              double minPrice = 0.0;
              if (maxPriceController.text.isNotEmpty) {
                maxPrice = double.tryParse(maxPriceController.text) ?? maxPrice;
              }
              if (minPriceController.text.isEmpty) {
                minPrice = double.tryParse(minPriceController.text) ?? minPrice;
              }
              widget.onApplyFilter(minPrice, maxPrice, searchDiscount, hasDiscounts);
            },
          )
        ],
      ),
    );
  }
}
