#default makefile to use for programs
#to use autocompletion call :YcmGenerateConfig
PROGRAM := a.out

#location of object files
OBJECT_DIR := ./objects

#location of source files
SOURCE_DIR := #./sources
vpath %.cpp $(SOURCE_DIR)
LIB_DIR := #./clipper

#list of source,object, and dependency files
SOURCES = main.cpp
OBJECTS = $(addprefix $(OBJECT_DIR)/, $(SOURCES:.cpp=.o))
DEPENDS = $(addprefix $(OBJECT_DIR)/, $(SOURCES:.cpp=.d))
INCLUDE = ./

#list of libraries to include
LIBS = 
LDFLAGS = #'-Wl,-rpath=/usr/local/lib/OpenCV_Debug/lib:./clipper'

#compiler
CXX = g++

#compile flags
ifeq ($(MODE), release)
	CXXFLAGS = -std=c++11 -Wall -O0 -g -MP -MMD -I$(INCLUDE)
else
	CXXFLAGS = -std=c++11 -Wall -O3 -MP -MMD -I$(INCLUDE)
endif

#link the program together
all : $(PROGRAM)
$(PROGRAM) : $(OBJECTS)
	$(CXX) -L$(shell pwd) -o $(PROGRAM) $(LDFLAGS) $(OBJECTS) $(LIBS) 

#compile the object file
$(OBJECT_DIR)/%.o : %.cpp | $(OBJECT_DIR)
	$(CXX) -o $@ -c $(CXXFLAGS) $< 

#make directory for objects directory
$(OBJECT_DIR):
	mkdir -p $(OBJECT_DIR)

#clean command
.PHONY : clean
clean:
	$(RM) -f *.o *.d $(PROGRAM)
	$(RM) -r $(OBJECT_DIR)

-include $(DEPENDS)
#include properties/opencv_makefile
#include properties/clipper_makefile
