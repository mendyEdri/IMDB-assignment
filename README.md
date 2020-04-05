# IMDB-assignment


## Pods
To run this project please run `pod install` in the root directory.

Please make sure to open `IMDB-assignment.xcworkspace` (not the `.xcodeproj`)

---

## Project

The project uses 2 pods:

1. `lit_networking` a testable protocol-oriented pod i created recently to deal with network calls. (https://github.com/mendyEdri/lit-networking)

2. `SDWebImage` the well-known pod for downloading asynchronous images.


Tests are in the same target, please cmd+u to run the tests.

`CI` scheme is configured for later use in CI platform.

---

## TODO

- [ ] Finish implementing cachable proxy - to save the genres list and load it from cache for speed response 
- [ ] Add more test - test MVVM models
- [ ] Make travis build pass 
