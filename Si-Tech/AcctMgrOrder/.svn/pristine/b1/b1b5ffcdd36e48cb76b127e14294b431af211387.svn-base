package com.sitech.acctmgr.app.task.dao;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.app.odrBlob.OdrLineContVO;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.ijdbc.SqlChange;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.sql.SqlParameter;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcfx.dt.MBean;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by hp on 2015/8/17.
 */
public class MsgInfoDspDao extends BaseBusi {

    /**
     * 查询更新前先锁定记录，防止分布式下的重复处理
     */
    public int updateMsgList(Map<String,Object> msgInfo, Connection conn) throws SQLException {

        SqlChange sqlChg = new SqlChange();
        StringBuffer buffer = new StringBuffer("update IN_MSGSEND_INFO " +
                "set DSP_STATUS = ?, DSP_UPDATE_TIME = TO_DATE(?,'YYYYMMDDHH24MISS'), DSP_ACCEPT = ?, DSP_POSITION = ?");
        buffer.append("WHERE CREATE_ACCEPT IN ( select create_accept from ");
        buffer.append("(select create_accept from in_msgsend_info where TOPIC_ID = ? AND mod(BUSIID_NO, ?) = ? and op_time < sysdate order by op_time, login_accept)");
        buffer.append(" where ROWNUM <= 100 ) ");
        
        sqlChg.addParam(new SqlParameter("DSP_STATUS", SqlTypes.VARCHAR, msgInfo.get("DSP_STATUS")));
        sqlChg.addParam(new SqlParameter("DSP_UPDATE_TIME",SqlTypes.VARCHAR, ((String)msgInfo.get("DSP_UPDATE_TIME")).replace('-', ' ').replace(':', ' ').replace(" ", "")));
        sqlChg.addParam(new SqlParameter("DSP_ACCEPT",SqlTypes.VARCHAR, msgInfo.get("DSP_ACCEPT")));
        sqlChg.addParam(new SqlParameter("DSP_POSITION",SqlTypes.VARCHAR, msgInfo.get("DSP_POSITION")));

        sqlChg.addParam(new SqlParameter("TOPIC_ID",SqlTypes.VARCHAR, msgInfo.get("TOPIC_ID")));
        sqlChg.addParam(new SqlParameter("TOTAL_NUM",SqlTypes.NUMERIC, msgInfo.get("TOTAL_NUM")));
        sqlChg.addParam(new SqlParameter("TASK_NUM",SqlTypes.NUMERIC, msgInfo.get("TASK_NUM")));
        return sqlChg.execute(conn, buffer.toString());

        //return baseDao.update("in_msgsend_info.updateByDsp",msgInfo);
    }

    public List queryMsgList(Map<String,Object> msgInfo){
        List rstList =  baseDao.queryForList("in_msgsend_info.queryMsgList", msgInfo);

        /**
         * 写拼的sql解决不了blob字段的问题，暂时只能用basedao
         */
//        List rstList = new ArrayList();
//        SqlFind find = new SqlFind();
//        StringBuffer buffer = new StringBuffer("SELECT CREATE_ACCEPT, DATA_SOURCE, BUSIID_NO, BUSIID_TYPE, TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_CODE, LOGIN_NO FROM IN_MSGSEND_INFO ");
//        buffer.append(" WHERE TOPIC_ID =? AND DSP_STATUS = ? AND DSP_ACCEPT = ? AND DSP_POSITION = ? ORDER BY OP_TIME ");
//        find.addParam(new SqlParameter("TOPIC_ID",SqlTypes.VARCHAR, msgInfo.get("TOPIC_ID")));
//        find.addParam(new SqlParameter("DSP_STATUS",SqlTypes.VARCHAR, msgInfo.get("DSP_STATUS")));
//        find.addParam(new SqlParameter("DSP_ACCEPT",SqlTypes.VARCHAR, msgInfo.get("DSP_ACCEPT")));
//        find.addParam(new SqlParameter("DSP_POSITION",SqlTypes.VARCHAR, msgInfo.get("DSP_POSITION")));
//        List list = find.findList(conn, buffer.toString());
//        if(list!=null && list.size()>0) {
//            for (int i = 0; i < list.size(); i++) {
//                OdrLineContVO odrLineContVO = new OdrLineContVO();
//                String[] strs = (String[]) list.get(i);
//                odrLineContVO.setGlCreatAct(Long.parseLong(strs[0]));
//                odrLineContVO.setGsDataSrc(strs[1]);
//                odrLineContVO.setGsBusiidNo(strs[2]);
//                odrLineContVO.setGsBusiidType(strs[3]);
//                odrLineContVO.setGsTopicId(strs[4]);
//                odrLineContVO.setGbContent(strs[5].getBytes());
//                odrLineContVO.setGsLoginAct(strs[6]);
//                odrLineContVO.setGsOpCode(strs[7]);
//                odrLineContVO.setGsLoginNo(strs[8]);
//                rstList.add(odrLineContVO);
//            }
//        }

        return rstList;
    }

    public boolean inputHisAndDel(Map<String, Object> indatamap, Connection conn) throws SQLException {

    	SqlChange sqlChg = new SqlChange();
        StringBuffer buffer = new StringBuffer(InterBusiConst.MSGSND_INHIS);

        //注意顺序 TOPIC_ID=? AND CREATE_ACCEPT=?
        sqlChg.addParam(new SqlParameter("MSG_ID", SqlTypes.VARCHAR, indatamap.get("MSG_ID")));
        sqlChg.addParam(new SqlParameter("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID")));
        sqlChg.addParam(new SqlParameter("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT")));
        sqlChg.execute(conn, buffer.toString());

        //执行删除INFO正表操作
        sqlChg.reset();
        StringBuffer buffer1 = new StringBuffer(InterBusiConst.MSGSND_DELETE);
        sqlChg.addParam(new SqlParameter("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID")));
        sqlChg.addParam(new SqlParameter("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT")));
        sqlChg.execute(conn, buffer1.toString());

        return true;
    }

    public void inputErrAndDel(Map<String, Object> indatamap, Connection conn) throws SQLException {
		JdbcConn jdbc = new JdbcConn(conn);
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_INSTERR);

		//注意顺序 #ERR_MSG# ,#ERR_CODE# FROM ... TOPIC_ID=#TOPIC_ID# AND CREATE_ACCEPT=#CREATE_ACCEPT#"
		jdbc.addParam("ERR_MSG", SqlTypes.VARCHAR, indatamap.get("ERR_MSG").toString());
		jdbc.addParam("ERR_CODE", SqlTypes.VARCHAR, indatamap.get("ERR_CODE").toString());
		jdbc.addParam("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT"));
		try {
		    int i = jdbc.execuse();
		} catch (Exception e) {
			log.error("插入错误表失败,继续删除正表数据！！！该条数据信息:"+indatamap.toString());
			log.error("插入错误表失败,报错信息："+e.toString());
			StackTraceElement[] error = e.getStackTrace();
		    for (StackTraceElement stackTraceElement : error){
		    	log.error(stackTraceElement.toString());
		    }
		}
		
		//执行删除INFO正表操作
		jdbc.setSqlBuffer(InterBusiConst.MSGSND_DELETE);
		jdbc.addParam("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID").toString());
		jdbc.addParam("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT"));
		try {
			int i = jdbc.execuse();
		} catch (Exception e) {
			log.error("删除正表失败,报错信息："+e.toString());
			StackTraceElement[] error = e.getStackTrace();
		    for (StackTraceElement stackTraceElement : error){
		    	log.error(stackTraceElement.toString());
		    }
		}

    }

    /**
     * 根据dataSource查配置信息
     * @param indataMap
     * @return
     */
    public Map<String,Object> getTopicCfg(Map<String,Object> indataMap){
        Map<String,Object> resultMap = (Map<String,Object>)baseDao.queryForObject("in_msgsend_cfg.query",indataMap);
        return resultMap;
    }

}
