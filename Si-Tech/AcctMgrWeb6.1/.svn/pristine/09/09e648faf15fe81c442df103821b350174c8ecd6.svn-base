package busirule.rule.core.common

import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity
import com.sitech.acctmgr.atom.entity.User
import com.sitech.acctmgr.atom.entity.inter.IUser
import com.sitech.common.utils.StringUtils
import com.sitech.jcf.context.LocalContextFactory

/**
 * Created by wangyla on 2016/6/17.
 */
class sUserPassLimit {
    /**
     * 功能：校验用户过户限制，已过户的用户不允许查询过户前的数据
     * 需要入参：PHONE_NO、YEAR_MONTH
     * @param obj
     */
    def entryMethod(Object obj) {
        MBean arg0 = obj.get("contextData");
        String phoneNo = arg0.getBodyStr("PHONE_NO");
        int queryYM = Integer.parseInt(arg0.getBodyStr("YEAR_MONTH"));
        String yearMonth = arg0.getBodyStr("YEAR_MONTH");

        if (StringUtils.isNull(phoneNo)) //入参为空
        {
            ResultBean bean = new ResultBean();
            bean.setResult(false);
            bean.setReturnCode("00001");
            bean.setReturnMsg("规则校验入参PHONE_NO不能为空!");
            return bean;
        }

        IUser user = LocalContextFactory.getInstance().getBean("userEnt", User.class);
        UserInfoEntity userInfo = user.getUserEntity(null, phoneNo, null, true);
        if (userInfo != null) {
            long idNo = userInfo.getIdNo();
            Date passDate = user.getUserPassDate(idNo, null);
            /*SimpleDateFormat sf = new SimpleDateFormat("yyyyMM")
            queryDate = sf.parse(queryDate);*/
            Date queryDate = Date.parse("yyyyMM", yearMonth);

            if (passDate != null && queryDate.before(passDate)) {
                ResultBean bean = new ResultBean();
                bean.setResult(false);
                bean.setReturnCode("00002");
                bean.setReturnMsg("已过户用户不能查询过户前账单信息");
                return bean;
            }
        }

        return true;
    }
}
