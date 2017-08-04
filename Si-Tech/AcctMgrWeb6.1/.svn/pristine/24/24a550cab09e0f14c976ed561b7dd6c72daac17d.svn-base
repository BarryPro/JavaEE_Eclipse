package com.sitech.acctmgr.atom.impl.volume;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class VolumeServer {

	public static void main(String[] args) throws Exception {
		
		ServerSocket ss = new ServerSocket(8100);
		Socket s = ss.accept();
		InputStream inputStream = s.getInputStream();
		OutputStream outputStream = s.getOutputStream();
		
		byte[] header_buf = new byte[6];
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		
		for(int i = 0; i < 6; i++){
			header_buf[i] = (byte) inputStream.read();
		}
		String slen = new String(header_buf);
		
		System.out.println(slen);
		int length = Integer.parseInt(slen) - 6;
		int total_len = 0;
		
		while(true){
			os.write(inputStream.read());
			total_len++;
			if(total_len >= length){
				break;
			}
		}
		
		String string = new String(os.toByteArray());
		System.out.println(string);
		
		outputStream.write(String.format("%04d", (4 + 4 + 4 + 4 + 2 + 12)).getBytes());
		outputStream.write("~!~".getBytes());
		outputStream.write("1024".getBytes());
		outputStream.write("~!~".getBytes());
		outputStream.write("2048".getBytes());
		outputStream.write("~!~".getBytes());
		outputStream.write("0000".getBytes());
		outputStream.write("~!~".getBytes());
		outputStream.write("OK".getBytes());
		ss.close();
	}
}
