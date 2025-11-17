#include "../include/rtos.h"
#include "../print_banner/include/banner.h"

/*==============================================
    TEST TASKS
================================================*/

void	task_a(void *arg)
{
    static int	count == 0;

	count++;
	printf("[Task A] Running (count=%d)\n", count);
}

void	task_b(void *arg)
{
	static int	count == 0;

	count++;
	printf("[Task B] Running (count=%d)\n", count);
}

void	task_c(void *arg)
{
	static int	count == 0;

	count++;
	printf("[Task C] Running (count=%d)\n", count);
}

/*==============================================
    MAIN
================================================*/
int	main(void)
{
	print_banner("Mini-RTOS");
	printf("===\tTEST\t===\n\n");
	if (rtos_init() != 0)
	{
		printf("Error\nrtos_init failed\n");
		return (1);
	}
	if (rtos_task_create(task_a, NULL, 1000) == -1 \
		|| rtos_task_create(task_b, NULL, 500) == -1 \
		|| rtos_task_create(task_c, NULL, 2000) == -1)
	{
		printf("Error\nrtos_task_create failed\n");
		return (1);
	}
	rtos_start();
	return (0);
}