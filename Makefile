run: modules/Example.swiftmodule modules/Example.dylib
	swift -I ./modules -L ./modules -lExample hello.swift

modules/Example.dylib: modules/Example.o
	libtool -macosx_version_min 10.11 \
		-L/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx \
	        -lswiftCore \
		-dynamic \
	        -lSystem \
		-install_name @rpath/libExample.dylib \
		-o modules/libExample.dylib \
		modules/Example.o

modules/Example.o: modules/Example.swift
	swiftc -emit-library \
	       -emit-object modules/Example.swift \
	       -o modules/Example.o

modules/Example.swiftmodule:
	swift -frontend \
	      -emit-module \
	      -module-name Example \
	      -emit-module-path modules/Example.swiftmodule \
	      -emit-module-doc-path modules/Example.swiftdoc \
	      modules/Example.swift

arg1:
	./args-with-cocoa.swift -keyName a-value

arg2:
	./args-on-swift.swift a b c

build: modules/Example.swiftmodule modules/Example.dylib
	swiftc -I ./modules/ -L ./modules/ -lExample -Xlinker -rpath -Xlinker ./modules/ -o hello ./hello.swift

clean:
	rm -rf hello modules/*.o modules/*.dylib modules/*.swiftdoc modules/*.swiftmodule
