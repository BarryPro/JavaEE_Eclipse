import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.atom.entity.inter.IDetailDisplayer
import com.sitech.common.utils.StringUtils
import com.sitech.jcf.context.LocalContextFactory

class sTransRegionLimit {
    /**
     * 跨区补卡3天内不允许查询详单
     * 需要参数：PHONE_NO
     * @param obj
     * @return
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

        IDetailDisplayer detailDisplayer = LocalContextFactory.getInstance().getBean("detailDisplayerEnt", IDetailDisplayer.class);
        boolean limtFlag = detailDisplayer.transRegionLimit(phoneNo, 3);
        if (!limtFlag) {
            ResultBean bean = new ResultBean();
            bean.setResult(false);
            bean.setReturnCode("00010");
            bean.setReturnMsg("该用户在3天内办理过跨区补卡业务，不予查询详单！");
            return bean;

        }

        return true;
    }

}