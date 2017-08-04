package busirule.rule.core.common

import java.util.logging.Logger;

import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity
import com.sitech.acctmgr.atom.entity.inter.IUser
import com.sitech.jcf.context.LocalContextFactory


/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
class sRunCodeNota {
	def entryMethod(Object obj){
		
		MBean arg0 = obj.get("contextData");
		String phoneNo = arg0.getBodyStr("PHONE_NO");

		IUser user = LocalContextFactory.getInstance().getBean("userEnt", IUser.class);
		UserInfoEntity userInfo = user.getUserInfo(phoneNo);
		if (userInfo != null) {
			String runCode = userInfo.getRunCode();

			if (!runCode.equals("A")) {
				ResultBean bean = new ResultBean();
				bean.setResult(false);
				bean.setReturnCode("10111109000000078");
				bean.setReturnMsg("该用户状态不正常，不允许办理该业务！");
				return bean;
			}
		}
		return true;
	}
}
