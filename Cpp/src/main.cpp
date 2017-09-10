//#include <bitmap.h>
//#include "pointer.h"
//#include "algorithms.h"
//#include "list.h"
#include<iostream>
using namespace std;

/*
 * main.c
 *
 *  Created on: 2017年8月23日
 *      Author: belong
 */

int main(int args, char* argv[]) {
//	LinkList head;
//	Info val1, val2, val3, val4;
//	val1.id = 1, val1.name = "Kevin", val2.id = 2, val2.name = "Cathy", val3.id =
//			3, val3.name = "Lucy", val4.id = 4, val4.name = "Gravin";
//
//	//测试插入功能
//	cout << "Insert test:" << endl;
//	head.InsertHead(val1);
//	head.Print();
//	head.Insert(val2, 1);
//	head.Print();
//	head.Insert(val3, 4);
//	head.Print();
//	head.InsertHead(val3);
//	head.Insert(val4, 2);
//	head.Print();
//
//	//测试反序功能
//	cout << "reverse test:" << endl;
//	head.Reverse();
//	cout << "reversed linklist is:" << endl;
//	head.Print();
//
//	//测试删除功能
//	cout << "remove test:" << endl;
//	cout << "the length of linklist is:" << endl;
//	cout << head.Length() << endl;
//	head.Remove(val4);
//	head.Print();
//	cout << "the length of linklist is:" << endl;
//	cout << head.Length() << endl;
//	head.Remove(val4);
//	head.Print();
	  int n[][2]={20,40,60,80};
	    int (*p)[2];
	    p=n;
	    cout<<p[0][0]<<","<<*(p[0]+1)<<endl;
	return 0;
}

