package main

import (
	"fmt"
	"log"
	"net/http"
)

func hello(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "hello")
}

func main() {
	http.HandleFunc("/", hello)
	log.Fatalln(http.ListenAndServe(":80", nil))
}
