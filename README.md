Save all files in the same directory. Then, open the project with Vivado and follow these steps:

1- In "Flow Navigator", select Open Block Design.
2- In the "Tcl Console", enter the instructions provided in the instruction set.
3- In "Flow Navigator":
   · Select "Generate Bitstream" (note that this process may take some time). 
   · The bitstream will be generated in: vivado_ip_prj\vivado_prj.runs\impl_1\system_top_wrapper.bit.
4- Select "Open Target" and click on "Auto Connect".
5- Click on "Program Device", and choose the previously generated bitstream.

After this simple procedure, the FPGA will be programmed including the connection to the external ADC and DAC modules.
