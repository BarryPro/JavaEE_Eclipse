package org.crazyit.ball;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.KeyEvent;
import java.io.IOException;

/**
 * ������Ϸ�߼��Ķ���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class BallService {
	// ����һ��Stick(����)
	private Stick stick = null;
	// ����һ������
	private Ball ball = null;
	// ����һ����Ϸ����ͼƬ
	private BallComponent gameOver = null;
	// ����һ��Ӯ����Ϸ��ͼƬ
	private BallComponent won = null;
	// ����һ��ש��ͼƬ����
	private Brick[][] bricks = null;
	private int width;
	private int height;
	BallFrame ballFrame = null;

	/**
	 * ˽�пչ�����
	 */
	private BallService() {
		super();
	}

	/**
	 * 
	 * @param frame
	 *            JFrame JFrameʵ��
	 * @param width
	 *            int ��
	 * @param height
	 *            int ��
	 * @return BallService
	 */
	public BallService(BallFrame frame, int width, int height)
			throws IOException {
		// ��ʼ������
		this.width = width;
		this.height = height;
		this.ballFrame = frame;
		// ����һ��Stick(����)ʵ��
		stick = new Stick(width, height, "img/stick.jpg");
		// ����һ�������ʵ��
		ball = new Ball(width, height, stick.getImage().getHeight(null),
				"img/ball.gif");
		// ��Ϸ����ͼƬ
		gameOver = new BallComponent("img/over.gif");
		// ӮͼƬ
		won = new BallComponent("img/win.gif");
		// ש��ͼƬ����
		bricks = createBrickArr("img/brick.gif", 11, 6);
	}

	/**
	 * run
	 * 
	 * @return void
	 */
	public void run() {
		// ��������ı�
		setBallPos();
		// ��������ĸı�
		setMagicPos();
	}

	/**
	 * ���õ���ͼƬ��λ��
	 * 
	 * @param ke
	 *            KeyEvent �����¼�
	 * @return void
	 */
	public void setStickPos(KeyEvent ke) {
		// �ѵ�����˶�״̬��Ϊtrue
		ball.setStarted(true);
		// ����������
		if (ke.getKeyCode() == KeyEvent.VK_LEFT) {
			if (stick.getX() - stick.SPEED > 0) {
				// x���������ƶ�
				stick.setX(stick.getX() - stick.SPEED);
			}
		}
		// ������ҷ����
		if (ke.getKeyCode() == KeyEvent.VK_RIGHT) {
			if (stick.getX() + stick.SPEED < width - stick.getPreWidth()) {
				// x���������ƶ�
				stick.setX(stick.getX() + stick.SPEED);
				// ballFrame.getBallGame().reStart( ballFrame );
			}
		}
		// �����F2��
		if (ke.getKeyCode() == KeyEvent.VK_F2) {
			// ��ʼ��ballFrame
			try {
				ballFrame.initialize();
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}
		}
	}

	/**
	 * ����С��ͼƬ��λ��
	 * 
	 * @return void
	 */
	public void setBallPos() {
		// ����������
		int absSpeedX = Math.abs(ball.getSpeedX());
		int absSpeedY = Math.abs(ball.getSpeedY());
		// �����Ϸ�Ѿ���ʼ����û�н���
		if (ball.isStarted()) {
			// ���С��������߽�
			if (ball.getX() - absSpeedX < 0) {
				// ��������x����
				ball.setX(ball.getImage().getWidth(null));
				// ��x������ٶ���Ϊ������
				ball.setSpeedX(-ball.getSpeedX());
			}
			// ���С�������ұ߽�
			if (ball.getX() + absSpeedX > width
					- ball.getImage().getWidth(null)) {
				// ��������x����
				ball.setX(width - ball.getImage().getWidth(null) * 2);
				// ��x������ٶ���Ϊ������
				ball.setSpeedX(-ball.getSpeedX());
			}
			// ���С�������ϱ߽�
			if (ball.getY() - absSpeedY < 0) {
				// ��������y����
				ball.setY(ball.getImage().getWidth(null));
				// ��y������ٶ���Ϊ������
				ball.setSpeedY(-ball.getSpeedY());
			}
			// ���С�������±߽�
			if (ball.getY() + absSpeedY > height
					- stick.getImage().getHeight(null)) {
				// ���С���뵵������ײ
				if (isHitStick(ball)) {
					// ��������y����
					ball.setY(height - ball.getImage().getHeight(null) * 2);
					// ��y������ٶ���Ϊ������
					ball.setSpeedY(-ball.getSpeedY());
				}
			}
			// ��ש����ײ����˶�
			for (int i = bricks.length - 1; i > -1; i--) {
				for (int j = bricks[i].length - 1; j > -1; j--) {
					// ���С����ש������ײ
					if (isHitBrick(bricks[i][j])) {
						if (ball.getSpeedY() > 0) {
							ball.setSpeedY(-ball.getSpeedY());
						}
					}
				}
			}
			// ������Ϸ
			if (ball.getY() > height) {
				ball.setStop(true);
			}

			// ����x����
			ball.setX(ball.getX() - (int) (Math.random() * 2)
					- ball.getSpeedX());
			// ����y����
			ball.setY(ball.getY() - (int) (Math.random() * 2)
					- ball.getSpeedY());
		}
	}

	/**
	 * С����ש���Ƿ�����ײ
	 * 
	 * @return boolean
	 */
	public boolean isHitBrick(Brick brick) {
		if (brick.isDisable()) {
			return false;
		}
		// ball��Բ��x����
		double ballX = ball.getX() + ball.getImage().getWidth(null) / 2;
		// ball��Բ��y����
		double ballY = ball.getY() + ball.getImage().getHeight(null) / 2;
		// brick������x����
		double brickX = brick.getX() + brick.getImage().getWidth(null) / 2;
		// brick������y����
		double brickY = brick.getY() + brick.getImage().getHeight(null) / 2;
		// ���������ľ���
		double distance = Math.sqrt(Math.pow(ballX - brickX, 2)
				+ Math.pow(ballY - brickY, 2));
		// �������ͼ���ص�������true;
		if (distance < (ball.getImage().getWidth(null) + brick.getImage()
				.getWidth(null)) / 2) {
			// ʹbrick��Ч
			brick.setDisable(true);
			return true;

		}
		return false;
	}

	/**
	 * BallComponent�Ƿ��뵵������ײ
	 * 
	 * @param image
	 *            BallComponent ͼ��
	 * @return boolean
	 */
	public boolean isHitStick(BallComponent bc) {
		// ��ȡͼƬ����
		Image tempImage = bc.getImage();
		// ����뵵������ײ
		if (bc.getX() + tempImage.getWidth(null) > stick.getX()
				&& bc.getX() < stick.getX() + stick.getPreWidth()
				&& bc.getY() + tempImage.getHeight(null) > stick.getY()) {
			return true;
		}
		return false;
	}

	/**
	 * ���õ��ߵ�λ��
	 * 
	 * @return void
	 */
	public void setMagicPos() {
		for (int i = 0; i < bricks.length; i++) {
			for (int j = 0; j < bricks[i].length; j++) {
				// ��ȡmagic
				Magic magic = bricks[i][j].getMagic();
				if (magic != null) {
					// ������brick��״̬����Ч��
					if (bricks[i][j].isDisable() && magic.getY() < height) {
						// ����magic��y������������
						magic.setY(magic.getY() + magic.getSpeed());
						// ���õ���Ŀ��
						setStickWidth(magic);

					}
				}
			}
		}
	}

	/**
	 * ���õ���ĳ���
	 * 
	 * @param magic
	 *            Magic ����
	 * @return void
	 */
	public void setStickWidth(Magic magic) {
		if (isHitStick(magic)) {
			// ���ߵ�����
			magic.magicDo(stick);
		}
	}

	/**
	 * �ж��Ƿ�Ӯ��
	 * 
	 * @return boolean
	 */
	public boolean isWon() {
		// �������ȫ��ש�飬��ΪӮ
		for (int i = 0; i < bricks.length; i++) {
			for (int j = 0; j < bricks[i].length; j++) {
				if (!bricks[i][j].isDisable()) {
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * ����һ������ΪBrick������
	 * 
	 * @param path
	 *            String ͼ��·��
	 * @param xSize
	 *            int
	 * @param ySize
	 *            int
	 * @return Brick[][]
	 */
	public Brick[][] createBrickArr(String path, int xSize, int ySize)
			throws IOException {
		// ����һ��Brick[][]
		Brick[][] bricks = new Brick[xSize][ySize];
		int x = 0;
		int y = 0;
		int random = 0;
		int imageSize = 28;
		boolean isDisable = false;
		// ������ʼ������
		for (int i = 0; i < xSize; i++) {
			for (int j = 0; j < ySize; j++) {
				// ����һ���µ�ש��
				random = (int) (Math.random() * 3);
				x = i * imageSize;
				y = j * imageSize;
				// һ������û��ש��
				isDisable = Math.random() > 0.8 ? true : false;
				if (isDisable) {
					random = 0;
				}
				Brick brick = new Brick(path, random, x, y);
				brick.setDisable(isDisable);
				// ����x����
				brick.setX(x);
				// ����y����
				brick.setY(y);
				bricks[i][j] = brick;
			}
		}
		return bricks;
	}

	/**
	 * ��ͼ
	 * 
	 * @param g
	 *            Graphics ������ͼ�Ķ���
	 * @return void
	 */
	public void draw(Graphics g) {
		// ���Ӯ��
		if (isWon()) {
			// ����Ӯ��ͼƬ
			g.drawImage(won.getImage(), won.getX(), won.getY(), width,
					height - 10, null);
		} else if (ball.isStop()) {
			// ������Ϸ����ͼ��
			g.drawImage(gameOver.getImage(), gameOver.getX(), gameOver.getY(),
					width, height - 10, null);
		} else {
			// ���ԭ����ͼ��
			g.clearRect(0, 0, width, height);
			// ���Ƶ���ͼ��
			g.drawImage(stick.getImage(), stick.getX(), stick.getY(), stick
					.getPreWidth(), stick.getImage().getHeight(null), null);
			// ���Ƶ���ͼ��
			g.drawImage(ball.getImage(), ball.getX(), ball.getY(), null);
			// ��������ש��ͼ��
			for (int i = 0; i < bricks.length; i++) {
				for (int j = 0; j < bricks[i].length; j++) {
					BallComponent magic = bricks[i][j].getMagic();
					// ������ש��ͼ���������Ч��
					if (!bricks[i][j].isDisable()) {
						// ���������1Ϊש��ͼ���ļ�϶
						g.drawImage(bricks[i][j].getImage(), bricks[i][j]
								.getX(), bricks[i][j].getY(), bricks[i][j]
								.getImage().getWidth(null) - 1, bricks[i][j]
								.getImage().getHeight(null) - 1, null);
					} else if (magic != null && magic.getY() < height) {
						g.drawImage(magic.getImage(), magic.getX(), magic
								.getY(), null);
					}
				}
			}
		}
	}
}