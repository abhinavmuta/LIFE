# LIFE makefile

# Compiler command
CXX=g++
CXXFLAGS=-O3 -std=c++11 -fopenmp -Wall -Wextra

# Location of source, header and object files
SDIR := src
HDIR := inc
EXAMPLES := examples

# Set TEST from command line: make TEST=LidDrivenCavity
TEST ?= examples/LidDrivenCavity

# Normalize test directory and name
TESTDIR := $(TEST)
TESTNAME := $(notdir $(patsubst %/, %, $(TEST)))
BUILDDIR := build/$(TESTNAME)

# Get the sources and object files
SRCS:=$(wildcard $(SDIR)/*.cpp)
OBJS := $(patsubst $(SDIR)/%.cpp, $(BUILDDIR)/%.o, $(SRCS))
EXE := $(TESTDIR)/LIFE

# Include and library files
INCLUDES := -I$(TESTDIR) -I$(HDIR)
LIB=-llapack -lboost_system -lboost_filesystem
LIB+=-L/usr/local/lib


# ==== Default target ====
all: $(EXE)

$(EXE): $(OBJS) | $(BUILDDIR)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(LIB) $^ -o $@

# Compile src/*.cpp into object files
$(BUILDDIR)/%.o: $(SDIR)/%.cpp | $(BUILDDIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Create build directory if needed
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Clean the project
.PHONY: clean
clean:
	rm -rf $(EXE) $(BUILDDIR) $(TESTDIR)/Results
