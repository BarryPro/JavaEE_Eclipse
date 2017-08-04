package com.sitech.acctmgr.inter.acctmng;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:  节假日免停办理接口 </p>
* <p>Description:  节假日免停办理接口 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author xiongjy
* @version 1.0
*/
public interface IHolidayOpr {
	OutDTO cfm(InDTO inParam);
}
