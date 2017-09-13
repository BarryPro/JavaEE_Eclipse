package com.belong.test;

import java.util.Arrays;

public class Main {
	public static void main(String[] args) {
		int[] a = { 343, 35, 46, 5, 52, 23, 5, 26, 2, 624265, 47, 6, 43, 534, 45, 345, 25, };
		// minHeapSort(a);
		// maxHeapSort(a);
		// mergeSort(a);
		// quickSort(a);
		// dubboSort(a);
		// insertSort(a);
		binaryInsertSort(a);
		System.out.println((int) binarySearch(a, 624265));
		System.out.println(Arrays.toString(a));
	}

	private static int binarySearch(int[] a, int i) {
		int l = 0;
		int r = a.length - 1;
		while (l <= r) {
			int mid = (l + r) / 2;
			if (a[mid] > i) {
				r = mid - 1;
			} else if (a[mid] < i) {
				l = mid + 1;
			} else {
				return mid;
			}
		}
		return -1;
	}

	private static void binaryInsertSort(int[] a) {
		for (int i = 1; i < a.length; i++) {
			if (a[i] < a[i - 1]) {
				int l = 0;
				int r = i;
				while (l <= r) {
					int mid = (l + r) / 2;
					if (a[mid] > a[i]) {
						r = mid - 1;
					} else {
						l = mid + 1;
					}
				}
				int tmp = a[i];
				backMove(a, l, i);
				a[l] = tmp;
			}
		}
	}

	private static void insertSort(int[] a) {
		for (int i = 0; i < a.length; i++) {
			int index = -1;
			for (int j = 0; j < i; j++) {
				if (a[i] < a[j]) {
					index = j;
					break;
				}
			}
			if (index != -1) {
				int tmp = a[i];
				backMove(a, index, i);
				a[index] = tmp;
			}
		}
	}

	private static void backMove(int[] a, int index, int i) {
		for (int j = i; j > index; j--) {
			a[j] = a[j - 1];
		}
	}

	private static void dubboSort(int[] a) {
		for (int i = 0; i < a.length - 1; i++) {
			boolean flag = true;
			for (int j = 0; j < a.length - 1 - i; j++) {
				if (a[j] > a[j + 1]) {
					swap(a, j, j + 1);
					flag = false;
				}
			}
			if (flag) {
				break;
			}
		}
	}

	private static void quickSort(int[] a) {
		sortQ(a, 0, a.length - 1);
	}

	private static void sortQ(int[] a, int i, int j) {
		boolean flag = true;
		int l = i;
		int r = j;
		if (l >= r) {
			return;
		}
		while (l != r) {
			if (a[l] > a[r]) {
				swap(a, l, r);
				flag = !flag;
			}
			if (flag) {
				r--;
			} else {
				l++;
			}
		}
		r++;
		l--;
		sortQ(a, i, l);
		sortQ(a, r, j);
	}

	private static void mergeSort(int[] a) {
		sortM(a, 0, a.length - 1);
	}

	private static void sortM(int[] a, int i, int j) {
		if (i < j) {
			int mid = (i + j) / 2;
			sortM(a, i, mid);
			sortM(a, mid + 1, j);
			merge(a, i, mid, j);
		}
	}

	private static void merge(int[] a, int i, int mid, int j) {
		int[] tmp = new int[a.length];
		int index = i;
		int lf = i;
		int rf = mid + 1;
		while (lf <= mid && rf <= j) {
			if (a[lf] < a[rf]) {
				tmp[index++] = a[lf++];
			} else {
				tmp[index++] = a[rf++];
			}
		}
		while (lf <= mid) {
			tmp[index++] = a[lf++];
		}
		while (rf <= j) {
			tmp[index++] = a[rf++];
		}
		while (i <= j) {
			a[i] = tmp[i++];
		}

	}

	private static void maxHeapSort(int[] a) {
		for (int i = 0; i < a.length - 1; i++) {
			buildMaxHeap(a, a.length - 1 - i);
			swap(a, 0, a.length - 1 - i);
		}
	}

	private static void buildMaxHeap(int[] a, int len) {
		for (int i = (len - 1) / 2; i >= 0; i--) {
			int cur = i;
			int l = cur * 2 + 1;
			int r = l + 1;
			int max = l;
			while (l <= len) {
				if (r <= len) {
					if (a[l] < a[r]) {
						max = r;
					}
				}
				if (a[cur] < a[max]) {
					swap(a, cur, max);
					cur = max;
				} else {
					break;
				}
			}
		}
	}

	private static void minHeapSort(int[] a) {
		for (int i = 0; i < a.length - 1; i++) {
			buildMinHeap(a, a.length - 1 - i);
			swap(a, 0, a.length - 1 - i);
		}
	}

	private static void buildMinHeap(int[] a, int i) {
		for (int j = (i - 1) / 2; j >= 0; j--) {
			int cur = j;
			int l = cur * 2 + 1;
			int r = l + 1;
			int min = l;
			while (l <= i) {
				if (r <= i) {
					if (a[l] > a[r]) {
						min = r;
					}
				}
				if (a[cur] > a[min]) {
					swap(a, cur, min);
					cur = min;
				} else {
					break;
				}
			}
		}
	}

	private static void swap(int[] a, int cur, int min) {
		a[cur] = a[cur] ^ a[min];
		a[min] = a[cur] ^ a[min];
		a[cur] = a[cur] ^ a[min];
	}
}