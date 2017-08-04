package busirule.rule.core.common;

import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.acctmgr.atom.domains.pub.PubWrtoffCtrlEntity;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.jcf.context.LocalContextFactory


/**
 * 出账期间不允许办理业务
 * 需要入参：无
 *@author guowy
	 */
class sWriteOff{
	def entryMethod(Object object){

		System.out.println("sWriteOff begin = ");
		IControl contral = LocalContextFactory.getInstance().getBean("controlEnt", IControl.class);
		PubWrtoffCtrlEntity  ctrlEnt = contral.getWriteOffFlagAndMonth();
		String iWrtoffFlag = ctrlEnt.getWrtoffFlag();
		System.out.println("iWrtoffFlag = " + iWrtoffFlag);
		if (iWrtoffFlag.equals("1")) { // 出账期间
			ResultBean bean = new ResultBean();
			bean.setResult(false);
			bean.setReturnCode("10111109000000019");
			bean.setReturnMsg("出账期间不可办理/查询该业务");
			return bean;
		}else{
			return true;
		}

	}
}

