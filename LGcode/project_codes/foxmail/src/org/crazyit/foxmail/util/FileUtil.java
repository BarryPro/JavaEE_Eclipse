package org.crazyit.foxmail.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeUtility;
import com.thoughtworks.xstream.XStream;

import foxmail.src.org.crazyit.foxmail.object.Mail;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * �ļ�������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class FileUtil {

	//��������û����ݵ�Ŀ¼
	public static final String DATE_FOLDER = "datas" + File.separator;
	//��ž���ĳ���û����õ�properties�ļ�
	public static final String CONFIG_FILE = File.separator + "mail.properties";
	
	//�ռ����Ŀ¼��
	public static final String INBOX = "inbox";
	//�������Ŀ¼��
	public static final String OUTBOX = "outbox";
	//�ѷ��͵�Ŀ¼��
	public static final String SENT = "sent";
	//�ݸ����Ŀ¼��
	public static final String DRAFT = "draft";
	//�������Ŀ¼��
	public static final String DELETED = "deleted";
	//�����Ĵ��Ŀ¼��
	public static final String FILE = "file";
	
	/**
	 * �����û����ʺ�Ŀ¼����ص���Ŀ¼
	 * @param ctx
	 */
	public static void createFolder(MailContext ctx) {
		String accountRoot = getAccountRoot(ctx);
		//ʹ���û���ǰ���õ��ʺ�������Ŀ¼, ����һ���û���user1,��ô������datas/user1/������һ���ʺ�Ŀ¼
		mkdir(new File(accountRoot));
		//����INBOXĿ¼
		mkdir(new File(accountRoot + INBOX));
		//������
		mkdir(new File(accountRoot + OUTBOX));
		//�ѷ���
		mkdir(new File(accountRoot + SENT));
		//�ݸ���
		mkdir(new File(accountRoot + DRAFT));
		//������
		mkdir(new File(accountRoot + DELETED));
		//�������Ŀ¼
		mkdir(new File(accountRoot + FILE));
	}
	
	//�õ��ʼ��ʺŵĸ�Ŀ¼
	private static String getAccountRoot(MailContext ctx) {
		String accountRoot = DATE_FOLDER + ctx.getUser() + 
		File.separator + ctx.getAccount() + File.separator;
		return accountRoot;
	}
	
	//�õ�ĳ��Ŀ¼����, ����õ�file��Ŀ¼, inbox��Ŀ¼
	public static String getBoxPath(MailContext ctx, String folderName) {
		return getAccountRoot(ctx) + folderName + File.separator;
	}
	
	//Ϊ�������������ļ�, Ŀ¼�ǵ�¼�û�����������file��
	public static FileObject createFileFromPart(MailContext ctx, Part part) {
		try {
			//�õ��ļ���ŵ�Ŀ¼
			String fileRepository = getBoxPath(ctx, FILE);
			String serverFileName = MimeUtility.decodeText(part.getFileName());
			//����UUID��Ϊ�ڱ���ϵͳ��Ψһ���ļ���ʶ
			String fileName = UUID.randomUUID().toString();
			File file = new File(fileRepository + fileName + 
					getFileSufix(serverFileName));
			//��д�ļ�
			FileOutputStream fos = new FileOutputStream(file);
			InputStream is = part.getInputStream();
			BufferedOutputStream outs = new BufferedOutputStream(fos);
			//�����������Ϊ��part.getSizeΪ-1, ���ֱ��new byte, ���׳��쳣
			int size = (part.getSize() > 0) ? part.getSize() : 0;
			byte[] b = new byte[size];
			is.read(b);
			outs.write(b);
			outs.close();
			is.close();
			fos.close();
			//��װ����
			FileObject fileObject = new FileObject(serverFileName, file);
			return fileObject;
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileException(e.getMessage());
		}
	}
	
	//����Ӧ��box�еõ�ȫ����xml�ļ�
	public static List<File> getXMLFiles(MailContext ctx, String box) {
		String rootPath = getAccountRoot(ctx);
		String boxPath = rootPath + box;
		//�õ�ĳ��box��Ŀ¼
		File boxFolder = new File(boxPath);
		//���ļ����к�׺����
		List<File> files = filterFiles(boxFolder, ".xml");
		return files;
	}
	
	//��һ���ļ�Ŀ¼��, �Բ����ļ���׺subfixΪ����, �����ļ�
	private static List<File> filterFiles(File folder, String sufix) {
		List<File> result = new ArrayList<File>();
		File[] files = folder.listFiles();
		if (files == null) return new ArrayList<File>();
		for (File f : files) {
			if (f.getName().endsWith(sufix)) result.add(f);
		}
		return result;
	}
		
	//�õ��ļ����ĺ�׺
	public static String getFileSufix(String fileName) {
		if (fileName == null || fileName.trim().equals("")) return "";
		if (fileName.indexOf(".") != -1) {
			return fileName.substring(fileName.indexOf("."));
		}
		return "";
	}
	
	//����XStream����
	private static XStream xstream = new XStream();
	
	//��һ���ʼ�����ʹ��XStreamд��xml�ļ���
	public static void writeToXML(MailContext ctx, Mail mail, String boxFolder) {
		//�õ�mail��Ӧ��xml�ļ����ļ���
		String xmlName = mail.getXmlName();
		//�õ���Ӧ��Ŀ¼·��
		String boxPath = getAccountRoot(ctx) + boxFolder + File.separator;
		File xmlFile = new File(boxPath + xmlName);
		writeToXML(xmlFile, mail);
	}
	
	//��һ��mail����д��xmlFile��
	public static void writeToXML(File xmlFile, Mail mail) {
		try {
			if (!xmlFile.exists()) xmlFile.createNewFile();
			FileOutputStream fos = new FileOutputStream(xmlFile);
			OutputStreamWriter writer = new OutputStreamWriter(fos, "UTF8");
			xstream.toXML(mail, writer);
			writer.close();
			fos.close();
		} catch (Exception e) {
			throw new FileException("д���ļ��쳣: " + xmlFile.getAbsolutePath());
		}
	}
	
	//��һ��xml�ĵ�ת����Mail����
	public static Mail fromXML(MailContext ctx, File xmlFile) {
		try {
			FileInputStream fis = new FileInputStream(xmlFile);
			//����XStream��ת���������ļ�ת���ɶ���
			Mail mail = (Mail)xstream.fromXML(fis);
			fis.close();
			return mail;
		} catch (Exception e) {
			throw new FileException("ת�������쳣: " + xmlFile.getAbsolutePath());
		}
	}
	//�����ļ��ķ���
	public static void copy(File sourceFile, File targetFile) {
		try {
			Process process = Runtime.getRuntime().exec("cmd /c copy \"" + 
					sourceFile.getAbsolutePath() + "\" \"" + 
					targetFile.getAbsolutePath() + "\"");
			process.waitFor();
		} catch (Exception e) {
			throw new FileException("����ļ�����: " + targetFile.getAbsolutePath());
		}
	}

	/*
	 * ����Ŀ¼�Ĺ��߷���, �ж�Ŀ¼�Ƿ����
	 */
	private static void mkdir(File file) {
		if (!file.exists()) file.mkdir();
	}
}
