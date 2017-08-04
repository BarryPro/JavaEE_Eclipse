package com.sitech.acctmgr.inter.adj;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 国际漫游漫游日套餐  </p>
* <p>Description: 国际漫游漫游日套餐扣费  </p>
* <p>Copyright: Copyright (c) 2017</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public interface IRoamPay {
	
	OutDTO payCfm(InDTO inParam);

}
