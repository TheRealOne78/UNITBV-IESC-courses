CC = clang
CFLAGS = -Wall -Wextra -Isrc/fifo_popen

SRC_DIR = src
BIN_DIR = bin
FIFO_DIR = $(SRC_DIR)/fifo_popen
PROC_DIR = $(SRC_DIR)/ExProcese

# C Programs
EX6_SRCS = $(SRC_DIR)/ex-system.c $(SRC_DIR)/rd-popen.c $(SRC_DIR)/wr-popen.c
EX7_SRCS = $(PROC_DIR)/parinte.c $(PROC_DIR)/fiu1.c $(PROC_DIR)/fiu2.c
FIFO_SRCS = $(FIFO_DIR)/server.c $(FIFO_DIR)/client.c

C_BINS = $(BIN_DIR)/ex-system $(BIN_DIR)/rd-popen $(BIN_DIR)/wr-popen \
         $(BIN_DIR)/parinte $(BIN_DIR)/fiu1 $(BIN_DIR)/fiu2 \
         $(BIN_DIR)/fifo_popen/server $(BIN_DIR)/fifo_popen/client

# Shell Scripts
OPT1_SH = $(SRC_DIR)/generate_primes.sh
OPT2_SH = $(SRC_DIR)/merge_sort.sh
OPT3_SH = $(SRC_DIR)/calc_expression.sh
OPT4_SH = $(SRC_DIR)/shell_pipe.sh
OPT5_SH = $(SRC_DIR)/vector_sum.sh
OPT6_SH = $(SRC_DIR)/divide_sum.sh
OPT7_SH = $(SRC_DIR)/divide_gcd.sh

.PHONY: all clean compile_c ex6 ex7 opt1 opt2 opt3 opt4 opt5 opt6 opt7 fifo_server fifo_client

all: compile_c

compile_c: $(BIN_DIR) $(BIN_DIR)/fifo_popen $(C_BINS)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BIN_DIR)/fifo_popen:
	mkdir -p $(BIN_DIR)/fifo_popen

# Pattern rules
$(BIN_DIR)/%: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/%: $(PROC_DIR)/%.c
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/fifo_popen/%: $(FIFO_DIR)/%.c
	$(CC) $(CFLAGS) $< -o $@

# Exercise 6
ex6: $(BIN_DIR)/ex-system $(BIN_DIR)/rd-popen $(BIN_DIR)/wr-popen
	@echo "Rulare ex-system:"
	@echo "." | ./$(BIN_DIR)/ex-system
	@echo "\nRulare rd-popen:"
	@./$(BIN_DIR)/rd-popen | head -n 5
	@echo "\nRulare wr-popen:"
	@./$(BIN_DIR)/wr-popen

# Exercise 7
ex7: $(BIN_DIR)/parinte $(BIN_DIR)/fiu1 $(BIN_DIR)/fiu2
	@echo "Rulare parinte:"
	@cd $(BIN_DIR) && ./parinte

# FIFO/popen Server & Client
fifo_server: $(BIN_DIR)/fifo_popen/server
	@./$(BIN_DIR)/fifo_popen/server

fifo_client: $(BIN_DIR)/fifo_popen/client
	@./$(BIN_DIR)/fifo_popen/client

# Optional targets
opt1:
	@sh $(OPT1_SH) 20
opt2:
	@sh $(OPT2_SH) 38 27 43 3 9 82 10
opt3:
	@sh $(OPT3_SH) "3+4*2"
opt4:
	@sh $(OPT4_SH) "ls -l | grep src"
opt5:
	@echo "1 2 3" > vec1.txt && echo "4 5 6" > vec2.txt
	@sh $(OPT5_SH) vec1.txt vec2.txt
	@rm vec1.txt vec2.txt
opt6:
	@sh $(OPT6_SH) 1 2 3 4 5
opt7:
	@sh $(OPT7_SH) 12 18 24

clean:
	rm -rf $(BIN_DIR) text.gz request_fifo response_fifo
