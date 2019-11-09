MKDIR_P := mkdir -p
LUA := lua
CP := cp
CP_A := cp -a
RM_RF := rm -rf
BUSTED = /Users/steckel/.luarocks/bin/busted

.PHONY: all dist/OmniWheel.lua dist/OmniWheel.toc dist/Bindings.xml clean

all: dist/OmniWheel.lua dist/OmniWheel.toc dist/Bindings.xml dist/textures

dist:
	@${MKDIR_P} dist

dist/OmniWheel.lua: dist
	${LUA} concat.lua -o dist/OmniWheel.lua\
 -g module_polyfill\
 -g globals\
 -e OmniWheel\
 -m observable.observable \
 -m observable.subject\
 -m observable.subscription\
 -m observable.subscription_observer\
 -m OmniWheelAddon\
 -m WheelView\
 -m WheelGeometry\
 -m Sector\
 -m set \
 -m TextureGrid\
 -m WheelGraphics


dist/OmniWheel.toc: dist
	@${CP} src/OmniWheel.toc dist/OmniWheel.toc

dist/Bindings.xml: dist
	@${CP} src/Bindings.xml dist/Bindings.xml

dist/textures: dist
	@${CP_A} textures dist/textures

clean:
	@${RM_RF} dist

test:
	@${BUSTED} src
