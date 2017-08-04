import com.sitech.ac.rdc.re.api.bean.ResultBean
import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.acctmgr.common.utils.DateUtils

class sCheckQueryRange {

    /**
     * 校验详单查询中时间范围
     * 只能查询近6个月数据
     * 需要入参：QUERY_FLAG, YEAR_MONTH, BEGIN_TIME, END_TIME
     */

    def entryMethod (Object obj) {
        MBean arg0 = obj.get("contextData");
        String queryFlag = arg0.getBodyStr("QUERY_FLAG");
        int queryYM = 0;
        String beginTime = null;
        String endTime = null;
        int begYm = 0;
        int endYm = 0;

        if (queryFlag.equals("1")) {
            queryYM = Integer.parseInt(arg0.getBodyStr("YEAR_MONTH"));

            begYm = queryYM;
            endYm = queryYM;
        } else if (queryFlag.equals("0")){
            beginTime = arg0.getBodyStr("BEGIN_TIME");
            endTime = arg0.getBodyStr("END_TIME");

            begYm = Integer.parseInt(beginTime.substring(0, 6));
            endYm = Integer.parseInt(endTime.substring(0, 6));
        }

        int curYm = DateUtils.getCurYm();
        int lastYm = DateUtils.addMonth(curYm, -5);

        if ((begYm < lastYm || begYm > curYm) || (endYm < lastYm || endYm > curYm)) {
            ResultBean resultBean = new ResultBean();
            resultBean.setResult(false);
            resultBean.setReturnCode("10111109814220002");
            resultBean.setReturnMsg("只允许查询最近6个月的详单！");
            return resultBean;
        }

        return true;

    }
}