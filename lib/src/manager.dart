import 'package:badge_chain/badge_chain.dart';

class BadgeManager {
  BadgeManager._privateConstructor();
  static final BadgeManager _instance = BadgeManager._privateConstructor();
  static BadgeManager get instance {
    return _instance;
  }

  final BadgeModel _root = BadgeModel("root", _rootKeyPath);

  static String get _rootKeyPath => "root";

  final Map<String, Function(BadgeModel)> _listenKeyPaths = {};

  void addListener({String? keyPath, Function(BadgeModel)? listener}) {
    if (keyPath == null || listener == null) {
      return;
    }
    _listenKeyPaths[keyPath] = listener;
    var badge = badgeForKeyPath(keyPath);
    if (badge != null) {
      listener(badge);
    }
  }

  void removeListener({String? keyPath}) {
    if (keyPath == null) {
      return;
    }
    _listenKeyPaths.remove(keyPath);
  }

  void setBadgeForKeyPath(
    String keyPath, {
    int? badgeCount,
  }) {
    List keyPaths = keyPath.split(".");
    List notifyBadges = [];
    BadgeModel parent = _root;
    for (String name in keyPaths) {
      if (name == "root") {
        continue;
      }
      BadgeModel? child;
      for (BadgeModel item in parent.childList) {
        if (item.name == name) {
          child = item;
          break;
        }
      }
      String namePath = ".$name";
      String subKeyPath = parent.keyPath + namePath;
      if (child == null) {
        child = BadgeModel(name, subKeyPath, badgeCount: 0, parent: parent);
        parent.childList.add(child);
      }
      parent = child;
      if (subKeyPath == keyPath) {
        child.badgeCount = badgeCount;
        child.needShow = true;
      }
      notifyBadges.add(child);
    }
    statusChangeForBadges(notifyBadges);
  }

  void cleanBadgeForKeyPath(
    String keyPath, {
    bool isForced = false,
  }) {
    List keyPaths = keyPath.split(".");
    List notifyBadges = [];
    BadgeModel parent = _root;
    for (String name in keyPaths) {
      if (name == "root") {
        continue;
      }
      BadgeModel? child;
      for (BadgeModel item in parent.childList) {
        if (item.name == name) {
          child = item;
          parent = child;
          break;
        }
      }
      if (child == null) {
        return;
      }
      if (name == keyPaths.last) {
        child.needShow = false;
        if (child.getBadgeCount == 0 || isForced) {
          if (child.childList.isNotEmpty && isForced) {
            List childList = child.getAllLinkChildren;
            notifyBadges.addAll(childList);
            child.cleanAllChild();
          }
          child.badgeCount = 0;
          child.removeFromParent();
        }
      }
      notifyBadges.add(child);
    }
    statusChangeForBadges(notifyBadges);
  }

  int countForKeyPath(String keyPath) {
    BadgeModel? badge = badgeForKeyPath(keyPath);
    return badge?.getBadgeCount ?? 0;
  }

  BadgeModel? badgeForKeyPath(String keyPath) {
    List keyPaths = keyPath.split(".");
    BadgeModel parent = _root;
    BadgeModel? find;
    for (String name in keyPaths) {
      if (name == "root") {
        continue;
      }
      BadgeModel? child;
      for (BadgeModel item in parent.childList) {
        if (item.name == name) {
          child = item;
          parent = child;
          break;
        }
      }
      if (child == null) {
        return null;
      }
      find = child;
    }
    return find;
  }

  void statusChangeForBadges(List badges) {
    if (badges.isEmpty) {
      return;
    }

    for (BadgeModel item in badges) {
      String path = item.keyPath;
      if (path == _rootKeyPath) {
        continue;
      }
      var handler = _listenKeyPaths[path];
      if (handler != null) {
        handler(item);
      }
    }
  }
}
