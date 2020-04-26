PROGRAM=OgreAssimpConverter

all: $(PROGRAM)

OBJS = \
	src/AssimpLoader.o \
	src/OgreXMLMeshSerializer.o \
	src/OgreXMLSkeletonSerializer.o \
	tool/main.o

PKG_CONFIG=pugixml assimp OGRE OGRE-MeshLodGenerator

ifndef PKG_CONFIG
PKG_CONFIG_CFLAGS=
PKG_CONFIG_LDFLAGS=
PKG_CONFIG_LIBS=
else
PKG_CONFIG_CFLAGS=`pkg-config --cflags $(PKG_CONFIG)`
PKG_CONFIG_LDFLAGS=`pkg-config --libs-only-L $(PKG_CONFIG)`
PKG_CONFIG_LIBS=`pkg-config --libs-only-l $(PKG_CONFIG)`
endif

CFLAGS= -Isrc -O2 -g -Wall -Wno-unused-variable -Wno-unused-value -Wno-unused-but-set-variable
LDFLAGS= -Wl,--as-needed -Wl,--no-undefined -Wl,--no-allow-shlib-undefined
INCS=-Isrc
LIBS=
DEFS=
CSTD=-std=c11
CPPSTD=-std=c++11

$(PROGRAM): $(OBJS)
	g++ $(CPPSTD) $(CSTD) $(LDFLAGS) $(PKG_CONFIG_LDFLAGS) $+ -o $@ $(LIBS) $(PKG_CONFIG_LIBS)

%.o: %.cpp
	g++ -o $@ -c $+ $(CPPSTD) $(DEFS) $(INCS) $(CFLAGS) $(PKG_CONFIG_CFLAGS)

%.o: %.c
	gcc -o $@ -c $+ $(CSTD) $(DEFS) $(INCS) $(CFLAGS) $(PKG_CONFIG_CFLAGS)

test: $(PROGRAM)
	@rm -fv */*.material */*.mesh */*.skeleton
	for F in humanmesh/*.obj; do ./$(PROGRAM) "$$F"; done

test-lod: $(PROGRAM)
	@rm -fv */*.material */*.mesh */*.skeleton
	for F in humanmesh/*.obj; do ./$(PROGRAM) -l 2 "$$F"; done

clean:
	@rm -fv *.o *.a *~
	@rm -fv */*.o */*.a */*~
	@rm -fv $(PROGRAM)
