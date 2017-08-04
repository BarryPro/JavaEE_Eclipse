package com.sitech.acctmgr.test.junit;

import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.util.DateUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangyla on 2016/5/12.
 */
public class DateUtilsTest {
    public static void main(String[] args) {
        System.out.println(DateUtil.toStringPlusMonths(String.valueOf(201501), -1, "yyyyMM"));
        System.out.println(DateUtils.addMonth(201501, -1));

        Map<String, Object> map = new HashMap<>();
//        map.put("ID_NO", "");
        System.out.println(map.containsKey("ID_NO"));
        System.out.println("[" + map.get("ID_NO") + "]");
        System.out.println(StringUtils.isNotEmptyOrNull(map.get("ID_NO")));
        System.out.println("======");
        int ymd = 20160824;
        System.out.println(DateUtils.addDays(ymd, 25));
    }
}
