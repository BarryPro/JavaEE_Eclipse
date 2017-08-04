package com.sitech.acctmgr.app.common.log;

import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.NetUtil;
import com.sitech.jcfx.util.RandomGUID;
import org.slf4j.LoggerFactory;

/**
 * Created by hp on 2015/9/8.
 */
public class E2ELog
{
    private static org.slf4j.Logger logger = LoggerFactory.getLogger(E2ELog.class);
    private static org.apache.log4j.Logger flumeLogger = org.apache.log4j.Logger.getLogger("flume");
    private static final String TAB = "~!~";
    private static String hostIp = NetUtil.getLocalHost();
    private static String port = "8088";//后台应用的端口没指定，随便写一个
    private static String linkType = "B002";//平台编码，BOSS做为一个平台，唯一

    public static void writeLog(String serviceName, MBean mbean, String beginTime, String endTime, String returnCode, String returnMsg, String inParam, String outParam)
    {
        if (null == mbean) {
            return;
        }

        E2EBean logBean = new E2EBean();
        String traceId = mbean.getHeaderStr("TRACE_ID");
        logBean.setTraceId(traceId);
        String parentCallId = mbean.getHeaderStr("CALL_ID");
        logBean.setParentCallId(parentCallId);
        logBean.setSpanidName(serviceName);

        logBean.setStartTime(beginTime);
        logBean.setEndTime(endTime);
        logBean.setResultCode(returnCode);
        logBean.setResultInfo(returnMsg);
        logBean.setInParams(inParam);
        logBean.setOutParams(outParam);

        sendLog(logBean);
    }

    private static void sendLog(E2EBean logBean)
    {
        StringBuilder sb = new StringBuilder(256);
        sb.append(logBean.getTraceId());
        sb.append(TAB);
        sb.append(RandomGUID.getRandomGUID());
        sb.append(TAB);
        sb.append(logBean.getParentCallId());
        sb.append(TAB);
        sb.append(logBean.getSpanId());
        sb.append(TAB);
        sb.append(logBean.getSpanidName());
        sb.append(TAB);
        sb.append(linkType);
        sb.append(TAB);
        sb.append(logBean.getRegionCode());
        sb.append(TAB);
        sb.append(logBean.getFunctionName());
        sb.append(TAB);
        sb.append(logBean.getStartTime());
        sb.append(TAB);
        sb.append(logBean.getEndTime());
        sb.append(TAB);
        sb.append(hostIp);
        sb.append(TAB);
        sb.append(port);
        sb.append(TAB);
        sb.append(logBean.getClientIp());
        sb.append(TAB);
        sb.append(logBean.getObjectType());
        sb.append(TAB);
        sb.append(logBean.getObjectValue());
        sb.append(TAB);
        sb.append(logBean.getUserId());
        sb.append(TAB);
        sb.append(logBean.getBhCode());
        sb.append(TAB);
        sb.append(logBean.getOpCode());
        sb.append(TAB);

        sb.append(logBean.getResultCode());
        sb.append(TAB);
        sb.append(logBean.getResultInfo());
        sb.append(TAB);
        sb.append(logBean.getInParams());
        sb.append(TAB);
        sb.append(logBean.getOutParams());

        String logStr = sb.toString();

        long t1 = System.currentTimeMillis();

        flumeLogger.info(logStr);
        long t2 = System.currentTimeMillis();
        logger.info("---------------jcf plugin E2E: record log to flume,run time is [" + (t2 - t1) + "]ms");
    }


    public static void main(String[] args)
    {
        E2EBean logBean = new E2EBean();
        sendLog(logBean);
    }
}
