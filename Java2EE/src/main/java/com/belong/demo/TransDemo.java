package com.belong.demo;

/**
 * Created by belong on 2017/4/6.
 */
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

class ClassLib implements Serializable {
    private transient InputStream is;

    private int majorVer;
    private int minorVer;

    ClassLib(InputStream is) throws IOException {
        System.out.println("ClassLib(InputStream) called");
        this.is = is;
        DataInputStream dis;
        if (is instanceof DataInputStream)
            dis = (DataInputStream) is;
        else
            dis = new DataInputStream(is);
        if (dis.readInt() != 0xcafebabe)
            throw new IOException("not a .class file");
        minorVer = dis.readShort();
        majorVer = dis.readShort();
    }

    int getMajorVer() {
        return majorVer;
    }

    int getMinorVer() {
        return minorVer;
    }

    void showIS() {
        System.out.println(is);
    }
}

public class TransDemo {
    public static void main(String[] args) throws IOException {
        Foo foo = new Foo();
        System.out.printf("w: %d%n", Foo.w);
        System.out.printf("x: %d%n", Foo.x);
        System.out.printf("y: %d%n", foo.y);
        System.out.printf("z: %d%n", foo.z);
        try (FileOutputStream fos = new FileOutputStream("x.ser");
             ObjectOutputStream oos = new ObjectOutputStream(fos)) {
            oos.writeObject(foo);
        }

        foo = null;

        try (FileInputStream fis = new FileInputStream("x.ser");
             ObjectInputStream ois = new ObjectInputStream(fis)) {
            System.out.println();
            foo = (Foo) ois.readObject();
            System.out.printf("w: %d%n", Foo.w);
            System.out.printf("x: %d%n", Foo.x);
            System.out.printf("y: %d%n", foo.y);
            System.out.printf("z: %d%n", foo.z);
        } catch (ClassNotFoundException cnfe) {
            System.err.println(cnfe.getMessage());
        }
    }
}
