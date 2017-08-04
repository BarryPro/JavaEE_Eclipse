package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
* <p>Title: 智能终端CRM缴费报表接口  </p>
* <p>Description: 智能终端CRM缴费数据汇总和展示  </p>
* <p>Copyright: Copyright (c) 2017</p>
* <p>Company: SI-TECH </p>
* @author suzj
* @version 1.0
*/
public interface ICRMIntellPrt {
	
	/**
	 * 名称：智能终端CRM缴费报表数据汇总
	 * @param  login_no
	 * @param  begin_date
	 * @param  end_date
	 * @return login_accept
	 * @author SUZJ
	 */
	OutDTO collect(final InDTO inParam);
	
	/**
	 * 名称：智能终端CRM缴费报表查询
	 * @param login_accept
	 * @return 
	 * @author SUZJ
	 */
	OutDTO query(final InDTO inParam);
	
}
