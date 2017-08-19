package org.crazyit.flashget.thread;

import java.io.File;
import java.io.RandomAccessFile;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import flashget.src.org.crazyit.flashget.DownloadContext;
import flashget.src.org.crazyit.flashget.state.Finished;

public class DownloadHandler {
	
	public static Map<String, Timer> timers = new HashMap<String, Timer>();
	
	public void stopTimer(Resource r) {
		Timer t = timers.get(r.getId());
		if (t != null) {
			t.cancel();
		}
	}
	
	public void doDownload(Resource r) {
		try {
			//������������
			if (r.getDownloadDate() == null) r.setDownloadDate(new Date());
			r.setState(DownloadContext.CONNECTION);
			//�����ÿһ��Ĵ�С
			int partLength = r.getSize() / r.getThreadSize() + 1;
			//ʱ���������
			CountTimeTask timeTask = new CountTimeTask(r);
			Timer timer = new Timer();
			timer.schedule(timeTask, 0, 1000);
			//��Timer����ŵ�Map��, keyΪ����Դ��id
			timers.put(r.getId(), timer);
			for (int i = 0; i < r.getThreadSize(); i++) {
				int length = partLength;
				//��������һ��, ��ʹ����������ȥǰ�����ܺ�
				if (i == (r.getThreadSize() - 1)) {
					length = r.getSize() - i * partLength;
				}
				//��������Part����
				Part p = new Part((i * partLength), length, 0);
				r.getParts().add(p);
				RandomAccessFile rav = new RandomAccessFile(r.getFilePath() + 
						File.separator + p.getPartName(), "rw");
				DownloadThread t = new DownloadThread(r, rav, p);
				//�����߳����ȼ�
				t.setPriority(6);
				t.start();
			}
		} catch (Exception e) {
			r.setState(DownloadContext.FAILED);
			e.printStackTrace();
		}
	}
	
	public void resumeDownload(Resource r) {
		if (r.getState() instanceof Finished) return;
		try {
			CountTimeTask timeTask = new CountTimeTask(r);
			Timer timer = new Timer();
			timer.schedule(timeTask, 0, 1000);
			//��Timer����ŵ�Map��, keyΪ����Դ��id
			timers.put(r.getId(), timer);
			for (int i = 0; i < r.getParts().size(); i++) {
				Part p = r.getParts().get(i);
				RandomAccessFile rav = new RandomAccessFile(r.getFilePath() + 
						File.separator + p.getPartName(), "rw");
				DownloadThread t = new DownloadThread(r, rav, p);
				t.start();
			}
		} catch (Exception e) {
			r.setState(DownloadContext.FAILED);
			e.printStackTrace();
		}
	}
	
	//����ʱ������
	class CountTimeTask extends TimerTask {
		private Resource r;
		public CountTimeTask(Resource r) {
			this.r = r;
		}
		public void run() {
			r.setCostTime(r.getCostTime() + 1);
		}
	}
}
