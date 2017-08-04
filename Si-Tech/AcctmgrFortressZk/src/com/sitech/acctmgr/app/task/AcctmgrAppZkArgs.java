package com.sitech.acctmgr.app.task;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sitech.fortress.cluster.FortressZkClusterState;
import com.sitech.fortress.cluster.JobBase;
import com.sitech.fortress.cluster.JobStatus;
import com.sitech.fortress.cluster.StatusType;
import com.sitech.fortress.config.Config;
import com.sitech.fortress.schedule.defaultassign.ResourceWorkerSlot;
import com.sitech.fortress.task.Assignment;
import com.sitech.fortress.task.TaskInfo;
import com.sitech.fortress.utils.Pair;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class AcctmgrAppZkArgs {

	static int machineNum = 3;//机器数量
	static int workNum = 2;//每台机器work数量
	static String hostName = "acctmgrMachine";//机器名称前缀
	
	static String jobName = "AcctmgrJob";//job名称
	static String jobId = "AcctmgrJobId";//jobId
	static String workName = "com.sitech.acctmgr.app.task.AcctmgrWorker";//work名称，继承接口
	
	//Map<CaptionId, List<Pair<portId, List<taskId>>>>
	static Map<String, List<Pair<Integer, List<String>>>> machineMap = new HashMap<String, List<Pair<Integer, List<String>>>>();//machineId与workId对应关系
	
	/**
	 * 初始化存储对象
	 */
	public static void init() {
		int portId = 0;
		for(int machine = 0; machine < machineNum; machine++){//循环机器
			String captainId = hostName+(machine+1);//主机名称
			List<Pair<Integer, List<String>>> workList = new ArrayList<Pair<Integer, List<String>>>();//workId对象
			for(int work = 0; work < workNum; work++){
				List<String> taskIdList = new ArrayList<String>();
				Pair<Integer, List<String>> workTasks = new Pair<Integer, List<String>>(portId, taskIdList);//workId与taskId关系
				workList.add(workTasks);//将work对象放入
				portId++;
			}
			machineMap.put(captainId, workList);
		}
		
	}
	
	/**
	 * 
	 * @param fortressZkClusterState 
	 * @param className 类名
	 * @param args  入参
	 * @param taskNum 所有主机注册该类的数量
	 * @param name 名称
	 * @return
	 * @throws Exception
	 */
	public static void receiveFortress(FortressZkClusterState fortressZkClusterState, String className,
			String args, int taskNum, String name) throws Exception {
		
		List<String> taskIdList = null;// taskId
		Pair<Integer, List<String>> workTasks = null;// workId与taskId关系
		List<Pair<Integer, List<String>>> workList = null;// workId对象
		TaskInfo info = null;
		int portId = 0;
		int preWorkTask = 0; // 已经分配的数量
        int taskNo = 0;

		for (int machine = 0; machine < machineNum; machine++) {// 循环机器
			String captainId = hostName + (machine + 1);// 主机名称
			System.out.println(captainId);
			workList = machineMap.get(captainId);
			preWorkTask = 0;

			for (int work = 0; work < workNum; work++) {// 循环work

				workTasks = workList.get(work);// workId与taskId关系
				taskIdList = workTasks.getSecond();// taskId列表

				// 注册taskInfo对象，并将taskId放入taskIdList

				int currWorkTaskNum = (taskNum/machineNum - preWorkTask) / (workNum - work);
				preWorkTask += currWorkTaskNum;
				for (int taskIndex = 0; taskIndex < currWorkTaskNum; taskIndex++,taskNo++) {
                    String taskId = null;
                    if (args != null && !"".equals(args)) {
						info = new TaskInfo(className, args+","+taskNum+","+taskNo);
                        taskId = portId + "_" + name + "(" + args + ")_" + taskNo;
					} else {
						info = new TaskInfo(className, "");
                        taskId = portId + "_" + name + "_" + taskNo;
					}
					taskIdList.add(taskId);

					fortressZkClusterState.setTask(jobId, taskId, info);
				}

				portId++;
			}

			machineMap.put(captainId, workList);
		}
		
	}
	
	/**
	 * 注册主机
	 * @param fortressZkClusterState
	 * @throws Exception
	 */
	public static void receiveMachine(FortressZkClusterState fortressZkClusterState) throws Exception{
		Set<ResourceWorkerSlot> workers =  new HashSet<ResourceWorkerSlot>();;
		Map<String, String> nodeHost = new HashMap<String, String>();
		for(int i=0;i<machineNum;i++){
			String captainId = hostName+(i+1);//主机名称
			List<Pair<Integer, List<String>>> workList = machineMap.get(captainId);
			for(Pair<Integer, List<String>> worker : workList) {
				ResourceWorkerSlot resourceWorkerSlot = new ResourceWorkerSlot();
				resourceWorkerSlot.setHostname(captainId);
				resourceWorkerSlot.setNodeId(captainId);
				resourceWorkerSlot.setPort(worker.getFirst());
				resourceWorkerSlot.setArg(""); //worker无定制化的参数。
				Set<String> tasks =new HashSet<String>();
				tasks.addAll(worker.getSecond());

				resourceWorkerSlot.setTasks(tasks);
				workers.add(resourceWorkerSlot);
			}
			
			nodeHost.put(captainId, hostName);
			
		}
			
		Assignment assignment = new Assignment(workers, nodeHost);
		fortressZkClusterState.setAssignment(jobId,assignment);
	}
	
	public static void main(String[] args) throws Exception{

		//1、注册WORK
		Map<Object, Object> config = Config.readFortressConfig();
		FortressZkClusterState fortressZkClusterState = new FortressZkClusterState(config);
		JobStatus jobStatus = new JobStatus(StatusType.active,1000,null);
		JobBase jobBase = new JobBase(jobName,10000,jobStatus,workName);
		fortressZkClusterState.activateJob(jobId, jobBase);	
		
		//初始化对象
		init();

        //注册数据工单任务
		receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.DataOrderTask", null, 30, "dataorder");
        //注册业务工单任务
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.BusiOrderTask", "BUSI", 24, "busiorder");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.BusiOrderTask", "SYNC", 6, "syncorder");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.BusiOrderTask", "BOSS", 6, "bossorder");

        //注册消息发送任务 （B库）
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "BUSI,B1", 18, "busi");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "FWKT,B2", 24, "fwkt");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "INVO,B1", 6, "invo");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "OPCT,B2", 18, "opct");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "LRPT,B1", 18, "lrpt");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "BACH,B2", 6, "bach");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "ORDR,B1", 6, "ordr");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "DTSN,B2", 12, "dtsn");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "CNTT,B1", 12, "cntt");
        receiveFortress(fortressZkClusterState, "com.sitech.acctmgr.app.task.MsgSendTask", "MRKT,B2", 6, "makt");

		//注册主机信息
		receiveMachine(fortressZkClusterState);
	
		System.out.println("执行完成");
		
	}

}
