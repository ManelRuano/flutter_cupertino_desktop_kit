import 'package:flutter/cupertino.dart';
import 'package:flutter_desktop_cupertino/cx_widgets.dart';

class LayoutPickers extends StatefulWidget {
  const LayoutPickers({super.key});

  @override
  State<LayoutPickers> createState() => _LayoutPickersState();
}

class _LayoutPickersState extends State<LayoutPickers> {
  double _value = 0.1;
  double _angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const SizedBox(height: 8),
      const Padding(padding: EdgeInsets.all(8), child: Text('CXPicker360:')),
      Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: CXPicker360(
              onChanged: (angle) {
                _angle = angle;
                setState(() {});
              },
            )),
        Text(_angle.toStringAsFixed(2), style: const TextStyle(fontSize: 12)),
      ]),
      const SizedBox(height: 8),
      const Padding(padding: EdgeInsets.all(8), child: Text('CXPickerSlider:')),
      Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
                width: 100,
                child: CSPickerSlider(
                  onChanged: (value) {
                    _value = value;
                    setState(() {});
                  },
                ))),
        Text(_value.toStringAsFixed(2), style: const TextStyle(fontSize: 12)),
      ]),
      const Padding(
          padding: EdgeInsets.all(8), child: Text('CXPickerButtonsSegmented:')),
      Wrap(children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
                width: 300,
                child: CXPickerButtonsSegmented(
                  options: const [
                    Text('Car'),
                    Text('Motorbike'),
                    Icon(CupertinoIcons.airplane)
                  ],
                  defaultIndex: 1,
                  onSelect: (int index) {
                    // ignore: avoid_print
                    print("Segmented: $index");
                  },
                ))),
        Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
                width: 250,
                child: CXPickerButtonsSegmented(
                  options: const [
                    Icon(CupertinoIcons.ant),
                    Text('Flower'),
                    Text('Grass'),
                    Text('Bush')
                  ],
                  isAccent: true,
                  defaultIndex: 1,
                  onSelect: (int index) {
                    // ignore: avoid_print
                    print("Segmented: $index");
                  },
                ))),
      ]),
      const Padding(
          padding: EdgeInsets.all(8), child: Text('CXPickerButtonsBar:')),
      Wrap(children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
                width: 300,
                child: CXPickerButtonsBar(
                  options: const [
                    {
                      "widget": Icon(CupertinoIcons.text_alignleft),
                      "value": true
                    },
                    {
                      "widget": Icon(CupertinoIcons.text_aligncenter),
                      "value": false
                    },
                    {
                      "widget": Icon(CupertinoIcons.text_alignright),
                      "value": false
                    },
                    {"widget": Text("Justify"), "value": false}
                  ],
                  onChanged: (List<bool> options) {
                    // ignore: avoid_print
                    print("Segmented: $options");
                  },
                ))),
        Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
                width: 250,
                child: CXPickerButtonsBar(
                  options: const [
                    {"widget": Icon(CupertinoIcons.bold), "value": false},
                    {"widget": Icon(CupertinoIcons.italic), "value": false},
                    {"widget": Icon(CupertinoIcons.underline), "value": true},
                    {
                      "widget": Icon(CupertinoIcons.strikethrough),
                      "value": false
                    }
                  ],
                  allowsMultipleSelection: true,
                  onChanged: (List<bool> options) {
                    // ignore: avoid_print
                    print("Segmented: $options");
                  },
                ))),
      ]),
      const Padding(
          padding: EdgeInsets.all(8), child: Text('CXPickerCheckList:')),
      Wrap(children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: CXPickerCheckList(
              options: const ['Car', 'Motorbike', 'Plane'],
              defaultIndex: 2,
              onSelect: (int index, String value) {
                // ignore: avoid_print
                print("Checkmark: $index $value");
                setState(() {});
              },
            )),
      ]),
      const SizedBox(height: 50),
    ]);
  }
}
