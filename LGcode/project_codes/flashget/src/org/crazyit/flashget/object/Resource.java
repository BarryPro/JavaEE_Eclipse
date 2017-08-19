package org.crazyit.flashget.object;

import java.io.File;
import java.io.Serializable;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.swing.Icon;

import flashget.src.org.crazyit.flashget.DownloadContext;
import flashget.src.org.crazyit.flashget.state.TaskState;

public class Resource implements Serializable {

	//��ʶ����Դ��id
	private String id;
	//��Դ��ַ
	private String url;
	//��Դ����·��
	private String filePath;
	//��Դ���غ������
	private String fileName;
	//��Դ����
	private String sourceName;
	//��Դ���غ���ļ�����
	private File saveFile;
	//״̬
	private TaskState state;
	//�ļ���С
	private int size = -1;
	//��������
	private Date downloadDate;
	//����
	private float progress;
	//�����ٶ�
	private float speed;
	//ʹ�õ�ʱ��
	private int costTime;
	//ʣ�µ�ʱ��
	private int spareTime;
	//�ļ�����ֵĿ�
	private List<Part> parts;
	//���ص��߳���
	private int threadSize;
	//��һ�����صĴ�С
	private int preLength;
	
	public Resource(String url, String filePath, String fileName, int threadSize) {
		this.id = UUID.randomUUID().toString();
		this.url = url;
		this.filePath = filePath;
		this.fileName = fileName;
		this.parts = new ArrayList<Part>();
		this.saveFile = new File(filePath + File.separator + fileName);
		this.state = DownloadContext.CONNECTION;
		this.threadSize = threadSize;
	}
	
	public String getId() {
		return this.id;
	}
	
	public String getSourceName() {
		this.sourceName = FileUtil.getFileName(this.url);
		return this.sourceName;
	}
	
	public int getThreadSize() {
		return threadSize;
	}

	public void setThreadSize(int threadSize) {
		this.threadSize = threadSize;
	}

	public File getSaveFile() {
		return this.saveFile;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public TaskState getState() {
		return state;
	}

	public void setState(TaskState state) {
		if (this.state != null) {
			//�жϲ�����״̬�뱾�����״̬�Ƿ�һ��
			if (!this.state.equals(state)) {
				//����״̬һ��, ����Ҫ�����κζ���, ��һ��, ִ�и�״̬�ķ���
				//ִ��ԭ��״̬�����ٷ���
				this.state.destory(this);
				//ִ����״̬��init����
				state.init(this);
			}
		}
		this.state = state;
	}

	/**
	 * �����ļ���С
	 * @return
	 */
	public int getSize() {
		try {
			//����һ���ļ�����
			URL resourceURL = new URL(this.url);
			//�ж�֮ǰ�Ƿ��Ѿ�ȡ���ļ���С
			if (this.size == -1) {
				HttpURLConnection urlConnection = (HttpURLConnection)resourceURL.openConnection();
				urlConnection.connect();
				this.size = urlConnection.getContentLength();
				//ȡ���ļ���С�󷵻�
				urlConnection.disconnect();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.size;
	}

	public Date getDownloadDate() {
		return downloadDate;
	}

	public void setDownloadDate(Date downloadDate) {
		this.downloadDate = downloadDate;
	}

	public float getProgress() {
		this.progress = Math.round(100.0f * getCurrentLength() / getSize());
		return progress;
	}
	
	/**
	 * ���������ٶ�, ��Ҫ�õ�ȫ�������صĳ���
	 * @return
	 */
	public float getSpeed() {
		//�õ���ǰ���п����صĴ�С
		int currentLength = getCurrentLength();
		//����ǰ���صĳ��ȼ�ȥǰһ�����صĳ���, �õ�����������������ٶ�
		speed = (currentLength - preLength) / 1024.0f;
		//����ǰ���صĳ�������Ϊǰһ�����صĳ���(�����ٶȼ����Ѿ����)
		preLength = currentLength;
		speed = Math.round(speed * 100) / 100.0f;
		return speed;
	}
	
	/**
	 * �õ�����Դ�Ѿ����صĳ���(�������п�ĳ���)
	 * @return
	 */
	public int getCurrentLength() {
		int result = 0;
		for (Part p : this.parts) {
			result += p.getCurrentLength();
		}
		return result;
	}

	public void setSpeed(float speed) {
		this.speed = speed;
	}
	
	public int getCostTime() {
		return this.costTime;
	}

	public void setCostTime(int costTime) {
		this.costTime = costTime;
	}

	public int getSpareTime() {
		//�õ�ʣ�೤��
		int spareSize = getSize() - getCurrentLength();
		if (this.speed == 0) return this.spareTime; 
		return (spareSize / (int)this.speed) / 1000;
	}
	
	public Icon getStateIcon() {
		return state.getIcon();
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public List<Part> getParts() {
		return parts;
	}

	public void setParts(List<Part> parts) {
		this.parts = parts;
	}
	

}
