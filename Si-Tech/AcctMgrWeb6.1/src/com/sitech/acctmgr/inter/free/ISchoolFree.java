package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface ISchoolFree {
	/**
	 * 功能：校园优惠查询
	 * 对应旧接口： sSchoolFavQry
	 * @param inParam
	 * @return
	 */
	OutDTO query(InDTO inParam);

}
