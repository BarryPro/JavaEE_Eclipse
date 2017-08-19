package org.crazyit.flashget.util;

import java.io.File;
import java.util.List;

public class FileUtil {

	public final static File SERIALIZABLE_FILE = new File("serializable.txt");
	
	/**
	 * ɾ���������ļ���.part�ļ�, 
	 * @param file
	 */
	public static void deletePartFiles(Resource resource) {
		List<Part> parts = resource.getParts();
		for (Part part : parts) {
			File partFile = new File(getPartFilePath(resource, part));
			if (!partFile.exists()) continue;
			//ֻҪ��һ���ļ�ɾ��ʧ��, �ٵݹ�ɾ��, ֱ������ɾ��Ϊֹ
			if (partFile.delete() == false) {
				deletePartFiles(resource);
			}
		}
	}
	
	public static String getFileName(String address) {
		if (address.indexOf("/") != -1) {
			return address.substring(address.lastIndexOf("/") + 1, 
					address.length());
		}
		return null;
	}
	
	/**
	 * �õ�.part�ļ��ľ���·��
	 * @param resource
	 * @param part
	 * @return
	 */
	public static String getPartFilePath(Resource resource, Part part) {
		return resource.getFilePath() + File.separator + part.getPartName();
	}
}
