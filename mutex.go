package main

import (
	"fmt"
	"math"
	"math/rand"
	"sync"
	"time"
)

var m = map[int]int{}

func main() {
	fmt.Println("main")

	mutex := &sync.RWMutex{}
	wg := &sync.WaitGroup{}

	wg.Add(1)
	go func() { write(100, mutex, wg) }()
	wg.Add(1)
	go func() { write(100, mutex, wg) }()
	wg.Add(1)
	go func() { write(100, mutex, wg) }()

	wg.Wait()

	fmt.Println("end: ", len(m)) // end:  300
}

func write(count int, mutex *sync.RWMutex, wg *sync.WaitGroup) {
	seed := time.Now().UnixNano()
	r := rand.New(rand.NewSource(seed))

	fmt.Printf("write(%d) start\n", seed)

	for i := 0; i < count; i++ {
		// If mutext.Louck() do not execute,
		// Error will occur. `fatal error: concurrent map writes`
		mutex.Lock()
		m[r.Intn(math.MaxUint32)] = i
		mutex.Unlock()
		time.Sleep(time.Duration(r.Intn(6)) * time.Nanosecond)
	}

	mutex.RLock()
	fmt.Printf("write(%d) end: len:%d\n", seed, len(m))
	mutex.RUnlock()

	wg.Done()
}
