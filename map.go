package main

/**
map[name:Taro]
  rename  map[name:Jiro]
map[name:Jiro]
  rename  map[name:Sabro]
map[name:Sabro]
&{Taro}
  rename  &{Shiro}
&{Shiro}
  rename  &{Goro}
&{Goro}
**/

import (
	"fmt"
	"time"
)

var m = map[string]string{"name": "Taro"}

type User struct {
	Name string
}

func main() {
	//Map
	fmt.Println(m) //map[name:Taro]

	toJiro(m)
	fmt.Println(m) //map[name:Jiro]

	go toSabro(m)
	time.Sleep(time.Millisecond * 100)
	fmt.Println(m) //map[name:Sabro]

	//User Class
	u := &User{Name: "Taro"}
	fmt.Println(u) //&{Taro}

	toShiro(u)
	fmt.Println(u) //&{Shiro}

	go toGoro(u)
	time.Sleep(time.Millisecond * 100)
	fmt.Println(u) //&{Goro}

}

func toJiro(m map[string]string) {
	m["name"] = "Jiro"
	fmt.Println("  rename ", m)
}
func toSabro(m map[string]string) {
	m["name"] = "Sabro"
	fmt.Println("  rename ", m)
}

func toShiro(u *User) {
	u.Name = "Shiro"
	fmt.Println("  rename ", u)
}

func toGoro(u *User) {
	u.Name = "Goro"
	fmt.Println("  rename ", u)
}
