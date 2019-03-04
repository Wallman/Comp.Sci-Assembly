

int lsearch_2(int *A, int n, int target) {

    //.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
    // Question 3(a):  Replace this code with the new algorithm 
    //.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
    int i;
    for (i = 0; i < n; i++) {
        if (A[i] == target) {
            return i;
        }
    }
    return -1;
    //.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
    
}  // lsearch_2


