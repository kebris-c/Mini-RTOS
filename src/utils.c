#include "../include/rtos.h"

/*==============================================
	TIMING FUNCTIONS
================================================*/
unsigned long	get_time_ms(void)
{
	t_timeval	tv;

	gettimeofday(&tv, NULL);
	return ((tv.tv_sec * 1000UL) + (tv.tv_usec / 1000UL));
}