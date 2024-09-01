# Division-by-restoring-in-verilog
# Project Details
"4 bit Division by Restoring"
Coding language: Verilog

# Problem Description
The division by restoring algorithm is a fundamental technique for integer division. It iteratively subtracts the divisor from the dividend and checks the resulting sign. If the result is negative, the divisor is added back to restore the original value before proceeding to the next bit. This process gradually constructs the quotient bit by bit.

# Algorithm

The code consists of multiple modules. The primary module is structured into two essential components: the Datapath and the Controlpath. The Datapath defines the hardware requirements for implementation, while the Controlpath delineates the data flow and control signals within the hardware.
