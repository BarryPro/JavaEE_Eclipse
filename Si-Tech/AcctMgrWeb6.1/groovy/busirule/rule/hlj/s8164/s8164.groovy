package busirule.rule.hlj.s8164

import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity
import com.sitech.acctmgr.atom.entity.inter.IUser
import com.sitech.jcf.context.LocalContextFactory
import org.apache.commons.lang.StringUtils

/**
 * Created by wangyla on 2016/6/30.
 */
class s8164 {
    /**
     * 功能：物联网帐单查询与宽带帐单查询规则限制
     * <p>注意：物联网判断这里只对组成判断，还需要服务对品牌进行判断</p>
     * @param obj
     * 需要参数：PHONE_NO,QUERY_TYPE,YEAR_MONTH
     */
    def entryMethod(Object obj) {
        MBean arg0 = obj.get("contextData");
        String phoneNo = arg0.getBodyStr("PHONE_NO");
        int yearMonth = Integer.parseInt(arg0.getBodyStr("YEAR_MONTH"));

        if (StringUtils.isNotEmpty(phoneNo)) {
            IUser user = LocalContextFactory.getInstance().getBean("userEnt", IUser.class);
            if (user.isInternetOfThingsPhone(phoneNo) == true) {

                if (yearMonth < 190001) {
                    ResultBean resultBean = new ResultBean();
                    resultBean.setResult(false);
                    resultBean.setReturnCode("10111109816400002");
                    resultBean.setReturnMsg("物联网用户不能查询190001前的帐单");
                    return resultBean;
                }

                UserInfoEntity uie = user.getUserInfo(phoneNo);
                String runCode = uie.getRunCode();
                String brandId = uie.getBrandId();

                if (!brandId.equals("2330PB")) {
                    ResultBean resultBean = new ResultBean();
                    resultBean.setResult(false);
                    resultBean.setReturnCode("10111109816400001");
                    resultBean.setReturnMsg("非物联网用户不能查询帐单");
                    return resultBean;
                }

                if (runCode.equals("S")) {
                    ResultBean resultBean = new ResultBean();
                    resultBean.setResult(false);
                    resultBean.setReturnCode("10111109816400005");
                    resultBean.setReturnMsg("用户当前状态不允许办理账单查询业务");
                    return resultBean;
                }
            }
        }
        return true;
    }

}
