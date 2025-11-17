/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rtos.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kebris-c <kebris-c@student.42madrid.c      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/17 18:46:17 by kebris-c          #+#    #+#             */
/*   Updated: 2025/11/17 21:28:30 by kebris-c         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef RTOS_H
# define RTOS_H

/*		HEADERS		*/
# include "libft/include/libft.h"
# include "banner/include/banner.h"
# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <sys/time.h>
# include <stdint.h>
# include <string.h>

/*		DEFINES		*/
# define MAX_TASKS 16

/*		TYPEDEFS	*/
typedef void	(*t_task_func)(void *);
typedef	struct timeval	t_timeval;

typedef enum
{
	TASK_READY,
	TASK_RUNNING,
	TASK_BLOCKED
}	e_task_state;

typedef struct s_tcb
{
	int				id;
	e_task_state	state;
	t_task_func		func;
	void			*arg;
	unsigned int	period_ms;
	unsigned long	next_run;
}	t_tcb;

typedef struct s_msg_queue
{
	uint8_t	*buffer;
	size_t	item_size;
	int		head;
	int		tail;
	int		count;
	int		capacity;
}	t_msg_queue;

/*		PROTOTYPES		*/
int				rtos_init(void);
int				rtos_task_create(t_task_func func, void *arg, unsigned int period_ms);
int				rtos_send_message(int queue_id, const void *data, size_t size);
int				rtos_recv_message(int queue_id, void *buffer, size_t *size);
void			rtos_start(void);
void			rtos_delay(unsigned int ms);
void			rtos_yield(void);

unsigned long	get_time_ms(void);

void			task_print_info(void);
void			task_example(void *arg);

#endif
