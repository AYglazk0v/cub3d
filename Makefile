NAME		=	cub3d

CC			=	gcc

# FLAGS		=	-Wall -Wextra -Werror -g
FLAGS		=	-Wall -Wextra -Werror -DLINUX -g

INCL		= 	./header_files/

CFLAGS		=	$(FLAGS) -I $(INCL)

PATH_SRC	=	source_files/

PARS_SRC	=	source_files/parser/

PATH_LFT	=	libft/

PATH_OBJ	=	./object_files/

FILE_PRS	=	parser.c prepars_list_func.c preparser.c prepars_continue.c utils.c map.c dity_utils.c utils_1.c utils_2.c

FILE_SRC	=	main.c initialization.c utils.c cub_destroy.c raycasting.c raycasting_utils.c init_utils.c raycasting_computation.c move.c sprite.c door.c person.c rotate.c minimap.c
				
LIBFT_SRC	=	ft_atoi.c		ft_bzero.c		ft_calloc.c	ft_isalnum.c	ft_isalpha.c	ft_isascii.c	ft_isdigit.c	ft_isprint.c\
				ft_itoa.c		ft_memchr.c	ft_memcmp.c 	ft_memcpy.c 	ft_memmove.c 	ft_memset.c	ft_putchar_fd.c	ft_strjoin_free.c\
				ft_putendl_fd.c ft_putnbr_fd.c 	ft_putstr_fd.c 	ft_split.c 		ft_strchr.c 	ft_strcmp.c		ft_strdup.c		ft_striteri.c\
				ft_strjoin.c 	ft_strlcat.c 	ft_strlcpy.c 	ft_strlen.c 	ft_strmapi.c 	ft_strncmp.c	ft_strnstr.c\
				ft_strrchr.c 	ft_strtrim.c 	ft_substr.c 	ft_tolower.c 	ft_toupper.c 	ft_isspace.c	ft_strncpy.c\
				ft_lstadd_back_bonus.c 			ft_lstadd_front_bonus.c 		ft_lstclear_bonus.c			ft_lstdelone_bonus.c				ft_lstiter_bonus.c\
				ft_lstlast_bonus.c				ft_lstnew_bonus.c				ft_lstsize_bonus.c				ft_lstmap_bonus.c

HEAD_FILE	=	./header_files/cub3d.h\
				./header_files/parser.h\
				./header_files/struct.h\
				./libft/libft.h


SRC_SH		=	$(addprefix $(PATH_SRC), $(FILE_SRC))\
				$(addprefix $(PARS_SRC), $(FILE_PRS))

SRC_FT		=	$(addprefix $(PATH_LFT), $(LIBFT_SRC))

OBJ			=	$(patsubst $(PATH_SRC)%, $(PATH_OBJ)%, $(SRC_SH:.c=.o))

#****************************************************************************************************************************************************************************#

.PHONY			:	all clean fclean re
.ONESHELL		:

all				:	$(NAME) $(HEAD_FILE)

$(PATH_OBJ)%.o	:	$(PATH_SRC)%.c $(HEAD_FILE)
	@if ! [ -d ./object_files ] ; then \
		mkdir object_files ; \
		mkdir object_files/parser ; \
	fi 
	@$(CC) $(FLAGS) -Imlx -c $< -o $@
	@echo FILE COLLECTED $@

$(NAME)			:	 $(OBJ) $(HEAD_FILE) $(SRC_FT) $(SRC_SH)
	@make -C libft/
	@make -C mlx/
	@$(CC) $(CFLAGS) $(PATH_OBJ)*.o $(PATH_OBJ)parser/*.o -Lmlx -lmlx -framework OpenGL -framework AppKit -o $(NAME)

linux : $(OBJ) $(HEAD_FILE) $(SRC_FT) $(SRC_SH)
	@make -C libft/
	@make -C minilibx-linux/
	@$(CC) $(CFLAGS) $(PATH_OBJ)*.o $(PATH_OBJ)parser/*.o -L minilibx-linux/ -lmlx -lGL -lm -lX11 -lXext -o $(NAME)

clean			:
	@rm -rf $(PATH_OBJ)

fclean			:	clean
	@make fclean -C libft/
	@make clean -C mlx/
	@make clean -C minilibx-linux/
	@rm -rf $(NAME)

re				:	fclean all
