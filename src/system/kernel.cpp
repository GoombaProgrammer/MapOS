/*
    MKERNEL SOURCE FILE FROM MAP OPERATING SYSTEM
    AUTHOR: KAP PETROV
    DESCRIPTION: MKERNEL SOURCE CODE FROM MAP OPERATING SYSTEM
*/

#include "../../include/kernel.h"

extern "C" void main()
{
    int* ptr = (int*) 0xb8000;
    *ptr = 0x50505050;
    return;
}