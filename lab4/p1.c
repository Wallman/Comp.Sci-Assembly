
int proc2(int, int);
#include <stdio.h>


void proc1(char *s, int *a, int *b) {
    int v;
    int t;

    t = *a;
    v = proc2(*a, *b);	// v = a*b - 12

    sprintf(s, "The product of %d and %d is %d.", *a, *b, v);

    *a = *b - 2;
    *b = t;

    return;
}

