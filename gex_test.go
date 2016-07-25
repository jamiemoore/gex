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
		{"dev", "Hello from dev!"},
		{"test", "Hello from test!"},
		{"prod", "Hello from prod!"},
		{"unknown", "Hello from unknown!"},
	}

	for _, tt := range messageTests {

		actual := getMessage(tt.n)

		if actual != tt.expected {
			t.Errorf("GetGexEnv(%d): expected %d, actual %d", tt.n, tt.expected, actual)
		}

	}
}
