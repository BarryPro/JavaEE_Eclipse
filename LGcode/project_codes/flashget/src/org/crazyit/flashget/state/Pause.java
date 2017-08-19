package org.crazyit.flashget.state;

import javax.swing.ImageIcon;

import flashget.src.org.crazyit.flashget.ContextHolder;

public class Pause extends AbstractState {
	
	@Override
	public ImageIcon getIcon() {
		return ImageUtil.PAUSE_IMAGE;
	}

	@Override
	public String getState() {
		return "pause";
	}

	@Override
	public void init(Resource resource) {
		//��Դ��ͣ��ȡ������
		ContextHolder.dh.stopTimer(resource);
	}

}
