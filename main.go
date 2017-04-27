package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Yo, bro!")
	})
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%v", 8080), nil))
}
