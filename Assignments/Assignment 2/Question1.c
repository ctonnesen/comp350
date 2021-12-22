#include<stdio.h>
#include<math.h>

float single_precision(){
    int smallest = -1;
    float x = 1;
    while (smallest == -1) {
        float divison = 1/x;
        float result = divison * x;
        if (result != 1) {
            return x;
        }
        x++;
    }
}

float double_precision(){
    int smallest = -1;
    double x = 1;
    while (smallest == -1) {
        double divison = 1/x;
        double result = divison * x;
        if (result != 1) {
            return x;
        }
        x++;
    }
}

void main(){
    printf("%f \n", single_precision());
    printf("%f", double_precision());
}





