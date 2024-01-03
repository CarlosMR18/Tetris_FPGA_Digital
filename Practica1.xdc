# Clock @ 125 MHz
set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { clk }];

# Buttons
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { reset }];

# 7 segments - SEGMENTS
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { segmentos[6] }]; # a
set_property -dict { PACKAGE_PIN U10   IOSTANDARD LVCMOS33 } [get_ports { segmentos[5] }]; # b
set_property -dict { PACKAGE_PIN Y12   IOSTANDARD LVCMOS33 } [get_ports { segmentos[4] }]; # c
set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { segmentos[3] }]; # d
set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { segmentos[2] }]; # e
set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { segmentos[1] }]; # f
set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { segmentos[0] }]; # g

# 7 segments - SELECTOR
set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports { selector[3] }]; # 0
set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { selector[2] }]; # 1
set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports { selector[1] }]; # 2
set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { selector[0] }]; # 3
