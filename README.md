# protobuf-compiler
Dockerized protobuf compiler for Arduino and python

Example usecase: Measure weather data with a sensor attached to an ESP32 which transmits the data via MQTT (encoded in __protobuf__ format) to a Raspberry Pi. On the Raspberry Pi, the data is decoded by a python-script and saved in a database.

Proper configuration of protoc (https://developers.google.com/protocol-buffers) and nanopb (https://jpa.kapsi.fi/nanopb/) turned out to be quite messy. Especially, since my Mac refused to execute the pre-compiled nanopb. Dockerizing the compilers makes this task much easier and increases reproducability.


## 1. Create ```.proto``` file

Define your protocol buffer message type in a .proto file, e.g. ```test.proto```:
```
syntax = "proto2";
 
message TestMessage {
    required int32 test_number = 1;
}
```


## 2. Compile for Arduino/ESP8266/ESP32 etc. (nanopb)

Run the following command in the directory that includes your proto-files to compile all your proto-filed. If you have several and only want to compile one, replace the ```*.proto``` by the file name.
```
docker run -v $(pwd):/protos -it --rm buschg/protobuf-compiler:latest protoc --plugin=protoc-gen-nanopb=/nanopb-0.4.1-linux-x86/generator/protoc-gen-nanopb --nanopb_out=/protos --proto_path=/protos/ *.proto
```
You will find the compiled versions in the same directory as ```test.pb.c``` and ```test.pb.h```.


## 3. Compile for python
Similarly, run the following command to compile your proto-files for python:
```
docker run -v $(pwd):/protos -it --rm buschg/protobuf-compiler:latest protoc --python_out=/protos --proto_path=/protos/ *.proto
```
You will find the compiled version in the same directory as ```test_pb2.py```.
