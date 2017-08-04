package com.belong.service;

import java.util.List;

import com.belong.vo.Message;

public interface IMessageService {
	public boolean addMessage(Message message);
	public List<Message> queryMessage();
	public boolean checkEmail(String message);
	public boolean delMessage(Message message);
}
