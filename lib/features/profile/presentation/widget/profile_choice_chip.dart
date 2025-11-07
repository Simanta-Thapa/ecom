import 'package:flutter/material.dart';
import 'package:ecommerce/features/profile/domain/entities/profile_tab.dart';

import '../bloc/profile_event.dart';

typedef TabSelectedCallback = void Function(ProfileTab tab);

class ProfileChoiceChip extends StatelessWidget {
  final List<ProfileTabItem> tabs;
  final ProfileTab selectedTab;
  final TabSelectedCallback onTabSelected;

  const ProfileChoiceChip({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12, // spacing between chips
      children: tabs.map((tabItem) {
        final isSelected = tabItem.tab == selectedTab;

        return ChoiceChip(
          label: Text(tabItem.label),
          avatar: Icon(
            tabItem.icon,
            color: isSelected ? Colors.white : Colors.black54,
            size: 20,
          ),
          selected: isSelected,
          selectedColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          onSelected: (_) => onTabSelected(tabItem.tab),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      }).toList(),
    );
  }
}
