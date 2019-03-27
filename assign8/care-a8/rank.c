#include <stdlib.h>
#include <stdio.h>

// struct to keep grade correlated with initial position
struct Grade {
        int initialPosition;
        float grade;
    };

// compare function, descending order
int compare(const void *p, const void *q) { 
    float l = ((struct Grade *)p)->grade; 
    float r = ((struct Grade *)q)->grade;  
    return (l < r) - (l > r); 
} 

void compute_ranks(float *F, int N, int *R, float *avg, float *passing_avg, int *num_passed) {
    int i, j;
    int Tnum_passed = 0;        // Remove memory aliasing
    int Tavg = 0.0;
    int Tpassing_avg = 0.0;

    // init grades struct
    struct Grade grades[N];
    for (i = 0; i < N; i++) {
        grades[i].grade = F[i];
        grades[i].initialPosition = i;
    }

    // sort grades
    qsort(grades, N, sizeof(struct Grade), compare);

    // compute ranks
    for (i = 0; i < N; i++)
    {
        int position = grades[i].initialPosition;
        R[position] = i + 1;
    }

    // compute averages
    for (i = 0; i < N; i++) {
        Tavg += F[i];
        if (F[i] >= 50.0) {
            Tpassing_avg += F[i];
            Tnum_passed += 1;
        }
    }

    // check for div by 0
    if (N > 0) Tavg /= N;
    if (num_passed) Tpassing_avg /= Tnum_passed;

    *num_passed = Tnum_passed;  // Assign original pointers
    *avg = Tavg;
    *passing_avg = Tpassing_avg;

} // compute_ranks

