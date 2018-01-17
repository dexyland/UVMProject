if [file exists "work"] {vdel -all}
vlib work

# Comment out either the SystemVerilog or VHDL DUT.
# There can be only one!

#VHDL DUT
vcom -f dut.f

vlog -f tb.f
vopt top -o top_optimized  +acc +cover=sbfec+adder(rtl).
vsim top_optimized -coverage -classdebug -uvmcontrol=all
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
quit
