package org.crazyit.flashget.ui;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.image.BufferedImage;

import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import javax.swing.JWindow;

/**
 * ��������
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SuspendWindow extends JWindow {

	private BufferedImage img = ImageUtil.getImage(ImageUtil.SUSPEND_IMAGE_PATH);
	
	//������������е�����
	private int x;
	private int y;
	
	private JPopupMenu popupMenu = new JPopupMenu();
	
	private JMenuItem openItem = new JMenuItem("��/�ر�", ImageUtil.SUSPEND_OPEN_IAMGE);
	private JMenuItem newItem = new JMenuItem("�½���������", ImageUtil.SUSPEND_NEW_IAMGE);
	private JMenuItem startItem = new JMenuItem("��ʼȫ������", ImageUtil.SUSPEND_START_IAMGE);
	private JMenuItem pauseItem = new JMenuItem("��ͣȫ������", ImageUtil.SUSPEND_PAUSE_IAMGE);
	private JMenuItem removeItem = new JMenuItem("ɾ���������", ImageUtil.SUSPEND_REMOVE_IAMGE);
	private JMenuItem quitItem = new JMenuItem("�˳�", ImageUtil.SUSPEND_QUIT_IAMGE);
	
	private MainFrame mainFrame;
	
	public SuspendWindow(MainFrame mainFrame) {
		this.mainFrame = mainFrame;
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		createPopupMenu();
		this.setSize(36, 36);
		int locationX = screen.width - screen.width / 5;
		int locationY = screen.height - (int)(screen.height / 1.06);
		this.setLocation(locationX, locationY);
		this.setAlwaysOnTop(true);
		this.setVisible(true);
		initListeners();
	}
	
	private void createPopupMenu() {
		this.popupMenu.add(this.openItem);
		this.popupMenu.addSeparator();
		this.popupMenu.add(this.newItem);
		this.popupMenu.add(this.removeItem);
		this.popupMenu.addSeparator();
		this.popupMenu.add(this.startItem);
		this.popupMenu.add(this.pauseItem);
		this.popupMenu.addSeparator();
		this.popupMenu.add(this.quitItem);
		this.openItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (mainFrame.isVisible()) {
					mainFrame.setVisible(false);
				} else {
					mainFrame.setVisible(true);
				}
			}
		});
		this.newItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				mainFrame.getNewTaskFrame().setVisible(true);
			}
		});
		this.startItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				mainFrame.startAllTask();
			}
		});
		this.pauseItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				mainFrame.pauseAllTask();
			}
		});
		this.removeItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				mainFrame.deleteFinished();
			}
		});
		this.quitItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				mainFrame.serializable();
				System.exit(0);
			}
		});
	}
	
	private void initListeners() {
		this.addMouseMotionListener(new MouseMotionAdapter() {
			public void mouseDragged(MouseEvent e) {
	            //��õ�ǰ�������Ļ�е�����
	            int xScreen = e.getXOnScreen();
	            int yScreen = e.getYOnScreen();
	            setLocation(xScreen - x, yScreen - y);
			}
		});
		this.addMouseListener(new MouseAdapter() {
			public void mousePressed(MouseEvent e) {
				x = e.getX();
				y = e.getY();
			}
			public void mouseReleased(MouseEvent e) {
				if (e.isPopupTrigger()) {
					popupMenu.show(SuspendWindow.this, e.getX(), e.getY());
				}
			}
			public void mouseClicked(MouseEvent e) {
				if (e.getClickCount() == 2) {
					mainFrame.setVisible(true);
				}
			}
		});
	}
	
	public void paint(Graphics g) {
		g.drawImage(img, 0, 0, this);
	}


}
