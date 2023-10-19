import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import './storage.dart';

TextEditingController rssUrlController = TextEditingController();
TextEditingController rssNameController = TextEditingController();

class Star extends StatefulWidget {
  const Star({super.key});
  State<Star> createState() => _StarState();
}

class SPUtil {
  //创建工厂方法
  static SPUtil? _instance;
  factory SPUtil() => _instance ??= SPUtil._initial();
  SharedPreferences? _preferences;
  //创建命名构造函数
  SPUtil._initial() {
    //为什么在这里需要新写init方法 主要是在命名构造中不能使用async/await
    init();
  }
  //初始化SharedPreferences
  void init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  SPUtil._pre(SharedPreferences prefs) {
    _preferences = prefs;
  }
  //到这里还没有完 有时候会遇到使用时提示 SharedPreferences 未初始化,所以还需要提供一个static 的方法
  static Future<SPUtil?> perInit() async {
    if (_instance == null) {
      //静态方法不能访问非静态变量所以需要创建变量再通过方法赋值回去
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _instance = SPUtil._pre(preferences);
    }
    return _instance;
  }

  void setString(key, value) {
    _preferences?.setString(key, value);
  }

  ///设置setStringList类型的
  void setStringList(key, value) {
    _preferences?.setStringList(key, value);
  }

  ///设置setBool类型的
  void setBool(key, value) {
    _preferences?.setBool(key, value);
  }

  ///设置setDouble类型的
  void setDouble(key, value) {
    _preferences?.setDouble(key, value);
  }

  ///设置setInt类型的
  void setInt(key, value) {
    _preferences?.setInt(key, value);
  }

  ///通过泛型来获取数据
  T? get<T>(key) {
    var result = _preferences?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}

class _StarState extends State<Star> {
  _addFeedButton(context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("添加订阅源"),
                            content: Column(
                              children: [
                                SizedBox(
                                  child: TextField(
                                    controller: rssNameController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      hintText: '名字',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: TextField(
                                    controller: rssUrlController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      hintText: '网站的rssurl',
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(5.0)),
                                ElevatedButton(
                                  child: const Text("添加"),
                                  onPressed: () {
                                    if (rssUrlController.text.isEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("提示"),
                                              content: Text("不能为空！"),
                                            );
                                          });
                                    } else {
                                      var instance = SharedPref();
                                      instance.save(rssNameController.text,
                                          rssUrlController.text);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("提示"),
                                              content: Text("添加成功！"),
                                            );
                                          });
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ))
      ],
    );
  }

  _waitValue() async {
    var storage = SharedPref();
    List<String> values = [];
    values = await storage.readkeys();
    return values;
  }

  List<Widget> _waitName() {
    var storage = SharedPref();
    List<String> names = [];
    List<String> values = [];
    List<Widget> tiles = [];
    storage.readkeys().then((j) {
      for (String name in j) {
        String value = "";
        storage.readValue(name).then((z) => value = z);
        tiles.add(FutureBuilder(
            future: _waitValue(),
            builder: (context, snapshot) {
              return ListTile(
                title: Text(name),
                subtitle: Text(value)
                );
            }));
      }
    });
    return tiles;
  }

  _showFeedUrl(context) {}

  @override
  Widget build(BuildContext context) {
    List tiles = [];
    return Stack(children: [
      ListView(
        children:
        _waitName()
      ),
      _addFeedButton(context),
    ]);
  }
}
