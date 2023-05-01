//********
//******** Christofer Piedra Z23365973
//******** Skeleton Program for Lab 5
//******** Run this program as is to show you have correct hardware connections
//******** Explore the program and see the effect of Switches on pins P2.3-5
//******** Lab5 Grade --> Make the appropriate changes to build the desired effects of input switches

#include <msp430.h> 

//Digit configuration, make sure segments h-a are connected to PORT1 pins 7-0
//also besides digits 0-9, you have single segments abcdefg.
int LEDS[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67,0x01,0x02,04,0x08,0x10,0x20,0x40,0x80};

int switches=0;
int leftdigit=0,  rightdigit=0;
int pleftdigit=0, prightdigit=0;    //preset values
int flag=0;

int main(void)

{
    BCSCTL2 |= DIVS_2;              // DIVS_0; DIVS_1; DIVS_2; DIVS_3;
    WDTCTL = WDT_MDLY_0_5;          // WDT_MDLY_32; WDT_MDLY_8; WDT_MDLY_0_5;
    IE1 |= WDTIE;

    P1OUT = 0x00;           // Port 1 out default 00
    P1DIR = 0xFF;           // Port 1 all output
    P2DIR = 0x03;           // Port 2 all inputs, except BIT0 and BIT1

    __enable_interrupt();

for (;;)
{
  
  //  switches =  P2IN; //if wired as active high
  switches = ~P2IN; //if wired as active low

  // SW-321 = 000: left and right digits reset to 00
if (((switches & BIT5) != BIT5) && ((switches & BIT4) != BIT4) && ((switches & BIT3) != BIT3))
    {leftdigit=0; rightdigit=0; }

// SW-321 = 001: right digit counts up
    if (((switches & BIT5) != BIT5) && ((switches & BIT4) != BIT4) && ((switches & BIT3) == BIT3))
    {rightdigit++; if (rightdigit >=10) {rightdigit=0;} }

    // SW-321 = 010: left digit counts up
    if (((switches & BIT5) != BIT5) && ((switches & BIT4) == BIT4) && ((switches & BIT3) != BIT3))
    {leftdigit++ ; if (leftdigit >=10) {leftdigit=0;} }

    // SW-321 = 011: right and left digits both hold values (preset value)
    if (((switches & BIT5) != BIT5) && ((switches & BIT4) == BIT4) && ((switches & BIT3) == BIT3))
    {pleftdigit=leftdigit; prightdigit=rightdigit; }

    // SW-321 = 101: Display preset value
    if (((switches & BIT5) == BIT5) && ((switches & BIT4) != BIT4) && ((switches & BIT3) == BIT3))
    {
        leftdigit = pleftdigit;     // Left 7-seg is set to predetermined value
        rightdigit = prightdigit;   // Right 7-seg is set to predetermined value
    }
    // SW-321 = 110: Display preset value
    if (((switches & BIT5) == BIT5) && ((switches & BIT4) == BIT4) && ((switches & BIT3) != BIT3))
    // *** modify this section according to the lab manual requirement
    {
        leftdigit = pleftdigit;     // Left 7-seg is set to preset value
        rightdigit = prightdigit;   // Right 7-seg is set to preset value
    }

    // SW-321 = 100: Count up to 90
    if (((switches & BIT5) == BIT5) && ((switches & BIT4) != BIT4)&& ((switches & BIT3) != BIT3))
    // *** modify this section according to the lab manual requirement
    {

        if(leftdigit == 9)
        {
          leftdigit = pleftdigit;     // Left 7-seg is reset to preset to value
          rightdigit = prightdigit;   // Right 7-seg is reset to preset to value
        }
        else
        {
          if(rightdigit < 9)
            {
                rightdigit++;
            }
            else
            {
                rightdigit = 0;
                leftdigit++;
            }
        }
    }

    // SW-321 = 111: count down to 10

    if (((switches & BIT5) == BIT5) && ((switches & BIT4) == BIT4)&& ((switches & BIT3) == BIT3))
    // *** modify this section according to the lab manual requirement
    {
        if((leftdigit == 1 && rightdigit == 0) || (leftdigit == 0))
        {
            leftdigit = pleftdigit;     // Left 7-seg is set to predetermined value
            rightdigit = prightdigit;   // Right 7-seg is set to predetermined value
        }   else if(rightdigit != 0)
            {
                rightdigit--;   // Counts down 1's space
            }   else
            {
                rightdigit = 9;
                leftdigit--;    // Counts down 10's space
            }
    }

    // this delay determines the speed of changing the numbers being displayed
    // 500,000 microseconds for half a second, you can change it to 100,000 for example to make the numbers change 10 times faster
    // remember, this is the delay of the man loop, and it has no effect on the interrupt frequency
    __delay_cycles (100000);

} // end of for loop
} // end of main

// WDT interrupt service routine
#pragma vector=WDT_VECTOR
__interrupt void WDT(void){
    //This executes every time there is a timer interrupt from WDT
    //The frequency of this interrupt controls the flickering of display
    //The right and left digits are displayed alternatively
    //Note that both digits must be turned off to avoid aliasing

    //Display code for Common-Anode display
    P1OUT= 0; P2OUT=0;
    __delay_cycles (100);
    if (flag == 0) {P2OUT= BIT0; P1OUT= LEDS[leftdigit];  flag=1;}  // display left  digit and change flag to 1
    else           {P2OUT= BIT1; P1OUT= LEDS[rightdigit]; flag=0;} // display right digit and change flag to 0
    __delay_cycles (100);


    /*
    //Display code for Common-Cathode display
    P1OUT= 0xFF; P2OUT=0xFF;
    __delay_cycles (100);
    if (flag == 0) {P2OUT &= ~BIT0; P1OUT= ~LEDS[leftdigit];  flag=1;}
    else    {P2OUT &= ~BIT1; P1OUT= ~LEDS[rightdigit]; flag=0;}
    __delay_cycles (100);
    */
}
