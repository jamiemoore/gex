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
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/gorilla/mux"
)

var (
	gexEnv = "unknown"
	gexVer = "unknown"
)

type message struct {
	Message string `json:"message"`
}

type version struct {
	Version string `json:"version"`
}

// Index Handler that returns the web root
func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, getMessage(gexEnv))
}

// APImessage Handler that returns the message for the API
func APImessage(w http.ResponseWriter, r *http.Request) {
	json.NewEncoder(w).Encode(message{Message: getMessage(gexEnv)})
}

// APIversion Handler that returns the version for the API
func APIversion(w http.ResponseWriter, r *http.Request) {
	json.NewEncoder(w).Encode(version{Version: getVersion()})
}

func getGexEnv() (environment string) {

	environment = os.Getenv("GEXENV")
	if environment == "" {
		environment = "unknown"
	}

	return environment

}

func getMessage(environment string) (m string) {

	m = fmt.Sprintf("Hello from %s! - version %s", environment, getVersion())
	return m
}

func getVersion() (ver string) {

	if gexVer == "" {
		ver = "unknown"
	} else {
		ver = gexVer
	}

	return ver
}

func main() {

	gexEnv = getGexEnv()

	port := 8080

	fmt.Println("Gex Running...")
	fmt.Println("Environment:", gexEnv)
	fmt.Println("Listening on port", port)

	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/", Index)
	router.HandleFunc("/api/message", APImessage)
	router.HandleFunc("/api/version", APIversion)
	log.Fatal(http.ListenAndServe(":"+strconv.Itoa(port), router))
}
