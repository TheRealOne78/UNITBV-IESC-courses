VERILATOR ?= verilator
GTKWAVE ?= gtkwave
CXX ?= g++

MAIN_TOP := tb
MAIN_OBJ := obj_dir/main
MAIN_BIN := $(MAIN_OBJ)/V$(MAIN_TOP)

CTRL_TOP := adxl345_controller_tb
CTRL_OBJ := obj_dir/controller
CTRL_BIN := $(CTRL_OBJ)/V$(CTRL_TOP)

DISPLAY_TOP := display_tb
DISPLAY_OBJ := obj_dir/display
DISPLAY_BIN := $(DISPLAY_OBJ)/V$(DISPLAY_TOP)

RTL_COMMON := \
	rtl/seven_segment.sv \
	rtl/display_map.sv \
	rtl/position_ctrl.sv \
	rtl/adxl345_controller.sv \
	rtl/spi_phy.sv

SIM_MAIN := \
	sim/dut.sv \
	sim/tb.sv

SIM_CONTROLLER := \
	sim/subsystems/adxl345_controller_dut.sv \
	sim/subsystems/adxl345_controller_tb.sv

SIM_DISPLAY := \
	sim/subsystems/display_dut.sv \
	sim/subsystems/display_tb.sv

.PHONY: all build run waves build-controller run-controller build-display run-display lint clean

all: run

build:
	mkdir -p $(MAIN_OBJ)
	$(VERILATOR) --binary -sv --trace --top-module $(MAIN_TOP) --Mdir $(MAIN_OBJ) \
		-MAKEFLAGS "CXX=$(CXX)" \
		$(RTL_COMMON) $(SIM_MAIN)

run: build
	./$(MAIN_BIN)

waves: run
	$(GTKWAVE) wave.vcd

build-controller:
	mkdir -p $(CTRL_OBJ)
	$(VERILATOR) --binary -sv --trace --top-module $(CTRL_TOP) --Mdir $(CTRL_OBJ) \
		-MAKEFLAGS "CXX=$(CXX)" \
		rtl/adxl345_controller.sv $(SIM_CONTROLLER)

run-controller: build-controller
	./$(CTRL_BIN)

build-display:
	mkdir -p $(DISPLAY_OBJ)
	$(VERILATOR) --binary -sv --trace --top-module $(DISPLAY_TOP) --Mdir $(DISPLAY_OBJ) \
		-MAKEFLAGS "CXX=$(CXX)" \
		rtl/seven_segment.sv rtl/display_map.sv rtl/position_ctrl.sv $(SIM_DISPLAY)

run-display: build-display
	./$(DISPLAY_BIN)

lint:
	$(VERILATOR) --lint-only -sv -Wno-WIDTHEXPAND --top-module $(MAIN_TOP) \
		rtl/DE10_LITE_Golden_Top.sv rtl/seven_segment.sv rtl/display_map.sv \
		rtl/position_ctrl.sv rtl/adxl345_controller.sv \
		rtl/spi_phy.sv ip/alt_pll_bb.v $(SIM_MAIN)
	$(VERILATOR) --lint-only -sv --top-module $(CTRL_TOP) \
		rtl/adxl345_controller.sv $(SIM_CONTROLLER)
	$(VERILATOR) --lint-only -sv --top-module $(DISPLAY_TOP) \
		rtl/seven_segment.sv rtl/display_map.sv rtl/position_ctrl.sv $(SIM_DISPLAY)

clean:
	rm -rf obj_dir wave.vcd display_wave.vcd adxl345_controller_wave.vcd *.vcd *.fst
