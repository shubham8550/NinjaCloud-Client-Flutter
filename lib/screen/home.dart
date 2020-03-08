// Flutter code sample for Scaffold

// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold]. The [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/scaffold_bottom_app_bar.png)

import 'package:flutter/material.dart';
import 'package:ninjacloud/src/Manager.dart';



class home_page extends StatefulWidget {
  home_page({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<home_page> {
  int _count = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ninja Cloud'),
      ),
      body: file_list(_count),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _count++;
        }),
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget file_list(int _count){
   // return Text('You have pressed the button $_count times.');
    return listbody();
  }






}









class listbody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BodyLayoutState();
  }
  
}






 class BodyLayoutState extends State<listbody> {

      // The GlobalKey keeps track of the visible state of the list items
      // while they are being animated.
      final GlobalKey<AnimatedListState> _listKey = GlobalKey();

      // backing data
      List<String> _data = ['Sun', 'Moon', 'Star'];
            
      final icons = [Icons.directions_bike, Icons.directions_boat,
        Icons.directions_bus, Icons.directions_car, Icons.directions_railway,
        Icons.directions_run, Icons.directions_subway, Icons.directions_transit,
        Icons.directions_walk];

      @override
      Widget build(BuildContext context) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: AnimatedList(
                // Give the Animated list the global key
                key: _listKey,
                initialItemCount: _data.length,
                // Similar to ListView itemBuilder, but AnimatedList has
                // an additional animation parameter.
                itemBuilder: (context, index, animation) {
                  // Breaking the row widget out as a method so that we can
                  // share it with the _removeSingleItem() method.
                  return _buildItem(_data[index], animation,index);
                },
              ),
            ),
            RaisedButton(
              child: Text('Insert item', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _insertSingleItem();
              },
            ),
            RaisedButton(
              child: Text('Remove item', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _removeSingleItem();
              },
            )
          ],
        );
      }

      // This is the animated row with the Card.
      Widget _buildItem(String item, Animation animation,int index) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            child: ListTile(
              trailing: menu_items(index),
              leading: Icon(icons[index]),
              title: Text(
                item,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      }

     Widget menu_items(int index){
        return PopupMenuButton<int>(
          onSelected: (val){
              toast('button ${val} selected of number ${index}');
          },
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Download"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Share"),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text("Delete"),
                ),
              ],
        );
      }
      void _insertSingleItem() {
        String newItem = "Planet";
        // Arbitrary location for demonstration purposes
        int insertIndex = 2;
        // Add the item to the data list.
        _data.insert(insertIndex, newItem);
        // Add the item visually to the AnimatedList.
        _listKey.currentState.insertItem(insertIndex);
      }

      void _removeSingleItem() {
        int removeIndex = 2;
        // Remove item from data list but keep copy to give to the animation.
        String removedItem = _data.removeAt(removeIndex);
        // This builder is just for showing the row while it is still
        // animating away. The item is already gone from the data list.
        AnimatedListRemovedItemBuilder builder = (context, animation) {
          return _buildItem(removedItem, animation,removeIndex);
        };
        // Remove the item visually from the AnimatedList.
        _listKey.currentState.removeItem(removeIndex, builder);
      }
    }