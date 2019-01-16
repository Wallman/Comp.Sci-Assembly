
#include <stdio.h>
#include <stdlib.h>

int mystery(char *, int);

char *str = "Good mood food.";

int main (int argc, char *argv[]){
    char *ptr;
    int n = strtol(argv[1], &ptr, 10);
    printf("The return value was:  %d.\n", mystery(str,n));
    return 0;
}
