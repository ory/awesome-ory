// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ory_client/ory_client.dart';

import '../blocs/auth/auth_bloc.dart';
import 'nodes/image.dart';
import 'nodes/input.dart';
import 'nodes/input_submit.dart';
import 'nodes/text.dart';

/// Returns color of a message depending on its [type]
getMessageColor(UiTextTypeEnum type) {
  switch (type) {
    case UiTextTypeEnum.success:
      return Colors.green;
    case UiTextTypeEnum.error:
      return Colors.red;
    case UiTextTypeEnum.info:
      return Colors.grey;
  }
}

/// Returns error widget with corresponding [message]
buildFlowNotCreated(BuildContext context, String? message) {
  if (message != null) {
    return Center(
        child: Text(
      message,
      style: const TextStyle(color: Colors.red),
    ));
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}

/// Returns a form for a specific [group] containing multiple [nodes].
/// Node changes and submits are handled by
/// [onInputChange] and [onInputSubmit], respectively
buildGroup<T extends Bloc>(
    BuildContext context,
    UiNodeGroupEnum group,
    List<UiNode> nodes,
    void Function(BuildContext, String, String) onInputChange,
    void Function(BuildContext, UiNodeGroupEnum, String, String)
        onInputSubmit) {
  final formKey = GlobalKey<FormState>();
  return Padding(
    padding: const EdgeInsets.only(bottom: 0),
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 0),
              shrinkWrap: true,
              itemBuilder: ((BuildContext context, index) {
                final attributes = nodes[index].attributes.oneOf;
                if (attributes.isType(UiNodeInputAttributes)) {
                  return buildInputNode<T>(context, formKey, nodes[index],
                      onInputChange, onInputSubmit);
                } else if (attributes.isType(UiNodeTextAttributes)) {
                  return TextNode(node: nodes[index]);
                } else if (attributes.isType(UiNodeImageAttributes)) {
                  return ImageNode(node: nodes[index]);
                } else {
                  return Container();
                }
              }),
              itemCount: nodes.length),
        ],
      ),
    ),
  );
}

/// Returns input node for [node] from a form associated with [formKey].
/// Node changes and submits are handled by
/// [onInputChange] and [onInputSubmit], respectively.
buildInputNode<T extends Bloc>(
    BuildContext context,
    GlobalKey<FormState> formKey,
    UiNode node,
    void Function(BuildContext, String, String) onInputChange,
    void Function(BuildContext, UiNodeGroupEnum, String, String)
        onInputSubmit) {
  final attributes = asInputAttributes(node);
  switch (attributes.type) {
    case UiNodeInputAttributesTypeEnum.submit:
      return InputSubmitNode(
          node: node,
          formKey: formKey,
          onChange: onInputChange,
          onSubmit: onInputSubmit);
    case UiNodeInputAttributesTypeEnum.button:
      return InputSubmitNode(
          node: node,
          formKey: formKey,
          onChange: onInputChange,
          onSubmit: onInputSubmit);
    default:
      return InputNode<T>(node: node, onChange: onInputChange);
  }
}

/// Returns nodes with a type of [group] from all available [nodes]
List<UiNode> getNodesOfGroup(UiNodeGroupEnum group, BuiltList<UiNode> nodes) {
  return nodes.where((node) {
    if (node.group == group) {
      if (group == UiNodeGroupEnum.oidc) {
        if (isInputNode(node)) {
          final attributes = asInputAttributes(node);
          return Platform.isAndroid
              ? !getInputNodeValue(attributes).contains('ios')
              : getInputNodeValue(attributes).contains('ios');
        }
      } else {
        if (isInputNode(node)) {
          final attributes = asInputAttributes(node);
          if (attributes.type == UiNodeInputAttributesTypeEnum.hidden) {
            return false;
          } else {
            return true;
          }
        } else {
          return true;
        }
      }
    }
    return false;
  }).toList();
}

/// Returns true if [node] is of type UiNodeInputAttributes.
/// Otherwise, returns false
bool isInputNode(UiNode node) {
  return node.attributes.oneOf.isType(UiNodeInputAttributes);
}

/// Returns string value of [attributes]
String getInputNodeValue(UiNodeInputAttributes attributes) {
  return attributes.value?.asString ?? '';
}

/// Returns input attributes of a [node].
/// Attributes must be of type UiNodeInputAttributes
UiNodeInputAttributes asInputAttributes(UiNode node) {
  if (isInputNode(node)) {
    return node.attributes.oneOf.value as UiNodeInputAttributes;
  } else {
    throw ArgumentError(
        'attributes of this node are not of type UiNodeInputAttributes');
  }
}

bool isSessionRefreshRequired(List<Condition> conditions) {
  final sessionRefreshCondition = conditions
      .firstWhereOrNull((element) => element is SessionRefreshRequested);
  return sessionRefreshCondition != null;
}

bool isRecoveryRequired(List<Condition> conditions) {
  final recoveryCondition =
      conditions.firstWhereOrNull((element) => element is RecoveryRequested);
  return recoveryCondition != null;
}
