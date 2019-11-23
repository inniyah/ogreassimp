SimpleOpenGLModelViewer:
	gcc -g -o "$@" $(INCLUDEFLAGS) -s SimpleOpenGLModelViewer.cpp $(LIBFLAGS) -Wl,-Bstatic -Wl,-Bdynamic -lstdc++ -lglut -lassimp -lGL -lGLU -lIL

clean:
	@rm -fv SimpleOpenGLModelViewer assimp_log.txt *.o *~

.PHONY: clean
