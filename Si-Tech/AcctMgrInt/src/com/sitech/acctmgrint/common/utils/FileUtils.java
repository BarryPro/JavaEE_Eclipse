package com.sitech.acctmgrint.common.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangyla on 2017/2/8.
 */
public class FileUtils {
    /**
     * 功能：获取目标路径下所有文件
     * @param filePath
     * @return
     */
    public static List<File> getFiles(String filePath) {
        List<File> arrlist = new ArrayList<File>();
        File root = new File(filePath);
        File[] files = root.listFiles();
        if (files == null || files.length == 0) {
            System.out.println("文件系统 filePath[" + filePath + "]下没有文件");
        } else {
            for (File file : files) {
                if (file.isFile()) {
                    arrlist.add(file);
                }
            }
        }

        return arrlist;
    }

    public static void main(String[] args) {
        String filePath = "E:\\work\\HLJ_PROJECTS\\AcctMgrWeb6.1\\out\\DI";
        List<File> files = getFiles(filePath);
        for (File file : files) {
            System.out.println(file.getName());
        }
    }
}
