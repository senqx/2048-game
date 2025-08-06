# Compiler and flags
CXX := g++
STD := -std=c++20
COMMON_FLAGS := $(STD) -Wall -Wextra -Werror -Wpedantic -MMD -MP
LDFLAGS :=

# Directories
SRC_DIR := src
OBJ_DIR_BASE := build
BIN_DIR_BASE := bin

# Sources
SRCS := $(shell find $(SRC_DIR) -name '*.cpp')

# Default
.DEFAULT_GOAL := release

# -------------------------------
# Target definitions
# -------------------------------
debug: BUILD := debug
debug: CXXFLAGS := -g -O0 $(COMMON_FLAGS)
debug: build_template

release: BUILD := release
release: CXXFLAGS := -O2 -DNDEBUG $(COMMON_FLAGS)
release: build_template

build_template:
	@echo "Building in $(BUILD) mode..."
	$(MAKE) all MODE=$(BUILD) CXXFLAGS="$(CXXFLAGS)"

# -------------------------------
# Actual build logic
# -------------------------------
MODE ?= release
OBJ_DIR := $(OBJ_DIR_BASE)/$(MODE)
BIN_DIR := $(BIN_DIR_BASE)/$(MODE)
TARGET := $(BIN_DIR)/2048
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))
DEPS := $(OBJS:.o=.d)

all: $(TARGET)
	@echo "Build complete: $(TARGET)"

$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	@echo "Linking $@"
	$(CXX) $^ -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	@echo "Compiling $<"
	$(CXX) $(CXXFLAGS) -I$(SRC_DIR) -c $< -o $@

# -------------------------------
# Clean
# -------------------------------
.PHONY: clean clean-all clean-debug clean-release

clean:
	@echo "Cleaning build/..."
	rm -rf $(OBJ_DIR_BASE)

clean-all:
	@echo "Cleaning build/ and bin/..."
	rm -rf $(OBJ_DIR_BASE) $(BIN_DIR_BASE)

clean-debug:
	@echo "Cleaning debug..."
	rm -rf $(OBJ_DIR_BASE)/debug $(BIN_DIR_BASE)/debug

clean-release:
	@echo "Cleaning release..."
	rm -rf $(OBJ_DIR_BASE)/release $(BIN_DIR_BASE)/release

# -------------------------------
# Dependency handling
# -------------------------------
-include $(DEPS)

