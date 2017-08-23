#include<stdio.h>

/**
 * 指针测试
 */
int main(void){
	char* str = "ABCDEFGHIJK";
	int* pt = (int*)str;
	printf("%c\n%c\n",*(str+1),(char*)(pt+2));
	printf(str);
	printf("\n");
	printf(pt);
	printf("\n测试指针类型的大小\n");
	printf("char*:%d\n",sizeof(str));
	printf("int*:%d\n",sizeof(pt));
	return 0;
}
