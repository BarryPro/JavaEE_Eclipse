package org.crazyit.flashget.thread;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import flashget.src.org.crazyit.flashget.ContextHolder;
import flashget.src.org.crazyit.flashget.DownloadContext;
import flashget.src.org.crazyit.flashget.exception.URLException;
import flashget.src.org.crazyit.flashget.state.Pause;

public class DownloadThread extends Thread {

	private URL url;
	
	private RandomAccessFile raf;
	
	//���ص���Դ����
	private Resource resource;
	
	//���߳���Ҫ���صĿ�
	private Part part;
	
	/**
	 * �����̹߳�����
	 */
	public DownloadThread(Resource resource, RandomAccessFile raf, Part part) {
		this.url = createURL(resource.getUrl());
		this.raf = raf;
		this.part = part;
		this.resource = resource;
	}
	
	private URL createURL(String urlPath) {
		try {
			return new URL(urlPath);
		} catch (Exception e) {
			throw new URLException("create url error");
		}
	}
	
	public final static int MAX_BUFFER_SIZE = 1024;

	public void run() {
		try {
			//���㿪ʼ���������
			int begin = part.getBegin() + part.getCurrentLength();
			int end = part.getBegin() + part.getLength() - 1;
			//����ǿ�ʼ����ڽ�����, ֤���ÿ��Ѿ��������
			if (begin >= end) {
				this.raf.close();
				return;
			}
			HttpURLConnection urlConnection = (HttpURLConnection)url.openConnection();
			urlConnection.setRequestProperty("Range", "bytes=" + begin + "-" + end); 
			//������Ӳ�����Ӧ�ĵ�ַ, �׳�java.net.UnknownHostException
			urlConnection.connect();
			//����Ҳ�����Ӧ����Դ, ���׳�java.io.FileNotFoundException
			InputStream is = urlConnection.getInputStream();
			byte[] buffer = new byte[MAX_BUFFER_SIZE];
			int perRead = 0;
			//����״̬Ϊ����
			this.resource.setState(DownloadContext.DOWNLOADING);
			//��.part�ļ������õ�ǰ����ȡ��ָ��
			this.raf.seek(this.part.getCurrentLength());
			while ((perRead = is.read(buffer)) != -1) {
				//�ж���Դ�����״̬�Ƿ��޸ĳ���ͣ
				if (this.resource.getState() instanceof Pause) {
					closeStream(is, urlConnection, this.raf);
					return;
				}
				//�ж���Դ����״̬
				raf.write(buffer, 0, perRead);
				this.part.setCurrentLength(this.part.getCurrentLength() + perRead);
			}
			closeStream(is, urlConnection, this.raf);
			//�ж��Ƿ��������, ����������, ����кϲ��ļ�
			//ע��������Ҫ�õ������ļ��Ĵ�С, ������ĳ��.part�ļ��Ĵ�С
			if (isFinished(this.resource.getSize())) uniteParts();
		} catch (Exception e) {
			this.resource.setState(DownloadContext.FAILED);
			e.printStackTrace();
		}
	}
	
	private void closeStream(InputStream is, HttpURLConnection urlConnection, 
			RandomAccessFile raf) throws IOException {
		is.close();
		urlConnection.disconnect();
		raf.close();
	}

	/**
	 * �ж��Ƿ��������, ���������ļ��ĸ���.part�ļ�
	 * @param fileLength
	 * @return
	 */
	private boolean isFinished(int fileLength) {
		List<Part> parts = this.resource.getParts();
		//���������ص�����
		int downCount = 0;
		for (Part part : parts) downCount += part.getCurrentLength();
		return (downCount >= fileLength) ? true : false;
	}
	
	/**
	 * �ϲ�part�ļ�
	 */
	private void uniteParts() throws IOException {
		List<Part> parts = this.resource.getParts();
		//�����ļ������, ����������ļ�
		OutputStream bos = new FileOutputStream(this.resource.getSaveFile(), 
				false);
		for (Part part : parts) {
			//�õ�.part�ļ�
			File partFile = new File(FileUtil.getPartFilePath(this.resource, 
					part));
			//����ļ�������
			InputStream is = new FileInputStream(partFile);
            byte[] buffer = new byte[1024];
            int bytesRead;
            int temp = 0;
            while ((bytesRead = is.read(buffer)) != -1) {
            	temp += bytesRead;
            	//д���ļ���
                bos.write(buffer, 0, bytesRead);
            }
            is.close();
		}
		bos.close();
		this.resource.setState(DownloadContext.FINISHED);
	}
	
	public static void main(String[] args) throws Exception {
		int threadSize = 5;
		
		Resource f = new Resource("http://www.apache.org/dist/struts/library/struts-2.1.8.1-lib.zip", 
				"C:/test-download", "struts.zip", threadSize);
		ContextHolder.dh.doDownload(f);
	}
}
