package com.belong.test;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * 笔试编程最短路径
 * Created by belong on 2017/4/7.
 */
public class MinRoute {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        while (scanner.hasNext()) {
            String s = scanner.next();
            String e = scanner.next();

            int diffLR = s.charAt(0) - e.charAt(0);
            int diffUD = s.charAt(1) - e.charAt(1);

            List<String> steps = new ArrayList<>();

            while (diffLR != 0 || diffUD != 0) {
                StringBuffer step = new StringBuffer("");
                if (diffLR < 0) {
                    step.append("R");
                    diffLR++;
                } else if (diffLR > 0) {
                    step.append("L");
                    diffLR--;
                }
                if (diffUD < 0) {
                    step.append("U");
                    diffUD++;
                } else if (diffUD > 0) {
                    step.append("D");
                    diffUD--;
                }
                steps.add(step.toString());
            }

            System.out.println(steps.size());
            for (String step : steps) {
                System.out.println(step);
            }
        }

        scanner.close();
    }
}
