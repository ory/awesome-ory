// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ory_client/ory_client.dart';

import 'nodes/input.dart';
import 'nodes/input_submit.dart';
import 'nodes/text.dart';

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
              shrinkWrap: true,
              itemBuilder: ((BuildContext context, index) {
                final attributes = nodes[index].attributes.oneOf;
                if (attributes.isType(UiNodeInputAttributes)) {
                  return buildInputNode<T>(context, formKey, nodes[index],
                      onInputChange, onInputSubmit);
                } else if (attributes.isType(UiNodeTextAttributes)) {
                  return TextNode(node: nodes[index]);
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

buildInputNode<T extends Bloc>(
    BuildContext context,
    GlobalKey<FormState> formKey,
    UiNode node,
    void Function(BuildContext, String, String) onInputChange,
    void Function(BuildContext, UiNodeGroupEnum, String, String)
        onInputSubmit) {
  final inputNode = node.attributes.oneOf.value as UiNodeInputAttributes;
  switch (inputNode.type) {
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
    case UiNodeInputAttributesTypeEnum.hidden:
      return const SizedBox.shrink();

    default:
      return InputNode<T>(node: node, onChange: onInputChange);
  }
}
