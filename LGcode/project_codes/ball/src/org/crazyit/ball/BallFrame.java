package org.crazyit.ball;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.IOException;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;

/**
 * ��Ϸ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class BallFrame extends JFrame {
	// ����JPanel�Ŀ��
	private final int BALLPANEL_WIDTH = 307;
	// ����JPanel�ĸ߶�
	private final int BALLPANEL_HEIGHT = 400;
	// ���廭��
	private BallPanel ballPanel = null;
	// ���嵵��
	// private Image stick = null;
	// ���õ���x����
	private int stickX = -1;
	// ����һ��BallServiceʵ��
	private BallService service = null;
	// ����һ��timer
	Timer timer = null;

	/**
	 * Ĭ�Ϲ�����
	 */
	public BallFrame() throws IOException {
		super();
		// ��ʼ��
		initialize();
	}

	/**
	 * ��ʼ������
	 * 
	 * @return void
	 */
	public void initialize() throws IOException {
		// ���ô��ڵı���
		this.setTitle("����");
		// ����Ϊ���ɸı��С
		this.setResizable(false);
		// ���ñ���Ϊ��ɫ
		this.setBackground(Color.BLACK);
		// ��ȡ����
		ballPanel = getBallPanel();
		// ����BallServiceʵ��
		service = new BallService(this, BALLPANEL_WIDTH, BALLPANEL_HEIGHT);

		// ����ÿ0.1��ִ��һ�μ�����
		ActionListener task = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				// ��ʼ�ı�λ��
				service.run();
				// ˢ�»���
				ballPanel.repaint();
			}
		};
		// ���timer��Ϊ��
		if (timer != null) {
			// ���¿�ʼtimer
			timer.restart();
		} else {
			// �½�һ��timer
			timer = new Timer(100, task);
			// ��ʼtimer
			timer.start();
		}

		this.add(ballPanel);
		// �����¼�������
		KeyListener[] klarr = this.getKeyListeners();
		if (klarr.length == 0) {
			// ������̼���������
			KeyListener keyAdapter = new KeyAdapter() {
				public void keyPressed(KeyEvent ke) {
					// �ı䵵�������
					service.setStickPos(ke);
				}
			};
			this.addKeyListener(keyAdapter);
		}
	}

	/**
	 * ��ȡ����
	 * 
	 * @return BallPanel ����BallPanle
	 */
	public BallPanel getBallPanel() {

		if (ballPanel == null) {
			// �½�һ������
			ballPanel = new BallPanel();
			// ���û���Ĵ�С
			ballPanel.setPreferredSize(new Dimension(BALLPANEL_WIDTH,
					BALLPANEL_HEIGHT));
		}
		return ballPanel;
	}

	// ����һ��JPanel�ڲ�������ɻ�ͼ����
	public class BallPanel extends JPanel {
		/**
		 * ��дvoid paint( Graphics g )����
		 * 
		 * @param g
		 *            Graphics
		 * @return void
		 */
		public void paint(Graphics g) {
			// ��ͼ
			service.draw(g);
		}
	}

}