// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// VMOptions=--verbose_debug

// Test checks to make sure we don't encounter any unhandled exceptions
// in the URL lookup code.
// (please see https://github.com/dart-lang/sdk/issues/53334 for more details).

import 'dart:developer';
import 'dart:io';

import 'package:expect/expect.dart';

import 'common/service_test_common.dart';
import 'common/test_helper.dart';

// AUTOGENERATED START
//
// Update these constants by running:
//
// dart runtime/observatory/tests/service/update_line_numbers.dart <test.dart>
//
const int LINE_0 = 46;
// AUTOGENERATED END
const String file = "break_on_unhandled_exception_test.dart";

Future<int> testFunction() async {
  try {
    var client = new HttpClient();
    final urlstr = 'https://www.bbc.co.uk/';
    final uri = Uri.parse(urlstr);
    var response = await client.getUrl(uri);
    Expect.equals(urlstr, response.uri.toString());
    return 0;
  } catch (e) {
    print(e.toString());
    return 1;
  }
}

void testMain() async {
  debugger();
  final ret = await testFunction();
  Expect.equals(ret, 0);
  print("Done"); // LINE_0
}

final tests = <IsolateTest>[
  hasStoppedAtBreakpoint,

  // Add breakpoint
  setBreakpointAtUriAndLine(file, LINE_0),

  resumeIsolate,

  hasStoppedAtBreakpoint,
  stoppedAtLine(LINE_0),
  resumeIsolate,
];

void main(args) => runIsolateTests(
      args,
      tests,
      'break_on_unhandled_exception_test.dart',
      pause_on_unhandled_exceptions: true,
      testeeConcurrent: testMain,
    );
