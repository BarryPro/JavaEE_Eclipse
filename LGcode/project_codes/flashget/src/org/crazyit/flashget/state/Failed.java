package org.crazyit.flashget.state;

import javax.swing.ImageIcon;

import flashget.src.org.crazyit.flashget.ContextHolder;

public class Failed extends AbstractState {

	@Override
	public ImageIcon getIcon() {
		return ImageUtil.FAILED_IMAGE;
	}
	
	public String getState() {
		return "failed";
	}

	@Override
	public void init(Resource resource) {
		System.out.println(resource.getSaveFile().getAbsolutePath());
		System.out.println("��ֹͣ��");
		//����������Ϊ��������ʱ, ֹͣʱ�������
		ContextHolder.dh.stopTimer(resource);		
	}

}
