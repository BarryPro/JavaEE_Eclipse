package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
* <p>Title:wlan预付费扣款  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public interface IWPrePayCard {
	
	OutDTO limit(InDTO inParam);
	
	OutDTO cfm(InDTO inParam);
	
}
