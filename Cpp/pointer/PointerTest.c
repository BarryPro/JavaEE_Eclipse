#include<stdio.h>

/**
 * ≤‚ ‘÷∏’Î
 */
int main(void){
	char* str = "ASFDJKFD";
	int* pt = (int*)str;
	printf("%c\n%c\n",*(str+1),(char*)(pt+1));
	printf(str);
	printf("\n");
	printf(pt);
	return 0;
}
