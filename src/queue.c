/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   queue.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kebris-c <kebris-c@student.42madrid.c      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/18 17:25:20 by kebris-c          #+#    #+#             */
/*   Updated: 2025/11/19 11:07:48 by kebris-c         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rtos.h"

/*==============================================================================
	INTERNAL STATE (extern globals)
==============================================================================*/
t_msg_queue	g_queue[MAX_QUEUES];

/*==============================================================================
	INITIALIZATION
==============================================================================*/
int	queue_init(void)
{
	int	i;

	i = 0;
	while (i < MAX_QUEUES)
	{
		memset(&g_queue[i], 0, sizeof(t_msg_queue));
		g_queue[i].capacity = CAPACITY;
		g_queue[i].item_size = ITEM_SIZE;
		i++;
	}
	return (0);
}

/*==============================================================================
	QUEUE CONTROL
==============================================================================*/
int	queue_send_msg(int queue_id, const void *data, size_t size)
{
	if (g_queue[queue_id].count >= g_queue[queue_id].capacity)
	return (0);
}

int	queue_recv_msg(int queue_id, void *buffer, size_t *size)
{
	return (0);
}
