#!/usr/bin/env swift -I ./modules -L ./modules -lExample

import Example

print(MyFunction("Module"))

var module = Example(name: "Command Line")
print("Hello, \(module.name)")
