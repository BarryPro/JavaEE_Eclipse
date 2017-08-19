package org.crazyit.editor.util;

import java.io.File;
import java.io.FileWriter;
import java.io.InputStream;

/**
 * �������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class CommandUtil {
	
	public final static String WINDOWS_COMMAND = "cmd /c ";
	
	//���ؽ���process�Ĵ�����Ϣ
	public static String getErrorMessage(Process process) {
		return getProcessString(process.getErrorStream());
	}
	
	private static String getProcessString(InputStream is) {
		try {
			StringBuffer buffer = new StringBuffer();
			byte[] b = new byte[4096];
			for (int n; (n = is.read(b)) != -1;)  
				buffer.append(new String(b, 0, n));
			is.close();
			return buffer.toString();
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
	//��ȡһ�����̵Ĵ�����Ϣ
	public static String getProcessString(Process process) {
		StringBuffer result = new StringBuffer();
		//����CommandUtil�ķ���
		String errorString = getErrorMessage(process);
		if (errorString.length() != 0) result.append("����: " + errorString);
		else result.append("ִ�����");
		return result.toString();
	}
	
	//����һ�����̵���Ϣ
	public static String getRunString(Process process) {
		String error = getErrorMessage(process);
		String message = getProcessString(process.getInputStream());
		return error + message;
	}
	
	//ִ��һ�����������Ӧ����Ϣ
	public static Process executeCommand(String command) {
		try {
			//��windows�½���������һ��bat�ļ�, ��ִ�и�bat�ļ�
			File batFile = new File("dump.bat");
			if (!batFile.exists()) batFile.createNewFile();
			//������д���ļ���
			FileWriter writer = new FileWriter(batFile);
			writer.write(command);
			writer.close();
			//ִ�и�bat�ļ�
			Process process =Runtime.getRuntime().exec(WINDOWS_COMMAND + batFile.getAbsolutePath());
			process.waitFor();
			//��bat�ļ�ɾ��
			batFile.delete();
			return process;
		} catch (Exception e) {
			return null;
		}
	}
}
