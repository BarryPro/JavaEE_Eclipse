package com.belong.net.socket;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * Created by belong on 2016/12/12.
 */
public class Chat {
    public static void main(String[] args) {
        try {
            InetAddress addr = InetAddress.getLocalHost();//获得主机的地址
            System.out.println(addr.getHostName());
            System.out.println(addr.getHostAddress());
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        Chat chat = new Chat();
        chat.server();
        chat.client();
    }

    /**
     * 负责启动服务器
     */
    public void server(){
        Server server = new Server(8090);
        Thread thread = new Thread(server);
        thread.start();
    }

    /**
     * 负责启动用户
     */
    public void client(){
        Client client = new Client("127.0.0.1",8090);
        Thread thread = new Thread(client);
        thread.start();
    }
}
