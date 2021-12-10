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

## Mutex
