class Tab {
  String? text;
  String? icon;
  int? index;
  bool selectedTab;
  List<Tab> subTabs;
  bool visible;

  dynamic keyId;

  Tab({
    this.selectedTab = false,
    this.text,
    this.icon,
    this.index,
    this.visible=true,
    this.subTabs = const [], // Initialize with empty list
  });

  bool _selected=false;
  bool get selected => _selected;
  setSelected(bool selected) async {
    _selected = selected;
  }

}
