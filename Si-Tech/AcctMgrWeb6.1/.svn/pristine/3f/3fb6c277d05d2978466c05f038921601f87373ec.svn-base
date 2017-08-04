package com.sitech.acctmgr.atom.impl.volume;

import com.sitech.acctmgr.net.ResponseData;
import org.apache.commons.lang.StringUtils;

public class TestClient {
	public static void main(String[] args){
		
		VolumeClient client = new VolumeClient();
		client.getServerProxy().setServerInfo("10.110.19.135", 12391);
		//client.setRequestArgs("000060", "01", "01", "0", "13509716916", "0", "00", "00", "0", "0", "0");
		String reqString = "000189~!~01~!~01~!~20160711~!~18249070556~!~18249070556~!~03~!~04~!~1~!~1~!~1~!~9900000000000084~!~65~!~~!~50008~!~30001~!~~!~1~!~10000~!~1~!~1~!~20170101000000~!~20170711000000~!~1~!~1~!~1";
		String[] arr = StringUtils.splitByWholeSeparator(reqString, "~!~");
		client.setRequestArgs(arr);
		ResponseData response = client.getResponseData();
		System.out.println("response = " + response.getResponseString());
	}
}
