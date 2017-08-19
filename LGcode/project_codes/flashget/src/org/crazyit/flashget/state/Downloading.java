package org.crazyit.flashget.state;

import javax.swing.ImageIcon;

public class Downloading extends AbstractState {

	@Override
	public ImageIcon getIcon() {
		return ImageUtil.DOWNLOADING_IMAGE;
	}
	public String getState() {
		return "downloading";
	}
}
