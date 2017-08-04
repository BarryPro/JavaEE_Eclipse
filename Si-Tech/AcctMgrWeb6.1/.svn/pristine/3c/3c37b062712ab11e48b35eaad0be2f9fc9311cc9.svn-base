import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.common.utils.DateUtils

/**
 * Created by wangyla on 2016/6/17.
 */

class s8143 {
    /**
     * 功能：校验帐单查询六个月限制
     * 需要入参 YEAR_MONTH
     * @param obj
     */
    def entryMethod(Object obj) {
        MBean arg0 = obj.get("contextData");
        int queryYM = Integer.parseInt(arg0.getBodyStr("YEAR_MONTH"));

        int curYm = DateUtils.getCurYm();
        int lastYM = DateUtils.addMonth(curYm, -5); //六个月之前的时间

        if (queryYM < lastYM || queryYM > curYm) {
            ResultBean resultBean = new ResultBean();
            resultBean.setResult(false);
            resultBean.setReturnCode("10111109814300001");
            resultBean.setReturnMsg("只能查询最近6个月的账单信息。（包括当前月）");
            return resultBean;
        }

        return true;

    }

}