package com.sitech.acctmgr.app.task;

import com.sitech.acctmgr.app.common.BusiProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.dataorder.IDataOrder;
import com.sitech.acctmgr.app.msgodrsend.MsgSendDAO;
import com.sitech.acctmgr.app.odrBlob.OdrLineContVO;
import com.sitech.acctmgr.app.task.dao.MsgInfoDspDao;
import com.sitech.acctmgr.app.task.pool.IdmmMessagePool;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.api.PullCode;
import com.sitech.fortress.task.JobContext;
import com.sitech.fortress.task.client.TableTaskBase;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.dao.IBaseDao;
import com.sitech.jcf.core.datasource.DataSourceHelper;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

public class MsgSendTask extends TableTaskBase {
    private static Log log = LogFactory.getLog(MsgSendTask.class);
    //当前任务执行的主题id
    private String topicId = "";
    //当前任务的分区序号
    private String taskNum = "";
    //当前任务执行的总线程数
    private String totalNum = "";
    
    private String sDbLabel = "";

    private static MsgInfoDspDao msgInfoDspDao = (MsgInfoDspDao)LocalContextFactory.getInstance().getBean("msgInfoDspSvc");
    private static MsgSendDAO msgSendDAO = (MsgSendDAO)LocalContextFactory.getInstance().getBean("MsgDAOAppEnt");
    private static IdmmMessagePool pool = LocalContextFactory.getInstance().getBean("idmmMessagePool", IdmmMessagePool.class);

    private MessageContext context;
    private String client = "";
    private int priori = 0;

    public MsgSendTask() throws UnknownHostException {
        super();
    }

    @Override
    /**
     * dsp_status：状态 0:未处理、1:处理中、2:完成
     * dsp_accept：流水，需要增加索引，以便加快处理速度。取值方法：计算得出，生成规则为“ip+线程ID+时间尾部（日+时+分+秒+微秒）”
     * dsp_position：执行的worker；取值方法：内容为“ip（后3位）+taskID（在zk设置）；用途：因为分布式调度，不能确定业务执行所在的主机。为了定位主机方便，增加执行本条记录的IP地址。
     */
    protected int updateDspList(Map<String, Object> stringObjectMap) {
        int num = 0;

        stringObjectMap.put("TOPIC_ID",topicId);
        stringObjectMap.put("TASK_NUM",taskNum);
        stringObjectMap.put("TOTAL_NUM",totalNum);

        try {
        	if(conn == null || conn.isClosed()){//如果连接中断，则重新获取连接
        		conn = ((DataSource)LocalContextFactory.getInstance().getBean("dataSource"+sDbLabel, DataSource.class)).getConnection();
			}
        	long t1 = System.currentTimeMillis();
            num = msgInfoDspDao.updateMsgList(stringObjectMap,conn);
            /*
             *   这儿必须做commit。因为qryDspList用的连接和这个不是一个，不Commit，查不到数据
              */
            conn.commit();
            
            long t2 = System.currentTimeMillis();
            if((t2-t1) > 300){
                 log.error("!!!!usetime=updatedata="+(t2-t1)+"ms");
            }
        } catch (SQLException e) {
            log.error("msgInfoDspDao.updateMsgList error:");
            log.error(e.getMessage());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
        }

        return num;
    }

    @Override
    /**
     * 获取已经锁定的记录List
     */
    protected List<Object> qryDspList(Map<String, Object> stringObjectMap) {

        stringObjectMap.put("TOPIC_ID", topicId);
        SessionContext.setDbLabel(sDbLabel);
        long t1 = System.currentTimeMillis();
        List<Object> list = msgInfoDspDao.queryMsgList(stringObjectMap);
        long t2 = System.currentTimeMillis();
        if((t2-t1) > 300){
             log.error("!!!!usetime=getdata="+(t2-t1)+"ms");
        }
        return list;
    }

    @Override
    /**
     * 执行每条记录，做相应的业务操作，传入的是每条object
     */
    protected void executeBusi(Object o) {
        OdrLineContVO odrLineContVO = (OdrLineContVO)o;

        Map<String, Object> mapDataTmp = msgSendDAO.switchVoToMap(odrLineContVO);

        //数据库中字节码为GBK,此处转换为框架字符集UTF-8
        String sContent = null;
        String gbk_content = null;
        try {
            gbk_content = new String((byte[])mapDataTmp.get("CONTENT"), "GBK");
            sContent = new String(gbk_content.getBytes(InterBusiConst.MSGSND_CHARSET), InterBusiConst.MSGSND_CHARSET);
            log.debug("sContent:"+sContent);
        } catch (UnsupportedEncodingException e1) {
            log.error("MsgSendTask.executeBusi err:");
            log.error(e1.getMessage());
            StackTraceElement[] error = e1.getStackTrace();
            for (StackTraceElement stackTraceElement : error) {
                log.error(stackTraceElement.toString());
            }
        }
        
        //发送本条消息
        try {
        	if(conn == null || conn.isClosed()){//如果连接中断，则重新获取连接
        		conn = ((DataSource)LocalContextFactory.getInstance().getBean("dataSource"+sDbLabel, DataSource.class)).getConnection();
			}
        	
        	//创建msg
            final Message message = Message.create(sContent);
            message.setProperty(PropertyOption.GROUP, mapDataTmp.get("BUSIID_NO").toString());
            message.setProperty(PropertyOption.PRIORITY, priori);
            //message.setProperty(PropertyOption.COMPRESS, true);//自动压缩

    		//发送
            long t1 = System.currentTimeMillis();
            
            context = pool.getPool().borrowObject(client);	           
            String id = context.send(topicId, message);//输出MsgID            		
            context.commit(id);
            
            long t2 = System.currentTimeMillis();
            if((t2-t1) > 500){
                 log.error("!!!!usetime=senddata="+(t2-t1)+"ms");
            }
            

            //入历史，无论入历史是否成功，都需要删正表记录
            mapDataTmp.put("MSG_ID", id);
            msgInfoDspDao.inputHisAndDel(mapDataTmp, conn);//使用JDBC
            

        } catch (Exception e) {
            log.error("MsgSendTask.executeBusi err2:");
            log.error(e.getMessage());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
            
            //本地事务处理，入err表
            mapDataTmp.put("ERR_CODE", "0011");
            String err_msg = "msg-send-error-"+e.getMessage();
            mapDataTmp.put("ERR_MSG", err_msg.length()>1024?err_msg.substring(0, 1023):err_msg);
            try {
                msgInfoDspDao.inputErrAndDel(mapDataTmp, conn);
            } catch (SQLException e1) {
                log.error("MsgSendTask.executeBusi err3:");
                log.error(e1.getMessage());
                StackTraceElement[] error1 = e.getStackTrace();
                for (StackTraceElement stackTraceElement : error1){
                    log.error(stackTraceElement.toString());
                }
            }
        } finally{
        	try {
        		if(context != null){
        			pool.getPool().returnObject(client, context);
        		}
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
    }


    @Override
    protected void updateDspByKey(Object o) {

    }

    @Override
    public void prepare(JobContext jobContext) {
        //提取子系统task启动初始化参数
        String initParamStr = jobContext.getTaskInfo().getArgs();
        String[] initParamArr = initParamStr.split(",");
        String dataSource = initParamArr[0];
        sDbLabel = initParamArr[1];
        totalNum = initParamArr[2];
        taskNum = initParamArr[3];
        taskId = jobContext.getTaskId();

        //设置数据源
        log.info("sDbLabel:"+sDbLabel);
        SessionContext.setDbLabel(sDbLabel);
        //根据dataSource获取topicId和优先级值
        Map<String,Object> inMap = new HashMap<String, Object>();
        inMap.put("DATA_SOURCE",dataSource);
        log.info("msgInfoDspDao before sDbLabel:"+SessionContext.getDbLabel());
        Map<String,Object> outMap = msgInfoDspDao.getTopicCfg(inMap);
        log.info("msgInfoDspDao after sDbLabel:"+SessionContext.getDbLabel());
        topicId = (String)outMap.get("TOPIC_ID");
        priori = Integer.parseInt(outMap.get("TOPIC_PRIOR").toString());
        //priori = Integer.parseInt(BusiProperties.getConfigByMap(dataSource + "_PRIOR"));
        //获取数据工单的池
        //启动消息中间件
        client = BusiProperties.getConfigByMap("PUB_CLIENT");
        try {
        	//直接从数据源中获取连接
			conn = ((DataSource)LocalContextFactory.getInstance().getBean("dataSource"+sDbLabel, DataSource.class)).getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
//        conn = msgInfoDspDao.getBaseDao().getNewConnection();
    }

    @Override
    public void cleanup() {
        DataSourceHelper.closeConnection(conn);
    }
}
