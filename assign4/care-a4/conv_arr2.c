#include <stdio.h>

int min(int, int);
char conv(char *, char *, int);

void conv_arr(char *x, int n, char *h, int m, char *result){

	for(int i=0; i<(n+m-1); i++){
		int ladj = min(i+1, m);
		int radj = m - min(m+n-(i+1), m);
		result[i] = conv(x + (i+1-ladj), h + radj, ladj-radj);
	}

}
