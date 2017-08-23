package com.belong.test;

import java.util.Arrays;

import org.junit.jupiter.api.function.ThrowingSupplier;

import com.sun.org.apache.bcel.internal.generic.SWAP;

/**
 * @Description: <p>大顶堆排序测试</p>
 * @Author : belong
 * @Date : 2017年8月22日
 */
public class HeapSortTest {
	private static int [] data = {4,6,5,4,6,7,567,6,87,564,6,45,645};
	public static void main(String[] args) {
		heapSort(data);
	}
	
	/**
	 * 堆排序的排序过程
	 * @param data 要排序的数组
	 */
	public static void heapSort(int [] data) {
		// 1.对数组中的元素进行循环创建大顶堆
		for(int i = 0; i < data.length - 1; i++) { // 最有一个元素就不需要在建堆了因为已经是有序的了
			// 从最后一个元素开始建堆，并且每次建完之后大的都在后边，所以后面的就不需要在建了
			buildHeap(data.length - 1 - i); 
			// 没建完一个大顶堆就把顶放到数组的后边，开始排序
			swap(0, data.length - 1 - i);
			System.out.println(Arrays.toString(data));
		}
	}

	/**
	 * 堆排序的建堆过程
	 * @param maxIndex 从最后一个索引开始，也就是最后一个元素
	 */
	private static void buildHeap(int lastIndex) {
		// 1、循环建堆,从后往前建
		// 二叉树的叶子节点与其父节点的索引关系是 2*父节点索引+1=叶子结点
		// 从最后一个非叶子结点开始建大顶堆 sonNode = curNode * 2 + 1
		for (int i = (lastIndex - 1) / 2; i >= 0; i--) {
			// 2、定义一个当前节点用于循环建堆
			int curNode = i;
			int left = curNode * 2 + 1; // 左结点
			int right = curNode * 2 + 2; // 右结点
			int maxNode = left; // 用于保存左右子树中较大的结点
			while (left <= lastIndex) { // 看当前节点的左叶子结点是否存在，如果存在来判断右子节点是否存在
				if (right <= lastIndex) { // 判断右子节点是否存在,防止下标越界
					// 比较左右子结点的大小
					if (data[left] < data[right]) {
						maxNode++; // 也就是右子结点是较大的值
					}
				}
				if (data[curNode] < data[maxNode]) { // 比较子结点中最大的和当前结点进行比较
					swap(curNode, maxNode);
					curNode = maxNode; // 当前节点换成最大的节点
				} else { // 如果子节点没有父节点大就不需要交换了
					break;
				}
			}
		}
	}

	/**
	 * 负责交换两节点的数据
	 * 
	 * @param curNode
	 * @param maxNode
	 */
	private static void swap(int curNode, int maxNode) {
		int tmp = data[curNode];
		data[curNode] = data[maxNode];
		data[maxNode] = tmp;
	}
}
