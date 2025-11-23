// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/widgets/helpers.dart';

class InputSubmitNode extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final UiNode node;
  final void Function(BuildContext, String, String) onChange;
  final void Function(BuildContext, UiNodeGroupEnum, String, String) onSubmit;

  const InputSubmitNode(
      {super.key,
      required this.formKey,
      required this.node,
      required this.onChange,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final attributes = asInputAttributes(node);
    final value = getInputNodeValue(attributes);
    final provider = _getProviderName(value);
    return SizedBox(
      width: double.infinity,
      child: node.group == UiNodeGroupEnum.oidc
          ? OutlinedButton.icon(
              icon: Image.asset(
                  'assets/images/flows-auth-buttons-social-$provider.png'),
              label: Text(node.meta.label?.text ?? ''),
              onPressed: () => onPressed(context),
            )
          : FilledButton(
              // validate input fields that belong to this buttons group
              onPressed: () => onPressed(context),
              child: Text(node.meta.label?.text ?? ''),
            ),
    );
  }

  _getProviderName(String? value) {
    if (value == null) {
      return '';
    } else if (value.contains('google')) {
      return 'google';
    } else if (value.contains('apple')) {
      return 'apple';
    } else {
      return '';
    }
  }

  onPressed(BuildContext context) {
    final attributes = asInputAttributes(node);

    // if attribute is method, validate the form
    if ((attributes.name == 'method' && formKey.currentState!.validate()) ||
        attributes.name != 'method') {
      final type = attributes.type;
      // if attribute type is a button with value 'false', set its value to true on submit
      if (type == UiNodeInputAttributesTypeEnum.button ||
          type == UiNodeInputAttributesTypeEnum.submit &&
              attributes.value?.value == 'false') {
        final nodeName = attributes.name;

        onChange(context, 'true', nodeName);
      }
      onSubmit(context, node.group, attributes.name,
          attributes.value!.isString ? attributes.value!.asString : '');
    }
  }
}
