class BadgeModel {
  String name;
  String keyPath;
  int? badgeCount;
  BadgeModel? parent;
  bool needShow = false;
  List childList = [];

  BadgeModel(
    this.name,
    this.keyPath, {
    this.badgeCount,
    this.needShow = false,
    this.parent,
  });

  void addChild(BadgeModel child) {
    if (!childList.contains(child)) {
      childList.add(child);
    }
  }

  void removeChild(BadgeModel child) {
    if (childList.contains(child)) {
      childList.remove(child);
      if (childList.isEmpty) {
        needShow = false;
        badgeCount = 0;
      }
    }
  }

  void cleanAllChild() {
    var copy = childList;
    childList.clear();
    for (BadgeModel item in copy) {
      item.badgeCount = 0;
      item.needShow = false;
      item.cleanAllChild();
    }
  }

  void removeFromParent() {
    if (parent != null) {
      parent?.removeChild(this);
      parent = null;
    }
  }

  bool get getNeedShow {
    if (childList.isNotEmpty) {
      for (BadgeModel item in childList) {
        if (item.getNeedShow) {
          return true;
        }
      }
      return false;
    }
    return needShow;
  }

  int get getBadgeCount {
    if (childList.isNotEmpty) {
      int tempCount = 0;
      for (BadgeModel item in childList) {
        tempCount += item.getBadgeCount ?? 0;
      }
      badgeCount = tempCount;
    }
    return badgeCount ?? 0;
  }

  List<BadgeModel> get getAllLinkChildren {
    List<BadgeModel> list = [];
    if (childList.isNotEmpty) {
      for (BadgeModel item in childList) {
        list.addAll(item.getAllLinkChildren);
      }
    }
    return list;
  }
}
