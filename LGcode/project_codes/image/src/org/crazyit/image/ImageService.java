package org.crazyit.image;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Point;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.JColorChooser;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JViewport;

import image.src.org.crazyit.image.tool.AbstractTool;

/**
 * ��ͼ���ߴ����߼���(�ǹ���)
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ImageService {
	private ImageFileChooser fileChooser = new ImageFileChooser();

	/**
	 * ��ȡ��Ļ�ķֱ���
	 * 
	 * @return Dimension
	 */
	public Dimension getScreenSize() {
		Toolkit dt = Toolkit.getDefaultToolkit();
		return dt.getScreenSize();
	}

	/**
	 * ��ʼ����drawSpace
	 * 
	 * @param frame
	 *            ImageFrame
	 * @return void
	 */
	public void initDrawSpace(ImageFrame frame) {
		// ��ȡ��ͼ����
		Graphics g = frame.getBufferedImage().getGraphics();
		// ��ȡ�����Ĵ�С
		Dimension d = frame.getDrawSpace().getPreferredSize();
		// ��ȡ��
		int drawWidth = (int) d.getWidth();
		// ��ȡ��
		int drawHeight = (int) d.getHeight();
		// �滭��
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, drawWidth, drawHeight);
	}

	/**
	 * repaint
	 * 
	 */
	public void repaint(Graphics g, BufferedImage bufferedImage) {
		int drawWidth = bufferedImage.getWidth();
		int drawHeight = bufferedImage.getHeight();
		Dimension screenSize = getScreenSize();
		// ���÷ǻ滭������ɫ
		g.setColor(Color.GRAY);
		g.fillRect(0, 0, (int) screenSize.getWidth() * 10, (int) screenSize
				.getHeight() * 10);
		// �����϶������ɫ
		g.setColor(Color.BLUE);
		g.fillRect(drawWidth, drawHeight, 4, 4);
		g.fillRect(drawWidth, (int) drawHeight / 2 - 2, 4, 4);
		g.fillRect((int) drawWidth / 2 - 2, drawHeight, 4, 4);
		// �ѻ����ͼƬ�滭����
		g.drawImage(bufferedImage, 0, 0, drawWidth, drawHeight, null);
	}

	/**
	 * �������ͼ��
	 * 
	 * @param path
	 *            String ͼ��·��
	 * @return Cursor;
	 */
	public static Cursor createCursor(String path) {
		Image cursorImage = Toolkit.getDefaultToolkit().createImage(path);
		return Toolkit.getDefaultToolkit().createCustomCursor(cursorImage,
				new Point(10, 10), "mycursor");
	}

	/**
	 * ����JViewport
	 * 
	 * @param scroll
	 *            JScrollPane
	 * @param panel
	 *            JPanel
	 * @param width
	 *            int
	 * @parem width int
	 * @return void
	 */
	public static void setViewport(JScrollPane scroll, JPanel panel, int width,
			int height) {
		// �½�һ��JViewport
		JViewport viewport = new JViewport();
		// ����viewport�Ĵ�С
		panel.setPreferredSize(new Dimension(width + 50, height + 50));
		// ����viewport
		viewport.setView(panel);
		scroll.setViewport(viewport);
	}

	/**
	 * ����ͼƬ
	 * 
	 * @param b
	 *            boolean �Ƿ�ֱ�ӱ���
	 * @param frame
	 *            ImageFrame
	 * @return void
	 */
	public void save(boolean b, ImageFrame frame) {
		if (b) {
			// ���ѡ�񱣴�
			if (fileChooser.showSaveDialog(frame) == ImageFileChooser.APPROVE_OPTION) {
				// ��ȡ��ǰ·��
				File currentDirectory = fileChooser.getCurrentDirectory();
				// ��ȡ�ļ���
				String fileName = fileChooser.getSelectedFile().getName();
				// ��ȡ��׺��
				String suf = fileChooser.getSuf();
				// ��ϱ���·��
				String savePath = currentDirectory + "\\" + fileName + "."
						+ suf;
				try {
					// ��ͼƬд������·��
					ImageIO.write(frame.getBufferedImage(), suf, new File(
							savePath));
				} catch (java.io.IOException ie) {
					ie.printStackTrace();
				}
				// ���ñ����Ĵ��ڱ���
				frame.setTitle(fileName + "." + suf + " - ��ͼ");
				// �ѱ���
				frame.getBufferedImage().setIsSaved(true);
			}
		} else if (!frame.getBufferedImage().isSaved()) {
			// �½�һ���Ի���
			JOptionPane option = new JOptionPane();
			// ��ʾȷ�ϱ���Ի���YES_NO_OPTION
			int checked = option.showConfirmDialog(frame, "����Ķ�?", "��ͼ",
					option.YES_NO_OPTION, option.WARNING_MESSAGE);
			// ���ѡ����
			if (checked == option.YES_OPTION) {
				// ����ͼƬ
				save(true, frame);
			}
		}
	}

	/**
	 * ��ͼƬ
	 * 
	 * @param frame
	 *            ImageFrame
	 * @return void
	 */
	public void open(ImageFrame frame) {
		save(false, frame);
		// �����һ���ļ�
		if (fileChooser.showOpenDialog(frame) == ImageFileChooser.APPROVE_OPTION) {
			// ��ȡѡ����ļ�
			File file = fileChooser.getSelectedFile();
			// ���õ�ǰ�ļ���
			fileChooser.setCurrentDirectory(file);
			BufferedImage image = null;
			try {
				// ���ļ���ȡͼƬ
				image = ImageIO.read(file);
			} catch (java.io.IOException e) {
				e.printStackTrace();
				return;
			}
			// ����
			int width = image.getWidth();
			int height = image.getHeight();
			AbstractTool.drawWidth = width;
			AbstractTool.drawHeight = height;
			// ����һ��MyImage
			MyImage myImage = new MyImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			// �Ѷ�ȡ����ͼƬ����myImage����
			myImage.getGraphics().drawImage(image, 0, 0, width, height, null);
			frame.setBufferedImage(myImage);
			// repaint
			frame.getDrawSpace().repaint();
			// ��������viewport
			ImageService.setViewport(frame.getScroll(), frame.getDrawSpace(),
					width, height);
			// ���ñ����Ĵ��ڱ���
			frame.setTitle(fileChooser.getSelectedFile().getName() + " - ��ͼ");
		}
	}

	/**
	 * ��ͼƬ
	 * 
	 * @param frame
	 *            ImageFrame
	 * @return void
	 */
	public void createGraphics(ImageFrame frame) {
		save(false, frame);
		// ����
		int width = (int) getScreenSize().getWidth() / 2;
		int height = (int) getScreenSize().getHeight() / 2;
		AbstractTool.drawWidth = width;
		AbstractTool.drawHeight = height;
		// ����һ��MyImage
		MyImage myImage = new MyImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics g = myImage.getGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, width, height);
		frame.setBufferedImage(myImage);
		// repaint
		frame.getDrawSpace().repaint();
		// ��������viewport
		ImageService.setViewport(frame.getScroll(), frame.getDrawSpace(),
				width, height);
		// ���ñ����Ĵ��ڱ���
		frame.setTitle("δ���� - ��ͼ");
	}

	/**
	 * �༭��ɫ
	 * 
	 * @param frame
	 *            ImageFrame
	 * @rerun void
	 */
	public void editColor(ImageFrame frame) {
		// ��ȡ��ɫ
		Color color = JColorChooser.showDialog(frame.getColorChooser(), "�༭��ɫ",
				Color.BLACK);
		color = color == null ? AbstractTool.color : color;
		// ���ù��ߵ���ɫ
		AbstractTool.color = color;
		// ����Ŀǰ��ʾ����ɫ
		frame.getCurrentColorPanel().setBackground(color);
	}

	/**
	 * �˳�
	 * 
	 * @parame frame ImageFrame
	 * @return void
	 */
	public void exit(ImageFrame frame) {
		save(false, frame);
		System.exit(0);
	}

	/**
	 * �����Ƿ�ɼ�
	 * 
	 * @param panel
	 *            JPanel
	 * @return void
	 */
	public void setVisible(JPanel panel) {
		boolean b = panel.isVisible() ? false : true;
		panel.setVisible(b);
	}

	/**
	 * ����˵��¼�
	 * 
	 * @param frame
	 *            ImageFrame
	 * @parem cmd String
	 * @return void
	 */
	public void menuDo(ImageFrame frame, String cmd) {
		if (cmd.equals("�༭��ɫ")) {
			editColor(frame);
		}

		if (cmd.equals("������(T)")) {
			setVisible(frame.getToolPanel());
		}

		if (cmd.equals("���Ϻ�(C)")) {
			setVisible(frame.getColorPanel());
		}

		if (cmd.equals("�½�(N)")) {
			createGraphics(frame);
		}

		if (cmd.equals("��(O)")) {
			open(frame);
		}

		if (cmd.equals("����(S)")) {
			save(true, frame);
		}

		if (cmd.equals("�˳�(X)")) {
			exit(frame);
		}

	}

}