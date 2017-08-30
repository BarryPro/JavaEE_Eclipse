#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <iterator>

#define SHIFT 5
#define MAXLINE 32
#define MASK 0x1F

using namespace std;
/*
 * algorithms.h
 *
 *  Created on: 2017年8月24日
 *      Author: belong
 */

int Kadane(const int array[], size_t length, unsigned int& left, unsigned int& right);


