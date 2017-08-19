package org.crazyit.linkgame;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Image;
import java.awt.event.MouseEvent;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRootPane;
import javax.swing.border.EtchedBorder;
import javax.swing.event.MouseInputAdapter;

import linkgame.src.org.crazyit.linkgame.commons.GameConfiguration;
import linkgame.src.org.crazyit.linkgame.listener.BeginListener;
import linkgame.src.org.crazyit.linkgame.listener.GameListener;
import linkgame.src.org.crazyit.linkgame.service.GameService;
import linkgame.src.org.crazyit.linkgame.service.impl.GameServiceImpl;

/**
 * ��Ϸ�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version 1.0 <br/>��վ: <a href="http://www.crazyit.org">���Java����</a> <br>
 *          Copyright (C), 2009-2010, yangenxiong <br>
 *          This program is protected by copyright laws.
 */
public class LinkGame {
	public static void main(String[] args) throws Exception {
		// ���ô��ڵı���
		JFrame frame = new JFrame("������");
		// ���ùرմ��ڵĶ������˳�����
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		// ���ÿ�͸�
		frame.setSize(830, 600);
		// ����frame��λ��
		frame.setLocation(100, 50);
		// ���ò��ɸı��С
		frame.setResizable(false);
		// ȥ��ԭ�����ڷ��
		frame.setUndecorated(true);
		// ���ñ�������ʽ
		frame.getRootPane().setWindowDecorationStyle(JRootPane.PLAIN_DIALOG);
		frame.setLayout(new BorderLayout(5, 0));

		// ��������һά���ֵΪ15�� ��ά���ֵΪ10����Ϸ����, ����һ�μ�10��, ��Ϸʱ��һ����
		final GameConfiguration config = new GameConfiguration(15, 10, 30, 30,
				10, 150);
		// ʹ�������GameConfiguration���󴴽�һ��GameService��ʵ����
		final GameService gameService = new GameServiceImpl(config);
		// ����һ��JPanel����
		final GamePanel gamePanel = new GamePanel(gameService);

		frame.add(gamePanel, BorderLayout.CENTER);

		// ����һ��JPanel����
		JPanel controlPanel = new JPanel();
		// ���ñ�����ɫ
		controlPanel.setBackground(new Color(127, 174, 252));
		// ���ñ߿���ʽ
		controlPanel.setBorder(new EtchedBorder());
		// ����һ��BoxLayout���󣬵�һ������Ϊ��Ҫ���ֵĵ��������ڶ�������Ϊ���ô������½��в���
		BoxLayout controlLayout = new BoxLayout(controlPanel, BoxLayout.Y_AXIS);
		// ����controlPanel�Ĳ���ΪBoxLayout
		controlPanel.setLayout(controlLayout);
		// ����������frame��EAST
		frame.add(controlPanel, BorderLayout.EAST);

		// ����һ��JPanel, ���ڴ�ŷ��Java���˵�logo
		JPanel crazyItLogoPanel = new JPanel();
		// �������JPanel�ı߿�
		crazyItLogoPanel.setBorder(new EtchedBorder());
		// ��ȡlogoͼƬ
		Image crazyItLogoImage = ImageIO
				.read(new File("images/crazyItLogo.jpg"));
		// ����һ���������ȡ��ͼƬΪ������JLabel
		JLabel crazyItLogoLable = new JLabel(new ImageIcon(crazyItLogoImage));
		// ����JPanel�ı�����ɫ
		crazyItLogoPanel.setBackground(new Color(127, 174, 252));
		// �������JLabel���뵽JPanel��
		crazyItLogoPanel.add(crazyItLogoLable);
		// ��󽫴�ŷ��Java����logo��JPanel�ŵ����������Ǹ�JPanel(controlPanel)��
		controlPanel.add(crazyItLogoPanel);
		// �����հ׵�JPanel
		controlPanel.add(createBlankPanel());

		// ���½�һ���Լ���logo
		JPanel logoPanel = new JPanel();
		// ���ñ߿�
		logoPanel.setBorder(new EtchedBorder());
		// ��ȡͼƬ
		Image logoImage = ImageIO.read(new File("images/logo.gif"));
		// ����һ��JLabel
		JLabel logoLable = new JLabel(new ImageIcon(logoImage));
		// ���ñ�����ɫ
		logoPanel.setBackground(new Color(127, 174, 252));
		// ��JLabel���뵽JPanel��
		logoPanel.add(logoLable);
		// �ӵ�controlPanel��
		controlPanel.add(logoPanel);
		// �����հ׵�JPanel
		controlPanel.add(createBlankPanel());

		// ����һ����ŷ������ֵ�JPanel
		JPanel pointTextPanel = new JPanel();
		// �������JPanel�ı���ɫ
		pointTextPanel.setBackground(new Color(169, 210, 254));
		// �������JPanel�ı߿�
		pointTextPanel.setBorder(new EtchedBorder());
		// ����һ��JLabel���ڷ���"����"������
		JLabel pointTextLabel = new JLabel();
		// �������JLabel��textΪ"����", Ϊ�˸��ÿ�, �����ڷ���������֮�����ո�
		pointTextLabel.setText("��            ��");
		// ��JLabel���뵽JPanel��
		pointTextPanel.add(pointTextLabel);
		// ����ŷ������ֵ�JPanel�ŵ���Ϸ��������JPanel(controlPanel)��
		controlPanel.add(pointTextPanel);

		// ����һ��JPanel
		JPanel pointPanel = new JPanel();
		// ���ñ߿�
		pointPanel.setBorder(new EtchedBorder());
		// ���ñ�����ɫ
		pointPanel.setBackground(new Color(208, 223, 255));
		// ����һ��JLabel
		final JLabel pointLabel = new JLabel();
		// ���ó�ʼ����
		pointLabel.setText("0");
		// ��JLabel��ӵ�JPanel��
		pointPanel.add(pointLabel);
		// ���뵽��Ϸ��������JPanel(controlPanel)��
		controlPanel.add(pointPanel);
		// �����հ׵�JPanel
		controlPanel.add(createBlankPanel());

		// ʱ����������Panel
		JPanel timeTextPanel = new JPanel();
		timeTextPanel.setBackground(new Color(169, 210, 254));
		timeTextPanel.setBorder(new EtchedBorder());
		JLabel timeTextLabel = new JLabel();// "����"�����ִ������
		timeTextLabel.setText("ʱ            ��");
		timeTextPanel.add(timeTextLabel);
		controlPanel.add(timeTextPanel);

		// ʱ�����
		JPanel timePanel = new JPanel();
		timePanel.setBorder(new EtchedBorder());
		timePanel.setBackground(new Color(208, 223, 255));
		JLabel timeLabel = new JLabel();// ����������
		timeLabel.setText("0   ��");
		timePanel.add(timeLabel);
		controlPanel.add(timePanel);
		// �����հ׵�JPanel
		controlPanel.add(createBlankPanel());

		// ����һ��timer

		// �½�һ������button��JPanel
		JPanel buttonsPanel = new JPanel();
		// �������JPanel�Ĳ��ַ���, ����BoxLayout�����д����ҽ��в���
		buttonsPanel.setLayout(new BoxLayout(buttonsPanel, BoxLayout.X_AXIS));
		// ���ñ�����ɫ
		buttonsPanel.setBackground(new Color(127, 174, 252));
		// ������ʼ��ť
		JButton beginButton = new JButton("��    ʼ");
		buttonsPanel.add(beginButton);
		// �½�һ��JLabel���ڸ���������ť, ʹ�ý���ÿ���
		JLabel blankLabel = new JLabel();
		blankLabel.setText("     ");
		buttonsPanel.add(blankLabel);

		// ����һ����������
		BeginListener beginListener = new BeginListener(gamePanel, gameService,
				pointLabel, timeLabel, config);
		// ʹ��addMouseListener����������ð�ť����������
		beginButton.addMouseListener(beginListener);
		// ������Ϸ���ļ�������
		GameListener gameListener = new GameListener(gameService, gamePanel,
				pointLabel, beginListener);
		// ΪGamePanel������������, ����beginListener����,���ڻ�ȡ����timer����
		gamePanel.addMouseListener(gameListener);

		// �����˳���ť
		JButton exitButton = new JButton("��    ��");
		// Ϊ�˳�������ť�����¼�
		exitButton.addMouseListener(new MouseInputAdapter() {
			public void mouseClicked(MouseEvent e) {
				System.exit(0);
			}
		});
		buttonsPanel.add(exitButton);
		controlPanel.add(buttonsPanel);
		// �����հ׵�JPanel
		controlPanel.add(createBlankPanel());

		frame.setVisible(true); // ʹ���ڿɼ�
	}

	private static JPanel createBlankPanel() {
		// ����һ��JPanel
		JPanel blankPanel = new JPanel();
		// �������JPanel�ı�����ɫ(���������JPanel(controlPanel)������ɫһ��
		blankPanel.setBackground(new Color(127, 174, 252));
		// ����һ��JLabel, ���ڴ�ſո�
		JLabel blankLabel = new JLabel();
		// ��������Ϊ�ո�
		blankLabel.setText("      ");
		// ��JLabel��ӵ��հ׵�JPanel��
		blankPanel.add(blankLabel);
		// �������JPanel����
		return blankPanel;
	}
}
