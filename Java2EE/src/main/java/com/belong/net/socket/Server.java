package com.belong.net.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Created by belong on 2016/12/12.
 */
public class Server implements Runnable{
    private static int port;

    public Server(int port){
        Server.port = port;
    }

    /**
     * 负责接受客户端的信息
     */
    public void server(){

    }

    @Override
    public void run() {
        ServerSocket serverclient = null;
        Socket client = null;
        try {
            serverclient = new ServerSocket(port);
            client = serverclient.accept();
            //得到客户端的输入流（服务器显示信息）
            BufferedReader reader =
                    new BufferedReader(new InputStreamReader(client.getInputStream()));
            boolean flag = true;
            while(flag){
                String word = reader.readLine();
                if(word.toLowerCase().equals("q")){
                    flag = false;
                    System.out.println("我不和你唠了！");
                } else {
                    System.out.println("client1说："+word);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
