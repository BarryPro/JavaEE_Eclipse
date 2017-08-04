package com.belong.socket;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

/**
 * Created by belong on 2016/12/12.
 */
public class Client implements Runnable{
    private static String host;
    private static int port;

    public Client(String host,int port){
        Client.host = host;
        Client.port = port;
    }

    /**
     * 客户端负责发送信息
     */
    public void client(){

    }


    @Override
    public void run() {
        Socket client = null;//定义客户端
        PrintWriter writer = null;
        Scanner cin = null;
        try {
            client = new Socket(host,port);
            writer = new PrintWriter(client.getOutputStream(),true);
            cin = new Scanner(System.in);
            while (cin.hasNext()) {
                String word = cin.nextLine();
                writer.println(word);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
