/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtos.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kebris-c <kebris-c@student.42madrid.c      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/17 18:46:17 by kebris-c          #+#    #+#             */
/*   Updated: 2025/11/19 11:05:19 by kebris-c         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RTOS_H
# define RTOS_H

/*==============================================================================
		HEADERS
==============================================================================*/
# include "libft/include/libft.h"
# include "banner/include/banner.h"
# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <sys/time.h>
# include <stdint.h>
# include <string.h>

/*==============================================================================
		DEFINES
==============================================================================*/
# define MAX_TASKS	3

# define MAX_QUEUES	2
# define CAPACITY	6
# define ITEM_SIZE	2

/*==============================================================================
		TYPEDEFS
==============================================================================*/
typedef void	(*t_task_func)(void *);

typedef enum e_task_state
{
	TASK_READY,
	TASK_RUNNING,
	TASK_BLOCKED
}	t_task_state;

typedef struct s_tcb
{
	int				id;
	t_task_state	state;
	t_task_func		func;
	void			*arg;
	unsigned int	period_ms;
	unsigned long	next_run;
}	t_tcb;

typedef struct s_msg_queue
{
	uint8_t	buffer[CAPACITY * ITEM_SIZE];
	int		head;
	int		tail;
	int		count;
	int		capacity;
	size_t	item_size;
}	t_msg_queue;

typedef struct timeval t_timeval;

/*==============================================================================
		EXTERNS GLOBALS
==============================================================================*/
extern t_msg_queue	g_queue[MAX_QUEUES];
extern t_tcb		g_task_list[MAX_TASKS];
extern t_tcb		*g_curr_task;
extern int			g_num_tasks;

/*==============================================================================
		PROTOTYPES
==============================================================================*/
//	rtos.c
int		rtos_init(void);
int		rtos_task_create(t_task_func func, void *arg, unsigned int period_ms);
void	rtos_start(void);
void	rtos_delay(unsigned int ms);
void	rtos_yield(void);
//	tasks.c
void	task_sensor(void *arg);
void	task_proc(void *arg);
void	task_thermal(void *arg);
//	src/queue.c
int		queue_init(void);
int		queue_send_msg(int queue_id, const void *data, size_t size);
int		queue_recv_msg(int queue_id, void *buffer, size_t *size);
//	driver_adc.c
int		driver_adc_read(void);
//	driver_uart.c
int		driver_uart(void);
//	utils.c
unsigned long	get_time_ms(void);

#endif
