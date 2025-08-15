import 'package:flutter/material.dart';

import '../../../../models/SourceResponse.dart';

class SourceNameTab extends StatelessWidget {
  Sources source;
  bool isSelected;
   SourceNameTab({super.key,required this.source,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return  Text(
      source.name ??'',
      style: isSelected?
      Theme.of(context).textTheme.labelLarge
          :Theme.of(context).textTheme.labelMedium,);
  }
}
