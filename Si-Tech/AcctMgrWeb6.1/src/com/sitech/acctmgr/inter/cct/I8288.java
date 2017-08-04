package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 信用度调整接口 </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @version 1.0
*/
public interface I8288 {
	/**
	 * Description:集团信用度查询
	 * @param unit_id 集团编码
	 * @return
	 */
	OutDTO grpInit(final InDTO inParam);

	/**
	 * Description:集团信用等级修改
	 * @return
	 */
	OutDTO grpCfm(final InDTO inParam);
}
