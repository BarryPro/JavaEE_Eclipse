package org.crazyit.image.tool;

import java.awt.event.MouseEvent;

/**
 * ���й��ߵĽӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface Tool {
	// ��������
	public static final String ARROW_TOOL = "ArrowTool";
	public static final String PENCIL_TOOL = "PencilTool";
	public static final String BRUSH_TOOL = "BrushTool";
	public static final String CUT_TOOL = "CutTool";
	public static final String ERASER_TOOL = "EraserTool";
	public static final String LINE_TOOL = "LineTool";
	public static final String RECT_TOOL = "RectTool";
	public static final String POLYGON_TOOL = "PolygonTool";
	public static final String ROUND_TOOL = "RoundTool";
	public static final String ROUNDRECT_TOOL = "RoundRectTool";
	public static final String ATOMIZER_TOOL = "AtomizerTool";
	public static final String COLORPICKED_TOOL = "ColorPickedTool";

	/**
	 * �϶����
	 * 
	 * @param e
	 *            MouseEvent
	 * @param jg
	 *            Graphics
	 * @return void
	 */
	public void mouseDragged(MouseEvent e);

	/**
	 * �ƶ����
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseMoved(MouseEvent e);

	/**
	 * �ɿ����
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseReleased(MouseEvent e);

	/**
	 * �������
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mousePressed(MouseEvent e);

	/**
	 * ���
	 * 
	 * @param e
	 *            MouseEvent
	 * @return void
	 */
	public void mouseClicked(MouseEvent e);
}