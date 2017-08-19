package org.crazyit.flashget.state;

import javax.swing.ImageIcon;

public class Connecting extends AbstractState {

	@Override
	public ImageIcon getIcon() {
		return ImageUtil.CONNECTING_IMAGE;
	}
	
	public String getState() {
		return "connecting";
	}
}
