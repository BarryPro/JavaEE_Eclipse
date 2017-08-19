package org.crazyit.tetris.piece;

import java.awt.Image;
import java.util.ArrayList;
import java.util.List;

import tetris.src.org.crazyit.tetris.object.Square;

public class Piece0 extends Piece {

	public Piece0(Image image) {
		//��������С���飬һ������Ϊһ�ֱ仯
		List<Square> squares = new ArrayList<Square>();
		squares.add(new Square(image, 0, 0));
		squares.add(new Square(image, 0, image.getHeight(null)));
		squares.add(new Square(image, image.getWidth(null), 0));
		squares.add(new Square(image, image.getWidth(null), image.getHeight(null)));
		//���뵽�仯��
		super.changes.add(squares);
		super.setSquares(squares);
	}
}
