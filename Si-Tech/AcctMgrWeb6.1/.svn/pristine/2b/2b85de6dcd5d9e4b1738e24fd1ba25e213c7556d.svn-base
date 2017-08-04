package com.sitech.acctmgr.atom.impl.volume;

import com.sitech.acctmgr.net.ParseDataException;
import com.sitech.acctmgr.net.RequestData;

public class VolumeRequestData implements RequestData {
	private String[] args;
	private String requestString;
	public static final String SPLIT_CODE = "~!~";
	
	public VolumeRequestData(String[] args){
		this.args = args;
	}

	@Override
	public void parse() throws ParseDataException {
		args = requestString.split(SPLIT_CODE);
	}

	@Override
	public String getRequestString() {
		StringBuffer reqbuff = new StringBuffer();
		for(int i = 0; i < args.length; i++){
			reqbuff.append(args[i]);
			if(i != args.length - 1){
				reqbuff.append(SPLIT_CODE);
			}
		}
		requestString = String.format("%06d%s%s", reqbuff.length() + 6 + SPLIT_CODE.length(), SPLIT_CODE, reqbuff.toString());

		System.out.println("requestString = [" + requestString + "]");
		return requestString;
	}
	
	public String[] getArgs(){
		return args;
	}

}
