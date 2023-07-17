#include "inc.h"
#include <stdio.h>

int foo(double arg1, int arg2)
{
    printf("arg1: %lf, arg2: %d\n", arg1, arg2);
    return arg2;
}