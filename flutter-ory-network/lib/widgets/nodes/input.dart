// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/blocs/bloc/recovery_bloc.dart';
import 'package:ory_network_flutter/blocs/login/login_bloc.dart';
import 'package:ory_network_flutter/blocs/registration/registration_bloc.dart';

import '../../blocs/settings/settings_bloc.dart';
import '../helpers.dart';

class InputNode<T extends Bloc> extends StatefulWidget {
  final UiNode node;
  final void Function(BuildContext, String, String) onChange;

  const InputNode({super.key, required this.node, required this.onChange});
  @override
  State<StatefulWidget> createState() => _InputNodeState<T>();
}

class _InputNodeState<T extends Bloc> extends State<InputNode> {
  TextEditingController textEditingController = TextEditingController();
  bool? isPasswordHidden;

  @override
  void initState() {
    super.initState();
    final attributes = asInputAttributes(widget.node);
    // if this is a password field, hide the text
    if (attributes.name == 'password') {
      setState(() {
        isPasswordHidden = true;
      });
    }
    final fieldValue = attributes.value;
    // assign node value to text controller on init
    textEditingController.text = fieldValue != null ? fieldValue.asString : '';
  }

// get text input type of a specific node
  _getTextInputType(UiNodeInputAttributesTypeEnum type) {
    switch (type) {
      case UiNodeInputAttributesTypeEnum.datetimeLocal:
        return TextInputType.datetime;
      case UiNodeInputAttributesTypeEnum.email:
        return TextInputType.emailAddress;
      case UiNodeInputAttributesTypeEnum.hidden:
        return TextInputType.none;
      case UiNodeInputAttributesTypeEnum.number:
        return TextInputType.number;
      case UiNodeInputAttributesTypeEnum.password:
        return TextInputType.text;
      case UiNodeInputAttributesTypeEnum.tel:
        return TextInputType.phone;
      case UiNodeInputAttributesTypeEnum.text:
        return TextInputType.text;
      case UiNodeInputAttributesTypeEnum.url:
        return TextInputType.url;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final attributes = asInputAttributes(widget.node);

    return BlocListener(
      bloc: (context).read<T>(),
      listener: (context, state) {
        UiNode? node;
        // find current node in updated state
        if (state is LoginState) {
          node = state.loginFlow?.ui.nodes.firstWhereOrNull((element) {
            if (isInputNode(element)) {
              return asInputAttributes(element).name == attributes.name;
            } else {
              return false;
            }
          });
        } else if (state is RegistrationState) {
          node = state.registrationFlow?.ui.nodes.firstWhereOrNull((element) {
            if (isInputNode(element)) {
              return asInputAttributes(element).name == attributes.name;
            } else {
              return false;
            }
          });
        } else if (state is SettingsState) {
          node = state.settingsFlow?.ui.nodes.firstWhereOrNull((element) {
            if (element.attributes.oneOf.isType(UiNodeInputAttributes)) {
              return (element.attributes.oneOf.value as UiNodeInputAttributes)
                      .name ==
                  attributes.name;
            } else {
              return false;
            }
          });
        } else if (state is RecoveryState) {
          node = state.recoveryFlow?.ui.nodes.firstWhereOrNull((element) {
            if (element.attributes.oneOf.isType(UiNodeInputAttributes)) {
              return (element.attributes.oneOf.value as UiNodeInputAttributes)
                      .name ==
                  attributes.name;
            } else {
              return false;
            }
          });
        }

        // assign new value of node to text controller
        if (node != null && isInputNode(node)) {
          final attributes = asInputAttributes(node);
          textEditingController.text = getInputNodeValue(attributes);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.node.meta.label?.text != null)
              Text(
                widget.node.meta.label!.text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: textEditingController,
              enabled: !attributes.disabled,
              keyboardType: _getTextInputType(attributes.type),
              onChanged: (String value) {
                widget.onChange(context, value, attributes.name);
              },
              obscureText: isPasswordHidden ?? false,
              decoration: isPasswordHidden == null
                  ? null
                  : InputDecoration(
                      suffixIcon: GestureDetector(
                      onTap: () => setState(() {
                        isPasswordHidden = !isPasswordHidden!;
                      }),
                      child: ImageIcon(isPasswordHidden!
                          ? const AssetImage('assets/icons/eye.png')
                          : const AssetImage('assets/icons/eye-off.png')),
                    )),
              validator: (value) {
                if (attributes.required_ != null) {
                  if (attributes.required_! &&
                      (value == null || value.isEmpty)) {
                    return 'Property is required';
                  }
                }
                return null;
              },
            ),
            for (var message in widget.node.messages)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(message.text,
                    style: TextStyle(color: getMessageColor(message.type))),
              ),
          ],
        ),
      ),
    );
  }
}
