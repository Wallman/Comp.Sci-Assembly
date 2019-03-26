
void compute_ranks(float *F, int N, int *R, float *avg, float *passing_avg, int *num_passed) {
    int i, j;
    int Tnum_passed = 0;
    int Tavg = 0.0;
    int Tpassing_avg = 0.0;

    // init ranks
    for (i = 0; i < N; i++) {
        R[i] = 1;
    }

    // compute ranks
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            if (F[i] < F[j]) {
                R[i] += 1;
            }
        }
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

    *num_passed = Tnum_passed;
    *avg = Tavg;
    *passing_avg = Tpassing_avg;

} // compute_ranks

