// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/PickupModel/model.dart';
import 'model/parcelModel/deliveySpeed.dart';
import 'model/parcelModel/parcelType.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5555872261757048357),
      name: 'districtModel',
      lastPropertyId: const IdUid(3, 4198584793457499620),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6643547793478532241),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8688731400272430432),
            name: 'idDistrict',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4198584793457499620),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 4331466328017722865),
      name: 'upazillaModel',
      lastPropertyId: const IdUid(4, 8252040764748573893),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3329337728251150349),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3037439750394560479),
            name: 'districtId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8840143007023956458),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8252040764748573893),
            name: 'upazillaID',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 663662894027871055),
      name: 'parcelTypeModel',
      lastPropertyId: const IdUid(3, 6597041937331313954),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1144201017441049393),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 119230464402146996),
            name: 'parcelID',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6597041937331313954),
            name: 'parcelType',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 5028831164552940882),
      name: 'deliverySpeedModel',
      lastPropertyId: const IdUid(3, 2572108945735617410),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 679129927270688373),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8254647830386428814),
            name: 'idspeed',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2572108945735617410),
            name: 'label',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 5028831164552940882),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [258803367532184255],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        3775897267175351761,
        524324501119972050,
        6241221855386852520
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    districtModel: EntityDefinition<districtModel>(
        model: _entities[0],
        toOneRelations: (districtModel object) => [],
        toManyRelations: (districtModel object) => {},
        getId: (districtModel object) => object.id,
        setId: (districtModel object, int id) {
          object.id = id;
        },
        objectToFB: (districtModel object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.idDistrict);
          fbb.addOffset(2, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = districtModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              idDistrict: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        }),
    upazillaModel: EntityDefinition<upazillaModel>(
        model: _entities[1],
        toOneRelations: (upazillaModel object) => [],
        toManyRelations: (upazillaModel object) => {},
        getId: (upazillaModel object) => object.id,
        setId: (upazillaModel object, int id) {
          object.id = id;
        },
        objectToFB: (upazillaModel object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.districtId);
          fbb.addOffset(2, nameOffset);
          fbb.addInt64(3, object.upazillaID);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = upazillaModel(
              upazillaID: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              districtId: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        }),
    parcelTypeModel: EntityDefinition<parcelTypeModel>(
        model: _entities[2],
        toOneRelations: (parcelTypeModel object) => [],
        toManyRelations: (parcelTypeModel object) => {},
        getId: (parcelTypeModel object) => object.id,
        setId: (parcelTypeModel object, int id) {
          object.id = id;
        },
        objectToFB: (parcelTypeModel object, fb.Builder fbb) {
          final parcelTypeOffset = object.parcelType == null
              ? null
              : fbb.writeString(object.parcelType!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.parcelID);
          fbb.addOffset(2, parcelTypeOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = parcelTypeModel(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              parcelID: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              parcelType: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        }),
    deliverySpeedModel: EntityDefinition<deliverySpeedModel>(
        model: _entities[3],
        toOneRelations: (deliverySpeedModel object) => [],
        toManyRelations: (deliverySpeedModel object) => {},
        getId: (deliverySpeedModel object) => object.id,
        setId: (deliverySpeedModel object, int id) {
          object.id = id;
        },
        objectToFB: (deliverySpeedModel object, fb.Builder fbb) {
          final labelOffset =
              object.label == null ? null : fbb.writeString(object.label!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.idspeed);
          fbb.addOffset(2, labelOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = deliverySpeedModel(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              idspeed: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              label: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [districtModel] entity fields to define ObjectBox queries.
class districtModel_ {
  /// see [districtModel.id]
  static final id =
      QueryIntegerProperty<districtModel>(_entities[0].properties[0]);

  /// see [districtModel.idDistrict]
  static final idDistrict =
      QueryIntegerProperty<districtModel>(_entities[0].properties[1]);

  /// see [districtModel.name]
  static final name =
      QueryStringProperty<districtModel>(_entities[0].properties[2]);
}

/// [upazillaModel] entity fields to define ObjectBox queries.
class upazillaModel_ {
  /// see [upazillaModel.id]
  static final id =
      QueryIntegerProperty<upazillaModel>(_entities[1].properties[0]);

  /// see [upazillaModel.districtId]
  static final districtId =
      QueryIntegerProperty<upazillaModel>(_entities[1].properties[1]);

  /// see [upazillaModel.name]
  static final name =
      QueryStringProperty<upazillaModel>(_entities[1].properties[2]);

  /// see [upazillaModel.upazillaID]
  static final upazillaID =
      QueryIntegerProperty<upazillaModel>(_entities[1].properties[3]);
}

/// [parcelTypeModel] entity fields to define ObjectBox queries.
class parcelTypeModel_ {
  /// see [parcelTypeModel.id]
  static final id =
      QueryIntegerProperty<parcelTypeModel>(_entities[2].properties[0]);

  /// see [parcelTypeModel.parcelID]
  static final parcelID =
      QueryIntegerProperty<parcelTypeModel>(_entities[2].properties[1]);

  /// see [parcelTypeModel.parcelType]
  static final parcelType =
      QueryStringProperty<parcelTypeModel>(_entities[2].properties[2]);
}

/// [deliverySpeedModel] entity fields to define ObjectBox queries.
class deliverySpeedModel_ {
  /// see [deliverySpeedModel.id]
  static final id =
      QueryIntegerProperty<deliverySpeedModel>(_entities[3].properties[0]);

  /// see [deliverySpeedModel.idspeed]
  static final idspeed =
      QueryIntegerProperty<deliverySpeedModel>(_entities[3].properties[1]);

  /// see [deliverySpeedModel.label]
  static final label =
      QueryStringProperty<deliverySpeedModel>(_entities[3].properties[2]);
}
