import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity
import com.sitech.acctmgr.atom.entity.inter.IDetailDisplayer
import com.sitech.acctmgr.atom.entity.inter.IUser
import com.sitech.jcf.context.LocalContextFactory

/**
 * 功能：详单禁查规则校验
 * 需要入参：LOGIN_NO,PHONE_NO
 */
class sDetailQueryLimited {

    def entryMethod(Object obj) {
        MBean arg0 = obj.get("contextData");
        String phoneNo = arg0.getBodyStr("PHONE_NO");
        String loginNo = arg0.getBodyStr("LOGIN_NO");
        IUser user = LocalContextFactory.getInstance().getBean("userEnt", IUser.class);
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo,true);

        long idNo = userInfo.getIdNo();
        IDetailDisplayer detailDisplayer = LocalContextFactory.getInstance().getBean("detailDisplayerEnt", IDetailDisplayer.class);

        String qryFlag = detailDisplayer.getDetailBillQryFlag(idNo);

        /*高级工号可以直接查询；普通工号不能查询办理过屏蔽详单用户的详单*/
        if (!(loginNo.equals("aavb55") || loginNo.equals("aaa8zy")) && qryFlag.equals("N")) {
            ResultBean bean = new ResultBean();
            bean.setResult(false);
            bean.setReturnCode("10111109000060007");
            bean.setReturnMsg("该客户办理了详单屏蔽业务，不能查询详单!");
            return bean;
        }

        return true;
    }
}