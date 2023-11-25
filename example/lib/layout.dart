import 'package:flutter/cupertino.dart';
import 'package:flutter_desktop_cupertino/cx_widgets.dart';
import 'layout_sidebar_left.dart';
import 'layout_sidebar_right.dart';
import 'layout_buttons.dart';
import 'layout_dialogs.dart';
import 'layout_fields.dart';
import 'layout_pickers.dart';
import 'layout_progress.dart';
import 'layout_introduction.dart';
import 'layout_utils.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => LayoutState();
}

class LayoutState extends State<Layout> {
  bool isSidebarLeftVisible = true;
  GlobalKey<CXAppSidebarsState> keyAppStructure = GlobalKey();
  String _section = "Introduction";
  List<String> options = [
    "Introduction",
    "Buttons",
    "Progress",
    "Fields",
    "Pickers",
    "Dialogs",
    "Utils",
  ];

  void toggleLeftSidebar() {
    final CXAppSidebarsState? state = keyAppStructure.currentState;
    if (state != null) {
      state.setSidebarLeftVisibility(!state.isSidebarLeftVisible);
    }
  }

  void toggleRightSidebar() {
    final CXAppSidebarsState? state = keyAppStructure.currentState;
    if (state != null) {
      state.setSidebarRightVisibility(!state.isSidebarRightVisible);
    }
  }

  void _changeSection(int index, String name) {
    setState(() {
      _section = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    CXTheme theme = CXThemeNotifier.of(context)!.changeNotifier;

    Widget centralWidget;
    switch (_section) {
      case "Introduction":
        centralWidget = const LayoutIntroduction();
        break;
      case "Buttons":
        centralWidget = const LayoutButtons();
        break;
      case "Progress":
        centralWidget = const LayoutProgress();
        break;
      case "Fields":
        centralWidget = const LayoutFields();
        break;
      case "Pickers":
        centralWidget = const LayoutPickers();
        break;
      case "Dialogs":
        centralWidget = const LayoutDialogs();
        break;
      case "Utils":
        centralWidget = const LayoutUtils();
        break;
      default:
        centralWidget = Container(); // Un contenidor buit com a cas per defecte
    }

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: theme.backgroundSecondary0.withOpacity(0.5),
          middle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CXButtonIcon(
                    icon: CupertinoIcons.sidebar_left,
                    onPressed: () {
                      toggleLeftSidebar();
                    }),
                Text(_section),
                CXButtonIcon(
                    icon: CupertinoIcons.sidebar_left,
                    onPressed: () {
                      toggleRightSidebar();
                    }),
              ]),
        ),
        child: CXAppSidebars(
          key: keyAppStructure,
          sidebarLeftIsResizable: true,
          sidebarLeftDefaultsVisible: true,
          sidebarRightDefaultsVisible: false,
          sidebarLeft:
              LayoutSidebarLeft(options: options, onSelect: _changeSection),
          sidebarRight: const LayoutSidebarRight(),
          central: centralWidget,
        ));
  }
}
