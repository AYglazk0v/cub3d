/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_lstdelone_bonus.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nfarfetc <nfarfetc@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/10/09 10:01:19 by nfarfetc          #+#    #+#             */
/*   Updated: 2022/07/05 16:18:44 by nfarfetc         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	ft_lstdelone(t_list **lst, t_list *del)
{
	t_list	*curr;

	curr = *lst;
	while (curr->next != del)
	{
		curr = curr->next;
	}
	curr->next = del->next;
	free(del->content);
	free(del);
}
