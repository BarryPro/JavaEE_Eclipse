package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class ChatTypeEntity {
	
    @JSONField(name = "CHARACTER_STR")
    private String characterStr;
    @JSONField(name = "CHAT_TYPE")
    private String chatType;
	/**
	 * @return the characterStr
	 */
	public String getCharacterStr() {
		return characterStr;
	}
	/**
	 * @param characterStr the characterStr to set
	 */
	public void setCharacterStr(String characterStr) {
		this.characterStr = characterStr;
	}
	/**
	 * @return the chatType
	 */
	public String getChatType() {
		return chatType;
	}
	/**
	 * @param chatType the chatType to set
	 */
	public void setChatType(String chatType) {
		this.chatType = chatType;
	}
}
