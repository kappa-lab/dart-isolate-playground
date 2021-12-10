# Dart.isolate samples
Comparing with goroutine

## Basic
- run isolate
- link and message between isolate

### Run and Output
`$ dart main.dart`
```
main
workerRecieve :Init
workerRecieve :Send 1
workerRecieve :Send 2
end
```

`$ go main.go`
```
main
workerRecieve :Init
workerRecieve :Send 1
workerRecieve :Send 2
end
```

## Shared memory
- isolate can not access shared memory
- goroutine can access shared memory

### Run and Output
`$ dart map.dart`
```
{name: Taro}:450904456
  rename {name: Jiro}: 450904456
{name: Jiro}:450904456
  rename {name: Sabro}: 701368836
{name: Jiro}:450904456
User(Taro): 640978175
  rename User(Shiro): 640978175
User(Shiro): 640978175
  rename User(Goro): 108999121
User(Shiro): 640978175
```

`$ go map.go`
```
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
```
