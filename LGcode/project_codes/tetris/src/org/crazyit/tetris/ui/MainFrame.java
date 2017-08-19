package org.crazyit.tetris.ui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.border.EtchedBorder;

import tetris.src.org.crazyit.tetris.object.PieceCreator;
import tetris.src.org.crazyit.tetris.object.Square;
import tetris.src.org.crazyit.tetris.object.impl.PieceCreatorImpl;

@SuppressWarnings("serial")
public class MainFrame extends JFrame {
	
	//��Ϸ��Panel
	private GamePanel gamePanel;
	

	//����
	private JLabel levelTextLabel = new JLabel("��     ��");
	private JLabel levelLabel = new JLabel();
	private Box levelTextBox = Box.createHorizontalBox();
	private Box levelBox = Box.createHorizontalBox();
	
	//����
	private Box scoreTextBox = Box.createHorizontalBox();
	private Box scoreBox = Box.createHorizontalBox();
	private JLabel scoreTextLabel = new JLabel("��     ��");
	private JLabel scoreLabel = new JLabel();
	
	//��һ��
	private Box nextTextBox = Box.createHorizontalBox();
	private JLabel nextTextLabel = new JLabel("��һ��");
	
	//����
	private Box resumeBox = Box.createHorizontalBox();
	private JLabel resumeLabel = new JLabel();
	//��ͣ
	private Box pauseBox = Box.createHorizontalBox();
	private JLabel pauseLabel = new JLabel();
	//��ʼ
	private Box startBox = Box.createHorizontalBox();
	private JLabel startLabel = new JLabel();
	
	private JPanel toolPanel = new JPanel();
	private Box blankBox = Box.createHorizontalBox();
	
	private PieceCreator creator = new PieceCreatorImpl();
	
	//��ǰ�����˶��Ķ���
	private Piece currentPiece;
	//��һ���󷽿����
	private Piece nextPiece;
	
	TetrisTask tetrisTask;
	
	private Timer timer;
	//��ǰ��Ϸ����
	private int currentLevel;
	
	private Square[][] squares;
	
	//����
	private int score = 0;
	
	//��ͣ�ı�ʶ, trueΪ��ͣ
	private boolean pauseFlag = false;

	public MainFrame() {
		this.currentLevel = 1;

		this.gamePanel = new GamePanel(this);
		
		BoxLayout toolPanelLayout = new BoxLayout(this.toolPanel, BoxLayout.Y_AXIS); 
		this.toolPanel.setLayout(toolPanelLayout);
		this.toolPanel.setBorder(new EtchedBorder());
		this.toolPanel.setBackground(Color.gray);
		//����
		this.scoreTextBox.add(this.scoreTextLabel);
		this.scoreLabel.setText(String.valueOf(this.score));
		this.scoreBox.add(this.scoreLabel);
		//����
		this.levelTextBox.add(this.levelTextLabel);
		this.levelLabel.setText(String.valueOf(this.currentLevel));
		this.levelBox.add(this.levelLabel);
		//������ť
		this.resumeLabel.setIcon(RESUME_ICON);
		this.resumeLabel.setPreferredSize(new Dimension(3, 25));
		this.resumeBox.add(this.resumeLabel);
		//��ͣ��ť
		this.pauseLabel.setIcon(PAUSE_ICON);
		this.pauseLabel.setPreferredSize(new Dimension(3, 25));
		this.pauseBox.add(this.pauseLabel);
		//��ʼ
		this.startLabel.setIcon(START_ICON);
		this.startLabel.setPreferredSize(new Dimension(3, 25));
		this.startBox.add(this.startLabel);
		//��һ��
		this.nextTextBox.add(this.nextTextLabel);

		this.toolPanel.add(Box.createVerticalStrut(10));
		this.toolPanel.add(scoreTextBox);
		this.toolPanel.add(Box.createVerticalStrut(10));
		this.toolPanel.add(scoreBox);
		this.toolPanel.add(Box.createVerticalStrut(10));
		this.toolPanel.add(levelTextBox);
		this.toolPanel.add(Box.createVerticalStrut(10));
		this.toolPanel.add(levelBox);
		this.toolPanel.add(Box.createVerticalStrut(15));
		this.toolPanel.add(this.resumeBox);
		this.toolPanel.add(Box.createVerticalStrut(15));
		this.toolPanel.add(this.pauseBox);
		this.toolPanel.add(Box.createVerticalStrut(15));
		this.toolPanel.add(this.startBox);
		this.toolPanel.add(Box.createVerticalStrut(30));
		this.toolPanel.add(this.nextTextBox);

		this.blankBox.add(Box.createHorizontalStrut(99));
		this.toolPanel.add(blankBox);
		
		this.add(this.gamePanel, BorderLayout.CENTER);
		this.add(this.toolPanel, BorderLayout.EAST);
		this.setPreferredSize(new Dimension(349, 416));
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLocation(350, 200);
		this.setResizable(false);
		this.setTitle("����˹����");
		this.pack();
		initListeners();
	}
	
	//���ص�ǰ�˶���Piece����
	public Piece getCurrentPiece() {
		return this.currentPiece;
	}
	
	//����꾭����ͣ��ťʱ��ʾ��ͼƬ
	private final static ImageIcon PAUSE_ON_ICON = new ImageIcon("images/button-bg-pause-on.gif");
	//��ͣ��ťͼƬ
	private final static ImageIcon PAUSE_ICON = new ImageIcon("images/button-bg-pause.gif");
	//������ťͼƬ
	private final static ImageIcon RESUME_ICON = new ImageIcon("images/button-bg-resume.gif");
	//��꾭��ʱ�İ�ťͼƬ
	private final static ImageIcon RESUME_ON_ICON = new ImageIcon("images/button-bg-resume-on.gif");
	//��ʼ��ťͼƬ
	private final static ImageIcon START_ICON = new ImageIcon("images/button-bg-start.gif");
	//��꾭��ʱ�İ�ťͼƬ
	private final static ImageIcon START_ON_ICON = new ImageIcon("images/button-bg-start-on.gif");
	
	private void initListeners() {
		this.resumeLabel.addMouseListener(new MouseAdapter() {
			public void mouseEntered(MouseEvent e) {
				resumeLabel.setIcon(RESUME_ON_ICON);
			}
			public void mouseExited(MouseEvent e) {
				resumeLabel.setIcon(RESUME_ICON);
			}
			public void mouseClicked(MouseEvent e) {
				resume();
			}
		});
		this.pauseLabel.addMouseListener(new MouseAdapter() {
			public void mouseEntered(MouseEvent e) {
				pauseLabel.setIcon(PAUSE_ON_ICON);
			}
			public void mouseExited(MouseEvent e) {
				pauseLabel.setIcon(PAUSE_ICON);
			}
			public void mouseClicked(MouseEvent e) {
				pause();
			}
		});
		this.startLabel.addMouseListener(new MouseAdapter() {
			public void mouseEntered(MouseEvent e) {
				startLabel.setIcon(START_ON_ICON);
			}
			public void mouseExited(MouseEvent e) {
				startLabel.setIcon(START_ICON);
			}
			public void mouseClicked(MouseEvent e) {
				start();
			}
		});
		//��Ӽ��̼�����
		this.addKeyListener(new KeyAdapter() {
			public void keyPressed(KeyEvent e) {
				//��
				if (e.getKeyCode() == 38) change();
				//��
				if (e.getKeyCode() == 40) down();
				//��
				if (e.getKeyCode() == 37) left(1);
				//��
				if (e.getKeyCode() == 39) right(1);
			}
		});
	}
	
	//��������ʱ�����ķ���
	public void change() {
		if (this.pauseFlag) return;
		if (this.currentPiece == null) return;
		this.currentPiece.change();
		//�ж�ת��������Ƿ�Խ��
		//�õ���ǰ������С��X����
		int minX = this.currentPiece.getMinXLocation();
		//���Խ��
		if (minX < 0) {
			//���Ƴ����Ĳ���
			this.currentPiece.setSquaresXLocation(-minX);
		}
		//�ж�ת�����ұ��Ƿ�Խ��
		int maxX = this.currentPiece.getMaxXLocation();
		int gamePanelWidth = this.gamePanel.getWidth();
		//�ұ�Խ��
		if (maxX > gamePanelWidth) {
			//���Ƴ���GamePanel��Ĳ���
			this.currentPiece.setSquaresXLocation(-(maxX - gamePanelWidth));
		}
		this.gamePanel.repaint();
	}

	
	//��, ����Ϊ����(һ��)
	public void right(int size) {
		if (this.pauseFlag) return;
		if (this.currentPiece == null) return;
		//�ж��ұ��Ƿ���Square
		if (isRightBolck()) return;
		//�ж��Ƿ񳬹�GamePanel�Ŀ�
		if (this.currentPiece.getMaxXLocation() >= this.gamePanel.getWidth()) return;
		int distance = Piece.SQUARE_BORDER * size;
		this.currentPiece.setSquaresXLocation(distance);
		this.gamePanel.repaint();
	}
	
	//��, ����Ϊ����(һ��)
	public void left(int size) {
		if (this.pauseFlag) return;
		if (this.currentPiece == null) return;
		//�ж�����Ƿ���Square
		if (isLeftBlock()) return;
		//�ж��Ƿ��Ѿ�������߽߱�
		if (this.currentPiece.getMinXLocation() <= 0) return;
		//�ó��ƶ�����
		int distance = -(Piece.SQUARE_BORDER * size);
		this.currentPiece.setSquaresXLocation(distance);
		this.gamePanel.repaint();
	}
	
	//�жϵ�ǰ��Piece��������Ƿ����ϰ�, ����true��ʾ��, ����false��ʾû��
	private boolean isLeftBlock() {
		List<Square> squares = this.currentPiece.getSquares();
		for (int i = 0; i < squares.size(); i++) {
			Square s = squares.get(i);
			//���ҽ��������е�Square����
			Square block = getSquare(s.getBeginX() - Piece.SQUARE_BORDER, s.getBeginY());
			//block�ǿձ�ʾ�����ϰ�
			if (block != null) return true;
		}
		return false;
	}
	
	//�жϵ�ǰ��Piece�����ұ��Ƿ����ϰ�, ����true��ʾ��, ����false��ʾû��
	private boolean isRightBolck() {
		List<Square> squares = this.currentPiece.getSquares();
		for (int i = 0; i < squares.size(); i++) {
			Square s = squares.get(i);
			//���ҽ��������е�Square����
			Square block = getSquare(s.getBeginX() + Piece.SQUARE_BORDER, s.getBeginY());
			//block�ǿձ�ʾ�����ϰ�
			if (block != null) return true;
		}
		return false;
	}
	
	//�¼���
	public void down() {
		if (this.pauseFlag) return;
		if (this.currentPiece == null) return;
		//�жϿ����½����Ƿ����ϰ����ߵ��ײ�
		if (isBlock() || isBottom()) return;
		int distance = Piece.SQUARE_BORDER;
		this.currentPiece.setSquaresYLocation(distance);
		//�ı�λ�ú����ж��Ƿ���Ҫ��ʾ��һ��
		showNext();
		this.gamePanel.repaint();
	}
	
	
	//������һ��
	private void createNextPiece() {
		this.nextPiece = this.creator.createPiece(NEXT_X, NEXT_Y);
		this.repaint();
	}
	
	//��һ��Piece��λ��
	private final static int NEXT_X = 270;
	private final static int NEXT_Y = 320;
	//��ǰPiece�Ŀ�ʼX����
	private final static int BEGIN_X = Piece.SQUARE_BORDER * 6;
	//��ǰPiece�Ŀ�ʼY����
	private final static int BEGIN_Y = -32;
	
	//��ʼ��Ϸ
	public void start() {
		//��ʼ�������ά����
		initSquares();
		if (this.timer != null) this.timer.cancel();
		createNextPiece();
		this.currentPiece = creator.createPiece(BEGIN_X, BEGIN_Y);
		this.timer = new Timer();
		//��ʼ����ʱ��
		this.tetrisTask = new TetrisTask(this);
		int time = 1000 / this.currentLevel;
		this.timer.schedule(this.tetrisTask, 0, time);
		this.pauseFlag = false;
		this.currentLevel = 1;
		this.score = 0;
		this.scoreLabel.setText(String.valueOf(this.score));
	}
	
	//��ͣ��Ϸ
	public void pause() {
		this.pauseFlag = true;
		if (this.timer != null) this.timer.cancel();
		this.timer = null;
	}
	
	//������Ϸ
	public void resume() {
		if (!this.pauseFlag) return;
		this.timer = new Timer();
		this.tetrisTask = new TetrisTask(this);
		int time = 1000 / this.currentLevel;
		timer.schedule(this.tetrisTask, 0, time);
		this.pauseFlag = false;
	}
	
	/************************************/
	//��ʼ�������ά����
	private void initSquares() {
		//�õ�����Դ�ŵķ������
		int xSize = this.gamePanel.getWidth()/Piece.SQUARE_BORDER;
		//�õ��߿��Դ�ŵķ������
		int ySize = this.gamePanel.getHeight()/Piece.SQUARE_BORDER;
		//�������Ķ�ά����
		this.squares = new Square[xSize][ySize];
		for(int i = 0; i < this.squares.length; i++) {
			for (int j = 0; j < this.squares[i].length; j++) {
				this.squares[i][j] = new Square(Piece.SQUARE_BORDER * i, 
						Piece.SQUARE_BORDER * j);
			}
		}
	}
	
	public Square[][] getSquares() {
		return this.squares;
	}
	
	public GamePanel getGamePanel() {
		return this.gamePanel;
	}
	
	public void paint(Graphics g) {
		super.paint(g);
		if (this.nextPiece == null) return;
		ImageUtil.paintPiece(g, nextPiece);
	}

	
	//������һ��
	public void showNext() {
		if (isBlock() || isBottom()) {
			//����ǰ��Piece�е�����Square����ӽ����ά������
			appendToSquares();
			//�ж��Ƿ�ʧ��
			if (isLost()) {
				this.repaint();
				this.timer.cancel();
				this.currentPiece = null;
				JOptionPane.showConfirmDialog(this, "��Ϸʧ��", "����", 
						JOptionPane.OK_CANCEL_OPTION);
				return;
			}
			//������
			cleanRows();
			finishDown();
		}
	}
	
	//�õ����������м���
	private void cleanRows() {
		//ʹ��һ�����ϱ��汻ɾ�����е�����
		List<Integer> rowIndexs = new ArrayList<Integer>();
		for (int j = 0; j < this.squares[0].length; j++) {
			int k = 0;
			for (int i = 0; i < this.squares.length; i++) {
				Square s = this.squares[i][j];
				//����ø���ͼƬ, ��k+1
				if (s.getImage() != null) k++;
			}
			//������ж���ͼƬ, ������
			if (k == this.squares.length) {
				//�ٴζԸ��н��б���, ���ø������и��ͼƬΪnull
				for (int i = 0; i < this.squares.length; i++) {
					Square s = this.squares[i][j];
					s.setImage(null);
				}
				rowIndexs.add(j);
				addScore();
			}
		}
		//����������Square
		handleDown(rowIndexs);
	}
	
	//�������
	private void addScore() {
		//�ӷ�
		this.score += 10;
		this.scoreLabel.setText(String.valueOf(score));
		//������Ա�100����, ���һ��
		if ((this.score % 100) == 0) {
			this.currentLevel += 1;
			this.levelLabel.setText(String.valueOf(this.currentLevel));
			//�������ö�ʱ��
			this.timer.cancel();
			this.timer = new Timer();
			this.tetrisTask = new TetrisTask(this);
			int time = 1000 / this.currentLevel;
			timer.schedule(this.tetrisTask, 0, time);
		}
	}
	
	//����������������Square��"�½�", ����Ϊ��ɾ�����е���������
	private void handleDown(List<Integer> rowIndexs) {
		//�ӱ�ɾ���������ó�������С����
		if (rowIndexs.size() == 0) return;
		int minCleanRow = rowIndexs.get(0);
		int cleanRowSize = rowIndexs.size();
		//�����½���Square
		for (int j = this.squares[0].length - 1; j >= 0; j--) {
			if (j < minCleanRow) {
				//�����������, ����������
				for (int i = 0; i < this.squares.length; i++) {
					Square s = this.squares[i][j];
					if (s.getImage() != null) {
						//�õ��½�ǰ��ͼƬ
						Image image = s.getImage();
						s.setImage(null);
						//�õ��½����Ӧ��Square����, ����Ķ�άֵҪ���������е�����
						Square sdown = this.squares[i][j + cleanRowSize];
						sdown.setImage(image);
					}
				}
			}
		}
	}
	
	//�ж��Ƿ���ײ�
	public boolean isBottom() {
		return this.currentPiece.getMaxYLocation() >= this.gamePanel.getHeight();
	}
	
	//�жϵ�ǰ��Piece�Ƿ������ϰ�, ����true��ʾ�����ϰ�, ����false��ʾû������
	public boolean isBlock() {
		List<Square> squares = this.currentPiece.getSquares();
		for (int i = 0; i < squares.size(); i++) {
			Square s = squares.get(i);
			//���ҽ��������е�Square����, ע��Ҫ��Y���ϱ߾�, ��ΪY�ǿ�ʼ����
			//��Ҫ��һ��Square�����Y����
			Square block = getSquare(s.getBeginX(), s.getBeginY() + Piece.SQUARE_BORDER);
			//block�ǿձ�ʾ�����ϰ�
			if (block != null) return true;
		}
		return false;
	}
	
	//���ݿ�ʼ�����ڵ�ǰ���������в�����Ӧ��Square
	private Square getSquare(int beginX, int beginY) {
		for (int i = 0; i < this.squares.length; i++) {
			for (int j = 0; j < this.squares[i].length; j++) {
				Square s = this.squares[i][j];
				//������Ŀ�ʼ������ͬ����ͼƬ��Ϊ��
				if (s.getImage() != null && (s.getBeginX() == beginX) && 
						(s.getBeginY() == beginY)) {
					return s;
				}
			}
		}
		return null;
	}
	
	//�ж��Ƿ�ʧ��, trueΪʧ��, false��֮
	private boolean isLost() {
		for (int i = 0; i < this.squares.length; i++) {
			Square s = this.squares[i][0];
			if (s.getImage() != null) {
				return true;
			}
		}
		return false;
	}

	//һ��Piece��������½�
	private void finishDown() {
		//����ǰ��Piece����Ϊ��һ��Piece
		this.currentPiece = this.nextPiece;
		//�����µ�Piece����
		this.currentPiece.setSquaresXLocation(-NEXT_X);
		this.currentPiece.setSquaresXLocation(BEGIN_X);
		this.currentPiece.setSquaresYLocation(-NEXT_Y);
		this.currentPiece.setSquaresYLocation(BEGIN_Y);
		//������һ��Piece
		createNextPiece();
	}
	
	//��Piece�����е�Square�����뵽��ά������
	private void appendToSquares() {
		List<Square> squares = this.currentPiece.getSquares();
		//����Piece�е�Square
		for(Square square : squares) {
			for(int i = 0; i < this.squares.length; i++) {
				for (int j = 0; j < this.squares[i].length; j++) {
					//�õ���ǰ�����е�Square
					Square s = this.squares[i][j];
					//�ж�Square�Ƿ�һ��
					if (s.equals(square)) this.squares[i][j] = square;
				}
			}
		}
		this.gamePanel.repaint();
	}
}

class TetrisTask extends TimerTask {
	//���������
	private MainFrame mainFrame;
	public TetrisTask(MainFrame mainFrame) {
		this.mainFrame = mainFrame;
	}
	public void run() {
		//�õ���ǰ�����˶��Ĵ󷽿�
		Piece currentPiece = this.mainFrame.getCurrentPiece();
		//�жϿ����½����Ƿ����ϰ����ߵ��ײ�
		if (this.mainFrame.isBlock() || this.mainFrame.isBottom()) {
			this.mainFrame.showNext();
			return;
		}
		currentPiece.setSquaresYLocation(Piece.SQUARE_BORDER);
		this.mainFrame.getGamePanel().repaint();
	}
}
