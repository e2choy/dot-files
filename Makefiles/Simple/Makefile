PROGRAM = a.out
SOURCES = $(wildcard *.cpp)
DEPENDS = $(SOURCES:.cpp=.d)
OBJECTS = $(SOURCES:.cpp=.o)
INCLUDE = ./
LIBS = -lGL -lGLU -lglut -lGLEW
CXXFLAGS = -std=c++0x -Wall -O0 -g -MP -MMD -I$(INCLUDE)
CXX = g++

all: $(PROGRAM)

clean:
	$(RM) -f *.o *.d $(PROGRAM)

$(PROGRAM): $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LIBS)

%.o: %.cpp
	$(CXX) -o $@ -c $(CXXFLAGS) $<
	
-include $(DEPENDS)
