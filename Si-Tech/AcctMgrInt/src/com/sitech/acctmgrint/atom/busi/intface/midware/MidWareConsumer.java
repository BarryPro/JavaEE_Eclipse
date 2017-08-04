package com.sitech.acctmgrint.atom.busi.intface.midware;

public class MidWareConsumer extends MidWare {
	
	private String message;
	
	MidWareConsumer(String url, String topic, String client) {
		super();
		setBrokerUrl(url);
		setTopicId(topic);
		setClientId(client);
	}
	
	public String getMessage() {

		
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
