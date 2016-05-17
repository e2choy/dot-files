#default makefile to use for programs
PROGRAM := a.out

#location of object files
OBJECT_DIR := ./Objects
#Objects

#location of source files
SOURCE_DIR := ./Sources
vpath %.cpp $(SOURCE_DIR)

#list of source,object, and dependency files
SOURCES = main.cpp
OBJECTS = $(addprefix $(OBJECT_DIR)/, $(SOURCES:.cpp=.o))
DEPENDS = $(addprefix $(OBJECT_DIR)/, $(SOURCES:.cpp=.d))
INCLUDE = ./

#list of libraries to include
LIBS =												 

#compiler
CXX = g++
#compile flags
ifeq ($(MODE), debug)
  CXXFLAGS = -std=c++11 -Wall -O0 -g -MP -MMD -I$(INCLUDE)
else
  CXXFLAGS = -std=c++11 -Wall -O3 -MP -MMD -I$(INCLUDE)
endif
#linker flags
LDFLAGS =

#link the program together
all : $(PROGRAM)

$(PROGRAM) : $(OBJECTS)
	$(CXX) -o $(PROGRAM) $(LDFLAGS) $(OBJECTS) $(LIBS)

#make directory for objects directory
$(OBJECTS) : | $(OBJECT_DIR)

$(OBJECT_DIR):
	mkdir -p $(OBJECT_DIR)

#compile the object file
$(OBJECT_DIR)/%.o : %.cpp 
	$(CXX) -o $@ -c $(CXXFLAGS) $<

#clean command
.PHONY : clean
clean:
	$(RM) -f *.o *.d $(PROGRAM)
	$(RM) -r $(OBJECT_DIR)

-include $(DEPENDS)
