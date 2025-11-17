/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kebris-c <kebris-c@student.42madrid.c      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/17 18:44:49 by kebris-c          #+#    #+#             */
/*   Updated: 2025/11/17 21:35:44 by kebris-c         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rtos.h"

/*==============================================================================
    TEST TASKS
==============================================================================*/
void	task_a(void *arg)
{
    static int	count = 0;

	(void)arg;
	count++;
	printf("[Task A] Running (count=%d)\n", count);
}

void	task_b(void *arg)
{
	static int	count = 0;

	(void)arg;
	count++;
	printf("[Task B] Running (count=%d)\n", count);
}

void	task_c(void *arg)
{
	static int	count = 0;

	(void)arg;
	count++;
	printf("[Task C] Running (count=%d)\n", count);
}

/*==============================================================================
    MAIN
==============================================================================*/
int	main(void)
{
	ft_banner("Minirtos");
	ft_printf("===\tTEST\t===\n\n");
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
