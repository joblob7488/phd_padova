set_property PACKAGE_PIN E3 [get_ports Clk]
set_property IOSTANDARD LVCMOS33 [get_ports Clk]
create_clock -period 10 -name sys_clk [get_ports Clk]

set_property PACKAGE_PIN A9 [get_ports Rx]
set_property IOSTANDARD LVCMOS33 [get_ports Rx]

#set_property PACKAGE_PIN D10 [get_ports uart_rxd_out]
#set_property IOSTANDARD LVCMOS33 [get_ports uart_rxd_out]

set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { led }]; #IO_L18N_T2_35 Sch=led0_b