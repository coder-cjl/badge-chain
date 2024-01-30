import 'package:badge_chain/badge_chain.dart';
import 'package:badges/badges.dart';
import 'package:flutter/widgets.dart';

class BadgeCountWidget extends StatefulWidget {
  String? keyPath;
  Widget child;
  BadgePosition? position;

  BadgeCountWidget({
    Key? key,
    this.keyPath,
    this.position,
    required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BadgeCountWidgetState();
  }
}

class BadgeCountWidgetState extends State<BadgeCountWidget> {
  BadgeModel? _badge;
  String? _badgeCount;

  @override
  void initState() {
    super.initState();
    BadgeManager.instance.addListener(
      keyPath: widget.keyPath,
      listener: (BadgeModel item) {
        setState(() {
          _badge = item;
          if (item.getBadgeCount == 0) {
            _badgeCount = "";
          } else if (item.getBadgeCount > 99) {
            _badgeCount = "99+";
          } else {
            _badgeCount = item.getBadgeCount.toString();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    BadgeManager.instance.removeListener(keyPath: widget.keyPath);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: widget.position,
      showBadge: _badge?.getNeedShow ?? false,
      badgeContent: Text(_badgeCount ?? ""),
      child: widget.child,
    );
  }
}
