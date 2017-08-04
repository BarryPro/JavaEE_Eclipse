package com.belong.service;

import java.util.List;
import java.util.regex.Pattern;

import com.belong.dao.IMessageDAO;
import com.belong.dao.MessageDAOImp;
import com.belong.vo.Message;

public class MessageServiceImp implements IMessageService {
	private IMessageDAO dao = new MessageDAOImp();
	@Override
	public boolean addMessage(Message message) {
		// TODO Auto-generated method stub
		return dao.addMessage(message);
	}

	@Override
	public List<Message> queryMessage() {
		// TODO Auto-generated method stub
		return dao.queryMessage();
	}

	@Override
	public boolean checkEmail(String message) {
		// TODO Auto-generated method stub
		//java中的正则用两个斜杠表示一个斜杠
		return Pattern.matches("^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$", message);
	}

	@Override
	public boolean delMessage(Message message) {
		// TODO Auto-generated method stub
		return dao.delMessage(message);
	}

}
