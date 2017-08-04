package com.sitech.acctmgr.app.msgodrsend;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPoolConfig;

import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleIfStatement.Else;
import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.app.odrBlob.OdrLineContDAO;
import com.sitech.acctmgr.app.odrBlob.OdrLineContVO;
import com.sitech.acctmgr.app.odrBlob.OdrLineErrVO;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.api.Message;
import com.sitech.crmpd.idmm2.client.api.PropertyOption;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcfx.dt.MBean;


public class MsgSend extends BaseBusi implements IMsgSend {

	protected OdrLineContDAO odrLineContDAO;
	protected MsgSendDAO msgSendDAO;
	
	private static final GenericKeyedObjectPoolConfig CONFIG = new GenericKeyedObjectPoolConfig();

	public MsgSendDAO getMsgSendDAO() {
		return msgSendDAO;
	}

	public void setMsgSendDAO(MsgSendDAO msgSendDAO) {
		this.msgSendDAO = msgSendDAO;
	}

	public OdrLineContDAO getOdrLineContDAO() {
		return odrLineContDAO;
	}

	public void setOdrLineContDAO(OdrLineContDAO odrLineContDAO) {
		this.odrLineContDAO = odrLineContDAO;
	}

	/*************数据处理部分 STT**************/
	
	/**
	 * Title 按BUSIID_NO%线程数=当前线程号，处理接口数据
	 * @param inThrdMap
	 * @return true/false
	 */
	@Override
	public void dealMidMsgByThrd(Map<String, Object> inThrdMap) {
		
		int iCurThrdCount = 0;
		String sDataSrc = "";
		sDataSrc = inThrdMap.get("DATA_SRC").toString();
		log.debug("-------msgsnd---inThrdMap="+inThrdMap.toString());

		//查看当前接口是否存在数据.是则继续，否则休息10s后再次查询
		while (true) {
			iCurThrdCount = 0;
			iCurThrdCount = (Integer) baseDao.queryForObject("in_msgsend_info.qCount", inThrdMap);
			if (iCurThrdCount != 0) {
				//有数据
				
				//取得接口表中，BUSIID_NO%ThrdNum=CurrNum时的数据
				List rstInfoList = odrLineContDAO.queryThrdListCont(inThrdMap);
				log.debug("-------待处理消息数："+rstInfoList.size()+" ---------");
				//处理<1000条消息
				sendMidMsg(sDataSrc, inThrdMap.get("MID_POOL"), rstInfoList);
				
			} else if (0 == iCurThrdCount) {
				//没有数据，休息10s
				try {
					log.debug("----没有数据，休息10s----");
					Thread.sleep(10000L);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			
		}//while end
		
	}
	
	/**
	 * Title 处理err表数据
	 */
	@Override
	public boolean dealErrOrder(Map<String, Object> inDealMap, String file_flag) {

		log.debug("ERRORDER--STT--inTopicMap="+inDealMap.toString());
		int iCurTopicCount = 0;
		String deal_flg = inDealMap.get("DEAL_FLG").toString();
		String deal_val = inDealMap.get("DEAL_VAL").toString();
		
		if ("Y".equals(file_flag)) {
			log.info("以用入参DEAL_FLG=3 DEAL_VAL=文件名，为文件处理方式实现!!!");
		} 
		
		if (!deal_flg.equals("3")) {
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("DEAL_FLG", deal_flg);
			
			//处理方式
			if ("0".equals(deal_flg)) //单条流水处理
				inMap.put("CREATE_ACCEPT", deal_val);
			else if ("1".equals(deal_flg)) //处理 ERR_CODE=#DELA_VAL#错单
				inMap.put("ERR_CODE", deal_val);
			else if ("2".equals(deal_flg)) //处理值(DELA_VAL)分钟内的错单
				inMap.put("MINUTS_FORMAT", Double.valueOf("5")*1/24/60);
			log.info("查询错单入参："+inMap.toString());
			
			iCurTopicCount = 0;
			iCurTopicCount = (Integer) baseDao.queryForObject("in_msgsend_err.qCount", inMap);
			//有数据
			if (iCurTopicCount != 0) {
				//取得接口表中数据
				List rstInfoList = odrLineContDAO.qErrTopicList(inMap);
				log.debug("-------待处理消息数："+rstInfoList.size()+" ---------");
				//处理消息，每次最多200条...
				sendErrMsg(inDealMap.get("POOL_MID"), rstInfoList);
				
			} else if (0 == iCurTopicCount) {
				log.debug("ERRORDER:--没有新的发送错误数据，退出！！！");
				return true;
			}
			
		} else {
			//处理文件
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("FILE_NAME", deal_val);
			int iSend = fileSendMsg(inMap);
			log.info("发送成功："+iSend+"条！！！");
		}
		log.debug("ERRORDER:--发送成功，END--inDealMap="+inDealMap.toString());
		
		return true;
	}
	
	public int fileSendMsg(Map<String, Object> in_map) {
		
		//入参
		int line = 1;
		String file_name = in_map.get("FILE_NAME").toString();
		
		//中间件配置
		String client = AppProperties.getConfigByMap("PUB_CLIENT");
		String addr = AppProperties.getConfigByMap("PUB_ADDR");
		final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
				new PooledMessageContextFactory(addr, 6000));
		MessageContext context = null;
		
		File file = null;
		try {
			file = new File(file_name);
		} catch (Exception e) {
			System.err.println("打开文件失败!!!文件名:["+file+"]");
		}
		
		BufferedReader reader = null;
		String topic_id = "";
		String msg_cont = "";
		try {
			System.out.println("以行为单位，每次读取一行:");
			FileReader fr = null;
			fr = new FileReader(file);
			reader = new BufferedReader(fr);
			String tmp_str = null;
			while ((tmp_str = reader.readLine()) != null) {
				if (tmp_str.trim().equals("")) {
					System.out.println("第 "+line+" 行数据:"+tmp_str+"为空，忽略...");
					continue;
				}
				System.out.println("处理第 "+line+" 行，内容:"+tmp_str);
				
				String[] arr = tmp_str.split("\t");
				if (1 < arr.length) {
					topic_id = arr[0];
					msg_cont = arr[1];
				} else {
					log.info("内容无主题，不发送！！！msg_cont="+tmp_str);
				}

				//发送至中间件
				try {
					context = pool.borrowObject(client);
					final Message message = Message.create(msg_cont);// 如果是对象，需要先序列化，在消费者侧反序列化
					message.setProperty(PropertyOption.COMPRESS, true);// 是否压缩
					message.setProperty(PropertyOption.PRIORITY, 1000);// 1-1000
					final PropertyOption<String> MESSAGE_PART = PropertyOption.valueOf("msg_part");
					message.setProperty(MESSAGE_PART,  "01");
					final String id = context.send(topic_id, message);//T109DataRpt
					context.commit(id);
					
					line ++;

					System.out.println("---------结束发送--------消息ID:"+id);
				} catch (final Exception e) {
					e.printStackTrace();
				} finally {
					pool.returnObject(client, context);
				}

			}
			reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return line;
	}
	
	/*************私有方法部分**************/
	
	/**
	 * Title  发送接口表中消息数据
	 * @param mapDataTmp
	 * @return
	 */
	private boolean sendMidMsg(String inDataSrc, Object inPool, List inDataList) {
		
		int iDataSize = 0;
		int iMsgLen = 0;
		String topic = "";
		String client = "";
		int priori = 0;
		Map<String, Object> mapDataTmp = null;
		
		log.debug("--JdbcConnmsgsend:Open conn...");
		JdbcConn jdbc = new JdbcConn(baseDao.getConnection());//默认使用A库
		try {
			
			//测试文件句柄数
			//RunCommand runcmd = new RunCommand();
			//句柄数大于100进程号命令
			//String cmd = "lsof -n|awk '{print $2}'|sort|uniq -c|sort  | awk '{if($1>100)print}'";
			
			//1.得到生产者对象池
			topic = getCfgValue(inDataSrc, "TOPIC");
			priori = Integer.valueOf(getCfgValue(inDataSrc, "PRIOR"));
			client = AppProperties.getConfigByMap("PUB_CLIENT");
			final KeyedObjectPool<String, MessageContext> pool = (KeyedObjectPool<String, MessageContext>) inPool;
			
			//处理消息
			OdrLineContVO odrLineContVO = null;
			iDataSize = inDataList.size(); 
			for (int i = 0; i < iDataSize; i++) {
				odrLineContVO = new OdrLineContVO();
				mapDataTmp = new HashMap<String, Object>();
				//取数据，类型转换
				odrLineContVO = (OdrLineContVO) inDataList.get(i);
				mapDataTmp = msgSendDAO.switchVoToMap(odrLineContVO);
				log.debug("--msgsend--当前列数据：["+mapDataTmp.toString()+"]--");
				
				//数据库中字节码为GBK,此处转换为框架字符集UTF-8
				String sContent = null;
				String gbk_content = null;
				try {
					gbk_content = new String((byte[])mapDataTmp.get("CONTENT"), "GBK");
					sContent = new String(gbk_content.getBytes(InterBusiConst.MSGSND_CHARSET), InterBusiConst.MSGSND_CHARSET);
					log.debug("--utf--CONTENT=["+sContent+"]");
				} catch (UnsupportedEncodingException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				//发送本条消息
				MessageContext context = null;
				try {
					context = pool.borrowObject(client);
					final Message message = Message.create(sContent);// 如果是对象，需要先序列化，在消费者侧反序列化
	
					//发送消息
					//message.setProperty(PropertyOption.COMPRESS, true);//自动压缩
					message.setProperty(PropertyOption.GROUP, mapDataTmp.get("BUSIID_NO").toString());
					message.setProperty(PropertyOption.PRIORITY, priori);
					String id = "";
					try {
						id = context.send(topic, message);//输出MsgID
						log.debug("--msgsendid--id="+id);
						mapDataTmp.put("MSG_ID", id);
					} catch (Exception e) {
						pool.returnObject(client, context);
	
						mapDataTmp.put("ERR_CODE", "0012");
						mapDataTmp.put("ERR_MSG", "msg-send-error-"+e.getMessage());
						msgSendDAO.inputErrAndDel(mapDataTmp, jdbc);
					}
					context.commit(id);
					pool.returnObject(client, context);
					
					//入历史，无论入历史是否成功，都需要删正表记录
					//dealMidHisData(mapDataTmp);//使用Ibatis
					msgSendDAO.inputHisAndDel(mapDataTmp, jdbc);//使用JDBC
					
				} catch (Exception e) {
					
					//本地事务处理，入err表
					mapDataTmp.put("ERR_CODE", "0011");
					mapDataTmp.put("ERR_MSG", "msg-send-error-"+e.getMessage());
					msgSendDAO.inputErrAndDel(mapDataTmp, jdbc);
					
					e.printStackTrace();
				}
				//继续处理下条消息
			}//for END
		} catch (Exception e) {
			jdbc.close();		
		}
		//关闭连接
		log.debug("----msgsendbegincloseconn----");
		jdbc.close();		
		return true;
	}
	
	/**
	 * 错单发送
	 * @param inPool
	 * @param inDataList
	 * @return
	 */
	private boolean sendErrMsg(Object inPool, List inDataList) {
		
		int iDataSize = 0;
		int iMsgLen = 0;
		String data_src = "";
		String topic = "";
		String client = "";
		int priori = 0;
		
		JdbcConn jdbc = new JdbcConn(baseDao.getNewConnection());//默认使用A库

		try {
			
			//1.得到生产者对象池
			client = AppProperties.getConfigByMap("PUB_CLIENT");
//			final KeyedObjectPool<String, MessageContext> pool = new GenericKeyedObjectPool<String, MessageContext>(
//					new PooledMessageContextFactory(AppProperties.getConfigByMap("PUB_ADDR"), 6000)); 
			final KeyedObjectPool<String, MessageContext> pool = (KeyedObjectPool<String, MessageContext>) inPool;
			
			//处理消息
			iDataSize = inDataList.size(); 
			for (int i = 0; i < iDataSize; i++) {

				//取数据，类型转换
				OdrLineErrVO odrLine = (OdrLineErrVO) inDataList.get(i);
				Map<String, Object> mapDataTmp = msgSendDAO.switchVoToMap(odrLine);
				
				data_src = mapDataTmp.get("DATA_SOURCE").toString();
				topic = mapDataTmp.get("TOPIC_ID").toString();
				priori = Integer.valueOf(getCfgValue(data_src, "PRIOR"));
				
				//数据库中字节码为GBK,此处转换为框架字符集UTF-8
				String sContent = null;
				String gbk_content = null;
				try {
					gbk_content = new String((byte[])mapDataTmp.get("CONTENT"), "GBK");
					sContent = new String(gbk_content.getBytes(InterBusiConst.MSGSND_CHARSET), InterBusiConst.MSGSND_CHARSET);
					log.debug("--utf--CONTENT=["+sContent+"]");
				} catch (UnsupportedEncodingException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				//发送本条消息
				MessageContext context = null;
				try {
					context = pool.borrowObject(client);
					final Message message = Message.create(sContent);// 如果是对象，需要先序列化，在消费者侧反序列化
	
					//发送消息
					//message.setProperty(PropertyOption.COMPRESS, true);//自动压缩
					message.setProperty(PropertyOption.GROUP, mapDataTmp.get("BUSIID_NO").toString());
					message.setProperty(PropertyOption.PRIORITY, priori);
					String id = "";
					
					id = context.send(topic, message);//输出MsgID
					log.debug("--消息id="+id);
					mapDataTmp.put("MSG_ID", id);
					
					context.commit(id);
					
					//入历史，无论入历史是否成功，都需要删正表记录
					//dealMidHisData(mapDataTmp);//使用Ibatis
					//MSG_ID若存在则入历删错，否则不处理
					if (null != mapDataTmp.get("MSG_ID"))
						msgSendDAO.inputHisAndDelErr(mapDataTmp, jdbc);//使用JDBC
					
				} catch (Exception e) {
					
					log.error("发送错误,入参datasrc数据："+mapDataTmp.toString());
					e.printStackTrace();
				} finally {
					pool.returnObject(client, context);
				}
				//继续处理下条消息
			}//for END
		} catch (Exception e) {
			e.printStackTrace();		
		}finally {
			//关闭连接
			jdbc.close();		
		}
		return true;
	}
	
	/**
	 * Title 取得APP.PROPERTIES 配置文件配置数据
	 * @param inDataSrc
	 * @param inName
	 * @return
	 */
	private String getCfgValue(String inDataSrc, String inName) {
		String sCfgName = inDataSrc.toUpperCase()+"_"+inName.toUpperCase();
		return AppProperties.getConfigByMap(sCfgName);
	}
	
//	@Override
//	public boolean dealMidInfoMsg() {
//		
//		String sDataSrc = "";
//		//String sSuffix = "";
//		//int iSuffix = 0;
//		// 循环接口表，发送消息
//		List<Map<String, Object>> tabCountList = new ArrayList<Map<String, Object>>();
//		
//		/*查询当前表 各主题下的数据量 */
//		tabCountList = getNotNoneTabInfo();
//		if (null == tabCountList) {
//			log.debug("-----消息发送接口表均无数据，请知晓！！----");
//			return true;
//		}
//		//tabCountList : tmpMap 包含：SUFFIX,COUNT,TOPIC_ID
//		
//		/*处理各主题的待发送消息*/
//		List rstInfoList = null;
//		for (Map<String, Object> tmpMap:tabCountList) {
//			//查询各主题下头1000条待发送信息
//			rstInfoList = odrLineContDAO.queryOdrListCont(tmpMap);
//
//			//处理当前 TOPIC 下接口表消息
//			//如何起多线程处理？？？
//			sDataSrc = tmpMap.get("DATA_SOURCE").toString();
//			//sSuffix  = tmpMap.get("SUFFIX").toString();
//			sendMidMsg(sDataSrc, rstInfoList);
//			
//			//iSuffix = (Integer) tmpMap.get("SUFFIX");
//		}
//		//处理完当前表数据，置其表状态为 false 表示没有在处理该表
//		//CurrentThread.setThreadMap(iSuffix, false);
//		
//		return true;
//	}
	
	
//	private List<Map<String, Object>> getNotNoneTabInfo() {
//		
//		int iCount = 0;
//		int iSuffNum = 0;
//		//String outTabSuffix = "";//返回非空接口表后缀
//		Map<String, Object> inMap = null;
//		List<Map<String, Object>> outDataList = null;
//		
//		for (iSuffNum = 0; iSuffNum < InterBusiConst.MSGSND_SUFFNUM; iSuffNum++) {
//			inMap = new HashMap<String, Object>();
//
//			//若当前接口 的Key 为false,表示有线程在处理
//
//			if (CurrentThread.getThreadMap().size() != 0 && 
//					CurrentThread.getThrdValue(iSuffNum) == true)
//				continue;
//			
////			if (iSuffNum < 10)
////				outTabSuffix = "0"+String.valueOf(iSuffNum);
////			else 
////				outTabSuffix = String.valueOf(iSuffNum);
////			inMap.put("SUFFIX", outTabSuffix);
//			iCount = (Integer) baseDao.queryForObject("in_msgsend_info.qCount", inMap);
//			if (iCount == 0)
//				continue;
//			outDataList = new ArrayList<Map<String, Object>>();
//			outDataList = baseDao.queryForList("in_msgsend_info.qCountByTopic", inMap);
//			if (outDataList.size() != 0) {
//				log.debug("-----There are DATAS in the table need to dealwith!-------outDataList=" + outDataList.size());
//				//设置当前接口表状态，true开始处理，false 没有处理
//				CurrentThread.setThreadMap(iSuffNum, true);
//				//有数据，则返回
//				break;
//			}
//			
//			if (iSuffNum == InterBusiConst.MSGSND_SUFFNUM) {
//				
//				return null;
//			}
//		}/*for circle END*/
//		
//		return outDataList;
//	}
	
}
