

#include <msp430.h> 

void LED(); //led function read/write, rotation, and speed.

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;    //Stop watch dog timer then call LED function
    LED();
}


void LED()
{
        int R5_SW = 0, R6_LED = 0;

        P1OUT = 0b00000000;
        P1DIR = 0b11111111;
        P2DIR = 0b00000000;

        while (1) {

            R5_SW = P2IN;

            if(R5_SW & BIT0)   //checking P2.0 for read mode. 1 = read mode, 0 = one of the rotation modes in else if statements
            {
                R6_LED = R5_SW & (BIT3 | BIT4 | BIT5);

                P1OUT = R6_LED; // display the pattern


            }   else if (R5_SW & BIT1){ // First display rotation mode

                R6_LED &= 0xFF;
                R6_LED = (R6_LED >> 1) | (R6_LED << 7);

                P1OUT = R6_LED;

                if(R5_SW & BIT2) { // speed from pin 3

                    __delay_cycles(400000);

                } else {
                    __delay_cycles(100000);
                }


            }   else {    // Second display rotation mode

                R6_LED &= 0xFF;
                R6_LED = (R6_LED << 1) | (R6_LED >> 7);

                P1OUT = R6_LED; // display the pattern

                if(R5_SW & BIT2) {  // speed from pin 3

                    __delay_cycles(400000);

                } else {
                    __delay_cycles(100000);
                }

                }
        }
}
