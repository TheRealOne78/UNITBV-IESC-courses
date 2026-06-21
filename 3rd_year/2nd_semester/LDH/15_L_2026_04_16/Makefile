VERILATOR ?= verilator
QUARTUS_SH ?= quartus_sh
QUARTUS_PGM ?= quartus_pgm

PROJECT := SPI
TOP     := DE10_LITE_Golden_Top
SOF     := output_files/$(PROJECT).sof

RTL_SRCS := \
	rtl/DE10_LITE_Golden_Top.sv \
	rtl/adxl345_controller.sv \
	rtl/spi_phy.sv

IP_SRCS := \
	ip/alt_pll_bb.v

SRCS := $(RTL_SRCS) $(IP_SRCS)

.PHONY: all build lint quartus program clean clean-quartus

all: build

build: lint

lint:
	$(VERILATOR) --lint-only -sv -Wno-WIDTHEXPAND --top-module $(TOP) $(SRCS)

quartus:
	$(QUARTUS_SH) --flow compile $(PROJECT)

program:
	$(QUARTUS_PGM) -m JTAG -o "p;$(SOF)"

clean:
	rm -rf obj_dir logs *.vcd *.fst

clean-quartus:
	rm -rf db incremental_db output_files greybox_tmp .qsys_edit
