#include<stdio.h>
#include<math.h>



// at i=28, first_sqrt = 1 by rounding, meaning second_sqrt will equal 0

double original_formula() {
    double previous = 2*sqrt(2);
    for (int i = 2; i < 35; i++){
        double internal_sq = pow(previous/pow(2,i),2);
        double first_sqrt = sqrt(1-internal_sq);
        double second_sqrt = sqrt(2*(1-first_sqrt));
        double last_calc = pow(2,i) * second_sqrt;
        previous = last_calc;
        // int current = i+1;
        // printf("i = %i, an = %f \n", current, previous);
    }
    return previous;
}

double better_formula() {
    double previous = 2*sqrt(2);
    for (int i = 2; i < 35; i++) {
        double top = 2*pow(previous/pow(2,i),2);
        double bottom = 1 + sqrt(1-pow(previous/pow(2,i),2));
        double overall = pow(2,i)*sqrt(top/bottom);
        previous = overall;
        // int current = i+1;
        // printf("i = %i, an = %f \n", current, previous);
    }
    return previous;
}


void main(){
    printf("%f \n", original_formula());
    printf("%f \n", better_formula());
}