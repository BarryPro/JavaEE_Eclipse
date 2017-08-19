package org.crazyit.editor.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;

/**
 * �ļ���������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class FileUtil {
	
	//��ȡһ���ļ�������
	public static String readFile(File file) {
		StringBuffer result = new StringBuffer();
		try	{
			//ʹ��IO����ȡ�ļ�
			FileInputStream fis= new FileInputStream(file);
			String content = null;
			byte[] arr = new byte[1024];
			int readLength ;
			while ((readLength = fis.read(arr)) > 0) {
				content = new String(arr, 0, readLength);
				result.append(content);
			}
			fis.close();
		}
		catch(IOException e) {
			throw new FileException("read '" + file.getAbsolutePath() + "' file error");
		}
		return result.toString();
	}
	
	//ʹ��IO��������contentд�뵽����file��
	public static void writeFile(File file, String content) {
		try {
			FileOutputStream fos = new FileOutputStream(file);
			PrintStream ps = new PrintStream(fos);
			ps.print(content);
			ps.close();
			fos.close();
		} catch (IOException e) {
			throw new FileException("write file error");
		}
	}
}
