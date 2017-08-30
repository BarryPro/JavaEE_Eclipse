package com.belong.test;

import java.util.Arrays;
import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;

public class Main {
	public static <v> void main(String[] args) {
		int[] a = { -23, 17, -7, 11, -2, 1, -34 };
		// maxHeapSort(a);
		// minHeapSort(a);
		// mergeSort(a);
		// quickSort(a);
		// insertSort(a);
		// binaryInsertSort(a);
		// dubboSort(a);
		// inversionArray(a);
		// System.out.println(maxSubSum(a));
		// System.out.println((int) binarySearch(a, 11));
		System.out.println(Arrays.toString(a));
	}

	private static int maxSubSum(int[] a) {
		int max = Integer.MIN_VALUE;
		int sum = 0;
		for (int i = 0; i < a.length; i++) {
			sum += a[i];
			if (sum > max) {
				max = sum;
			}
			if (sum < 0) {
				sum = 0;
			}
		}
		return max;
	}

	private static void inversionArray(int[] a) {
		for (int i = 0; i < a.length / 2; i++) {
			int tmp = a[i];
			a[i] = a[a.length - 1 - i];
			a[a.length - 1 - i] = tmp;
		}
	}

	private static int binarySearch(int[] a, int i) {
		int l = 0;
		int r = a.length - 1;
		while (l < r) {
			int mid = (l + r) / 2;
			if (a[mid] < i) {
				l = mid + 1;
			} else if (a[mid] > i) {
				r = mid - 1;
			} else {
				return mid;
			}
		}
		return -1;
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

	private static void binaryInsertSort(int[] a) {
		for (int i = 1; i < a.length; i++) {
			if (a[i] < a[i - 1]) {
				int tmp = a[i];
				int l = 0;
				int r = i;
				while (l <= r) {
					int mid = (l + r) / 2;
					if (a[mid] < a[i]) {
						l = mid + 1;
					} else {
						r = mid - 1;
					}
				}
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

	private static void quickSort(int[] a) {
		sortQuick(a, 0, a.length - 1);
	}

	private static void sortQuick(int[] a, int i, int j) {
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
		sortQuick(a, i, l);
		sortQuick(a, r, j);
	}

	private static void mergeSort(int[] a) {
		sort(a, 0, a.length - 1);
	}

	private static void sort(int[] a, int i, int j) {
		if (i < j) {
			int mid = (i + j) / 2;
			sort(a, i, mid);
			sort(a, mid + 1, j);
			merge(a, i, mid, j);
		}
	}

	private static void merge(int[] a, int i, int mid, int j) {
		int t[] = new int[a.length];
		int index = i;
		int lf = i;
		int rf = mid + 1;
		while (lf <= mid && rf <= j) {
			if (a[lf] < a[rf]) {
				t[index++] = a[lf++];
			} else {
				t[index++] = a[rf++];
			}
		}
		while (lf <= mid) {
			t[index++] = a[lf++];
		}
		while (rf <= j) {
			t[index++] = a[rf++];
		}
		while (i <= j) {
			a[i] = t[i++];
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

	private static void maxHeapSort(int[] a) {
		for (int i = 0; i < a.length - 1; i++) {
			buildMaxHeap(a, a.length - 1 - i);
			swap(a, 0, a.length - 1 - i);
		}
	}

	private static void buildMaxHeap(int[] a, int i) {
		for (int j = (i - 1) / 2; j >= 0; j--) {
			int cur = j;
			int l = cur * 2 + 1;
			int r = l + 1;
			int max = l;
			while (l <= i) {
				if (r <= i) {
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

	private static void swap(int[] a, int cur, int max) {
		int t = a[cur];
		a[cur] = a[max];
		a[max] = t;
	}
}