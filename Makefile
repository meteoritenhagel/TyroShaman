#
# Makefile
#

PROJECT_NAME        := TyroShaman

RGBDS_ASM           := rgbasm
RGBDS_LINK          := rgblink
RGBDS_FIX           := rgbfix
 
LINK_FLAGS          := 
FIX_FLAGS           := -v -p 0xFF

PROJECT_EXT         := gb
SRC_DIR             := src
INC_DIR             := include
BUILD_DIR           := build
FINAL_DIR           := final
FINAL_TARGET        := $(FINAL_DIR)/$(PROJECT_NAME)
 
$(info "Building : $(FINAL_TARGET).$(PROJECT_EXT)")
 
########################################
 
# list all source .asm files    : source/main.asm source/player.asm source/battle.asm
SOURCE_FILES        := $(wildcard $(SRC_DIR)/*.asm)
 
# list all include .inc files   : -iinclude/hardware.inc -iinclude/temp.inc
INCLUDE_FILES       := $(addprefix -i, $(wildcard $(INC_DIR)/*.inc))
 
# list all objects to input     : source/main.o source/player.o source/battle.o
OBJECTS_INPUT       := $(SOURCE_FILES:.asm=.o)
 
# list all objects that output  : build/main.o build/player.o build/battle.o
# note they are placed into the build folder by removing the previous directory
# using notdir, then a new directory is prefixed
OBJECTS_OUTPUT      := $(addprefix $(BUILD_DIR)/, $(notdir $(SOURCE_FILES:%.asm=/%.o)))
 
$(info "SOURCE_FILES = $(SOURCE_FILES)")
$(info "INCLUDE_FILES = $(INCLUDE_FILES)")
$(info "OBJECTS_INPUT = $(OBJECTS_INPUT)")
$(info "OBJECTS_OUTPUT = $(OBJECTS_OUTPUT)")
 
########################################
 
%.o : %.asm
	#$(RGBDS_ASM) $(INCLUDE_FILES) -o $(BUILD_DIR)/$(notdir $@) $<
	$(RGBDS_ASM) -o $(BUILD_DIR)/$(notdir $@) $<
 
$(FINAL_TARGET) : $(OBJECTS_INPUT)
	@$(RGBDS_LINK) $(LINK_FLAGS) -o $@.$(PROJECT_EXT) -n $@.sym $(OBJECTS_OUTPUT)
	@$(RGBDS_FIX) $(FIX_FLAGS) $(FINAL_TARGET).$(PROJECT_EXT)
 
########################################
 
prepare:
	mkdir -p $(FINAL_DIR)
	mkdir -p $(BUILD_DIR)
 
all: $(FINAL_TARGET)
 
clean:
	rm -rf  $(FINAL_DIR)/*.*
	rm -rf  $(BUILD_DIR)
 
run: $(TARGET)
	$(EMULATOR) $(TARGET)
