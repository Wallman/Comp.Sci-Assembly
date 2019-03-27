#include <stdlib.h>
#include <stdio.h>

// struct to keep grade correlated with initial position
struct Grade {
        unsigned int initialPosition;
        float grade;
    };

// compare function, descending order
int compare(const void *p, const void *q) { 
    float l = ((struct Grade *)p)->grade; 
    float r = ((struct Grade *)q)->grade;  
    return (l < r) - (l > r); 
} 

void compute_ranks(float *F, int N, int *R, float *avg, float *passing_avg, int *num_passed) {
    unsigned int i, j;
    unsigned int Tnum_passed = 0;        // Remove memory aliasing
    float Tavg = 0.0;
    float Tpassing_avg = 0.0;
    struct Grade grades[N];

    // combined loop instead of having multiple
    for (i = 0; i < N; i++) {
        // init grades struct
        grades[i].grade = F[i];
        grades[i].initialPosition = i;

        // compute averages
        Tavg += F[i];
        // replaced branching conditional for calculating passing_avg with OR statement.
        float tmpGrade = F[i];
        tmpGrade >= 50 || (tmpGrade = 0);
        Tpassing_avg += tmpGrade;
        Tnum_passed += (tmpGrade >= 50);
    }

    // sort grades
    qsort(grades, N, sizeof(struct Grade), compare);

    // compute ranks
    for (i = 0; i < N; i++) {
        int position = grades[i].initialPosition;
        R[position] = i + 1;
    }

    // check for div by 0
    if (N > 0) Tavg /= N;
    if (Tnum_passed) Tpassing_avg /= Tnum_passed;

    // Assign original pointers to correct values
    *num_passed = Tnum_passed;
    *avg = Tavg;
    *passing_avg = Tpassing_avg;

} // compute_ranks

