This repo contains codes for digital design and implementation on FPGA, from basic to complex.
*Designs are described in VHDL and simulated in Modelsim 
(except for FPGA and SoPC)*

- [Simple combinational and sequential circuits](/Simple%20combinational%20and%20sequential%20circuits)
  + Full Adder
  + Ripple Carry Adder
  + 3-way Multiplexer
  + 8-bit Register
  + Counter
- [FIR filter RT level design](/FIR%20filter%20RTL%20design)
  
  A finite impulse response (FIR) filter is a type of a digital filter. It is “finite” because its response to an impulse ultimately settles to zero. 
  This is in contrast to infinite impulse response filters which have internal feedback and may continue to respond indefinitely.
  
- [FIR filter Control Unit design](/FIR%20filter%20Control%20Unit%20design)

  VHDL description of the Control Unit of the FIR filter, alternative implementation (with resource constraints of two adders and two multipliers).

- [FPGA implementation of FIR filter](/FPGA%20implementation)

  Altera’s Quartus is used to implement a FIR filter design on a Cyclone II FPGA target. FIR filter is redesigned with pipeline registers to meet 10ns clock constraint.

- [SoPC design: FIR filter routine accelerator](SoPC%20design%20-%20accelerate%20FIR%20filter%20routine)

  Altera’s Quartus SOPC builder is used to implement a NIOS-II processor based System-on-Programmable Chip Design on a Cyclone II FPGA target. 
  Firstly, FIR filter software routine is tested then the NIOS-II instruction set is modified by adding a custom instruction that relies on a 
  VHDL description of a new hardware block to add to the processor datapath.

- [SoPC design: FIR hardware accelerator integration with Avalon bus](/SoPC%20design%20-%20FIR%20hardware%20accelerator%20as%20Avalon%20bus%20slave)

  Time taken to execute a FIR filter function is compared in software (in previous section) with a specific hardware implementation. 
  FIR filter described in VHDL is integrated as a slave in the NIOS-II Avalon bus communication infrastructure
