.PHONY: all clean

UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)

ifeq ($(UNAME_S),Darwin)
    ifeq ($(UNAME_M),arm64)
        ASM_FILE := AArch64-macOS/hello.asm
        OBJ_FILE := hello.o
        TARGET := ./hello
        
        all: $(TARGET)
        
        $(TARGET): $(OBJ_FILE)
			ld -arch arm64 -o $(TARGET) $(OBJ_FILE) -lSystem -syslibroot $$(xcrun --show-sdk-path) -e _start
        
        $(OBJ_FILE): $(ASM_FILE)
			as -arch arm64 $(ASM_FILE) -o $(OBJ_FILE)
    else
        $(error Unsupported macOS architecture: $(UNAME_M))
    endif
else ifeq ($(UNAME_S),Linux)
    ASM_FILE := x86_Linux/hello.asm
    OBJ_FILE := hello.o
    TARGET := ./hello
    
    all: $(TARGET)
    
    $(TARGET): $(OBJ_FILE)
		ld -m elf_i386 $(OBJ_FILE) -o $(TARGET)
    
    $(OBJ_FILE): $(ASM_FILE)
		nasm -f elf32 $(ASM_FILE) -o $(OBJ_FILE)
else
    $(error Unsupported OS: $(UNAME_S))
endif

clean:
	rm -f $(OBJ_FILE) $(TARGET)
