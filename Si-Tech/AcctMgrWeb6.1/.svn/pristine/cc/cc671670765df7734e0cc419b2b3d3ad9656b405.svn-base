package com.sitech.acctmgr.atom.impl.volume;

import com.sitech.acctmgr.net.ServerProxy;
import com.sitech.acctmgr.net.impl.AbstractClient;

public class VolumeClient extends AbstractClient {

	public VolumeClient(){
		super();
		setServerProxy(null);
	}
	
	public VolumeClient(ServerProxy proxy){
		super(proxy);
	}
	@Override
	public void setResponseData() {
		responseData = serverProxy.query(new VolumeRequestData(args));
	}

	@Override
	public void setServerProxy(ServerProxy arg0) {
		if(arg0 != null){
			serverProxy = arg0;
		}else{
			serverProxy = new VolumeServerProxy();
		}
	}

}
