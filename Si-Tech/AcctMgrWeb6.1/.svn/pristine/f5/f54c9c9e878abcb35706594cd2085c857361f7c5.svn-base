package busirule.rule.hlj.s8107

import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity
import com.sitech.acctmgr.atom.entity.inter.IUser
import com.sitech.acctmgr.common.constant.CommonConst
import com.sitech.jcf.context.LocalContextFactory
import com.sitech.common.utils.StringUtils

class s8107 {
    /**
     * 功能：物联网休眠期用户限制
     * 需要参数：PHONE_NO
     */
    def entryMethod(Object obj) {
        MBean arg0 = obj.get("contextData");
        String phoneNo = arg0.getBodyStr("PHONE_NO");

            IUser user = LocalContextFactory.getInstance().getBean("userEnt", IUser.class);
            UserInfoEntity uie = user.getUserInfo(phoneNo);
            String runCode = uie.getRunCode();
            long idNo = uie.getIdNo();
            
            String addNo="";
			addNo = user.getAddServiceNo(idNo, CommonConst.NBR_TYPE_WLW);
			if(StringUtils.isNotEmptyOrNull(addNo)) {
				if(runCode.equals("S")) {
					ResultBean resultBean = new ResultBean();
                	resultBean.setResult(false);
                	resultBean.setReturnCode("10111109810700001");
                	resultBean.setReturnMsg("物联网休眠期用户不允许查询");
                	return resultBean;
				}
			}

        return true;

    }
}
