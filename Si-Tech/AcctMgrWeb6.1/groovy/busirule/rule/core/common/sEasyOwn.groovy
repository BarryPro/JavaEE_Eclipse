import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity
import com.sitech.acctmgr.atom.entity.Prod
import com.sitech.acctmgr.atom.entity.User
import com.sitech.acctmgr.atom.entity.inter.IProd
import com.sitech.acctmgr.atom.entity.inter.IUser
import com.sitech.common.utils.StringUtils
import com.sitech.jcf.context.LocalContextFactory

/**
 * Created by wangyla on 2016/8/22.
 */
class sEasyOwn {
    //TODO 需要补充神州行业务限制的实现逻辑
    /**
     * 功能：神州行未签约用户不允许办理业务
     * 需要入参：PHONE_NO
     * @param obj
     */
    def entryMethod(Object obj) {
        MBean arg0 = obj.get("contextData");
        String phoneNo = arg0.getBodyStr("PHONE_NO");

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
            long idNo = userInfo.getIdNo();
            UserBrandEntity brandInfo = user.getUserBrandRel(idNo);
            String brandId = brandInfo.getBrandId();
            if (brandId.equals("2330zn")) { //神州行
                IProd prod = LocalContextFactory.getInstance().getBean("prodEnt", Prod.class);
                UserPrcEntity prcInfo = prod.getUserPrcidInfo(idNo);
                String mainPrcId = prcInfo.getProdPrcid();
                if (prod.isClassPrcId("OLDzn", mainPrcId)) { //判断用户主资费是否为神州行资费
                    boolean signFlag = user.isEasyOwnSigned(idNo);
                    if (!signFlag) {
                        ResultBean bean = new ResultBean();
                        bean.setResult(false);
                        bean.setReturnCode("10111109000050008");
                        bean.setReturnMsg("神州行用户,未签约不允许办理此业务！");
                        return bean;
                    }
                }
            }

        }
        return true;
    }

}