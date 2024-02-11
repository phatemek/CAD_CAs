	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/cnt2bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/cnt4bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataPath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mac.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mem.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg9.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg16.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg64.v	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/sreg16.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/topmodule.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/cntnbit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PE.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/cnt6bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Layer2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mem2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mem3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/sreg64.v

	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	