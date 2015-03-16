#summary Document describing the CPU functions.

# Functions that must be implemented by the programmer #

### EXPORT char**dev\_type ###**

Defines the device type. Must be "cpu".

Example:
```
EXPORT char dev_type[] = "cpu";
```

### EXPORT char**dev\_cpu\_name ###**

Defines the CPU name. This name will appear as the button label in the main emulator window.

Example:
```
EXPORT char dev_cpu_name[] = "8086";
```

### EXPORT char**dev\_cpu\_register\_name(int n) ###**

This function will return the register names. For example, if your processor has two registers, X and Y, when n == 0, the function would return "X", and when n == 1, it would return "Y". The funcion must return NULL for every other value of n.

Example:
```
EXPORT char* dev_cpu_register_name(int n)
{
	switch(n)
    {
		case 0:  return "X";
		case 1:  return "Y";
		default: return NULL;
	}
}
```

### EXPORT unsigned int dev\_cpu\_register\_value(int n) ###

This function will return the register values. For example, if your processor has two registers, X and Y, when n == 0, the function would return the value in X, and when n == 1, it would return the value in Y. The value of the register n must match the register n passed on the function dev\_cpu\_register\_name. This value will have to be stored somewhere (likely a global function).

Example:
```
EXPORT unsigned int dev_cpu_register_value(int n)
{
	switch(n)
	{
		case 0:  return X;
		case 1:  return Y;
		default: return 0;
	}
}
```

### EXPORT char**dev\_cpu\_flag\_name(int n) ###**

This function will return the flag names. For example, if your processor has two flags, N and Z, when n == 0, the function would return "N", and when n == 1, it would return "Z". The funcion must return NULL for every other value of n.

Example:
```
EXPORT char* dev_cpu_flag_name(int n)
{
	switch(n)
	{
		case 0:  return "N";
		case 1:  return "Z";
		default: return NULL;
	}
}
```

### EXPORT unsigned char dev\_cpu\_flag\_value(int n) ###

This function will return the register values. For example, if your processor has two flags, N and Z, when n == 0, the function would return the value in N, and when n == 1, it would return the value in Z. The value of the register n must match the register n passed on the function dev\_cpu\_register\_name. This value will have to be stored somewhere (likely a global function).

Example:
```
EXPORT unsigned char dev_cpu_flag_value(int n)
{
	switch(n)
	{
		case 0:  return N;
		case 1:  return Z;
		default: return 0;
	}
}
```

### EXPORT char**dev\_cpu\_debug(unsigned long addr, int**num\_cycles, int **bytes) ###**

This code will return the human-readable opcode from a given position in memory. It'll be used bu the debugger to display the data. The data must be returned in a persistent way, using the global variable buffer, or a segfault might happen. The parameters are:

  * **addr** - the address to be debugger
  * **num\_cycles** - return the (predicted) number of cycles that would be spent by this operation
  * **bytes** - the number of bytes used by the instruction. It'll usually be more than one if the instruction recieves a parameter.

The function must return NULL in case of invalid opcode.

Example:
```
char buffer[100];

EXPORT char* dev_cpu_debug(unsigned long addr, int *num_cycles, int *bytes)
{
	switch(dev_mem_get(addr))
	{
		case 0: // ADD X Y
			sprintf(buffer, "ADD X Y");
			*num_cycles = 3;
			*bytes = 1;
			break;
		default:
			*num_cycles = 0;
			*bytes = 0;
			return NULL;
	}
	return buffer;	
}
```

### EXPORT void dev\_cpu\_reset() ###

This function performs a reset of the CPU.

Example:
```
EXPORT void dev_cpu_reset()
{
	PC = 0xF000;
	X = Y = 0;
	N = Z = 0;
}
```

### EXPORT unsigned long int dev\_cpu\_ip() ###

This function returns the Instruction Pointer.

Example:
```
EXPORT unsigned long int dev_cpu_ip()
{
	return PC;
}
```

### EXPORT int dev\_cpu\_step(int **num\_cycles) ###**

This function performs a CPU step. **This function is the heart of your emulator.**

The function must return 0 in case of success, or -1 in case of faluire (a bad opcode, for example). The **num\_cycles** parameter is used to return the number of cycles spent on the step. You must advance the Instruction Pointer manually.

The example below is from a very simple CPU, and more complex !CPUs might have to modify the whole function.

This code will run hundreds of times per second, so make it run as fast as possible, but remember to mantain it C ANSI and portable.

Example:
```
EXPORT int dev_cpu_step(int *num_cycles)
{
	switch(dev_mem_get(PC))
	{
		case 0: /* ADD X Y */
			X = X + Y;
			PC++;
			*num_cycles = 3;
			break;
		default:
			*num_cycles = 0;
			return -1;
	}
	return 0;
}
```

# Functions that are provided by the EDK #

### int emu\_cpu\_init(char**filename) ###**

Load and initialize the CPU DLL file developed by the programmer. This file will have a **.dll** extension on Windows or a **.so** extension on Linux. The parameter **filename** must be the name of the file _without_ the extension.

Example:
```
emu_cpu_init("8086");
```

### void emu\_cpu\_run() ###

Runs the emulation. You can use this function of you want to run the emulation as soon as the user turn on the emulator, or as soon he loads the ROM.

Example:
```
emu_cpu_run();
```

### void emu\_cpu\_pause() ###

Pauses the emulation. It can be used for setting hardwired breakpoints, and for debugging.

Example:
```
emu_cpu_pause();
```