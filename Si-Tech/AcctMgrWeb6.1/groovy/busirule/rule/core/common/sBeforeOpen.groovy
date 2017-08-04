import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity
import com.sitech.acctmgr.atom.entity.User
import com.sitech.acctmgr.atom.entity.inter.IUser
import com.sitech.common.utils.StringUtils
import com.sitech.jcf.context.LocalContextFactory

/**
 * Created by wangyla on 2016/8/22.
 */
class sBeforeOpen {
    /**
     * 功能：校验用户开户前限制，开户前月份不允许受理业务
     * 需要入参：PHONE_NO、YEAR_MONTH
     * @param obj
     */
    def entryMethod(Object obj) {
        MBean arg0 = obj.get("contextData");
        String phoneNo = arg0.getBodyStr("PHONE_NO");
        int queryYM = Integer.parseInt(arg0.getBodyStr("YEAR_MONTH"));

        if (StringUtils.isNull(phoneNo)) //入参为空
        {
            ResultBean bean = new ResultBean();
            bean.setResult(false);
            bean.setReturnCode("00001");
            bean.setReturnMsg("规则校验入参PHONE_NO不能为空!");
            return bean;
        }

        IUser user = LocalContextFactory.getInstance().getBean("userEnt", User.class);
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        if (userInfo != null) {
            String openTimeMonth = userInfo.getOpenTime().substring(0,6);
            int openMonth = Integer.parseInt(openTimeMonth);
            if (queryYM < openMonth) {
                ResultBean bean = new ResultBean();
                bean.setResult(false);
                bean.setReturnCode("10111109000050002"); //TODO
                bean.setReturnMsg("对不起，不受理用户开户前的业务");
                return bean;
            }
        }

        return true;
    }

}