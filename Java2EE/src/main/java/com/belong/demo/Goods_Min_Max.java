package com.belong.demo;

import java.util.*;

/**
 * Created by belong on 2017/4/7.
 */
public class Goods_Min_Max {
    public static void main(String[] args) {
        Scanner cin = new Scanner(System.in);
        while (cin.hasNext()) {
            int n = cin.nextInt();
            int m = cin.nextInt();
            ArrayList<Integer> prices = new ArrayList();
            //商品可能重复用hashMap,key是商品，value是数量
            HashMap<String, Integer> goods_list = new HashMap();
            //最好的情况就是最多的商品单价最低
            int sum_min = 0;
            //最高不好的情况是最多的商品单价最高
            int sum_max = 0;
            for (int i = 0; i < n; i++) {
                prices.add(cin.nextInt());
            }
            for (int i = 0; i < m; i++) {
                String good = cin.next();
                //如果商品存在数量加一
                if (goods_list.containsKey(good)) {
                    int count = goods_list.get(good);
                    goods_list.put(good, ++count);
                } else {
                    //默认数量是1
                    goods_list.put(good, 1);
                }
            }
            //要把链表装换成集合才能使用Collections的算法
            //强转
            Collection<Integer> list = goods_list.values();
            //排序(能排序实现list的接口的集合)
            //把集合转换成ArrayList
            ArrayList<Integer> good_sort = new ArrayList(list);
            Collections.sort(good_sort);
            Collections.sort(prices);
            for (int i = 0; i < good_sort.size(); i++) {
                sum_min += good_sort.get(good_sort.size() - 1 - i) * prices.get(i);
                sum_max += good_sort.get(good_sort.size() - 1 - i) * prices.get(prices.size() - 1 - i);
            }
            System.out.println(sum_min + " " + sum_max);
        }
    }
}
