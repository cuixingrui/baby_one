import 'dart:async';//（检测网络）
import 'package:flutter/services.dart';//（检测网络）
import 'package:connectivity/connectivity.dart';//（检测网络）
import 'package:fluttertoast/fluttertoast.dart';//提示框
import 'package:shared_preferences/shared_preferences.dart';//（存值）

/**
 * @Description  公用方法
 * @Author  城别
 */
class publicAll{
  /**
   * @Effect  检测网络
   */
  //定义变量（网络状态）
  String _connectionStatus = 'Unknown';
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //网络初始状态
  connectivityInitState(){
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
          print(result.toString());
          if(result.toString() == 'ConnectivityResult.none'){
            Fluttertoast.showToast(
                msg: '网络连接错误!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 2,
                fontSize: 16.0
            );
          }
        });
  }
  //网络结束监听
  connectivityDispose(){
    _connectivitySubscription.cancel();
  }
  //网络进行监听
  Future<Null> initConnectivity() async {
    String connectionStatus;
    //平台消息可能会失败，因此我们使用Try/Catch PlatformException。
    try {
      connectionStatus = (await Connectivity().checkConnectivity()).toString();

      if (connectionStatus == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
      } else if (connectionStatus == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
      }
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }
  }


  /**
   * @Effect  储值数值
   */
  StoredValue(stype,sname,scontent) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch(stype){
      case 'setString':prefs.setString(sname, scontent);
        break;
      case 'setBool':prefs.setBool(sname, scontent);
        break;
      case 'setDouble':prefs.setDouble(sname, scontent);
        break;
      case 'setInt':prefs.setInt(sname, scontent);
        break;
      case 'setStringList':prefs.setStringList(sname, scontent);
        break;
    }
  }




}