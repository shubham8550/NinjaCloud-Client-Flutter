// Flutter code sample for Scaffold

// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold]. The [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/scaffold_bottom_app_bar.png)

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:ninjacloud/filesdatamap.dart';
import 'package:ninjacloud/resources/R.dart';
import 'package:ninjacloud/src/Manager.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
class home_page extends StatefulWidget {
  home_page({Key key}) : super(key: key);
           




  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<home_page> {
  int _count = 0;




  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    
    if(mounted)
    setState(() {
         getfiles(R.username);
    });
    _refreshController.loadComplete();
  }




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ninja Cloud'), 
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: file_list(_count),
        ),
      //----body end
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()  {
          _file_picker();
         
          // setState(() {
            
          // });
        },
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  _file_picker() async {
     File file = await FilePicker.getFile();
     print(path.dirname(file.path));
        print((file.path));
     

    final uploader = FlutterUploader();

    final taskId = await uploader.enqueue(
        url: "http://dev.moryasolarz.com/ninja/upload.php", //required: url to upload to
        files: [FileItem(filename:  path.basename(file.path), savedDir: path.dirname(file.path), fieldname:"uploadFile")], // required: list of files that you want to upload
        method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
        headers: {"apikey": "api_123456", "userkey": "userkey_123456","u": R.username},
        data: {"u": R.username}, // any data you want to send in upload request
        showNotification: true, // send local notification (android only) for upload status
        tag: "uploading ${path.basename(file.path)}"); // unique tag for upload task
      int i=0;
      final subscription = uploader.progress.listen((progress)  {
            print(progress.progress);
            if(progress.progress==100 && i==0){
            
              
              i++;
                

            }
            }
          
      );
  print("Uploader stopped");
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
                initialItemCount: R.totalfiles,
                // Similar to ListView itemBuilder, but AnimatedList has
                // an additional animation parameter.
                itemBuilder: (context, index, animation) {
                  // Breaking the row widget out as a method so that we can
                  // share it with the _removeSingleItem() method.
                  return _buildItem((allFiles[index]).filename, animation,index);
                },
              ),
            ),
            // RaisedButton(
            //   child: Text('Insert item', style: TextStyle(fontSize: 20)),
            //   onPressed: () {
            //     _insertSingleItem();
            //   },
            // ),
            // RaisedButton(
            //   child: Text('Remove item', style: TextStyle(fontSize: 20)),
            //   onPressed: () {
            //     _removeSingleItem();
            //   },
            // )
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
          onSelected: (val) async {
              toast('button ${val} selected of number ${index}');
              if(val==1){
                _launchURL(index);
                              
              }else if(val==2){
                Share.share('Hey ${R.username} shared you File -: ${allFiles[index].filename} . and here\'s your Download Link : ${allFiles[index].url}', subject: 'Shared file from ${R.username}');
                
              }else if(val==3){
                final response = await http.get(R.SERVERURL+'deletefile.php?id=${allFiles[index].id}');
                if(response.body=="Record deleted successfully"){
                toast(allFiles[index].filename+" is Deleted Succesfully");

                 _removeSingleItem(index);

                setState(() {
                  getfiles(R.username);
                });
                }else{
                  toast(response.body);

                }
              }
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


_launchURL(int index) async {
  String url = allFiles[index].url;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    toast('Could not launch $url');
  }
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

      void _removeSingleItem(int ida) {
        int removeIndex = ida;
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