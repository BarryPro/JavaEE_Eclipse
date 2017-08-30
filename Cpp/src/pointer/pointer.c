#include "pointer.h"

/**
 * 指针测试
 */
int pointerTest(void){
	char* str = "ABCDEFGHIJK";
	int* pt = (int*)str;
	printf("%c\n%s\n",*(str+1),(char*)(pt+2));
	printf(str);
	printf("\n");
	printf(pt);
	printf("\n测试指针类型的大小\n");
	printf("char*:%d\n",sizeof(str));
	printf("int*:%d\n",sizeof(pt));
	return 0;
}

/*
 * 求最小值
 * 返回值是int类型，返回两个整数中较小的一个
 */
int min(int a, int b) {
    return a < b ? a : b;
}

/*
 * 求最大值
 * 返回值是int类型，返回两个整数中较大的一个
 */
int max(int a, int b) {
    return a > b ? a : b;
}

/**
 * 函数指针测试类具体实现
 */
int funPointerTest()
{
    printf("------------------------------ Start\n");
    int (*f)(int, int); // 声明函数指针，指向返回值类型为int，有两个参数类型都是int的函数
    f = max; // 函数指针f指向求最大值的函数max
    int c = (*f)(1, 2);
    printf("The max value is %d \n", c);
    f = min; // 函数指针f指向求最小值的函数min
    c = (*f)(1, 2);
    printf("The min value is %d \n", c);
    printf("------------------------------ End\n");
    getchar();
    return 0;
}

int pointerFunTest()
{
    printf("------------------------------ Start\n");
    int *p1 = NULL;
    printf("The memeory address of p1 = 0x%x \n", p1);
    p1 = f(1, 2);
    printf("The memeory address of p1 = 0x%x \n", p1);
    printf("*p1 = %d \n", *p1);
    printf("------------------------------ End\n");
    getchar();
    return 0;
}

/*
 * 指针函数的定义
 * 返回值是指针类型int *
 */
int *f(int a, int b) {
    int *p = (int *)malloc(sizeof(int));
    printf("The memeory address of p = 0x%x \n", p);
    memset(p, 0, sizeof(int));
    *p = a + b;
    printf("*p = %d \n", *p);
    return p;
}
