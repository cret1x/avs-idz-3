#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>


#define PRECISION_LOOP 20
#define TIME_LOOP 10000000


long long fact(long n) {
	long long ret = 1;
	while (n > 0) {
		ret *= n;
		n--;
	}
	return ret;
}


double do_task(double number) {
	double ret = 0;
	for (int i = 0; i < PRECISION_LOOP; i+=2) {
		double up = pow(number, i);
		long long down = fact(i);
		ret += up / (double) down;
	}
	return ret;
}


double read_double_from_file(FILE *f) {
	double ret;
	fscanf(f, "%lf", &ret);
	return ret;
}

long get_rand_value(long lower, long upper) {
	return (rand() % (upper - lower)) + lower;
}

int main(int argc, char const *argv[])
{
	srand(time(NULL));
	clock_t start_read, end_read, start_calc, end_calc, start_write, end_write;
	if (argc < 2) {
		printf("Invalid args count\n");
		return 0;
	}
	if (strcmp(argv[1], "-f") == 0) {
		if (argc != 4) {
			printf("Invalid args count\n");
			return 0;
		}
		FILE* double_file = fopen(argv[2], "r");
		FILE* out_file = fopen(argv[3], "w");
		if (double_file == NULL || out_file == NULL) {
			printf("Error opening the files\n");
			return 0;
		}
		start_read = clock();
		double x_value = read_double_from_file(double_file);
		end_read = clock() - start_read;
		start_calc = clock();
		double ch_value;
		for (int i = 0; i < TIME_LOOP; i++)
			ch_value = do_task(x_value);
		end_calc = clock() - start_calc;
		start_write = clock();
		fprintf(out_file, "%f\n", ch_value);
		end_write = clock() - start_write;
		
		fclose(double_file);
		fclose(out_file);
		double time_read = ((double)end_read)/CLOCKS_PER_SEC;
		double time_calc = ((double)end_calc)/CLOCKS_PER_SEC;
		double time_write = ((double)end_write)/CLOCKS_PER_SEC;
		printf("Elapsed time:\n");
		printf("Read:\t\t%f\n", time_read);
		printf("Calculations:\t%f\n", time_calc);
		printf("Write:\t\t%f\n", time_write);

	} else if (strcmp(argv[1], "-r") == 0) {
		if (argc != 4) {
			printf("Invalid args count\n");
			return 0;
		}
		long n1 = atol(argv[2]);
		long n2 = atol(argv[3]);
		double x_value = (double) get_rand_value(n1, n2);
		double ch_value = do_task(x_value);
		printf("Generated x value: %f\n", x_value);
		printf("Value of ch(x): %f\n", ch_value);
 	} else {
		printf("Invalid flag\n");
	}
	return 0;
}