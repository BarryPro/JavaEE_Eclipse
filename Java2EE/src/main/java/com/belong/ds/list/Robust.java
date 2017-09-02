package com.belong.ds.list;

import com.belong.ds.list.LinkedList.Node;

/**
 * @Description:
 *               <p>
 *               单链表获取倒数第k个数，一次循环，时间复杂度O(n)
 *               </p>
 * @Author : belong
 * @Date : 2017年9月2日
 */
public class Robust {

	public static int findKthToTail(Node head,int k) {
		if (head == null || k == 0) {
			return -1;
		}
		Node cur = head; // 一直遍历的指针
		Node before = head; // 从第k-1个开始遍历，当cur遍历到末尾，before正好到达倒数第k个位置
		for (int i = 0; i < k - 1; i++) {
			if (cur != null) {
				cur = cur.next;
			} else {
				return -1;
			}
		}
		while (cur.next != null) {
			before = before.next;
			cur = cur.next;
		}
		return before.value;
	}

	public static void main(String[] args) {
		for (int i = 0; i < 6; i++) {
			LinkedList.insert(i);
		}
		System.out.println(LinkedList.show());
		System.out.println(findKthToTail(LinkedList.head, 2));
	}
}
