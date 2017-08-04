package com.sitech.acctmgr.app.task;

import com.sitech.acctmgr.app.busiorder.IBusiOrderSyn;
import com.sitech.acctmgr.app.common.BusiProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.log.E2ELog;
import com.sitech.acctmgr.app.task.pool.IdmmMessagePool;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.crmpd.idmm2.client.exception.OperationException;
import com.sitech.fortress.task.ITaskExecutor;
import com.sitech.fortress.task.JobContext;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class BusiOrderTask implements ITaskExecutor {
    private static Log log = LogFactory.getLog(BusiOrderTask.class);

    private static IdmmMessagePool pool = LocalContextFactory.getInstance().getBean("idmmMessagePool", IdmmMessagePool.class);
    private static IBusiOrderSyn iBusiOrder = LocalContextFactory.getInstance().getBean("BusiOrderSynSvc", IBusiOrderSyn.class);
    private MessageContext context;
    private PullCode code = null;
    private String lastMessageId = null;
    private String client;
    private int time_out = 10;
    private String sTopic;
    private String serviceName = "com_sitech_acctmgr_app_BusiOrder_Task";

	@Override
	public void cleanup() {
		
	}

	@Override
	public void execute(Object arg0) {
        Message message = (Message) arg0;
        if (message == null) {
            log.info("the param input JSON file:[" + message.getContentAsString() + "]");
        }

        //业务操作
        String content = "";
        MBean mb = null;
        String busi_code = "";
        try {
            content = message.getContentAsString();
            //content = message.getContentAsUtf8String();
            lastMessageId = message.getId();
    		code = PullCode.COMMIT_AND_NEXT;
    		//打印出来方便查询
    		log.error("TOPIC="+sTopic+"勿删：业务工单消息ID:["+lastMessageId+"],busiorder task content:" + content);
    		
            String beginTime = DateUtil.format(new Date(), "yyyy-MM-ddHH:mm:ss.SSS");
    		try {
    			mb = new MBean(content);
			} catch (Exception e) {
				log.error("消息["+lastMessageId+"]不能转换为Json格式，忽略!!!内容："+content);
				StackTraceElement[] error = e.getStackTrace();
	            for (StackTraceElement stackTraceElement : error){
	                log.error(stackTraceElement.toString());
	            }
				return ;
			}
    		
    		busi_code = iBusiOrder.getBusiCode(mb);
    		String db_id = mb.getHeaderStr(InterBusiConst.DATAODR_DBID);
    		String r_key = mb.getHeaderStr("ROUTING.ROUTE_KEY");
    		if ((null != db_id && !db_id.equals("") && !db_id.equalsIgnoreCase("null"))
    			|| (null != r_key && (r_key.equals("11") || r_key.equals("12") || r_key.equals("15")) )
    		) {
    			if (null == db_id || db_id.equals("") || db_id.equalsIgnoreCase("null")) {
    				/**** update by zhangleij 20170222 修改业务工单数据库标签判断逻辑 begin ****/
    				String region = mb.getHeaderStr("ROUTING.ROUTE_VALUE").substring(2, 4);
    				if (null != region && ("01".equals(region) || "05".equals(region) || "06".equals(region) || "07".equals(region) || "08".equals(region) || "09".equals(region)))
    					db_id =  "A2";
    				else if (null != region && ("02".equals(region) || "03".equals(region) || "04".equals(region) || "10".equals(region) || "11".equals(region) || "12".equals(region) || "13".equals(region)))
    					db_id =  "B2";
    				/**** update by zhangleij 20170222 修改业务工单数据库标签判断逻辑 end ****/
    				mb.setDbId(db_id);
    			}
    			SessionContext.setDbLabel(db_id);
    		
	    		if (iBusiOrder.dealBusiOrderData(content, busi_code, lastMessageId) == false) {
	                log.error("return false,please check!已记入历史，请查询~~~");
	            }
    		} else {
    			log.error("勿删：业务工单消息ID:["+lastMessageId+"]传入DB_ID为空，该业务工单入错单表，内容:" + content);
    			Map<String, Object> err_map = new HashMap<String, Object>();
    			err_map.put("ERR_CODE", "0013");
    			String err_msg = "busiodrerror--errmsg=DB_IDisnull";
    			err_map.put("ERR_MSG", err_msg);
    			err_map.put("BUSI_CODE", busi_code);
    			iBusiOrder.inputBusiErr(mb, err_map);
    		}
    		log.error("TOPIC="+sTopic+"勿删：业务工单消息ID:["+lastMessageId+"],DEAL OVER!");

    		String endTime = DateUtil.format(new Date(), "yyyy-MM-ddHH:mm:ss.SSS");
            E2ELog.writeLog(serviceName, mb, beginTime, endTime, "0", "OK", "", "");
        } catch (Exception e) {
            log.error(e.getMessage());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
            //设置A,B库
            String db_id = mb.getHeaderStr(InterBusiConst.DATAODR_DBID);
            if (null != db_id && !db_id.equals("") && !db_id.equalsIgnoreCase("null"))
    			SessionContext.setDbLabel(db_id);
            
            Map<String, Object> err_map = new HashMap<String, Object>();
			err_map.put("ERR_CODE", "0001");
			String err_msg = "busiodrerror--errmsg="+e.getMessage();
			err_map.put("ERR_MSG", err_msg.length()>1024?err_msg.substring(0, 1023):err_msg);
			err_map.put("BUSI_CODE", busi_code);
			iBusiOrder.inputBusiErr(mb, err_map);
        }
		
	}

	@Override
	public Object fetchData() {
        String description = "数据工单-消费成功";
        Message message = null;
        try {
        	long t1 = System.currentTimeMillis();
            message = context.fetch(sTopic, time_out, lastMessageId, code, description, false);
            long t2 = System.currentTimeMillis();
            if((t2-t1) > 500){
                 log.error("!!!!usetime=rcvbusidata="+(t2-t1)+"ms");
            }
            final ResultCode resultCode = ResultCode.valueOf(message.getProperty(PropertyOption.RESULT_CODE));
            if (resultCode == ResultCode.NO_MORE_MESSAGE) {
            	log.debug(sTopic+":业务工单没有消息~~~~");
                lastMessageId = null;
                code = null;
                description = null;
                return null;
            }
        } catch (OperationException e) {
            try {
            	//重新获取前一定要把原来的还回去
            	if(context != null){
            		pool.getPool().returnObject(client, context);
            	}
                context = pool.getPool().borrowObject(client);
            } catch (Exception e1) {
                log.error(e1.getMessage());
                StackTraceElement[] error = e1.getStackTrace();
                for (StackTraceElement stackTraceElement : error){
                    log.error(stackTraceElement.toString());
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
        }
        return message;
	}

	@Override
	public void prepare(JobContext jobContext) {
        //获取数据工单的池
        String initParamStr = jobContext.getTaskInfo().getArgs();
        String[] initParamArr = initParamStr.split(",");
        String clientName = initParamArr[0];

        client = BusiProperties.getConfigByMap(clientName+"_ORDER_CLIENT");
        time_out = Integer.valueOf(BusiProperties.getConfigByMap("PUB_TIMEOUT"));
        sTopic = BusiProperties.getConfigByMap(clientName+"_ORDER_TOPIC");
        log.debug(BusiProperties.getConfigByMap(clientName+"_ORDER_TOPIC")+"--业务工单主题:"+sTopic);
        //启动消息中间件
        try {
            context = pool.getPool().borrowObject(client);
        } catch (Exception e) {
            log.error(e.getMessage());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
        }
	}
}
