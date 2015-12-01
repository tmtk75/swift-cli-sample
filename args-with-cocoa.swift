#!/usr/bin/env swift

import Foundation

func hello(name: String) -> String {
    return "Hello, \(name)"
}

let  args = NSUserDefaults.standardUserDefaults()

print(hello("Swift"))
print(args.objectForKey("keyName"))
