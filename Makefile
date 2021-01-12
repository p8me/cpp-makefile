# General purpose C/C++ Makefile
# Created by Pooya Merat on 2018-04-10.

CXX      = g++
CC       = gcc

# Set the executable name
PROG_NAME := exec_name # name of the executable

SRC_DIRS = .
OBJDIR = obj

SRCS := $(shell find $(SRC_DIRS) -maxdepth 1 -type f -regex ".*\.cpp" -o -regex ".*\.c")
_OBJS := $(addsuffix .o,$(basename $(SRCS)))
OBJS := $(patsubst ./%,$(OBJDIR)/%,$(_OBJS))

# Add Libraries (-L and -l have to be in order for ubuntu)
# Example: LDFLAGS += -L/usr/local/lib -lpthread

# Compiler flags
CXXFLAGS 	+= -Wall -std=c++11
CCFLAGS 	+= -Wall -Wextra
CCFLAGS 	+= -std=gnu99 # Disable if not needed
CCFLAGS 	+= -O3

# Commands

.PHONY: clean

$(PROG_NAME): directories $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

directories:
	@mkdir -p $(OBJDIR)

$(OBJDIR)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(OBJDIR)/%.o: %.c
	$(CC) $(CCFLAGS) -c -o $@ $<

clean:
	@- $(RM) $(PROG_NAME)
	@- $(RM) -rf $(OBJDIR)

# Print for debugging
print-%  : ; @echo $* = $($*)
