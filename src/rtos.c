/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtos.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kebris-c <kebris-c@student.42madrid.c      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/17 18:47:44 by kebris-c          #+#    #+#             */
/*   Updated: 2025/11/18 17:39:58 by kebris-c         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rtos.h"

/*==============================================================================
	INTERNAL STATE (extern globals)
==============================================================================*/
t_tcb		g_task_list[MAX_TASKS];
t_tcb		*g_curr_task;
int			g_num_tasks;

/*==============================================================================
	INITIALIZATION
==============================================================================*/
int	rtos_init(void)
{
	memset(g_task_list, 0, sizeof(g_task_list));
	g_curr_task = NULL;
	g_num_tasks = 0;
	return (0);
}

/*==============================================================================
	TASK MANAGEMENT
==============================================================================*/
int	rtos_task_create(t_task_func func, void *arg, unsigned int period_ms)
{
	t_tcb	*task;

	if (g_num_tasks >= MAX_TASKS)
		return (-1);
	task = &g_task_list[g_num_tasks];
	task->id = g_num_tasks;
	task->state = TASK_READY;
	task->func = func;
	task->arg = arg;
	task->period_ms = period_ms;
	task->next_run = get_time_ms();
	g_num_tasks++;
	return (task->id);
}

/*==============================================================================
	SCHEDULING
==============================================================================*/
void	rtos_start(void)
{
	unsigned long	now;
	t_tcb			*task;
	int				id;

	printf("[RTOS] Starting scheduler with %d tasks\n", g_num_tasks);
	while (1)
	{
		now = get_time_ms();
		for (id = 0; id < g_num_tasks; id++)
		{
			task = &g_task_list[id];
			if (task->state != TASK_READY)
				continue ;
			if (now < task->next_run)
				continue ;
			g_curr_task = task;
			task->state = TASK_RUNNING;
			task->func(task->arg);
			task->state = TASK_READY;
			if (task->period_ms > 0)
				task->next_run = now + task->period_ms;
		}
		g_curr_task = NULL;
		usleep(1000);
	}
}

void	rtos_yield(void)
{
	return ;
}

void	rtos_delay(unsigned int ms)
{
	if (g_curr_task == NULL)
		return ;
	g_curr_task->next_run = get_time_ms() + ms;
	rtos_yield();
}
