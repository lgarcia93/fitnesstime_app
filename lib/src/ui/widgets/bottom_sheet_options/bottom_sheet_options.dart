import 'package:flutter/material.dart';

class BottomSheetOption {
  final String label;
  final VoidCallback onTap;

  BottomSheetOption({
    this.label,
    this.onTap,
  });
}

class BottomSheetOptionsList extends StatelessWidget {
  final List<BottomSheetOption> options;
  final double height;
  BottomSheetOptionsList({
    this.options,
    this.height = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: _buildSeparatedItems(context),
        ),
      ),
    );
  }

  List<Widget> _buildSeparatedItems(
    BuildContext context,
  ) {
    List<Widget> items = [];

    for (int iLoop = 0; iLoop < options.length; iLoop++) {
      items.add(_renderOption(context, options[iLoop]));

      if (iLoop < options.length - 1) {
        items.add(Divider());
      }
    }

    return items;
  }

  Widget _renderOption(
    BuildContext ctx,
    BottomSheetOption option,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          option.onTap();

          Navigator.of(ctx).pop();
        },
        child: Center(
          child: Text(
            option.label,
            style: Theme.of(ctx).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
