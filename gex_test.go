/*
Copyright 2016 Jamie Moore

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

package main

import (
	"os"
	"testing"
)

func TestGetGexEnv(t *testing.T) {

	expected := os.Getenv("GEXENV")
	n := expected

	if expected == "" {
		expected = "unknown"
	}
	actual := getGexEnv()

	if actual != expected {
		t.Errorf("GetGexEnv(%d): expected %d, actual %d", n, expected, actual)
	}

}

func TestGetMessage(t *testing.T) {

	var messageTests = []struct {
		n        string // input
		expected string // expected result
	}{
		{"dev", "Hello from dev! - version unknown"},
		{"test", "Hello from test! - version unknown"},
		{"prod", "Hello from prod! - version unknown"},
		{"unknown", "Hello from unknown! - version unknown"},
	}

	for _, tt := range messageTests {

		actual := getMessage(tt.n)

		if actual != tt.expected {
			t.Errorf("GetGexEnv(%d): expected %d, actual %d", tt.n, tt.expected, actual)
		}

	}
}
