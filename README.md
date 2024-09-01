# Division-by-restoring-in-verilog
# Project Details
"4 bit Division by Restoring"
Coding language: Verilog

# Problem Description
The division by restoring algorithm is a fundamental technique for integer division. It iteratively subtracts the divisor from the dividend and checks the resulting sign. If the result is negative, the divisor is added back to restore the original value before proceeding to the next bit. This process gradually constructs the quotient bit by bit.

# Algorithm

![image](https://github.com/user-attachments/assets/d7e4bcb3-0ab5-4f3f-950c-3f2b04ebacc5)

The code consists of multiple modules. The primary module is structured into two essential components: the Datapath and the Controlpath. The Datapath defines the hardware requirements for implementation, while the Controlpath delineates the data flow and control signals within the hardware.

##Datapath
![image](https://github.com/user-attachments/assets/cd566aad-c6ed-4d15-910b-b3729e7187d4)

##Controlpath
![Uploading image.png…]()

#Result
![image](https://github.com/user-attachments/assets/5ee3d182-b8c6-430e-a685-775b2a597909)


