#ifndef _LIBEMU_DEV_H_
#define _LIBEMU_DEV_H_

#ifdef _WIN32
#	define EXPORT __declspec(dllexport)
#else
#	define EXPORT
#endif

/* General */
void (*dev_message)(char* message);

/* Memory */
void (*dev_mem_set_direct)(unsigned long int pos, unsigned char data);
void (*dev_mem_set)(unsigned long int pos, unsigned char data);
unsigned char (*dev_mem_get)(unsigned long int pos);

EXPORT void set_callbacks(
	void (*dev_message_ptr)(char*),
	void (*dev_mem_set_direct_ptr)(unsigned long int, unsigned char),
	void (*dev_mem_set_ptr)(unsigned long int, unsigned char),
	unsigned char (*dev_mem_get_ptr)(unsigned long int)
) 
{
	dev_message        = dev_message_ptr;
	dev_mem_set_direct = dev_mem_set_direct_ptr;
	dev_mem_set        = dev_mem_set_ptr;
	dev_mem_get        = dev_mem_get_ptr;
}

#endif
