#include <libemu.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
	/* Initialize libemu */
	emu_init(argc, argv);
	
	/* Initialize components */
	emu_mem_init_k(64);
	emu_cpu_init("6502");
	
	/* Load ROM */
	//emu_rom_load("x.rom", 0);

	/* Start emulation */
	emu_cpu_reset();
	emu_main();

	return 0;
}
