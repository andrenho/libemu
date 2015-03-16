#summary Document describing the generic emulator functions.

# Functions that must be implemented by the programmer #

_None._

# Functions that are provided by the EDK #

### void emu\_init(const char**name, int argc, char****argv) ###**

This function initializes the EDK system. It must be the first function to be called from the [emulator file](EmulatorFile.md). The argument **name** provides the name that'll appear as the title of the main window. The arguments **argc** and **argv** are those passed by the main function.

Example:
```
#include <libemu.h>

int main(int argv, char* argc)
{
    emu_init("IBM PC", argc, argv);
    return 0;
}
```

### void emu\_main() ###

Passes the program control to EDK. It should be the last function to be called.

Example:
```
emu_main();
```

### void emu\_reset\_soft() ###

Makes a soft reset on the emulator. This will perform a reset in each device, but the memory will not be clean.

Example:
```
emu_reset_soft();
```

### void emu\_message(char**message) ###**

Writes a message to the user. These messages can be informative or warnings.

Example:
```
emu_message("Page fault in 0xFFFF.");
```

### void emu\_error(char**message) ###**

Presents a messagebox with a error message to the user and halts the emulation. Should be used for unrecoverable error.

Example:
```
emu_error("Invalid opcode!");
```