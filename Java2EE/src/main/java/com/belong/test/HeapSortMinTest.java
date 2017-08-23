package com.belong.test;

import java.util.Arrays;

import com.sun.org.apache.bcel.internal.generic.SWAP;

/**
 * @Description: <p>小顶堆排序</p>
 * @Author : belong
 * @Date : 2017年8月22日
 */
public class HeapSortMinTest {
	private static int [] data = {4,5,120,6,12,67,35,6,3763,6,36};
	
	public static void main(String[] args) {
		heapSortMin();
	}
	
	public static void heapSortMin() {
		for(int i = 0;i<data.length-1;i++) {
			buildHeap(data.length - 1 - i);
			swap(0, data.length-1-i);
		}
		System.out.println(Arrays.toString(data));
	}

	private static void buildHeap(int lastIndex) {
		// 从非叶子节点的节点开始循环建堆
		for(int i = (lastIndex - 1) / 2 ;i >= 0; i--) {
			int curNode = i;
			int left = i * 2 + 1;
			int right = i * 2 + 2;
			int minIndex = left; // 最小的节点初始值是左子树
			while(left <= lastIndex) { // 循环交换当前节点中最小的节点，左子树不能超过数组最大值
				if(right <= lastIndex) { // 如果右子树存在
					if(data[left] > data[right]) {
						minIndex++;
					}
				}
				if(data[curNode] > data[minIndex]) {
					swap(curNode,minIndex);
					curNode = minIndex;
				} else {
					break;
				}
			}
		}
	}

	private static void swap(int curNode, int minIndex) {
		int tmp = data[curNode];
		data[curNode] = data[minIndex];
		data[minIndex] = tmp;		
	}
}
