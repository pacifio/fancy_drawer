# Fancy drawer

![Fancy drawer](https://raw.githubusercontent.com/pacifio/fancy_drawer/master/media/fancy_drawer.gif "Fancy drawer")

A beautiful drawer experience for your flutter app .

## Usage

```dart
import 'package:fancy_drawer/fancy_drawer.dart';

...

FancyDrawerController _controller;

@override
void initState() {
  super.initState();
  _controller = FancyDrawerController(
      vsync: this, duration: Duration(milliseconds: 250))
    ..addListener(() {
      setState(() {}); // Must call setState
    }); // This chunk of code is important
}

@override
void dispose() {
  _controller.dispose(); // Dispose controller
  super.dispose();
}
...
FancyDrawerWrapper(
	backgroundColor: Colors.white, // Drawer background
	controller: _controller, // Drawer controller
	drawerItems: <Widget>[], // Drawer items
	child: Scaffold(), // Your app content
);
```

## Parameters

### required

`drawerItems` Drawer items are widgets needed to render<br/>
`child` child is the main app content<br/> `controller` is
needed to init and maintain the animation<br/>

### optional

`backgroundColor` Set to white background<br/> `itemGap`
set to 10.0<br/> `hideOnContentTap` controls if drawer will hide on
content tap or not , set to true<br/>`cornerRadius` set to 8.0<br/>

## TODO
- [x] Null safety
- [ ] 3D perspective
