/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tasks.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kebris-c <kebris-c@student.42madrid.c      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/18 17:10:05 by kebris-c          #+#    #+#             */
/*   Updated: 2025/11/18 21:07:07 by kebris-c         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rtos.h"

/*==============================================================================
    TASKS
==============================================================================*/
void	task_sensor(void *arg)
{
    static int	count = 0;

	(void)arg;
	count++;
	printf("[Task A] Running (count=%d)\n", count);
}

void	task_proc(void *arg)
{
	static int	count = 0;

	(void)arg;
	count++;
	printf("[Task B] Running (count=%d)\n", count);
}

void	task_thermal(void *arg)
{
	static int	count = 0;

	(void)arg;
	count++;
	printf("[Task C] Running (count=%d)\n", count);
}
