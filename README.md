# CDA3331C
My Course Assignments for Intro to Microprocessor Systems at Florida Atlantic University

16-bit microprocessor used: Texas Instrument's MSP4300G2553



Lab 1: Wrote an MSP430 assembly program that adds the content of Registers R4, R5, and R6 to register R7 then subtract the content of R10 from R7.  Once calculation is done all values of above mentioned registers must be saved in memory starting at memory address 0x0200.  Use these register values: R4 = 14, R5 = 15, R6 = 16, R10 = 10.


Lab 2: Wrote an MSP430 assembly language program where SORT1 sets the parameters for R4/R5/R6, which are used by the COPY and SORT subroutines to copy and sort array ARY1. ARY1 and ARY2 are the original un-altered arrays, while ARY1S and ARY2S are altered. R4 holds the starting address of the array. R5 holds the length of the array. R6 holds the starting location of the sorted array. The COPY subroutine copies the contents of array ARY1 into ARY1S. SORT subroutine sorts the elements on ARY1S in place. SORT2 is similar to SORT1 using same registers. An outline was provided.


Lab 3: Wrote an MSP430 assembly language program to calculate the following arithmetic function:
<img width="328" alt="Screenshot 2023-04-17 at 6 37 42 PM" src="https://user-images.githubusercontent.com/112228115/232625304-1cb52223-fddc-4654-bb3e-f9e809f8c340.png">
The value of "a" is stored in register R4 as 5. The value of "X" is stored in R5. The value of "F" is stored in R7. An outline was provided.


Lab 4: Wrote a program in C and assembled a breadboard to create a 3-bit lighting pattern. A total of 6 switches controlled the output of 8 LED's on the breadboard. The first 3 switches would change the direction that lights activated and deactivated, as well as the speed that the light pattern rotated. The next 3 switches determined if the first, second, or third light in the pattern would be activated or deactivated. An outline was provided.
https://user-images.githubusercontent.com/112228115/232627692-7eaa20eb-f142-473f-ac87-a16f273979be.mov


Lab 5: Wrote a program in C and assembled a breadboard to create a counter that displays numbers from 00-99. Different combinations of 3 switches determine the operation of the counter as explained below. Skeleton code was provided.
  Modified code so that the counter initial number setup goes as follows.
•  SW-321 = 000: Counter resets to 00
•  SW-321 = 100: Right digit cycles 0-9
•  SW-321 = 010: Left digit cycles 0-9
•  SW-321 = 110: Right and left digits both hold values (preset value)
•  SW-321 = 111: Counter cycles down from the preset value to 10, and repeats
•  SW-321 = 101: Recall the preset value
•  SW-321 = 011: Recall the preset value
•  SW-321 = 100: Counter cycles up from the preset value to 90, and repeats
https://user-images.githubusercontent.com/112228115/235547017-c0bb6cee-4203-4909-926c-5c12997a8a73.mov




Lab 6: Will be completed by 05/01
