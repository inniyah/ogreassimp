PROGRAM=OgreAssimpLoader

all: $(PROGRAM)

OBJS = src/AssimpLoader.o tool/main.o

PKG_CONFIG=assimp OGRE OGRE-MeshLodGenerator
PKG_CONFIG_CFLAGS=`pkg-config --cflags $(PKG_CONFIG)`
PKG_CONFIG_LDFLAGS=`pkg-config --libs-only-L $(PKG_CONFIG)`
PKG_CONFIG_LIBS=`pkg-config --libs-only-l $(PKG_CONFIG)`

CFLAGS= -Isrc -O2 -g -Wall -Wno-unused-variable -Wno-unused-value
LDFLAGS= -Wl,--as-needed -Wl,--no-undefined -Wl,--no-allow-shlib-undefined
LIBS=

$(PROGRAM): $(OBJS)
	g++ $(LDFLAGS) $(PKG_CONFIG_LDFLAGS) $+ -o $@ $(LIBS) $(PKG_CONFIG_LIBS)

%.o: %.cpp
	g++ -o $@ -c $+ $(CFLAGS) $(PKG_CONFIG_CFLAGS)

%.o: %.c
	gcc -o $@ -c $+ $(CFLAGS) $(PKG_CONFIG_CFLAGS)

clean:
	@rm -fv *.o *.a *~
	@rm -fv */*.o */*.a */*~
	@rm -fv $(PROGRAM)
