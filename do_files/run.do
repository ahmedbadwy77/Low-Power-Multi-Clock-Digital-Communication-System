if [file exists work] {
    vdel -all
}
vlib work

vlog -reportprogress 300 +acc -sv ../rtl/*/*.*v

vlog -reportprogress 300 +acc \
    ../Test_bench/SYSTEM_TOP_tb.v

vsim -voptargs="+acc" work.SYSTEM_TOP_tb

run -all
