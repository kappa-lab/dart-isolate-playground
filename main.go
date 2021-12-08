package main

import (
	"fmt"
	"time"
)

/**
------- print ------
main
workerRecieve :Init
workerRecieve :Send 1
workerRecieve :Send 2
end
--------------------
**/

func main() {
	fmt.Println("main")
	defer func() { fmt.Println("end") }()

	ch := make(chan string)
	go workerReciever(ch)
	go workerSender(ch)

	ch <- "Init"
	time.Sleep(1 * time.Second)
}

func workerReciever(ch chan string) {
	for {
		select {
		case message := <-ch:
			fmt.Printf("workerRecieve :%s\n", message)
		default:
		}
	}
}

func workerSender(ch chan string) {
	time.Sleep(100 * time.Millisecond)
	ch <- "Send 1"
	time.Sleep(100 * time.Millisecond)
	ch <- "Send 2"
}
