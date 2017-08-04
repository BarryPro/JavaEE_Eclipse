package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.io.IOException;


/**
*
* <p>Title: 集团自由划拨文件导入  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author qiaolin
* @version 1.0
*/
public interface I8295 {  


	 
	/**
	 * 文件入库
	 * @param inParam
	 * @return
     */
	OutDTO cfm(final InDTO inParam) throws IOException;

	
	/**
	 * 集团信息查询
	 * @param inParam
	 * @return
     */
	OutDTO init(InDTO inParam);

	
}
