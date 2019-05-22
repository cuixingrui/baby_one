import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //屏幕适配
import 'dart:io'; //获取设备信息
import 'package:baby_one/util/HttpUtil.dart';
//import 'package:device_info/device_info.dart'; //获取设备信息
import 'package:fluttertoast/fluttertoast.dart'; //提示框
import 'package:baby_one/util/publicAll.dart';
import 'package:baby_one/View/BottomNavigation/BottomNav.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _username = "";//用户名
  String _userpassword = "";//密码
  bool obscureTextYN = true; //密码显示隐藏
  bool checkRegisterLimitYN = true;//是否可以注册

  @override
  void initState() {//初始化执行
    super.initState();

  }
  @override
  void dispose() {//结束
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,//屏幕的宽度
                height: MediaQuery.of(context).size.height/2,
                child: Image.asset(
                  'images/dl.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
                child: _userName(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
                child: _userPassword(),
              ),
              //登录按钮、注册按钮
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
                child: _signInUserButtom(),
              ),
              //联系方式
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
                child: _signInTell(),
              ),

            ],
          )
      ),
    );
  }


  //用户名
  Widget _userName(){
    return TextFormField(
      onSaved: (String value) => _username = value,
      validator: (String value ){
        if(value.isEmpty){
          return '请输入姓名';
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          Icons.person,
        ),
        hintText: '请输入姓名',
      ),
    );
  }
  //密码
  Widget _userPassword(){
    return TextFormField(
      onSaved: (String value) => _userpassword = value,
      obscureText: obscureTextYN,
      validator: (String value ){
        if(value.isEmpty){
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          Icons.lock,
        ),
        hintText: '请输入密码',
        suffixIcon: IconButton(//查看密码
          icon: obscureTextYN?Icon(Icons.visibility)
              :Icon(Icons.visibility_off),
          onPressed: (){
            setState(() {
              obscureTextYN = !obscureTextYN;
            });
          },
        )
      ),
    );
  }
  //按钮
  Widget _signInUserButtom(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,//沿主轴放置在柔性布局中。
      mainAxisSize: MainAxisSize.max,//主轴应占用多少空间。
      children: <Widget>[
        //登录
        Container(
          width: MediaQuery.of(context).size.width / 3,
          child: RaisedButton(
              onPressed: (){
                _checkLogin(context);
              },
            color: Color.fromRGBO(36, 141, 248, 1),
            child: Text("登录",style: TextStyle(fontSize: 18.0),),
            shape: RoundedRectangleBorder(//角半径
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            // 该按钮上的文字颜色，但是前提是不设置字体自身的颜色时才会起作用
            textColor: Colors.white,
            // 点击按钮时的渐变背景色，当你不设置高亮背景时才会看的更清楚
            splashColor: Colors.blue,
            // 正常情况下浮动的距离
            elevation: 10.0,
            // 高亮时的浮动距离（可以尝试将该值设置的比elevation小，看看体验）
            highlightElevation: 5.0,
            disabledElevation: 50.0,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 7,
          //height: ScreenUtil().setHeight(200),
          child: Text(''),
        ),
        //注册
        Container(
          width: MediaQuery.of(context).size.width / 3,
          //height: ScreenUtil().setHeight(200),
          child: RaisedButton(
            onPressed: () {
              //_registerYN(context); //点击事件
            },
            color:checkRegisterLimitYN?Color.fromRGBO(36, 141, 248, 1):Color.fromRGBO(204, 204, 204, 1),
            child: new Text(
              '注册',
              style: TextStyle(fontSize: 18.0),
            ),
            //（RaisedButton）角半径
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            // 该按钮上的文字颜色，但是前提是不设置字体自身的颜色时才会起作用
            textColor: Colors.white,
            // 点击按钮时的渐变背景色，当你不设置高亮背景时才会看的更清楚
            splashColor: Colors.black12,
            // 正常情况下浮动的距离
            elevation: 10.0,
            // 高亮时的浮动距离（可以尝试将该值设置的比elevation小，看看体验）
            highlightElevation: 5.0,
            disabledElevation: 50.0,
            //padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          ),
        ),
      ],
    );
  }
  //联系方式
  //电话
  Widget _signInTell() {
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: ScreenUtil().setHeight(200),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '联系电话：135******12',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//登录
  _checkLogin(context) async{
    //根据输入框内容存值
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
    }
    //防止空内容往后执行
    if(_username == '' || _userpassword ==''){
      return false;
    }
    //由于该项目需要获取设备的唯一标识，所以在使用获取设备信息插件
    String deviceInfoId; //变量：设备唯一标识
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin(); //获取设备信息
    if(Platform.isIOS){
      //ios相关代码
    }else if(Platform.isAndroid){
      //android相关代码
    }
    //网络请求
    String url = basrUrl + "/mobile/mobileLogin/checkLogin";
    //如果需要参数在此处写
    var data = {
      'name': _username,
      'pw': _userpassword,
      /*'random': encrypTion[0],
      'code': encrypTion[1],
      'mac': deviceInfoId,*/
    };
    //await 关键字则表明这是阻塞调用
    var response = await HttpUtil().get(url, data: data);
    if(response['success']){
      //本地存储数据
      publicAll().StoredValue('setString', 'name',_username); //账号
      publicAll().StoredValue('setString', 'pw',_userpassword); //密码
      publicAll().StoredValue('setString', 'access_token',response['data']['access_token']); //token
      publicAll().StoredValue('setString', 'user_realname',response['data']['user_realname']); //真实姓名
      //如果成功则跳页
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => new MyAppNav()),
              (route) => route == null);
    }else{
      Fluttertoast.showToast(
          msg: '账号或密码错误!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          fontSize: 16.0);
    }
  }
}