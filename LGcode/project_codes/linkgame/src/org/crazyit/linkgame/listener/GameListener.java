package org.crazyit.linkgame.listener;

import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JLabel;
import javax.swing.event.MouseInputAdapter;

import linkgame.src.org.crazyit.linkgame.commons.LinkInfo;
import linkgame.src.org.crazyit.linkgame.service.GameService;

/**
 * ��Ϸ����(GamePanel)������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class GameListener extends MouseInputAdapter {
	// ������Ϸ���߼��ӿ�
	private GameService gameService;

	// �����Ѿ���ѡ��Piece����
	private List<Piece> selects;

	// �������������������Ҫ����Ķ���
	private GamePanel gamePanel;

	private JLabel gradeLabel;

	// �����������
	private BeginListener beginListener;

	public GameListener(GameService gameService, GamePanel gamePanel,
			JLabel gradeLabel, BeginListener beginListener) {
		// �ڱ��๹��ʱ��Ϊ������������ֵ
		this.gameService = gameService;
		this.gamePanel = gamePanel;
		// ���๹��ʱ��ʼ��ѡ���Piece����
		this.selects = new ArrayList<Piece>();
		this.gradeLabel = gradeLabel;
		this.beginListener = beginListener;
	}

	// ��дMouseInputAdapter���mousePressed����, ��ʾ��갴��ʱ�Ķ���
	public void mousePressed(MouseEvent event) {
		if (gamePanel.getOverImage() != null) {
			// ��Ϸ�Ѿ�ʤ��
			return;
		}
		// ��ȡGameServiceImpl�е���������
		Piece[][] pieces = gameService.getPieces();

		// ��ȡ����x����
		int mouseX = event.getX();
		// ��ȡ����y����
		int mouseY = event.getY();
		// ��ȡ��ǰѡ���Piece����
		Piece currentPiece = gameService.findPiece(mouseX, mouseY);
		// ���û��ѡ���κ�Piece����(��������ĵط�û������), ��������ִ��
		if (currentPiece == null)
			return;
		// ��GamePanel��������ѡ������̶���
		gamePanel.setSelectPiece(currentPiece);
		// ��ʾ֮ǰû��ѡ���κ�һ��Piece
		if (this.selects.size() == 0) {
			// ����ǰ��Piece����ŵ����������, ���½�GamePanel����, ����������ִ��
			this.selects.add(currentPiece);
			gamePanel.repaint();
			return;
		}
		// ��ʾ֮ǰ�Ѿ�ѡ����һ��
		if (this.selects.size() == 1) {
			// ���Խ�֮ǰѡ���һ��Piece�����û�
			Piece prePiece = this.selects.get(0);
			// �������Ҫ��currentPiece��prePiece�����жϲ���������
			LinkInfo linkInfo = this.gameService.link(prePiece, currentPiece);
			// ����Piece������,
			if (linkInfo == null) {
				// ������ɹ�����, ��Ҫ��֮ǰѡ���һ��Piece�Ӽ�����ɾ��, �ٰѱ���ѡ���Piece�ӵ�������
				this.selects.remove(0);
				this.selects.add(currentPiece);
			} else {
				// ���ǿ�������, ��GamePanel����LinkInfo
				gamePanel.setLinkInfo(linkInfo);
				// ȥ��ѡ��ͼ��
				gamePanel.setSelectPiece(null);
				// ���÷���
				long grade = gameService.countGrade();
				gradeLabel.setText(String.valueOf(grade));
				// ������Piece�����������ɾ��
				pieces[prePiece.getIndexX()][prePiece.getIndexY()] = null;
				pieces[currentPiece.getIndexX()][currentPiece.getIndexY()] = null;
				this.selects.remove(0);// ��ռ���
				// �ж��������Ƿ�������, ���û��, ��Ϸʤ��
				if (!gameService.hasPieces(pieces)) {
					// ����Ϸ��Ϊʤ��, ����ʾͼƬ
					gamePanel
							.setOverImage(ImageUtil.getImage("images/win.gif"));
					// ȡ������
					this.beginListener.getTimer().cancel();
				}
			}
		}

		gamePanel.repaint();
	}

	public void mouseReleased(MouseEvent event) {
		gamePanel.repaint();
	}
}
