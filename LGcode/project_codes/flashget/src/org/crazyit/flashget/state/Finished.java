package org.crazyit.flashget.state;

import javax.swing.ImageIcon;

import flashget.src.org.crazyit.flashget.ContextHolder;

public class Finished extends AbstractState {

	@Override
	public ImageIcon getIcon() {
		return ImageUtil.FINISHED_IMAGE;
	}

	public String getState() {
		return "finished";
	}

	public void init(Resource resource) {
		//ɾ����ʱ�ļ�
		FileUtil.deletePartFiles(resource);
		//��Դ������ɺ�ȡ������
		ContextHolder.dh.stopTimer(resource);
	}
	
	
}
