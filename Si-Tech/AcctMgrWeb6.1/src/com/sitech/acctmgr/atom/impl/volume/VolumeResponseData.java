package com.sitech.acctmgr.atom.impl.volume;

import com.sitech.acctmgr.net.ParseDataException;
import com.sitech.acctmgr.net.ResponseData;

public class VolumeResponseData implements ResponseData{
	private String response;
	
	public VolumeResponseData(String response){
		this.response = response;
	}

	@Override
	public void parse() throws ParseDataException {
		
	}

	@Override
	public String getResponseString() {
		return response;
	}

}
