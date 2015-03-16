#summary Document describing the API Reference of the EDK project.
#labels Featured,Phase-Implementation

**_THIS PAGE IS UNDER CONSTRUCTION_**

This is a reference page. If you never wrote a emulator before, you probably need to read the [Computer Tutorial](ComputerTutorial.md) page. If you already wrote a emulator and want to write your first emulator, check the [Emulator Tutorial](EmulatorTutoral.md).

The [Atari Tutorial](AtariTutorial.md) describes the process of writing a real machine emulator.

# Philosophy #

The EDK work philosophy is described in the [Philosophy](Philosophy.md) page. Its understanding is essential for writing a emulator.

# Tools #

EDK is made of 5 different tools. Check the [Tools](Tools.md) page to understand what they do.

# Function Prefixes #

All functions in the API begin with `emu_` or `dev_`. In fact, they are the same functions; the only difference is that when they're called from the emulator, they should be called with the `emu_` prefix. If they are called from one of the devices, they sould be called with the `dev_` prefix.

You don't need to understand why is that, but if you must, you can read [here](WhyEmuDev.md).

# API Reference #

  * [General Emulator Functions](GeneralFunctions.md)
    * emu\_init
    * emu\_main
    * emu\_reset\_soft
    * emu\_message
    * emu\_error
  * [CPU Functions](CPUFunctions.md)
  * [Video Card and Monitor Functions](VideoFunctions.md)
  * [Other Devices Functions](OtherFunctions.md)
  * [RAM Functions](RAMFunctions.md)
  * [ROM Functions](ROMFunctions.md)
  * [Input Functions](InputFunctions.md)