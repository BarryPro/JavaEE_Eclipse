package org.crazyit.linkgame.service.impl;

import java.util.ArrayList;
import java.util.List;

import linkgame.src.org.crazyit.linkgame.commons.GameConfiguration;
import linkgame.src.org.crazyit.linkgame.service.AbstractBoard;

/**
 * �������ε���Ϸ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */

public class SquareBoard extends AbstractBoard {
	protected List<Piece> createPieces(GameConfiguration config,
			Piece[][] pieces) {
		List<Piece> notNullPieces = new ArrayList<Piece>();
		for (int i = 0; i < pieces.length; i++) {
			for (int j = 0; j < pieces[i].length; j++) {
				// �ȹ���һ��Piece����, ֻ���������е�λ��Ϊi, j������ֵ������
				Piece piece = new Piece(i, j);
				// ��ӵ��ǿ�Piece����ļ�����
				notNullPieces.add(piece);
			}
		}
		return notNullPieces;
	}
}
