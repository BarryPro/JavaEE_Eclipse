package org.crazyit.image;

import static java.awt.Color.BLACK;
import static java.awt.Color.BLUE;
import static java.awt.Color.CYAN;
import static java.awt.Color.GRAY;
import static java.awt.Color.GREEN;
import static java.awt.Color.LIGHT_GRAY;
import static java.awt.Color.MAGENTA;
import static java.awt.Color.ORANGE;
import static java.awt.Color.PINK;
import static java.awt.Color.RED;
import static java.awt.Color.WHITE;
import static java.awt.Color.YELLOW;
import static org.crazyit.image.tool.Tool.*;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Graphics;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionAdapter;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JColorChooser;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JToolBar;

import image.src.org.crazyit.image.tool.ToolFactory;

/**
 * �������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ImageFrame extends JFrame {
	// ����ҵ���߼���
	private ImageService service = new ImageService();
	// ��ʼ����Ļ�ĳߴ�
	private Dimension screenSize = service.getScreenSize();
	// ����Ĭ�ϻ���
	private JPanel drawSpace = createDrawSpace();
	// ���û���ͼƬ
	private MyImage bufferedImage = new MyImage(
			(int) screenSize.getWidth() / 2, (int) screenSize.getHeight() / 2,
			BufferedImage.TYPE_INT_RGB);
	// ���õ�ǰʹ�õĹ���
	private Tool tool = null;
	// ���û�ͼ����
	Graphics g = bufferedImage.getGraphics();
	// ��ɫ��ʾ���
	private JPanel currentColorPanel = null;
	// ��ɫѡ����
	private JColorChooser colorChooser = getColorChooser();
	// �Ӹ��˵����¼�������
	ActionListener menuListener = new ActionListener() {
		public void actionPerformed(ActionEvent e) {
			service.menuDo(ImageFrame.this, e.getActionCommand());
		}
	};
	// Ĭ��JScrollPane
	private JScrollPane scroll = null;
	// ������
	JPanel toolPanel = createToolPanel();
	// ��ɫ���
	JPanel colorPanel = createColorPanel();

	/**
	 * Ĭ�Ϲ�����
	 * 
	 * @return void
	 */
	public ImageFrame() {
		super();
		// ��ʼ��
		init();
	}

	public ImageService getService() {
		return this.service;
	}

	/**
	 * ��ʼ��ImageFrame
	 * 
	 * @return void
	 */
	public void init() {
		// ���ñ���
		this.setTitle("δ���� - ��ͼ");
		// ��ʼ����ͼ
		service.initDrawSpace(this);
		// ���ñ���
		// ��ȡ����ʹ�õĹ���
		tool = ToolFactory.getToolInstance(this, PENCIL_TOOL);

		// ��������˶�������
		MouseMotionListener motionListener = new MouseMotionAdapter() {
			// �϶����
			public void mouseDragged(MouseEvent e) {
				tool.mouseDragged(e);
			}

			// �ƶ����
			public void mouseMoved(MouseEvent e) {
				tool.mouseMoved(e);
			}

		};
		// ������������
		MouseListener mouseListener = new MouseAdapter() {
			// �ɿ����
			public void mouseReleased(MouseEvent e) {
				tool.mouseReleased(e);
			}

			// �������
			public void mousePressed(MouseEvent e) {
				tool.mousePressed(e);
			}

			// ������
			public void mouseClicked(MouseEvent e) {
				tool.mouseClicked(e);
			}
		};

		drawSpace.addMouseMotionListener(motionListener);
		drawSpace.addMouseListener(mouseListener);

		createMenuBar();
		// ʹ��drawSpace����һ����������
		scroll = new JScrollPane(drawSpace);
		// ����viewport
		ImageService.setViewport(scroll, drawSpace, bufferedImage.getWidth(),
				bufferedImage.getHeight());
		// ��panel�ӵ���Frame����
		this.add(scroll, BorderLayout.CENTER);
		this.add(toolPanel, BorderLayout.WEST);
		this.add(colorPanel, BorderLayout.SOUTH);
	}

	/**
	 * ��ȡ����
	 * 
	 * @return JPanel
	 */
	public JPanel getDrawSpace() {
		return this.drawSpace;
	}

	/**
	 * ��ȡJScroolPane
	 * 
	 * @return JScrollPane
	 */
	public JScrollPane getScroll() {
		return this.scroll;
	}

	/**
	 * ��ȡ������
	 * 
	 * @return JPanel
	 */
	public JPanel getToolPanel() {
		return this.toolPanel;
	}

	/**
	 * ��ȡ��ɫ���
	 * 
	 * @return JPanel
	 */
	public JPanel getColorPanel() {
		return this.colorPanel;
	}

	/**
	 * ��ȡͼƬ
	 * 
	 * @return MyImage
	 */
	public MyImage getBufferedImage() {
		return this.bufferedImage;
	}

	/**
	 * ����ͼƬ
	 * 
	 * @param bufferedImage
	 *            MyImage
	 * @return void
	 */
	public void setBufferedImage(MyImage bufferedImage) {
		this.bufferedImage = bufferedImage;
	}

	/**
	 * ���ù���
	 * 
	 * @param tool
	 *            Tool
	 * @return void
	 */
	public void setTool(Tool tool) {
		this.tool = tool;
	}

	/**
	 * ��ȡ����
	 * 
	 * @return Tool
	 */
	public Tool getTool() {
		return this.tool;
	}

	/**
	 * ��ȡ��ɫѡ����
	 * 
	 * @return JColorChooser
	 */
	public JColorChooser getColorChooser() {
		if (colorChooser == null) {
			colorChooser = new JColorChooser();
		}
		return colorChooser;
	}

	/**
	 * ��������ɫѡ���
	 * 
	 * @return JPanel
	 */
	public JPanel createColorPanel() {
		// �½�һ��JPanel
		JPanel panel = new JPanel();
		// ���ò��ַ�ʽ
		panel.setLayout(new FlowLayout(FlowLayout.LEFT));
		// �½�һ��JToolBar
		JToolBar toolBar = new JToolBar("��ɫ");
		// ����Ϊ�����϶�
		toolBar.setFloatable(false);
		// ������߽�ľ���
		toolBar.setMargin(new Insets(2, 2, 2, 2));
		// ���ò��ַ�ʽ
		toolBar.setLayout(new GridLayout(2, 6, 2, 2));
		// Color���е�������ɫ
		Color[] colorArr = { BLACK, BLUE, CYAN, GRAY, GREEN, LIGHT_GRAY,
				MAGENTA, ORANGE, PINK, RED, WHITE, YELLOW };
		JButton[] panelArr = new JButton[colorArr.length];
		// ����ʹ�õ���ɫ
		currentColorPanel = new JPanel();
		currentColorPanel.setBackground(Color.BLACK);
		currentColorPanel.setPreferredSize(new Dimension(20, 20));
		// ������Щ��ɫ��button
		for (int i = 0; i < panelArr.length; i++) {
			// ����JButton
			panelArr[i] = new JButton(new ImageAction(colorArr[i],
					currentColorPanel));
			// ����button����ɫ
			panelArr[i].setBackground(colorArr[i]);
			// ��button�ӵ�toobar��
			toolBar.add(panelArr[i]);
		}
		panel.add(currentColorPanel);
		panel.add(toolBar);
		// ����
		return panel;
	}

	/**
	 * ��ȡ��ɫ��ʾ���
	 * 
	 * @return JPanel
	 */
	public JPanel getCurrentColorPanel() {
		return this.currentColorPanel;
	}

	/**
	 * ��ȡscreenSize
	 * 
	 * @return Dimension
	 */
	public Dimension getScreenSize() {
		return this.screenSize;
	}

	/**
	 * �����˵���
	 * 
	 * @return void
	 */
	public void createMenuBar() {
		// ����һ��JMenuBar���ò˵�
		JMenuBar menuBar = new JMenuBar();
		// �˵��������飬�������menuItemArrһһ��Ӧ
		String[] menuArr = { "�ļ�(F)", "�鿴(V)", "��ɫ(C)", "����(H)" };
		// �˵�����������
		String[][] menuItemArr = { { "�½�(N)", "��(O)", "����(S)", "-", "�˳�(X)" },
				{ "������(T)", "���Ϻ�(C)" }, { "�༭��ɫ" }, { "��������", "����" } };
		// ����menuArr��menuItemArrȥ�����˵�
		for (int i = 0; i < menuArr.length; i++) {
			// �½�һ��JMenu�˵�
			JMenu menu = new JMenu(menuArr[i]);
			for (int j = 0; j < menuItemArr[i].length; j++) {
				// ���menuItemArr[i][j]����"-"
				if (menuItemArr[i][j].equals("-")) {
					// ���ò˵��ָ�
					menu.addSeparator();
				} else {
					// �½�һ��JMenuItem�˵���
					JMenuItem menuItem = new JMenuItem(menuItemArr[i][j]);
					menuItem.addActionListener(menuListener);
					// �Ѳ˵���ӵ�JMenu�˵�����
					menu.add(menuItem);
				}
			}
			// �Ѳ˵��ӵ�JMenuBar��
			menuBar.add(menu);
		}
		// ����JMenubar
		this.setJMenuBar(menuBar);
	}

	/**
	 * ��������
	 * 
	 * @return JPanel
	 */
	public JPanel createDrawSpace() {
		JPanel drawSpace = new DrawSpace();
		// ����drawSpace�Ĵ�С
		drawSpace.setPreferredSize(new Dimension((int) screenSize.getWidth(),
				(int) screenSize.getHeight() - 150));
		return drawSpace;
	}

	/**
	 * ����������
	 * 
	 * @return JPanel
	 */
	public JPanel createToolPanel() {
		// ����һ��JPanel
		JPanel panel = new JPanel();
		// ����һ������Ϊ"����"�Ĺ�����
		JToolBar toolBar = new JToolBar("����");
		// ����Ϊ��ֱ����
		toolBar.setOrientation(toolBar.VERTICAL);
		// ����Ϊ�����϶�
		toolBar.setFloatable(true);
		// ������߽�ľ���
		toolBar.setMargin(new Insets(2, 2, 2, 2));
		// ���ò��ַ�ʽ
		toolBar.setLayout(new GridLayout(5, 2, 2, 2));
		// ��������
		String[] toolarr = { PENCIL_TOOL, BRUSH_TOOL, COLORPICKED_TOOL,
				ATOMIZER_TOOL, ERASER_TOOL, LINE_TOOL, POLYGON_TOOL, RECT_TOOL,
				ROUND_TOOL, ROUNDRECT_TOOL };
		for (int i = 0; i < toolarr.length; i++) {
			ImageAction action = new ImageAction(new ImageIcon("img/"
					+ toolarr[i] + ".jpg"), toolarr[i], this);
			// ��ͼ�괴��һ���µ�button
			JButton button = new JButton(action);
			// ��button�ӵ���������
			toolBar.add(button);
		}
		panel.add(toolBar);
		// ����
		return panel;
	}

	// ��ͼ����
	public class DrawSpace extends JPanel {
		/**
		 * ��дvoid paint( Graphics g )����
		 * 
		 * @param g
		 *            Graphics
		 * @return void
		 */
		public void paint(Graphics g) {
			// draw
			service.repaint(g, bufferedImage);
		}
	}

}