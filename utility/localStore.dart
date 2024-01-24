import 'package:courier_app/main.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/model/parcelModel/deliveySpeed.dart';

import 'package:courier_app/model/parcelModel/parcelType.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';

class LocalStore {
  /// The Store of this app.
  late final Store store;
  late final Box<districtModel> districtData;
  late final Box<upazillaModel> upazillaData;
  late final Box<parcelTypeModel> parcelTypeData;
  late final Box<deliverySpeedModel> deliveryspeed;

  LocalStore._create(this.store) {
    districtData = Box<districtModel>(store);
    upazillaData = Box<upazillaModel>(store);
    parcelTypeData = Box<parcelTypeModel>(store);
    deliveryspeed = Box<deliverySpeedModel>(store);
  }
// District Operation
  void setDistrict(districtModel data) => districtData.put(data);

  List<districtModel> get getDistrict => districtData.getAll();
  void deleteDistrict() => districtData.removeAll();

// Upazilla Operation
  void setUpazilla(upazillaModel data) => upazillaData.put(data);
  void deleteUpazilla() => upazillaData.removeAll();
  List<upazillaModel> get getsUpazilla => upazillaData.getAll();

  Stream<List<upazillaModel>> getUpazilla(int id) => upazillaData
      .query(upazillaModel_.districtId.equals(id))
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  void setparcelType(parcelTypeModel data) => parcelTypeData.put(data);
  List<parcelTypeModel> get getparcelType => parcelTypeData.getAll();
  void deleteparcelType() => parcelTypeData.removeAll();

  void setDeliverySpeed(deliverySpeedModel data) => deliveryspeed.put(data);
  List<deliverySpeedModel> get getDeliverySpeed => deliveryspeed.getAll();
  void deleteDeliverySpeed() => deliveryspeed.removeAll();

  static Future<LocalStore> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store =
        await openStore(directory: p.join(docsDir.path, "CourierApp"));

    return LocalStore._create(store);
  }
}

class SystemInfo {
  static void setUid(int uid) => prefs.setInt('uid', uid);
  static void removeUID() => prefs.remove('uid');
  static int? get getUid => prefs.getInt('uid');

  static String? get getToken => prefs.getString("token");
  static void setToken(String data) => prefs.setString("token", data);
  static void removeToken() => prefs.remove("token");

  static String? get geDBName => prefs.getString("db");
  static void setDBName(String data) => prefs.setString("db", data);
  static void removeDBName() => prefs.remove("db");

  // static void setDistrict(List<districtUpazilla> data) =>
  //     loaclStore.put("district", data);
  // static List<districtUpazilla> get getDistrict => loaclStore.get("district");

  // static void setUpazilla(List<districtUpazilla> data) =>
  //     loaclStore.put("upazilla", data);
  // static List<districtUpazilla> get getUpazilla => loaclStore.get("upazilla");

  // static void setParcelType(List<parcelType> data) =>
  //     loaclStore.put("Parceltype", data);
  // static List<parcelType> get getParcelType => loaclStore.get("Parceltype");
}
