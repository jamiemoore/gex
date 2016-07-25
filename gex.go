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
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os"
	"strconv"
)

var message string

type Message struct {
	Message string `json:"message"`
}

func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, message)
}

func APImessage(w http.ResponseWriter, r *http.Request) {
	json.NewEncoder(w).Encode(Message{Message: message})
}

func getGexEnv() (environment string) {

	environment = os.Getenv("GEXENV")
	if environment == "" {
		environment = "unknown"
	}
	return environment

}

func getMessage(environment string) (m string) {

	m = fmt.Sprintf("Hello from %s!", environment)
	return m
}

func main() {

	gexenv := getGexEnv()
	message = getMessage(gexenv)

	port := 8080

	fmt.Println("Gex Running...")
	fmt.Println("Environment:", gexenv)
	fmt.Println("Listening on port", port)

	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/", Index)
	router.HandleFunc("/api/message", APImessage)
	log.Fatal(http.ListenAndServe(":"+strconv.Itoa(port), router))
}
