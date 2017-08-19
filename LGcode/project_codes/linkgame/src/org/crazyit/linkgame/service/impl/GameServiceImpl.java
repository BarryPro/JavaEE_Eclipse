package org.crazyit.linkgame.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import linkgame.src.org.crazyit.linkgame.commons.GameConfiguration;
import linkgame.src.org.crazyit.linkgame.commons.LinkInfo;
import linkgame.src.org.crazyit.linkgame.service.AbstractBoard;
import linkgame.src.org.crazyit.linkgame.service.GameService;


/**
 * ��Ϸ�߼�������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class GameServiceImpl implements GameService {
	// ����һ���������飬ֻ�ṩgetter����
	private Piece[][] pieces;

	private GameConfiguration config;

	private AbstractBoard board;

	// �����������,��ʼֵΪ0
	private long grade = 0;

	public GameServiceImpl(GameConfiguration config) {
		// ����Ϸ�����ö������ñ�����
		this.config = config;
	}

	public void start() {
		this.grade = 0;
		// ����һ�����̶���
		AbstractBoard board = createBoard();
		// Ϊ����������board
		this.board = board;
		// ��ȡ��������
		this.pieces = board.create(config);
	}

	// ʵ�ֽӿڵ�hasPieces����
	public boolean hasPieces(Piece[][] pieces) {
		for (int i = 0; i < pieces.length; i++) {
			for (int j = 0; j < pieces[i].length; j++) {
				if (pieces[i][j] != null) {
					return true;
				}
			}
		}
		return false;
	}

	public Piece findPiece(int mouseX, int mouseY) {
		// �������ڱ����(����)board����Piece����, ���boardΪ��, ��������û������
		if (this.board == null) {
			return null;
		}
		// ���������ڴ���Piece�����ʱ��, ��ÿ��Piece�Ŀ�ʼ�������
		// GameConfiguration�����õ�beginImageX/beginImageYֵ, �������Ҫ��ȥ���ֵ
		int relativeX = mouseX - this.config.getBeginImageX();
		int relativeY = mouseY - this.config.getBeginImageY();
		// ���������ĵط��������е�һ��ͼƬ�Ŀ�ʼx����Ϳ�ʼy����ҪС, ��û���ҵ�����
		if (relativeX < 0 || relativeY < 0) {
			return null;
		}
		// ��ȡrelativeX���������������е�һάֵ, �ڶ�������Ϊÿ��ͼƬ�Ŀ�
		int indexX = getIndex(relativeX, this.board.getCommonImageWidth());
		// ��ȡrelativeY���������������еĶ�άֵ, �ڶ�������Ϊÿ��ͼƬ�ĸ�
		int indexY = getIndex(relativeY, this.board.getCommonImageHeight());
		// �������������������С������С, ����null
		if (indexX < 0 || indexY < 0) {
			return null;
		}
		// ����������������������������(���ߵ���), ����null
		if (indexX >= this.config.getXSize()
				|| indexY >= this.config.getYSize()) {
			return null;
		}
		// ���ر����������������ĳ��ֵ
		return this.pieces[indexX][indexY];
	}

	// ʵ�ֽӿڵ�link����
	public LinkInfo link(Piece p1, Piece p2) {
		// ����Piece��ͬһ��, ����������ѡ����ͬһ��Piece, ����null
		if (p1.equals(p2))
			return null;
		// ���p1��ͼƬ��p2��ͼƬ����ͬ, �򷵻�null
		if (!p1.isSameImage(p2))
			return null;
		// ���p2��p1�����, ����Ҫ����ִ�б�����, ������������
		if (p2.getIndexX() < p1.getIndexX())
			return link(p2, p1);
		// ��ȡp1�����ĵ�
		Point p1Point = getPieceCenter(p1);
		// ��ȡp2�����ĵ�
		Point p2Point = getPieceCenter(p2);
		// ��ȡÿ��ͼƬ�Ŀ�͸�
		int pieceWidth = this.board.getCommonImageWidth();
		int pieceHeight = this.board.getCommonImageHeight();
		// �������Piece��ͬһ��
		if (p1.getIndexY() == p2.getIndexY()) {
			// ������ͬһ�в�֮�������
			if (!isXBlock(p1Point, p2Point, pieceWidth)) {
				return new LinkInfo(p1Point, p2Point);
			}
		}
		// �������Piece��ͬһ��
		if (p1Point.getX() == p2Point.getX()) {
			if (!isYBlock(p1Point, p2Point, pieceHeight)) {// ����֮��û������ϰ�, û��ת�۵�
				return new LinkInfo(p1Point, p2Point);
			}
		}
		// ��һ��ת�۵�����
		// ��ȡ�������ֱ�������ĵ�, ��ֻ��һ��ת�۵�
		Point cornerPoint = getCornerPoint(p1Point, p2Point, pieceWidth,
				pieceHeight);
		if (cornerPoint != null) {
			return new LinkInfo(p1Point, cornerPoint, p2Point);
		}
		// ��map��key��ŵ�һ��ת�۵�, value��ŵڶ���ת�۵�, map��size˵���ж��ٸ��������ķ�ʽ
		Map<Point, Point> turns = getLinkPoints(p1Point, p2Point, pieceWidth,
				pieceHeight);
		if (turns.size() != 0) {
			return getShortcut(p1Point, p2Point, turns, getDistance(p1Point,
					p2Point));
		}
		return null;
	}

	public long countGrade() {
		this.grade += this.config.getPerGrade();
		return this.grade;
	}

	/**
	 * ��ȡp1��p2֮����̵�������Ϣ
	 * 
	 * @param p1
	 * @param p2
	 * @param turns
	 *            ��ת�۵��map
	 * @param shortDistance
	 *            ����֮�����̾���
	 * @return
	 */
	private LinkInfo getShortcut(Point p1, Point p2, Map<Point, Point> turns,
			int shortDistance) {
		List<LinkInfo> infos = new ArrayList<LinkInfo>();
		// �������map, ��ת�۵���ѡ��ĵ��װ��LinkInfo����, �ŵ�������
		for (Object info : turns.keySet()) {
			Point point1 = (Point) info;
			Point point2 = turns.get(point1);
			infos.add(new LinkInfo(p1, point1, point2, p2));
		}
		return getShortcut(infos, shortDistance);
	}

	/**
	 * ��infos�л�ȡ���ĸ�����̵��Ǹ�LinkInfo����
	 * 
	 * @param infos
	 * @return
	 */
	private LinkInfo getShortcut(List<LinkInfo> infos, int shortDistance) {
		int temp1 = 0;
		LinkInfo result = null;
		for (int i = 0; i < infos.size(); i++) {
			LinkInfo info = infos.get(i);
			// �������������ܾ���
			int distance = countAll(info.getLinkPoints());
			// ��ѭ����һ���Ĳ����temp1����
			if (i == 0) {
				temp1 = distance - shortDistance;
				result = info;
			}
			// �����һ��ѭ����ֵ��temp1�Ļ�С, ���õ�ǰ��ֵ��Ϊtemp1
			if (distance - shortDistance < temp1) {
				temp1 = distance - shortDistance;
				result = info;
			}
		}
		return result;
	}

	/**
	 * ����points�����е�ľ����ܺ�
	 * 
	 * @param points
	 * @return
	 */
	private int countAll(List<Point> points) {
		int result = 0;
		for (int i = 0; i < points.size(); i++) {
			if (i == points.size() - 1) {// ѭ�������һ��
				break;
			}
			Point point1 = points.get(i);
			Point point2 = points.get(i + 1);
			result += getDistance(point1, point2);
		}
		return result;
	}

	/**
	 * ��ȡ����LinkPoint֮�����̾���
	 * 
	 * @param p1
	 * @param p2
	 * @return
	 */
	private int getDistance(Point p1, Point p2) {
		int xDistance = Math.abs(p1.getX() - p2.getX());
		int yDistance = Math.abs(p1.getY() - p2.getY());
		return xDistance + yDistance;
	}

	/**
	 * ��ȡ����ת�۵�����
	 * 
	 * @param point1
	 * @param point2
	 * @return
	 */
	private Map<Point, Point> getLinkPoints(Point point1, Point point2,
			int pieceWidth, int pieceHeight) {
		Map<Point, Point> result = new HashMap<Point, Point>();
		// ��ȡ��point1Ϊ���ĵ�����, ����, ���µ�ͨ��
		List<Point> p1UpChanel = getUpChanel(point1, point2.getY(), pieceHeight);
		List<Point> p1RightChanel = getRightChanel(point1, point2.getX(),
				pieceWidth);
		List<Point> p1DownChanel = getDownChanel(point1, point2.getY(),
				pieceHeight);
		// ��ȡ��point2Ϊ���ĵ�����, ����, ���ϵ�ͨ��
		List<Point> p2DownChanel = getDownChanel(point2, point1.getY(),
				pieceHeight);
		List<Point> p2LeftChanel = getLeftChanel(point2, point1.getX(),
				pieceWidth);
		List<Point> p2UpChanel = getUpChanel(point2, point1.getY(), pieceHeight);
		// ��ȡ���̵����ֵ, �ߺͿ�
		int heightMax = (this.config.getYSize() + 1) * pieceHeight
				+ this.config.getBeginImageY();
		int widthMax = (this.config.getXSize() + 1) * pieceWidth
				+ this.config.getBeginImageX();
		// ��ȷ��������Ĺ�ϵ
		// point2��point1�����Ͻǻ������½�
		if (isLeftUp(point1, point2) || isLeftDown(point1, point2)) {
			// ������λ, ���ñ�����
			return getLinkPoints(point2, point1, pieceWidth, pieceHeight);
		}
		if (isInLine(point1, point2)) {// ��ͬһ��
			// ���ϱ���
			// ��p1�����ĵ����ϱ�����ȡ�㼯��
			p1UpChanel = getUpChanel(point1, 0, pieceHeight);
			// ��p2�����ĵ����ϱ�����ȡ�㼯��
			p2UpChanel = getUpChanel(point2, 0, pieceHeight);
			Map<Point, Point> upLinkPoints = getXLinkPoints(p1UpChanel,
					p2UpChanel, pieceHeight);
			// ���±���, ����������(�����ӵĵط�)�ı߿�
			// ��p1���ĵ����±�����ȡ�㼯��
			p1DownChanel = getDownChanel(point1, heightMax, pieceHeight);
			// ��p2���ĵ����±�����ȡ�㼯��
			p2DownChanel = getDownChanel(point2, heightMax, pieceHeight);
			Map<Point, Point> downLinkPoints = getXLinkPoints(p1DownChanel,
					p2DownChanel, pieceHeight);
			result.putAll(upLinkPoints);
			result.putAll(downLinkPoints);
		}
		if (isInColumn(point1, point2)) {// ��ͬһ��
			// �������
			// ��p1�����ĵ����������ȡ�㼯��
			List<Point> p1LeftChanel = getLeftChanel(point1, 0, pieceWidth);
			// ��p2�����ĵ����������ȡ�㼯��
			p2LeftChanel = getLeftChanel(point2, 0, pieceWidth);
			Map<Point, Point> leftLinkPoints = getYLinkPoints(p1LeftChanel,
					p2LeftChanel, pieceWidth);
			// ���ұ���, ���ó������̵ı߿�
			// ��p1�����ĵ����ұ�����ȡ�㼯��
			p1RightChanel = getRightChanel(point1, widthMax, pieceWidth);
			// ��p2�����ĵ����ұ�����ȡ�㼯��
			List<Point> p2RightChanel = getRightChanel(point2, widthMax,
					pieceWidth);
			Map<Point, Point> rightLinkPoints = getYLinkPoints(p1RightChanel,
					p2RightChanel, pieceWidth);
			result.putAll(leftLinkPoints);
			result.putAll(rightLinkPoints);
		}
		if (isRightUp(point1, point2)) {// point2��point1�����Ͻ�
			// ��ȡpoint1���ϱ���, point2���±���ʱ����������ӵĵ�
			Map<Point, Point> upDownLinkPoints = getXLinkPoints(p1UpChanel,
					p2DownChanel, pieceWidth);

			// ��ȡpoint1���ұ���, point2�������ʱ����������ӵĵ�
			Map<Point, Point> rightLeftLinkPoints = getYLinkPoints(
					p1RightChanel, p2LeftChanel, pieceHeight);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			p1UpChanel = getUpChanel(point1, 0, pieceHeight);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			p2UpChanel = getUpChanel(point2, 0, pieceHeight);
			// ��ȡpoint1���ϱ���, point2���ϱ���ʱ����������ӵĵ�
			Map<Point, Point> upUpLinkPoints = getXLinkPoints(p1UpChanel,
					p2UpChanel, pieceWidth);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			p1DownChanel = getDownChanel(point1, heightMax, pieceHeight);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			p2DownChanel = getDownChanel(point2, heightMax, pieceHeight);
			// ��ȡpoint1���±���, point2���±���ʱ����������ӵĵ�
			Map<Point, Point> downDownLinkPoints = getXLinkPoints(p1DownChanel,
					p2DownChanel, pieceWidth);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			p1RightChanel = getRightChanel(point1, widthMax, pieceWidth);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			List<Point> p2RightChanel = getRightChanel(point2, widthMax,
					pieceWidth);
			// ��ȡpoint1���ұ���, point2���ұ���ʱ����������ӵĵ�
			Map<Point, Point> rightRightLinkPoints = getYLinkPoints(
					p1RightChanel, p2RightChanel, pieceHeight);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			List<Point> p1LeftChanel = getLeftChanel(point1, 0, pieceWidth);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			p2LeftChanel = getLeftChanel(point2, 0, pieceWidth);
			// ��ȡpoint1�������, point2���ұ���ʱ����������ӵĵ�
			Map<Point, Point> leftLeftLinkPoints = getYLinkPoints(p1LeftChanel,
					p2LeftChanel, pieceHeight);
			result.putAll(upDownLinkPoints);
			result.putAll(rightLeftLinkPoints);
			result.putAll(upUpLinkPoints);
			result.putAll(downDownLinkPoints);
			result.putAll(rightRightLinkPoints);
			result.putAll(leftLeftLinkPoints);
		}
		if (isRightDown(point1, point2)) {// point2��point1�����½�
			// ��ȡpoint1���±���, point2���ϱ���ʱ��������ӵĵ�
			Map<Point, Point> downUpLinkPoints = getXLinkPoints(p1DownChanel,
					p2UpChanel, pieceWidth);
			// ��ȡpoint1���ұ���, point2�������ʱ��������ӵĵ�
			Map<Point, Point> rightLeftLinkPoints = getYLinkPoints(
					p1RightChanel, p2LeftChanel, pieceHeight);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			p1UpChanel = getUpChanel(point1, 0, pieceHeight);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			p2UpChanel = getUpChanel(point2, 0, pieceHeight);
			// ��ȡpoint1���ϱ���, point2���ϱ���ʱ��������ӵĵ�
			Map<Point, Point> upUpLinkPoints = getXLinkPoints(p1UpChanel,
					p2UpChanel, pieceWidth);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			p1DownChanel = getDownChanel(point1, heightMax, pieceHeight);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			p2DownChanel = getDownChanel(point2, heightMax, pieceHeight);
			// ��ȡpoint1���±���, point2���±���ʱ��������ӵĵ�
			Map<Point, Point> downDownLinkPoints = getXLinkPoints(p1DownChanel,
					p2DownChanel, pieceWidth);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			List<Point> p1LeftChanel = getLeftChanel(point1, 0, pieceWidth);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			p2LeftChanel = getLeftChanel(point2, 0, pieceWidth);
			// ��ȡpoint1�������, point2�������ʱ��������ӵĵ�
			Map<Point, Point> leftLeftLinkPoints = getYLinkPoints(p1LeftChanel,
					p2LeftChanel, pieceHeight);

			// ��ȡ��p1Ϊ���ĵ�����ͨ��
			p1RightChanel = getRightChanel(point1, widthMax, pieceWidth);
			// ��ȡ��p2Ϊ���ĵ�����ͨ��
			List<Point> p2RightChanel = getRightChanel(point2, widthMax,
					pieceWidth);
			// ��ȡpoint1���ұ���, point2���ұ���ʱ����������ӵĵ�
			Map<Point, Point> rightRightLinkPoints = getYLinkPoints(
					p1RightChanel, p2RightChanel, pieceHeight);

			result.putAll(downUpLinkPoints);
			result.putAll(rightLeftLinkPoints);// ���������ӵ����е㶼�ŵ������
			result.putAll(upUpLinkPoints);
			result.putAll(downDownLinkPoints);
			result.putAll(leftLeftLinkPoints);
			result.putAll(rightRightLinkPoints);
		}
		return result;
	}

	/**
	 * ������������, �ж���������Ԫ�ص�x����������ļ����е�Ԫ��x������ͬ(����), �����ͬ, ����ͬһ��, ���ж��Ƿ����ϰ�, û��,
	 * ��ӵ������map��ȥ
	 * 
	 * @param p1Chanel
	 * @param p2Chanel
	 * @param pieceHeight
	 * @return
	 */
	private Map<Point, Point> getYLinkPoints(List<Point> p1Chanel,
			List<Point> p2Chanel, int pieceHeight) {
		Map<Point, Point> result = new HashMap<Point, Point>();
		for (int i = 0; i < p1Chanel.size(); i++) {
			Point temp1 = p1Chanel.get(i);
			for (int j = 0; j < p2Chanel.size(); j++) {
				Point temp2 = p2Chanel.get(j);
				// ���x������ͬ(��ͬһ��)
				if (temp1.getX() == temp2.getX()) {
					// û���ϰ�, �ŵ�map��ȥ
					if (!isYBlock(temp1, temp2, pieceHeight)) {
						result.put(temp1, temp2);
					}
				}
			}
		}
		return result;
	}

	/**
	 * �ж��������Ƿ���ͬһ��(x������ͬ)
	 * 
	 * @param point1
	 * @param point2
	 * @return true point1��point2��ͬһ��(x������ͬ) false point1��point2����ͬһ��
	 */
	private boolean isInColumn(Point point1, Point point2) {
		return point1.getX() == point2.getX();
	}

	/**
	 * �ж��������Ƿ���ͬһ��(y������ͬ)
	 * 
	 * @param point1
	 * @param point2
	 * @return true point1��point2��ͬһ��(y������ͬ) false point1��point2����ͬһ��
	 */
	private boolean isInLine(Point point1, Point point2) {
		return point1.getY() == point2.getY();
	}

	/**
	 * ������������, �ж���������Ԫ�ص�y����������ļ����е�Ԫ��y������ͬ(����), �����ͬ, ����ͬһ��, ���ж��Ƿ����ϰ�, û��,
	 * ��ӵ������map��ȥ
	 * 
	 * @param p1Chanel
	 * @param p2Chanel
	 * @param pieceWidth
	 * @return ��ſ��Ժ���ֱ�����ӵ����ӵ�ļ�ֵ��
	 */
	private Map<Point, Point> getXLinkPoints(List<Point> p1Chanel,
			List<Point> p2Chanel, int pieceWidth) {
		Map<Point, Point> result = new HashMap<Point, Point>();
		for (int i = 0; i < p1Chanel.size(); i++) {
			// �ӵ�һͨ����ȡһ����
			Point temp1 = p1Chanel.get(i);
			// �ٱ����ڶ���ͨ��, ���µڶ�ͨ�����Ƿ��е������temp1��������
			for (int j = 0; j < p2Chanel.size(); j++) {
				Point temp2 = p2Chanel.get(j);
				// ���y������ͬ(��ͬһ��), ���ж�����֮���Ƿ���ֱ���ϰ�
				if (temp1.getY() == temp2.getY()) {
					if (!isXBlock(temp1, temp2, pieceWidth)) {
						// û���ϰ���ֱ�Ӽӵ������map��
						result.put(temp1, temp2);
					}
				}
			}
		}
		return result;
	}

	/**
	 * �ж�point2�Ƿ���point1�����Ͻ�
	 * 
	 * @param point1
	 * @param point2
	 * @return true point2��point1�����Ͻ� false point2����point1�����Ͻ�
	 */
	private boolean isLeftUp(Point point1, Point point2) {
		return (point2.getX() < point1.getX() && point2.getY() < point1.getY());
	}

	/**
	 * �ж�point2�Ƿ���point1�����½�
	 * 
	 * @param point1
	 * @param point2
	 * @return true point2��point1�����½� false point2����point1�����½�
	 */
	private boolean isLeftDown(Point point1, Point point2) {
		return (point2.getX() < point1.getX() && point2.getY() > point1.getY());
	}

	/**
	 * �ж�point2�Ƿ���point1�����Ͻ�
	 * 
	 * @param point1
	 * @param point2
	 * @return true point2��point1�����Ͻ� false point2����point1�����Ͻ�
	 */
	private boolean isRightUp(Point point1, Point point2) {
		return (point2.getX() > point1.getX() && point2.getY() < point1.getY());
	}

	/**
	 * �ж�point2�Ƿ���point1�����½�
	 * 
	 * @param point1
	 * @param point2
	 * @return true point2��point1�����½� false point2����point1�����½�
	 */
	private boolean isRightDown(Point point1, Point point2) {
		return (point2.getX() > point1.getX() && point2.getY() > point1.getY());
	}

	/**
	 * ��ȡ��������ͬһ�л���ͬһ�е�������ֱ�����ӵ�, ��ֻ��һ��ת�۵�
	 * 
	 * @param point1
	 * @param point2
	 * @return
	 */
	private Point getCornerPoint(Point point1, Point point2, int pieceWidth,
			int pieceHeight) {
		// ���ж����������λ�ù�ϵ
		// point2��point1�����Ͻ�, point2��point1�����½�
		if (isLeftUp(point1, point2) || isLeftDown(point1, point2)) {
			// ������λ, ���µ��ñ�����
			return getCornerPoint(point2, point1, pieceWidth, pieceHeight);
		}
		// ��ȡp1����, ����, ���µ�����ͨ��
		List<Point> point1RightChanel = getRightChanel(point1, point2.getX(),
				pieceWidth);
		List<Point> point1UpChanel = getUpChanel(point1, point2.getY(),
				pieceHeight);
		List<Point> point1DownChanel = getDownChanel(point1, point2.getY(),
				pieceHeight);
		// ��ȡp2����, ����, ���µ�����ͨ��
		List<Point> point2DownChanel = getDownChanel(point2, point1.getY(),
				pieceHeight);
		List<Point> point2LeftChanel = getLeftChanel(point2, point1.getX(),
				pieceWidth);
		List<Point> point2UpChanel = getUpChanel(point2, point1.getY(),
				pieceHeight);
		if (isRightUp(point1, point2)) {// point2��point1�����Ͻ�
			// ��ȡp1���Һ�p2���µĽ���
			Point linkPoint1 = getWrapPoint(point1RightChanel, point2DownChanel);
			// ��ȡp1���Ϻ�p2����Ľ���
			Point linkPoint2 = getWrapPoint(point1UpChanel, point2LeftChanel);
			// ��������һ������, ���û�н���, �򷵻�null
			return (linkPoint1 == null) ? linkPoint2 : linkPoint1;
		}
		if (isRightDown(point1, point2)) {// point2��point1�����½�
			// ��ȡp1���º�p2����Ľ���
			Point linkPoint1 = getWrapPoint(point1DownChanel, point2LeftChanel);
			// ��ȡp1���Һ�p2���µĽ���
			Point linkPoint2 = getWrapPoint(point1RightChanel, point2UpChanel);
			return (linkPoint1 == null) ? linkPoint2 : linkPoint1;
		}
		return null;
	}

	/**
	 * ��������ͨ��, ��ȡ���ǵĽ���
	 * 
	 * @param p1Chanel
	 * @param p2Chanel
	 * @param side
	 * @return
	 */
	private Point getWrapPoint(List<Point> p1Chanel, List<Point> p2Chanel) {
		for (int i = 0; i < p1Chanel.size(); i++) {
			Point temp1 = p1Chanel.get(i);
			for (int j = 0; j < p2Chanel.size(); j++) {
				Point temp2 = p2Chanel.get(j);
				if (temp1.equals(temp2)) {// �������List����Ԫ����ͬһ��, ����������ͨ���н���
					return temp1;
				}
			}
		}
		return null;
	}

	/**
	 * �ж�����y������ͬ�ĵ����֮���Ƿ����ϰ�, ��p1Ϊ�������ұ���
	 * 
	 * @param p1
	 * @param p2
	 * @param pieceWidth
	 * @return true ����֮�����ϰ� false ����֮��û���ϰ�
	 */
	private boolean isXBlock(Point p1, Point p2, int pieceWidth) {
		if (p2.getX() < p1.getX()) {// ���p2��p1���, ��������λ�õ��ñ�����
			return isXBlock(p2, p1, pieceWidth);
		}
		for (int i = p1.getX() + pieceWidth; i < p2.getX(); i = i + pieceWidth) {
			if (hasPiece(i, p1.getY())) {// ���ϰ�
				return true;
			}
		}
		return false;
	}

	/**
	 * �ж�����x������ͬ�ĵ����֮���Ƿ����ϰ�, ��p1Ϊ�������±���
	 * 
	 * @param p1
	 * @param p2
	 * @param pieceHeight
	 * @return true ����֮�����ϰ� false ����֮��û���ϰ�
	 */
	private boolean isYBlock(Point p1, Point p2, int pieceHeight) {
		if (p2.getY() < p1.getY()) {// ���p2��p1������, ��������λ�����µ��ñ�����
			return isYBlock(p2, p1, pieceHeight);
		}
		for (int i = p1.getY() + pieceHeight; i < p2.getY(); i = i
				+ pieceHeight) {
			if (hasPiece(p1.getX(), i)) {// ���ϰ�
				return true;
			}
		}
		return false;
	}

	/**
	 * �ж�GamePanel�е�x, y�������Ƿ���Piece����
	 * 
	 * @param x
	 * @param y
	 * @return true ��ʾ�и�������piece���� false ��ʾû��
	 */
	private boolean hasPiece(int x, int y) {
		if (findPiece(x, y) == null)
			return false;
		return true;
	}

	/**
	 * ��һ��Point����,�����������ͨ��
	 * 
	 * @param p
	 * @param pieceWidth
	 *            pieceͼƬ�Ŀ�
	 * @param min
	 *            �������ʱ��С�Ľ���
	 * @return
	 */
	private List<Point> getLeftChanel(Point p, int min, int pieceWidth) {
		List<Point> result = new ArrayList<Point>();
		// ��ȡ����ͨ��, ��һ�����������, ����ΪPieceͼƬ�Ŀ�
		for (int i = p.getX() - pieceWidth; i >= min; i = i - pieceWidth) {
			// �����ϰ�, ��ʾͨ���Ѿ�����ͷ, ֱ�ӷ���
			if (hasPiece(i, p.getY())) {
				return result;
			}
			result.add(new Point(i, p.getY()));
		}
		return result;
	}

	/**
	 * ��һ��Point����, ���������ұ�ͨ��
	 * 
	 * @param p
	 * @param pieceWidth
	 * @param max
	 *            ����ʱ�����ҽ���
	 * @return
	 */
	private List<Point> getRightChanel(Point p, int max, int pieceWidth) {
		List<Point> result = new ArrayList<Point>();
		// ��ȡ����ͨ��, ��һ�������ұ���, ����ΪPieceͼƬ�Ŀ�
		for (int i = p.getX() + pieceWidth; i <= max; i = i + pieceWidth) {
			// �����ϰ�, ��ʾͨ���Ѿ�����ͷ, ֱ�ӷ���
			if (hasPiece(i, p.getY())) {
				return result;
			}
			result.add(new Point(i, p.getY()));
		}
		return result;
	}

	/**
	 * ��һ��Point����, ������������ͨ��
	 * 
	 * @param p
	 * @param min
	 *            ���ϱ���ʱ��С�Ľ���
	 * @param pieceHeight
	 * @return
	 */
	private List<Point> getUpChanel(Point p, int min, int pieceHeight) {
		List<Point> result = new ArrayList<Point>();
		// ��ȡ����ͨ��, ��һ�������ұ���, ����ΪPieceͼƬ�ĸ�
		for (int i = p.getY() - pieceHeight; i >= min; i = i - pieceHeight) {
			// �����ϰ�, ��ʾͨ���Ѿ�����ͷ, ֱ�ӷ���
			if (hasPiece(p.getX(), i)) {
				return result;// ���һ�����ϰ�, ֱ�ӷ���
			}
			result.add(new Point(p.getX(), i));
		}
		return result;
	}

	/**
	 * ��һ��Point����, ������������ͨ��
	 * 
	 * @param p
	 * @param max
	 *            ���ϱ���ʱ��������
	 * @return
	 */
	private List<Point> getDownChanel(Point p, int max, int pieceHeight) {
		List<Point> result = new ArrayList<Point>();
		// ��ȡ����ͨ��, ��һ�������ұ���, ����ΪPieceͼƬ�ĸ�
		for (int i = p.getY() + pieceHeight; i <= max; i = i + pieceHeight) {
			// �����ϰ�, ��ʾͨ���Ѿ�����ͷ, ֱ�ӷ���
			if (hasPiece(p.getX(), i)) {
				return result;// ���һ�����ϰ�, ֱ�ӷ���
			}
			result.add(new Point(p.getX(), i));
		}
		return result;
	}

	/**
	 * ��ȡһ��Piece�����������
	 * 
	 * @param piece
	 * @return
	 */
	private Point getPieceCenter(Piece piece) {
		return new Point((piece.getEndX() - piece.getBeginX()) / 2
				+ piece.getBeginX(), (piece.getEndY() - piece.getBeginY()) / 2
				+ piece.getBeginY());
	}

	// ���߷���, ����relative�����ȡ����������һά���߶�ά��ֵ, sideΪÿ��ͼƬ�ߵĳ����߿�
	private int getIndex(int relative, int side) {
		// ��ʾ����relative���ڸ�������
		int index = -1;
		// ��������Ա߳�, û������, ������1
		// �������x����Ϊ20, �߿�Ϊ10, 20 % 10 û������, indexΪ1, ���������е�����Ϊ1(�ڶ���Ԫ��)
		if (relative % side == 0) {
			index = relative / side - 1;
		} else {
			// ������, �������x����Ϊ21, �߿�Ϊ10, 21 % 10������, indexΪ2
			// ���������е�����Ϊ2(������Ԫ��)
			index = relative / side;
		}
		return index;
	}

	// ʹ��һ��˽�з���ȥ�������̶���
	private AbstractBoard createBoard() {
		Random random = new Random();
		// ��ȡһ�������, ��ΪAbstractBoardֻ����������, �������Ϊ2
		int index = random.nextInt(2);
		switch (index) {
		// 0����SquareBoard
		case 0:
			return new SquareBoard();
			// 1����SimpleBoard
		case 1:
			return new SimpleBoard();
			// Ĭ�Ϸ���SquareBoard
		default:
			return new SquareBoard();
		}
	}

	/*
	 * ֱ�ӷ��ر������piece����
	 */
	public Piece[][] getPieces() {
		return this.pieces;
	}
}
