package busirule.rule.hlj.s8014

import com.sitech.ac.rdc.re.api.bean.ResultBean;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.common.utils.StringUtils;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
class s8014 {
	
	/**
	 * 转账业务限制
	 * 1、限制转账金额>0
	 * 2、转入账户和转出账户不能相同
	 * 入参：TRANS_FEE 转账金额 
	 * 		 OUT_CONTRACT_NO 转出账户
	 * 		 IN_CONTRACT_NO 转入账户
	 * 
	 *@author guowy
		 */
	def entryMethod(Object object){
		
		com.sitech.ac.rdc.re.api.common.util.MBean arg0 = object.get("contextData");
		
		//获取入参
		long transFee = 0;
		if(StringUtils.isNotEmptyOrNull(arg0.getBodyStr("TRANS_FEE"))){
			transFee = Long.parseLong(arg0.getBodyStr("TRANS_FEE"));
		}
		String opType = arg0.getBodyStr("OP_TYPE");
		long outContractNo = Long.parseLong(arg0.getBodyStr("OUT_CONTRACT_NO"));
		long inContractNo = Long.parseLong(arg0.getBodyStr("IN_CONTRACT_NO"));
		
		//1.限制转账金额>0
		if (transFee < 0 && (!opType.equals("TransAccountXH"))) {
			ResultBean bean = new ResultBean();
			bean.setResult(false);
			bean.setReturnCode("10111109801400004");
			bean.setReturnMsg("转账金额不能小于0！");
			return bean;
		}
		
		//2.转入账户和转出账户是否相同验证
		if (outContractNo == inContractNo) {
			ResultBean bean = new ResultBean();
			bean.setResult(false);
			bean.setReturnCode("10111109801400005");
			bean.setReturnMsg("不允许转账账户与被转账户相同！");
			return bean;
		}
				
		return true;			
	}

}
