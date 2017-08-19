package org.crazyit.transaction.ui.handler.impl;

import transaction.src.org.crazyit.transaction.ui.dialog.TransferTransactionDialog;
import transaction.src.org.crazyit.transaction.ui.handler.UserSelectHandler;

public class TransferUserSelectHandler implements UserSelectHandler {
	//ת������Ĵ�����
	private TransferTransactionDialog dialog;
	public TransferUserSelectHandler(TransferTransactionDialog dialog) {
		this.dialog = dialog;
	}
	public void confirm(String userId, String realName) {
		this.dialog.getUserIdText().setText(userId);
		this.dialog.getRealNameText().setText(realName);
	}
}
