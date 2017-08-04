package com.sitech.acctmgr.atom.impl.hlj.pay;

import java.util.Map;

import com.sitech.acctmgr.atom.dto.pay.S8016CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8016CfmOutDTO;
import com.sitech.acctmgr.atom.impl.pay.S8016;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;

/**
*
* <p>Title: 空中充值黑龙江服务  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
@ParamTypes({ 
	@ParamType(c = S8016CfmInDTO.class, oc = S8016CfmOutDTO.class, m = "cfm")
	})
public class S8016HLJ extends S8016 {

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.impl.pay.S8016#sendPayMsg(java.util.Map)
	 */
	@Override
	protected void sendPayMsg(Map<String, Object> inParam) {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.impl.pay.S8016#sendPayErrMsg(java.util.Map)
	 */
	@Override
	protected void sendPayErrMsg(String errType, Map<String, Object> inParam) {

		
	}

}
