package org.crazyit.image;

import java.awt.Color;
import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.ImageIcon;
import javax.swing.JPanel;

import image.src.org.crazyit.image.tool.AbstractTool;
import image.src.org.crazyit.image.tool.ToolFactory;

/**
 * ����������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ImageAction extends AbstractAction {
	private String name = "";
	private ImageFrame frame = null;
	private Color color = null;
	private Tool tool = null;
	private JPanel colorPanel = null;

	/**
	 * ������
	 * 
	 * @param icon
	 *            ImageIcon ͼ��
	 * @param name
	 *            ����
	 * @param frame
	 *            ImageFrame
	 */
	public ImageAction(Color color, JPanel colorPanel) {
		// ���ø�������
		super();
		this.color = color;
		this.colorPanel = colorPanel;
	}

	/**
	 * ������
	 * 
	 * @param icon
	 *            ImageIcon ͼ��
	 * @param name
	 *            ����
	 * @param frame
	 *            ImageFrame
	 */
	public ImageAction(ImageIcon icon, String name, ImageFrame frame) {
		// ���ø�������
		super("", icon);
		this.name = name;
		this.frame = frame;
	}

	/**
	 * ��дvoid actionPerformed( ActionEvent e )����
	 * 
	 * @param e
	 *            ActionEvent
	 */
	public void actionPerformed(ActionEvent e) {
		// ����tool
		tool = name != "" ? ToolFactory.getToolInstance(frame, name) : tool;
		if (tool != null) {
			// ��������ʹ�õ�tool
			frame.setTool(tool);
		}
		if (color != null) {
			// ��������ʹ�õ���ɫ
			AbstractTool.color = color;
			colorPanel.setBackground(color);
		}
	}
}