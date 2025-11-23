// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:built_value/json_object.dart';
import 'package:deep_collection/deep_collection.dart';
import 'package:one_of/one_of.dart';
import 'package:ory_client/ory_client.dart';
import 'package:collection/collection.dart';

import '../services/auth.dart';

class SettingsRepository {
  final AuthService service;

  SettingsRepository({required this.service});

  Future<SettingsFlow> createSettingsFlow() async {
    final settingsFlow = await service.createSettingsFlow();
    return resetButtonValues(settingsFlow: settingsFlow);
  }

  Future<SettingsFlow> getSettingsFlow({required String flowId}) async {
    final settingsFlow = await service.getSettingsFlow(flowId: flowId);
    return resetButtonValues(settingsFlow: settingsFlow);
  }

  SettingsFlow resetButtonValues({required SettingsFlow settingsFlow}) {
    final submitInputNodes = settingsFlow.ui.nodes.where((p0) {
      if (p0.attributes.oneOf.isType(UiNodeInputAttributes)) {
        final attributes = p0.attributes.oneOf.value as UiNodeInputAttributes;
        final type = attributes.type;

        if ((type == UiNodeInputAttributesTypeEnum.button ||
                type == UiNodeInputAttributesTypeEnum.submit) &&
            attributes.value?.asString == 'true') {
          return true;
        }
      }
      return false;
    });
    for (var node in submitInputNodes) {
      final attributes = node.attributes.oneOf.value as UiNodeInputAttributes;
      // reset button value to false
      // to prevent submitting values that were not selected
      settingsFlow = changeNodeValue(
          settings: settingsFlow, name: attributes.name, value: 'false');
    }
    return settingsFlow;
  }

  Future<SettingsFlow?> updateSettingsFlow(
      {required String flowId,
      required UiNodeGroupEnum group,
      required List<UiNode> nodes}) async {
    // get input nodes of the same group
    final inputNodes = nodes.where((p0) {
      if (p0.attributes.oneOf.isType(UiNodeInputAttributes)) {
        final type = (p0.attributes.oneOf.value as UiNodeInputAttributes).type;
        return p0.group == group &&
            type != UiNodeInputAttributesTypeEnum.button;
      } else {
        return false;
      }
    });

    // create maps from attribute names and their values
    final nestedMaps = inputNodes.map((e) {
      final attributes = e.attributes.oneOf.value as UiNodeInputAttributes;

      return generateNestedMap(attributes.name, attributes.value?.asString);
    }).toList();

    // merge nested maps into one
    final mergedMap =
        nestedMaps.reduce((value, element) => value.deepMerge(element));

    final updatedSettings = await service.updateSettingsFlow(
        flowId: flowId, group: group, value: mergedMap);
    return resetButtonValues(settingsFlow: updatedSettings);
  }

  SettingsFlow changeNodeValue(
      {required SettingsFlow settings,
      required String name,
      required String value}) {
    // get edited node
    final node = settings.ui.nodes.firstWhereOrNull((element) {
      if (element.attributes.oneOf.isType(UiNodeInputAttributes)) {
        return (element.attributes.oneOf.value as UiNodeInputAttributes).name ==
            name;
      } else {
        return false;
      }
    });

    // udate value of edited node
    final updatedNode = node?.rebuild((p0) => p0
      ..attributes.update((b) {
        final oldValue = b.oneOf?.value as UiNodeInputAttributes;
        final newValue = oldValue.rebuild((p0) => p0.value = JsonObject(value));
        b.oneOf = OneOf1(value: newValue);
      }));
    // get index of to be updated node
    final nodeIndex = settings.ui.nodes.indexOf(node!);
    // update list of nodes to iclude updated node
    final newList = settings.ui.nodes.rebuild((p0) => p0
      ..removeAt(nodeIndex)
      ..insert(nodeIndex, updatedNode!));
    // update settings' node
    final newSettings = settings.rebuild((p0) => p0..ui.nodes.replace(newList));
    return newSettings;
  }

  /// Generate nested map from  [path] with [value]
  Map<dynamic, dynamic> generateNestedMap(String path, String? value) {
    var steps = path.split('.');
    Object? result = value;
    for (var step in steps.reversed) {
      // if value is null, set to an empty string
      result = {step: result ?? ''};
    }
    return result as Map<dynamic, dynamic>;
  }
}
