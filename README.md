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
  - Isolate can return object(is not copy). 
  - However, Isolate caller can only pass copy objects to Isolate
- goroutine can access shared memory

### Run and Output
`$ dart map.dart`
```
{name: Taro}:117765460
  rename {name: Jiro}: 117765460
{name: Jiro}:117765460
  rename {name: Sabro}: 54522872
{name: Jiro}:117765460 ,Do not change Sabro! (hashCode Not equals)
User(Taro): 34171567
  rename User(Shiro): 34171567
User(Shiro): 34171567
  User(Shiro): 893950694, Apply Shiro, but it is different object.
  rename User(Goro): 893950694
User(Goro): 893950694 ,Return Goro from isolate
User(Shiro): 34171567 ,Do not change Goro! (hashCode Not equals)
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
