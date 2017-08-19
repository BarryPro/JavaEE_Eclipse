package org.crazyit.linkgame.view;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.List;

import javax.swing.JPanel;
import javax.swing.border.EtchedBorder;

import linkgame.src.org.crazyit.linkgame.commons.LinkInfo;
import linkgame.src.org.crazyit.linkgame.service.GameService;

/**
 * ��Ϸ����������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class GamePanel extends JPanel {
	private GameService gameService;

	// GamePanel�����ֻ��ʾһ���Ѿ���ѡ�е�����
	private Piece selectPiece;

	// ������Ϣ����
	private LinkInfo linkInfo;

	// ��Ϸ����ʱ����ʾ��ͼƬ
	private BufferedImage overImage;

	public void setLinkInfo(LinkInfo linkInfo) {
		this.linkInfo = linkInfo;
	}

	public GamePanel(GameService gameService) {
		// �������JPanel�ı�����ɫ
		this.setBackground(new Color(55, 77, 118));
		// �������JPanel�ı߿���ʽ
		this.setBorder(new EtchedBorder());
		// �����ڹ��챾����ʱ����GameService
		this.gameService = gameService;
	}

	public void setOverImage(BufferedImage overImage) {
		this.overImage = overImage;
	}

	public BufferedImage getOverImage() {
		return overImage;
	}

	public void setSelectPiece(Piece piece) {
		this.selectPiece = piece;
	}

	public void paint(Graphics g) {
		// ������ͼ����GamePanel(����)��0, 0��ʼ������������GamePanel
		g.drawImage(ImageUtil.getImage("images/background.gif"), 0, 0,
				getWidth(), getHeight(), null);
		// ͨ��gameService���pieces�������
		Piece[][] pieces = gameService.getPieces();
		// ���������������������
		// ���piecesû�г�ʼ�����Ͳ�Ҫ�����������Ϊ
		if (pieces != null) {
			// �������ά������б���
			for (int i = 0; i < pieces.length; i++) {
				for (int j = 0; j < pieces[i].length; j++) {
					// �����λ�������ά�����ĳ��ֵ��Ϊ�գ���ô����������ͼƬ������
					if (pieces[i][j] != null) {
						// �õ����Piece����
						Piece piece = pieces[i][j];
						// ����Graphics���drawImage������ͼ����piece�Ŀ�ʼ���꿪ʼ��
						g.drawImage(piece.getImage(), piece.getBeginX(), piece
								.getBeginY(), null);
					}
				}
			}
		}
		if (this.selectPiece != null) {
			// ��ǰ�����ӱ�ѡ��, ����ѡ���ͼƬ
			g.drawImage(ImageUtil.getImage("images/selected.gif"),
					this.selectPiece.getBeginX(), this.selectPiece.getBeginY(),
					null);
		}
		// �����ǰ��������linkInfo����, ��������Ϣ
		if (this.linkInfo != null) {
			// ��ʱ���ṩ����
			drawLine(this.linkInfo, g);
			// ����������linkInfo����
			this.linkInfo = null;
		}
		// ���overImage��Ϊ��, ���ʾ��Ϸ�Ѿ�ʤ������ʧ��
		if (this.overImage != null) {
			g.drawImage(this.overImage, 0, 0, null);
		}
	}

	private void drawLine(LinkInfo linkInfo, Graphics g) {
		List<Point> points = linkInfo.getLinkPoints();
		for (int i = 0; i < points.size() - 1; i++) {
			Point currentPoint = points.get(i);
			Point nextPoint = points.get(i + 1);

			g.drawLine(currentPoint.getX(), currentPoint.getY(), nextPoint
					.getX(), nextPoint.getY());
		}
	}
}
