package com.sitech.acctmgr.inter.adj;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public interface IFeiDouPay {
	
    //飞豆充值验证，并下发二次确认短信
    OutDTO check(final InDTO inParam);

    //飞豆充值确认
    OutDTO cfm(final InDTO inParam);

}
