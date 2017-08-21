package com.belong.algorithms.sort;

import java.util.Arrays;

//堆排序
public class HeapSort {
    private int[] data = {9, 79, 46, 30, 58, 49};

    public void heapSort() {
        System.out.println("开始排序");
        int arrayLength = data.length;
        //循环建堆
        /*
		 *        9
		 *      /   \
		 *    79    46
		 *   / \   /
		 * 30  58 49 
		 */
        //针对完全二叉树，大顶堆，最顶端的值(0号索引)肯定是在没swap之前的最大的值，
        //对其在数组里面进行排序交换，大的排在数组后面，虽然最大的在最上面，但是其他的数据并没有排好，因此，需要不停更换顶点，重新建堆，需要循环
        for (int i = 0; i < arrayLength - 1; i++) {//5 4 3 2 1
            //建堆
            builMaxdHeap(arrayLength - 1 - i);//-i的原因，就是数组中没经过一次循环，最大的数已经在数组的后面了，就不用在建堆了
            //由于是大顶锥方式：锥顶是最大的数，交换堆顶和最后一个元素
            System.out.print("交换锥顶前");
            System.out.println(Arrays.toString(data));

            swap(0, arrayLength - 1 - i);
            System.out.print("交换锥顶后");
            System.out.println(Arrays.toString(data));
        }
    }

    //对data数组从0到lastIndex建大顶堆.
    //大顶堆的特性是：所有父节点的值都大于两个左右子节点
    private void builMaxdHeap(int lastIndex) {//修建大顶堆
        //从lastIndex处节点（最后一个节点）的父节点开始
        //(lastIndex - 1)/2    为最后一个节点的父节点的索引(除根节点)

        //都是从子节点开始判断  k的值分别是 5 3 1 索引号依次判断
		/*
		 *        9
		 *      /   \
		 *    79    46
		 *   / \   /
		 * 30  58 49 
		 */
        for (int i = (lastIndex - 1) / 2; i >= 0; i--) {//索引号从大的开始
            //k保存当前正在判断的节点
            int k = i;
            //如果当前k节点的子节点存在，
            //k * 2 + 1 判断当前节点的子节点
            while (k * 2 + 1 <= lastIndex) {//看当前要判断k的子节点是否存在。
                //k节点的左子节点的索引
                int biggerIndex = 2 * k + 1;
                //如果biggerIndex小于lastIndex，即biggerIndex + 1
                //代表k节点的右子节点存在
                if (biggerIndex < lastIndex) {//防止溢出
                    //如果右子节点的值较大，biggerIndex存储的都是最大节点索引
                    if (data[biggerIndex] - (data[biggerIndex + 1]) < 0) {//左面的小于右面的
                        //biggerIndex总是记录较大子节点的索引，之后再和父亲比
                        biggerIndex++; //这是较大节点的索引号,也就是右节点的索引号
                    }
                }
                //如果k(父节点)节点的值小于其较大子节点(左右都有可能)的值，交换
                if (data[k] - (data[biggerIndex]) < 0) {
                    //交换它们
                    swap(k, biggerIndex);
                    //将biggerIndex赋给k，开始while循环的下一次循环，
                    //重新保证k节点的值大于其左、右子节点的值。
                    k = biggerIndex;//大节点的索引号,
                } else {//满足的条件刚好是节点的值大于子节点的值
                    break;//刚好进入下一层循环
                }
            }
        }
    }

    //交换data数组中i、j两个索引处的元素
    private void swap(int i, int j) {
        int tmp = data[i];
        data[i] = data[j];
        data[j] = tmp;
    }

    public static void main(String[] args) {
        HeapSort h = new HeapSort();

        System.out.println("排序之前：\n"
                + Arrays.toString(h.data));
        h.heapSort();
        System.out.println("排序之后：\n"
                + Arrays.toString(h.data));
    }
}
