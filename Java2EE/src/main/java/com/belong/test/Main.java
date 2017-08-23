package com.belong.test;

import java.util.Arrays;

public class Main {
	public static void main(String[] args) {
		int[] a = { 54, 4, 6, 67, 5, 7, 6, 456, 45654745, 34, 5654, 6 };
		mergeSort(a);
		System.out.println(Arrays.toString(a));
		System.out.println(barrySearch(a, 456));
	}

	private static void mergeSort(int[] a) {
		sort(a, 0, a.length - 1);
	}

	private static void sort(int[] a, int l, int r) {
		if (l < r) {
			int mid = (l + r) / 2;
			sort(a, l, mid);
			sort(a, mid + 1, r);
			merge(a, l, mid, r);
		}
	}

	private static void merge(int[] a, int l, int mid, int r) {
		int tmp[] = new int[a.length];
		int index = l;
		int lf = l;
		int rf = mid + 1;
		while (lf <= mid && rf <= r) {
			if (a[lf] < a[rf]) {
				tmp[index++] = a[lf++];
			} else {
				tmp[index++] = a[rf++];
			}
		}
		while (lf <= mid) {
			tmp[index++] = a[lf++];
		}
		while (rf <= r) {
			tmp[index++] = a[rf++];
		}
		while (l<=r) {
			a[l] = tmp[l++];
		}
	}

	private static int barrySearch(int[] a, int key) {
		int l = 0;
		int r = a.length - 1;
		int mid = (l + r) / 2;
		while (l <= r) {
			if (a[mid] < key) {
				l = mid++;
			} else if (a[mid] > key) {
				r = mid--;
			} else {
				return mid;
			}
		}
		return -1;
	}

}
