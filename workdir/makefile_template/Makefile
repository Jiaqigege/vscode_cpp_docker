# CROSS_COMPILE=
CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
OBJDUMP= $(CROSS_COMPILE)objdump
SRC:=$(wildcard *.cpp)
SRC+=$(wildcard src/*.cpp)
OBJ:=$(patsubst %.cpp,%.o,$(SRC))

TARGET = demo
INCLUDE = -Iinclude
LIB = -Llib
CFLAGS = -Wall -g

.PHONY:all clean
all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $^ $(LIB) -o $@
	$(OBJDUMP) -D -Matt $@ > $(TARGET).s

%.o:%.cpp
	$(CXX) -c $^ $(INCLUDE) $(CFLAGS) -o $@

clean:
	rm -f $(OBJ) $(TARGET) *.s compile_commands.json
