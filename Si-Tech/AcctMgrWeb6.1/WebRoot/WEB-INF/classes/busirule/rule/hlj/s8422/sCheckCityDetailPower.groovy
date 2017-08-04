import com.sitech.ac.rdc.re.api.common.util.MBean
import com.sitech.jcf.context.LocalContextFactory

/**
 * 功能：校验地市详单查询工号权限
 * 需要参数：LOGIN_NO,POWER_LEVEL
 */
class sCheckCityDetailPower {
    def entryMethod (Object obj) {
        MBean arg0 = obj.get("contextData");
        String loginNo = arg0.getBodyStr("LOGIN_NO");
        int powerLevel = Integer.parseInt(arg0.getBodyStr("POWER_LEVEL"));

        //TODO 增加权限校验部分
        //ILoginCheck loginCheck = LocalContextFactory.getInstance().getBean("loginCheckEnt", ILoginCheck.class);
        //loginCheck.pchkFuncPowerList();
        return true;
    }

}