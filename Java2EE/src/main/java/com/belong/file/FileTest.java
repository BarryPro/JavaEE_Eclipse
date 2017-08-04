package com.belong.file;

import java.io.File;

/**
 * Created by belong on 2016/12/4.
 */
public class FileTest {
    public static void main(String[] args) {
        File file = new File("1.txt");
        file.deleteOnExit();
    }
}
