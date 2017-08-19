package org.crazyit.viewer;

import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.ImageIcon;

/**
 * ��������Action��
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ViewerAction extends AbstractAction {
	private String actionName = "";
	private ViewerFrame frame = null;
	
	//�����������AbstractAction����Ӧ��org.crazyit.viewer.action����ĳ��Actionʵȫ
	private Action action = null;

	/**
	 * ������
	 * 
	 */
	public ViewerAction() {
		// ���ø�������
		super();
	}

	/**
	 * ������
	 * 
	 * @param icon
	 *            ImageIcon ͼ��
	 * @param name
	 *            String
	 */
	public ViewerAction(ImageIcon icon, String actionName, ViewerFrame frame) {
		// ���ø�������
		super("", icon);
		this.actionName = actionName;
		this.frame = frame;
	}

	/**
	 * ��дvoid actionPerformed( ActionEvent e )����
	 * 
	 * @param e
	 *            ActionEvent
	 */
	public void actionPerformed(ActionEvent e) {
		ViewerService service = ViewerService.getInstance();
		Action action = getAction(this.actionName);
		//����Action��execute����
		action.execute(service, frame);
	}
	
	/**
	 * ͨ��actionName�õ������ʵ��
	 * @param actionName
	 * @return
	 */
	private Action getAction(String actionName) {
		try {
			if (this.action == null) {
				//����Actionʵ��
				Action action = (Action)Class.forName(actionName).newInstance();
				this.action = action;
			}
			return this.action;
		} catch (Exception e) {
			return null;
		}
	}
	
	
}