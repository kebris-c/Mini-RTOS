# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kebris-c <kebris-c@student.42madrid.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/09/08 13:07:54 by kebris-c          #+#    #+#              #
#    Updated: 2025/11/27 15:03:54 by kebris-c         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.DEFAULT_GOAL := all

.PHONY: all bonus clean fclean re \
	rigor rigor_bonus dbg dbg_bonus gdb gdb_bonus \
	re_bonus re_rigor re_rigor_bonus re_dbg re_dbg_bonus re_gdb re_gdb_bonus \
	setup help norm norm_bonus norm_libft norm_banner norm_all \
	leaks leaks_bonus leaks_rigor leaks_rigor_bonus leaks_dbg leaks_dbg_bonus

#	Central variables to change on every project
#	Project and binary Name
#
BIN		= minirtos
B_BIN	= $(BIN)_bonus

#	Central SRCs. Change on every project
#
HAS_MAIN		= $(shell [ -f src/main.c ] && echo yes || echo no)
ifeq ($(HAS_MAIN),yes)
	MAIN_SRC	= main.c
	MAIN_OBJ	= $(OBJS_DIR)main.o
else
	MAIN_SRC	=
	MAIN_OBJ	=
endif

HAS_B_MAIN		= $(shell [ -f bonus/src/main_bonus.c ] && echo yes || echo no)
ifeq ($(HAS_B_MAIN),yes)
	B_MAIN_SRC	= main_bonus.c
	B_MAIN_OBJ	= $(B_OBJS_DIR)main_bonus.o
else
	B_MAIN_SRC	=
	B_MAIN_OBJ	=
endif
SRCS		= \
				drivers.c \
				queue.c \
				rtos.c \
				tasks.c \
				utils.c
B_SRCS		= $(SRCS)

#	Shell variable
#
SHELL	:= /bin/bash

# 🔧 Compiler and flags
#
CC			= cc
CFLAGS		= -Wall -Wextra -Werror
GDBFLAGS	= $(CFLAGS) \
			  -g3 \
			  -O0
CEXTRAFLAGS	= $(GDBFLAGS) \
			  -MMD \
			  -MP \
			  -std=c17 \
			  -Wpedantic \
			  -Wconversion \
			  -Wsign-conversion \
			  -Wshadow \
			  -Wstrict-prototypes \
			  -Wpointer-arith \
			  -Wcast-align \
			  -Wunreachable-code \
			  -Winit-self \
			  -Wswitch-enum \
			  -Wfloat-equal \
			  -Wformat=2 \
			  -Wmissing-prototypes \
			  -Wmissing-declarations \
			  -Wdouble-promotion \
			  -Wundef \
			  -Wbad-function-cast \
			  -Winline -Wvla \
			  -Wno-unused-parameter \
			  -Wno-missing-field-initializers \
			  -fstrict-aliasing \
			  -fstack-protector-strong \
			  -D_FORTIFY_SOURCE=2

# 🔨 Tools
#
AR      = ar rcs
RM      = rm -rf
NORM    = norminette
CP      = cp -r
LS		= ls -l

# 📂 Fast path variables / dirs
#
SRC_DIR		= src/
INCL_DIR	= include/
OBJS_DIR	= objs/
DEPS_DIR	= deps/
BIN_DIR		= bin/
# If there is bonus/
#
B_DIR			= bonus/
B_SRC_DIR		= $(B_DIR)$(SRC_DIR)
B_INCL_DIR		= $(B_DIR)$(INCL_DIR)
B_OBJS_DIR		= $(B_DIR)$(OBJS_DIR)
B_DEPS_DIR		= $(B_DIR)$(DEPS_DIR)
B_BIN_DIR		= $(B_DIR)$(BIN_DIR)
# If there is libft/
#
L_DIR			= libft/
L_SRC_DIR		= $(L_DIR)$(SRC_DIR)
L_INCL_DIR		= $(L_DIR)$(INCL_DIR)
L_OBJS_DIR		= $(L_DIR)$(OBJS_DIR)
L_DEPS_DIR		= $(L_DIR)$(DEPS_DIR)
L_BIN_DIR		= $(L_DIR)$(BIN_DIR)
# If there is banner/
#
BAN_DIR			= banner/
BAN_SRC_DIR		= $(BAN_DIR)$(SRC_DIR)
BAN_INCL_DIR	= $(BAN_DIR)$(INCL_DIR)
BAN_OBJS_DIR	= $(BAN_DIR)$(OBJS_DIR)
BAN_DEPS_DIR	= $(BAN_DIR)$(DEPS_DIR)
BAN_BIN_DIR		= $(BAN_DIR)$(BIN_DIR)

# 📚 Basic project variables
#	Notes:
#		P = PROJECT ; B = BONUS ; N = NAME of it's library *.a
# main projects
PROJECT		= $(BIN_DIR)$(BIN)
P_RIGOR		= $(PROJECT)_rigor
P_DBG		= $(PROJECT)_dbg
P_GDB		= $(PROJECT)_gdb
# bonus projects
P_BONUS		= $(B_BIN_DIR)$(B_BIN)
P_B_RIGOR	= $(P_BONUS)_rigor
P_B_DBG		= $(P_BONUS)_dbg
P_B_GDB		= $(P_BONUS)_gdb
# main names
NAME		= $(PROJECT).a
N_RIGOR		= $(P_RIGOR).a
N_DBG		= $(P_DBG).a
N_GDB		= $(P_GDB).a
# bonus names
N_BONUS		= $(P_BONUS).a
N_B_RIGOR	= $(P_B_RIGOR).a
N_B_DBG		= $(P_B_DBG).a
N_B_GDB		= $(P_B_GDB).a
# others names
BANNER		= $(BAN_BIN_DIR)banner.a
LIB			= $(L_BIN_DIR)libft.a

# 🎯 Objects and Deps
#
OBJS		= $(patsubst %.c,$(OBJS_DIR)%.o,$(SRCS))
ifeq ($(HAS_MAIN),yes)
    OBJS	+= $(MAIN_OBJ)
endif
DEPS		= $(patsubst $(OBJS_DIR)%.o,$(DEPS_DIR)%.d,$(OBJS))
# And if there is bonus...
#
B_OBJS		= $(patsubst %.c,$(B_OBJS_DIR)%.o,$(B_SRCS))
ifeq ($(HAS_B_MAIN),yes)
    B_OBJS	+= $(B_MAIN_OBJ)
endif
B_DEPS		= $(patsubst $(B_OBJS_DIR)%.o,$(B_DEPS_DIR)%.d,$(B_OBJS))

# 📄 Headers. First, we need to check if there is a libft and banner dirs
#
HAS_LIBFT = $(shell \
    if [ -d libft ]; then \
        echo yes; \
    else \
        echo no; \
    fi)
HAS_BANNER = $(shell \
    if [ -d banner ]; then \
        echo yes; \
    else \
        echo no; \
    fi)
#	now, set correct headers
HEADERS	= -I$(INCL_DIR)
ifeq ($(HAS_LIBFT),yes)
	HEADERS += -I$(L_INCL_DIR)
endif
ifeq ($(HAS_BANNER),yes)
	HEADERS += -I$(BAN_INCL_DIR)
endif

-include $(DEPS)
-include $(B_DEPS)

# ------------------------------------------------ #
#    COMPILE COMMANDS 			                   #
# ------------------------------------------------ #
#	Notes:
#		$(1) == flags | $(2) == main.o if needed and dependency *.a | $(3) == Executable Name
#
define COMPILE_PROJECT
	@if [ -d $(L_DIR) ] && [ -f $(LIB) ]; then \
		if [ -d $(BAN_DIR) ] && [ -f $(BANNER) ]; then \
			$(CC) $(1) $(2) -L$(L_BIN_DIR) -L$(BAN_BIN_DIR) $(BANNER) $(LIB) -o $(3); \
		else \
			$(CC) $(1) $(2) -L$(L_BIN_DIR) $(LIB) -o $(3); \
		fi; \
	else \
		$(CC) $(1) $(2) -o $(3); \
	fi
endef

# ------------------------------------------------ #
#  Setup rule: normalize project structure         #
# ------------------------------------------------ #

setup:
	@mkdir -p $(SRC_DIR) $(INCL_DIR) $(OBJS_DIR) $(DEPS_DIR) $(BIN_DIR)
	@if [ -d $(B_DIR) ]; then \
		mkdir -p $(B_SRC_DIR) $(B_INCL_DIR) $(B_OBJS_DIR) $(B_DEPS_DIR) $(B_BIN_DIR); \
		find . -maxdepth 1 -name "*_bonus.c" ! -path "./$(B_SRC_DIR)*" -exec mv -n {} $(B_SRC_DIR)/ \;; \
		find . -maxdepth 1 -name "*_bonus.h" ! -path "./$(B_INCL_DIR)*" -exec mv -n {} $(B_INCL_DIR)/ \;; \
		find . -maxdepth 1 -name "*_bonus.o" ! -path "./$(B_OBJS_DIR)*" -exec mv -n {} $(B_OBJS_DIR)/ \;; \
		find . -maxdepth 1 -name "*_bonus.d" ! -path "./$(B_DEPS_DIR)*" -exec mv -n {} $(B_DEPS_DIR)/ \;; \
	fi
	@find . -maxdepth 1 -name "*.c" ! -path "./$(SRC_DIR)*" -exec mv -n {} $(SRC_DIR)/ \;
	@find . -maxdepth 1 -name "*.h" ! -path "./$(INCL_DIR)*" -exec mv -n {} $(INCL_DIR)/ \;
	@find . -maxdepth 1 -name "*.o" ! -path "./$(OBJS_DIR)*" -exec mv -n {} $(OBJS_DIR)/ \;
	@find . -maxdepth 1 -name "*.d" ! -path "./$(DEPS_DIR)*" -exec mv -n {} $(DEPS_DIR)/ \;

# ------------------------------------------------ #
#  Help rule: Be user-friendly			           #
# ------------------------------------------------ #
# Make sure this rule is updated with correct data
#
help:
	@echo ""
	@echo "==================== HELP ===================="
	@echo ""
	@echo "📦 Basic build:"
	@echo "  all				-> build $(NAME) and $(PROJECT) (default)"
	@echo "  bonus				-> build $(N_BONUS) and $(P_BONUS)"
	@echo "  rigor				-> build $(N_RIGOR) and $(P_RIGOR) with extra rigorous flags"
	@echo "  rigor_bonus			-> build $(N_B_RIGOR) and $(P_B_RIGOR) with extra rigorous flags"
	@echo "  gdb				-> build $(N_GDB) and $(P_GDB). Then run gdb ./$(P_GDB)"
	@echo "  gdb_bonus			-> build $(N_B_GDB) and $(P_B_GDB). Then run gdb ./$(P_B_GDB)"
	@echo "  dbg				-> build $(N_DBG) and $(P_DBG)"
	@echo "  dbg_bonus			-> build $(N_B_DBG) and $(P_B_DBG)"
	@echo ""
	@echo "🧹 Cleaning:"
	@echo "  clean				-> remove .o and .d files (objs and deps)"
	@echo "  fclean			-> clean + remove binaries and .a"
	@echo "  re				-> full rebuild (fclean + all)"
	@echo "  re_bonus			-> full rebuild (fclean + bonus)"
	@echo "  re_rigor			-> full rebuild (fclean + rigor)"
	@echo "  re_rigor_bonus		-> full rebuild (fclean + rigor_bonus)"
	@echo "  re_gdb			-> full rebuild (fclean + gdb)"
	@echo "  re_gdb_bonus			-> full rebuild (fclean + gdb_bonus)"
	@echo "  re_dbg			-> full rebuild (fclean + dbg)"
	@echo "  re_dbg_bonus			-> full rebuild (fclean + dbg_bonus)"
	@echo ""
	@echo "🧠 Analysis & tools:"
	@echo "  norm				-> run norminette on main project"
	@echo "  norm_bonus			-> run norminette on bonus project"
	@echo "  norm_libft			-> run norminette on libft project"
	@echo "  norm_banner		-> run norminette on banner project"
	@echo "  norm_all			-> run norminette on main, bonus, banner and libft projects"
	@echo "  leaks				-> valgrind main project"
	@echo "  leaks_bonus			-> valgrind bonus project"
	@echo "  leaks_rigor			-> valgrind rigor project"
	@echo "  leaks_rigor_bonus		-> valgrind rigor bonus project"
	@echo "  leaks_dbg			-> valgrind debug project"
	@echo "  leaks_dbg_bonus		-> valgrind debug bonus project"
	@echo ""
	@echo "📁 Project setup:"
	@echo "  setup				-> create normalized folder structure"
	@echo ""
	@echo "==============================================="
	@echo ""

#------------------------------------------------#
#   BASIC RULES / LIBRARY COMMANDS               #
#------------------------------------------------#

#	Basic options
#
ifeq ($(HAS_MAIN),yes)
all: $(NAME) $(PROJECT)

rigor: $(N_RIGOR) $(P_RIGOR)

dbg: $(N_DBG) $(P_DBG)
else
all: $(NAME)

rigor: $(N_RIGOR)

dbg: $(N_DBG)
endif

gdb: $(N_GDB) $(P_GDB)
	gdb ./$(P_GDB)

ifeq ($(HAS_B_MAIN),yes)
bonus: $(N_BONUS) $(P_BONUS)

rigor_bonus: $(N_B_RIGOR) $(P_B_RIGOR)

dbg_bonus: $(N_B_DBG) $(P_B_DBG)
else
bonus: $(N_BONUS)

rigor_bonus: $(N_B_RIGOR)

dbg_bonus: $(N_B_DBG)
endif

gdb_bonus: $(N_B_GDB) $(P_B_GDB)
	gdb ./$(P_B_GDB)

#	Dependence makes -c
#
necessary_makes:
	@if [ -d $(L_DIR) ] && [ ! -f $(LIB) ]; then \
		$(MAKE) -C $(L_DIR); \
	fi;
	@if [ -d $(BAN_DIR) ] && [ ! -f $(BANNER) ]; then \
		$(MAKE) -C $(BAN_DIR); \
	fi;

#	Headers compilers
#
$(NAME): $(OBJS) | setup necessary_makes
	$(AR) $(NAME) $(OBJS); \
	echo "✅ $(NAME) built with main sources";

$(N_RIGOR): $(OBJS) | setup necessary_makes
	$(AR) $(N_RIGOR) $(OBJS); \
	echo "✅ $(N_RIGOR) built with main sources";

$(N_DBG): $(OBJS) | setup necessary_makes
	$(AR) $(N_DBG) $(OBJS); \
	echo "✅ $(N_DBG) built with main sources";

$(N_GDB): $(OBJS) | setup necessary_makes
	$(AR) $(N_GDB) $(OBJS); \
	echo "✅ $(N_GDB) built with bonus sources";

$(N_BONUS): $(B_OBJS) | setup necessary_makes
	$(AR) $(N_BONUS) $(B_OBJS); \
	echo "✅ $(N_BONUS) built with bonus sources";

$(N_B_RIGOR): $(B_OBJS) | setup necessary_makes
	$(AR) $(N_B_RIGOR) $(B_OBJS); \
	echo "✅ $(N_B_RIGOR) built with bonus sources";

$(N_B_DBG): $(B_OBJS) | setup necessary_makes
	$(AR) $(N_B_DBG) $(B_OBJS); \
	echo "✅ $(N_B_DBG) built with bonus sources";

$(N_B_GDB): $(B_OBJS) | setup necessary_makes
	$(AR) $(N_B_GDB) $(B_OBJS); \
	echo "✅ $(N_B_GDB) built with bonus sources";

#	Objects & bonus objects Compilers
#
$(OBJS_DIR)%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJS_DIR) $(DEPS_DIR)
	@echo "🔨 Compiling $<..."
	@$(CC) $(CFLAGS) -MMD -MP $(HEADERS) -MF $(DEPS_DIR)$* -c $< -o $@

$(B_OBJS_DIR)%.o: $(B_SRC_DIR)%.c
	@mkdir -p $(B_OBJS_DIR) $(B_DEPS_DIR)
	@echo "🔨 Compiling bonus $<..."
	@$(CC) $(CFLAGS) -MMD -MP $(HEADERS) -MF $(B_DEPS_DIR)$* -c $< -o $@

#	Cleaners
#
clean:
	@$(RM) \
		$(OBJS_DIR) $(DEPS_DIR) \
		$(B_OBJS_DIR) $(B_DEPS_DIR) \
		$(L_OBJS_DIR) $(L_DEPS_DIR) \
		$(BAN_OBJS_DIR) $(BAN_DEPS_DIR)

fclean: clean
	@$(RM) \
		$(BIN_DIR) \
		$(B_BIN_DIR) \
		$(L_BIN_DIR) \
		$(BAN_BIN_DIR)

#	Reworks from zero
#
re: fclean all

re_bonus: fclean bonus

re_rigor: fclean rigor

re_rigor_bonus: fclean rigor_bonus

re_gdb: fclean gdb

re_gdb_bonus: fclean gdb_bonus

re_dbg: fclean dbg

re_dbg_bonus: fclean dbg_bonus

#------------------------------------------------#
#   PROJECT COMPILATION                          #
#------------------------------------------------#

$(PROJECT):
	$(call COMPILE_PROJECT,$(CFLAGS),$(MAIN_OBJ) $(NAME),$(PROJECT))
	@if [ -f $(PROJECT) ]; then \
		echo "✅ $(PROJECT) linked"; \
	else \
		echo "⚠️ Failed to build $(PROJECT)"; \
	fi

$(P_RIGOR):
	$(call COMPILE_PROJECT,$(CEXTRAFLAGS),$(MAIN_OBJ) $(N_RIGOR),$(P_RIGOR))
	@if [ -f $(P_RIGOR) ]; then \
		echo "✅ $(P_RIGOR) linked"; \
	else \
		echo "⚠️ Failed to build $(P_RIGOR)"; \
	fi

$(P_DBG):
	$(call COMPILE_PROJECT,,$(MAIN_OBJ) $(N_DBG),$(P_DBG))
	@if [ -f $(P_DBG) ]; then \
		echo "✅ $(P_DBG) linked"; \
	else \
		echo "⚠️ Failed to build $(P_DBG)"; \
	fi

$(P_GDB):
	$(call COMPILE_PROJECT,$(GDBFLAGS),$(MAIN_OBJ) $(N_GDB),$(P_GDB))
	@if [ -f $(P_GDB) ]; then \
		echo "✅ $(P_GDB) linked"; \
	else \
		echo "⚠️ Failed to build $(P_GDB)"; \
	fi

$(P_BONUS):
	$(call COMPILE_PROJECT,$(CFLAGS),$(B_MAIN_OBJ) $(N_BONUS),$(P_BONUS))
	@if [ -f $(P_BONUS) ]; then \
		echo "✅ $(P_BONUS) linked"; \
	else \
		echo "⚠️ Failed to build $(P_BONUS)"; \
	fi

$(P_B_RIGOR):
	$(call COMPILE_PROJECT,$(CEXTRAFLAGS),$(B_MAIN_OBJ) $(N_B_RIGOR),$(P_B_RIGOR))
	@if [ -f $(P_B_RIGOR) ]; then \
		echo "✅ $(P_B_RIGOR) linked"; \
	else \
		echo "⚠️ Failed to build $(P_B_RIGOR)"; \
	fi

$(P_B_DBG):
	$(call COMPILE_PROJECT,,$(B_MAIN_OBJ) $(N_B_DBG),$(P_B_DBG))
	@if [ -f $(P_B_DBG) ]; then \
		echo "✅ $(P_B_DBG) linked"; \
	else \
		echo "⚠️ Failed to build $(P_B_DBG)"; \
	fi

$(P_B_GDB):
	$(call COMPILE_PROJECT,$(GDBFLAGS),$(B_MAIN_OBJ) $(N_B_GDB),$(P_B_GDB))
	@if [ -f $(P_B_GDB) ]; then \
		echo "✅ $(P_B_GDB) linked"; \
	else \
		echo "⚠️ Failed to build $(P_B_GDB)"; \
	fi

#------------------------------------------------#
#   NORMINETTE & LEAKS                           #
#------------------------------------------------#

norm:
	@if $(NORM) $(INCL_DIR) $(SRC_DIR) 2>/dev/null; then \
		exit 0; \
	else \
		exit 1; \
	fi

norm_bonus:
	@if $(NORM) $(B_INCL_DIR) $(B_SRC_DIR) 2>/dev/null; then \
		exit 0; \
	else \
		exit 1; \
	fi

norm_libft:
	@if $(NORM) $(L_INCL_DIR) $(L_SRC_DIR) 2>/dev/null; then \
		exit 0; \
	else \
		exit 1; \
	fi

norm_banner:
	@if $(NORM) $(BAN_INCL_DIR) $(BAN_SRC_DIR) 2>/dev/null; then \
		exit 0; \
	else \
		exit 1; \
	fi

norm_all: norm norm_bonus norm_libft norm_banner

leaks: $(PROJECT)
	@valgrind --leak-check=full --show-leak-kinds=all ./$(PROJECT) || true

leaks_bonus: $(P_BONUS)
	@valgrind --leak-check=full --show-leak-kinds=all ./$(P_BONUS) || true

leaks_rigor: $(P_RIGOR)
	@valgrind --leak-check=full --show-leak-kinds=all ./$(P_RIGOR) || true

leaks_rigor_bonus: $(P_B_RIGOR)
	@valgrind --leak-check=full --show-leak-kinds=all ./$(P_B_RIGOR) || true

leaks_dbg: $(P_DBG)
	@valgrind --leak-check=full --show-leak-kinds=all ./$(P_DBG) || true

leaks_dbg_bonus: $(P_B_DBG)
	@valgrind --leak-check=full --show-leak-kinds=all ./$(P_B_DBG) || true

# Dinamic version of .PHONY
#
#.PHONY: $(filter-out $(NAME) $(PROJECT) bonus_$(PROJECT), $(MAKECMDGOALS))
