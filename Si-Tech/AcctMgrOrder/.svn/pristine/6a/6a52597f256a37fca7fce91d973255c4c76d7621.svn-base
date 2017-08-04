package com.sitech.acctmgr.app.task;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.log.E2ELog;
import com.sitech.acctmgr.app.task.pool.IdmmMessagePool;
import com.sitech.crmpd.idmm2.client.exception.OperationException;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sitech.acctmgr.app.common.BusiProperties;
import com.sitech.acctmgr.app.dataorder.IDataOrder;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.crmpd.idmm2.client.api.ResultCode;
import com.sitech.fortress.task.ITaskExecutor;
import com.sitech.fortress.task.JobContext;
import com.sitech.jcf.context.LocalContextFactory;

import java.util.Date;
import java.util.Map;

/**
 * 数据工单fortress任务入口
 */
public class DataOrderTask implements ITaskExecutor {

    private static Log log = LogFactory.getLog(DataOrderTask.class);

    private static IdmmMessagePool pool = LocalContextFactory.getInstance().getBean("idmmMessagePool", IdmmMessagePool.class);
    private static IDataOrder iDataOrder = LocalContextFactory.getInstance().getBean("DataOrderSvc", IDataOrder.class);
    private MessageContext context;
    private PullCode code = null;
    private String lastMessageId = null;
    private String sTopic = null;
    private int time_out = 0;
    private String client;
    private String serviceName = "com_sitech_acctmgr_app_DataOrder_Task";

    @Override
    public void cleanup() {

    }

    /* (non-Javadoc)
     * @see com.sitech.fortress.task.ITaskExecutor#execute(java.lang.Object)
     */
    @Override
    public void execute(Object arg0) {

        Message message = (Message) arg0;
        if (message == null) {
            log.error("the param input message is NULL,message="+message);
        }
        
        //业务操作
        String content = "";
        MBean mBean = null;
        try {
            content = message.getContentAsString();
            //content = message.getContentAsUtf8String();
            lastMessageId = message.getId();
            code = PullCode.COMMIT_AND_NEXT;
            
            try {
                mBean = new MBean(content);
            } catch (Exception e) {
                log.error("This Content can't TRANSFER to MBean.content="+content);
                return;
            }
            //打印出来方便查询
            log.error("勿删：订单数据工单消息ID:["+lastMessageId+"],dataorder task content:" + content);
    		
            String beginTime = DateUtil.format(new Date(), "yyyy-MM-ddHH:mm:ss.SSS");

            //设置A,B库
            String sDbLabel = mBean.getHeaderStr(InterBusiConst.DATAODR_DBID);
            if (sDbLabel != null && !sDbLabel.equals("") && !sDbLabel.equalsIgnoreCase("null"))
            	SessionContext.setDbLabel(sDbLabel);
            
            if (iDataOrder.dataOrderSyn(mBean, "") == false) {
                log.error("return false,please check!已记入历史，请查询~~~");
            }
            String endTime = DateUtil.format(new Date(), "yyyy-MM-ddHH:mm:ss.SSS");
            E2ELog.writeLog(serviceName, mBean, beginTime, endTime, "0", "OK", "", "");
        } catch (Exception e) {
            //其他操作
            //插入错误历史表
            log.error("报错："+e.toString());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
            Map<String, Object> opr_info = iDataOrder.getOrderAccept(mBean);
            log.info("进入错误:" + opr_info);
            if(opr_info!=null) {
            	//设置A,B库
                String sDbLabel = mBean.getHeaderStr(InterBusiConst.DATAODR_DBID);
                SessionContext.setDbLabel(sDbLabel);
                
            	String err_msg = "DATAODRERR:"+e.toString();
                iDataOrder.inputErrOrderDeal(mBean, opr_info, err_msg.length()>1024?err_msg.substring(0, 1023):err_msg);
            }

        }//catch end

    }

    /* (non-Javadoc)
     * @see com.sitech.fortress.task.ITaskExecutor#fetchData()
     */
    @Override
    public Object fetchData() {
        String description = "数据工单-消费成功";
        Message message = null;
        try {
        	long t1 = System.currentTimeMillis();
            message = context.fetch(sTopic, time_out, lastMessageId, code, description, false);
            long t2 = System.currentTimeMillis();
            if((t2-t1) > 500){
                 log.error("!!!!usetime=rcvdatadata="+(t2-t1)+"ms");
            }
            final ResultCode resultCode = ResultCode.valueOf(message.getProperty(PropertyOption.RESULT_CODE));
            if (resultCode == ResultCode.NO_MORE_MESSAGE) {
            	log.debug("t101datasyn-数据工单没有消息~~~~");
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
    public void prepare(JobContext arg0) {

        //获取数据工单的池
        time_out = Integer.valueOf(BusiProperties.getConfigByMap("PUB_TIMEOUT"));
        sTopic = BusiProperties.getConfigByMap("DATAORDER_TOPIC");
        client = BusiProperties.getConfigByMap("DATAORDER_CLIENT");
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

        log.debug("time_out:"+time_out+",sTopic:"+sTopic+",client:"+client);

    }

    public static void main(String[] args) throws Exception {
        AcctmgrWorker aw = new AcctmgrWorker();
        aw.prepare(null, "AcctmgrJobId", null);
        DataOrderTask dot = new DataOrderTask();
        dot.prepare(null);
        dot.execute(dot.fetchData());

    }

}
