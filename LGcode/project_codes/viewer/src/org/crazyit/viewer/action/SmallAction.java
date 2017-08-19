package org.crazyit.viewer.action;

import viewer.src.org.crazyit.viewer.ViewerFrame;
import viewer.src.org.crazyit.viewer.ViewerService;

/**
 * ��СͼƬ��Action
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @author Kelvin Mak kelvin.mak125@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class SmallAction implements Action {

	public void execute(ViewerService service, ViewerFrame frame) {
		service.zoom(frame, false);
	}

}
