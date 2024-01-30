<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

App红点链路管理

## Features


## Getting started
share_plus: x.x.x


## Usage
### Main
```dart

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SharePage();
  }
}

class _SharePage extends State<SharePage> {
  final rootHomeKeyPath = "root.home";
  final rootMineKeyPath = "root.mine";
  final rootHomeKeyPathPage1 = "root.home.page1";
  final rootHomeKeyPathPage1Page2 = "root.home.page1.page2";
  final rootHomeKeyPathPage1Page2_1 = "root.home.page1.page2.page2-1";
  final rootHomeKeyPathPage1Page2_2 = "root.home.page1.page2.page2-2";
  final rootMineKeyPathPage1 = "root.mine.page1";

  @override
  void initState() {
    super.initState();
    
    BadgeManager.instance.setBadgeForKeyPath(rootHomeKeyPath);
    BadgeManager.instance.setBadgeForKeyPath(rootMineKeyPath);
    BadgeManager.instance.setBadgeForKeyPath(rootHomeKeyPathPage1);
    BadgeManager.instance.setBadgeForKeyPath(rootHomeKeyPathPage1Page2);
    BadgeManager.instance
        .setBadgeForKeyPath(rootHomeKeyPathPage1Page2_1, badgeCount: 2);
    BadgeManager.instance
        .setBadgeForKeyPath(rootHomeKeyPathPage1Page2_2, badgeCount: 3);
    BadgeManager.instance
        .setBadgeForKeyPath(rootMineKeyPathPage1, badgeCount: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share"),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                label: '首页',
                icon: BadgeDotWidget(
                  key: Key(rootHomeKeyPath),
                  keyPath: rootHomeKeyPath,
                  position: BadgePosition.topEnd(top: -12, end: -12),
                  child: const Icon(Icons.add),
                ),
              ),
              BottomNavigationBarItem(
                label: '我的',
                icon: BadgeCountWidget(
                  key: Key(rootMineKeyPath),
                  keyPath: rootMineKeyPath,
                  position: BadgePosition.topEnd(top: -12, end: -12),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
            currentIndex: 1,
            onTap: (index) {},
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
          ),
        ],
      ),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                /// 跳转页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Page1(),
                  ),
                );
              },
              child: const Text("自定义 view"),
            ),
            BadgeDotWidget(
              key: Key(rootMineKeyPathPage1),
              keyPath: rootMineKeyPathPage1,
              child: ElevatedButton(
                child: Text(
                  rootMineKeyPathPage1,
                ),
                onPressed: () {
                  BadgeManager.instance.cleanBadgeForKeyPath(
                    rootMineKeyPathPage1,
                    isForced: true,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

```

### Page1
```dart

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Page1();
  }
}

class _Page1 extends State<Page1> {
  @override
  void initState() {
    super.initState();
  }

  final keyPath = "root.home.page1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page1")),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BadgeCountWidget(
              key: Key(keyPath),
              keyPath: keyPath,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Page2()),
                  );
                },
                child: Text(keyPath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Page2
```dart

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Page2();
  }
}

class _Page2 extends State<Page2> {
  @override
  void initState() {
    super.initState();
  }

  final keyPath = "root.home.page1.page2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page2")),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BadgeCountWidget(
              key: Key(keyPath),
              keyPath: keyPath,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Page3()),
                  );
                },
                child: Text(keyPath),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page4()),
                );
              },
              child: const Text("root.home.first.first.second"),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Page3
```dart
class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Page3();
  }
}

class _Page3 extends State<Page3> {
  @override
  void initState() {
    super.initState();
  }

  final keyPath = "root.home.page1.page2.page2-1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page3")),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BadgeCountWidget(
              key: Key(keyPath),
              keyPath: keyPath,
              child: ElevatedButton(
                onPressed: () {
                  BadgeManager.instance.cleanBadgeForKeyPath(
                    keyPath,
                    isForced: true,
                  );
                },
                child: Text(keyPath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Page4
```dart

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Page4();
  }
}

class _Page4 extends State<Page4> {
  @override
  void initState() {
    super.initState();
  }

  final keyPath = "root.home.page1.page2.page2-2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page3")),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BadgeCountWidget(
              key: Key(keyPath),
              keyPath: keyPath,
              child: ElevatedButton(
                onPressed: () {
                  BadgeManager.instance.cleanBadgeForKeyPath(
                    keyPath,
                    isForced: true,
                  );
                },
                child: Text(keyPath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

## Additional information
None
