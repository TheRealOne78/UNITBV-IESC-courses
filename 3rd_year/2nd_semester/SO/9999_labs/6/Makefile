CC = clang
CFLAGS = -Wall -Wextra -std=c11

SRC_DIR = src
BIN_DIR = bin

.PHONY: all run_ex1a run_ex1b run_ex2a run_ex2b run_ex3 run_ex4 run_ex5 clean

all: $(BIN_DIR)/ex1a_matrix $(BIN_DIR)/ex1b_fractal $(BIN_DIR)/ex2a_linked_list $(BIN_DIR)/ex2b_student_list

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BIN_DIR)/ex1a_matrix: $(SRC_DIR)/ex1a_matrix.c | $(BIN_DIR)
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/ex1b_fractal: $(SRC_DIR)/ex1b_fractal.c | $(BIN_DIR)
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/ex2a_linked_list: $(SRC_DIR)/ex2a_linked_list.c | $(BIN_DIR)
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/ex2b_student_list: $(SRC_DIR)/ex2b_student_list.c | $(BIN_DIR)
	$(CC) $(CFLAGS) $< -o $@

run_ex1a: $(BIN_DIR)/ex1a_matrix
	printf "2\n3\n1\n2\n3\n4\n5\n6\n" | ./$(BIN_DIR)/ex1a_matrix

run_ex1b: $(BIN_DIR)/ex1b_fractal
	printf "9\n" | ./$(BIN_DIR)/ex1b_fractal

run_ex2a: $(BIN_DIR)/ex2a_linked_list
	./$(BIN_DIR)/ex2a_linked_list

run_ex2b: $(BIN_DIR)/ex2b_student_list
	./$(BIN_DIR)/ex2b_student_list

run_ex3:
	sh $(SRC_DIR)/ex3_page_faults.sh

run_ex4:
	sh $(SRC_DIR)/ex4_memory_fit.sh

run_ex5:
	sh $(SRC_DIR)/ex5_inode_calc.sh

clean:
	rm -rf $(BIN_DIR)
