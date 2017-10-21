// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';
import 'package:stack_trace_codec/stack_trace_codec.dart';
import 'package:test/test.dart';

void main() {
  final codec = const JsonTraceCodec();
  final input = Uri.parse('file://package/file.dart');

  test('should encode a stack trace', () {
    expect(
      codec.encode(
        new Trace([
          new Frame(input, 0, 5, 'memberA'),
          new Frame(input, 1, 8, 'memberB'),
        ]),
      ),
      [
        {'uri': '$input', 'line': 0, 'column': 5, 'member': 'memberA'},
        {'uri': '$input', 'line': 1, 'column': 8, 'member': 'memberB'},
      ],
    );
  });

  test('should decode a stack trace', () {
    expect(
      codec.decode([
        {'uri': '$input', 'line': 0, 'column': 5, 'member': 'memberA'},
        {'uri': '$input', 'line': 1, 'column': 8, 'member': 'memberB'},
      ]).toString(),
      new Trace([
        new Frame(input, 0, 5, 'memberA'),
        new Frame(input, 1, 8, 'memberB'),
      ]).toString(),
    );
  });

  test('should encode/decode an asynchronous stack trace (chain)', () async {
    final trace = new Completer<Trace>();
    await Chain.capture(() {
      scheduleMicrotask(() {
        Timer.run(() {
          // ignore: only_throw_errors
          throw 'BAD';
        });
      });
    }, onError: (Object _, s) {
      trace.complete(s.terse.toTrace());
    });
    final encoded = codec.encode(await trace.future);
    expect(encoded.toString(), contains('main'));
  });
}
