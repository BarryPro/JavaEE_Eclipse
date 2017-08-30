#include "algorithms.h"
/*
 * BitMap.cpp
 *  位图算法
 *  Created on: 2017年8月24日
 *      Author: belong
 */
/*
 * BitMap.cpp
 *  位图算法
 *  Created on: 2017年8月24日
 *      Author: belong
 */
int Kadane(const int array[], size_t length, unsigned int& left, unsigned int& right)
{
    unsigned int i, cur_left, cur_right;
    int cur_max, max;

    cur_max = max = left = right = cur_left = cur_right = 0;

    for(i = 0; i < length; ++i)
    {
        cur_max += array[i];

        if(cur_max > 0)
        {
            cur_right = i;

            if(max < cur_max)
            {
                max = cur_max;
                left = cur_left;
                right = cur_right;
            }
        }
        else
        {
            cur_max = 0;
            cur_left = cur_right = i + 1;
        }
    }

    return max;
}
