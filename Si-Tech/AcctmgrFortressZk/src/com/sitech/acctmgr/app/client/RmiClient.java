package com.sitech.acctmgr.app.client;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.cli.BasicParser;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;





import com.sitech.acctmgr.app.common.quartz.rmi.ISchedulerServerFactory;
import com.sitech.acctmgr.app.common.quartz.rmi.SchedulerServer;

/**
 *
 * <p>Title: RMI客户端测试程序  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class RmiClient {

	private static ISchedulerServerFactory sf;
	private static SchedulerServer ss;
	private static String url = "rmi://127.0.0.1/SchedulerServer";
	

	/**
	 * 启动客户端，初始化
	 */
	public void initEnv() throws RemoteException, MalformedURLException, NotBoundException{
		sf = (ISchedulerServerFactory)Naming.lookup(url);
	}
	
	public static void initSchedleMonitor(String schedulerName) throws RemoteException, MalformedURLException, NotBoundException{
		ss = sf.getSchedulerServer(schedulerName);
	}
	public static int listSchedleName() throws RemoteException,Exception{
		System.out.println("当前加载的scheduler：");
		int i=0;
		String schedleName = null;
		for(String str : sf.getSchedulerServerNames()){
			System.out.println("-- "+str);
			String name[] = str.split("&");
			schedleName = name[1] ;
			i++;
		}
		if(i==1){
			initSchedleMonitor(schedleName);
		}
		return i;
	}
	
	public static void listJobs() throws RemoteException,Exception{
		System.out.println("当前scheduler运行的Job：");
		System.out.printf("%-12s %-8s %-8s %-15s %-15s %-15s %-10s \n",
				new Object[] { "任务名称", "任务组", "任务状态", "任务启动时间", "下次运行时间", "前一次运行时间", "调度配置"});
		
		List<Map<String,Object>> ssList = ss.qryJobList();
		for(Map<String,Object> ssMap : ssList){
			System.out.printf("%-15s %-10s %-10s %-20s %-20s %-20s %-10s\n",
					new Object[] { (String)ssMap.get("JOB_NAME"), (String)ssMap.get("JOB_GROUP_NAME"), (String)ssMap.get("JOB_STATE"), 
					(String)ssMap.get("JOB_STRAT_TIME"), (String)ssMap.get("JOB_NEXT_TIME"), (String)ssMap.get("JOB_PRE_TIME"), 
					(String)ssMap.get("JOB_CRON")});
		}
	}
	
	public void startCmdEnv() throws Exception {
		InputStreamReader inputStreamReader = new InputStreamReader(System.in);

		String cmdLine = null;
		int i = listSchedleName();
		if (i>1){
			System.out.print(">请输入SchedleName(BeanName)");
			String schedleName = new BufferedReader(inputStreamReader).readLine();
			initSchedleMonitor(schedleName);
		}
		System.out.print(">");
		while (true) {
			cmdLine = new BufferedReader(inputStreamReader).readLine();

			if (cmdLine.equals("q"))
				return;

			if (!cmdLine.equals(""))
			{
				dispatchCmd(cmdLine);
			}

			System.out.print(">");
		}
	}
	
	public void dispatchCmd(String cmdLine) throws Exception {
		String[] cmdLineArr = cmdLine.split(" ");
		if (cmdLine.equals("h")) {
			System.out.println("h（help）：列出所有的内部命令，和命令的简单说明。");
			System.out.println("l: 列出所有加载的调度管理");
			System.out.println("sw: <SchedleName(BeanName)> 切换调度管理");
			System.out.println("stop: 停止调度管理");
			System.out.println("lj: 列出当前Schedle的job情况");
			System.out.println("sj: <JobName><JobGroup>启动job");
			System.out.println("pj: <JobName><JobGroup>暂停job");
			System.out.println("q：（quit）退出命令行环境。");
		} else if (cmdLine.equals("l")) {
			listSchedleName();
		} else if (cmdLineArr[0].equals("sw")) {
			if (cmdLineArr.length > 1)
				initSchedleMonitor(cmdLineArr[1]);
			else
				System.out.println("无效命令，请重新输入。");
		} else if (cmdLine.equals("stop")) {
			ss.stopScheduler();
		} else if (cmdLine.equals("lj")) {
			listJobs();
		} else if (cmdLineArr[0].equals("sj")) {
			if (cmdLineArr.length > 1)
				ss.startJob(cmdLineArr[1], cmdLineArr[2]);
			else
				System.out.println("无效命令，请重新输入。");
		} else if (cmdLineArr[0].equals("pj")) {
			if (cmdLineArr.length > 1)
				ss.pauseJob(cmdLineArr[1], cmdLineArr[2]);
			else
				System.out.println("无效命令，请重新输入。");
		} else {
			System.out.println("不存在 '" + cmdLine + "' 命令，忽略!");
		}
	}
	
	
	public static void main(String[] args) throws RemoteException, MalformedURLException, NotBoundException, Exception {
		
		Options opts = new Options();
		opts.addOption("p", true, "项目名称");
		BasicParser parser = new BasicParser();
		
		try {
			CommandLine cl = parser.parse(opts, args);
			
			if (cl.hasOption('h')) {
				HelpFormatter hf = new HelpFormatter();
				hf.printHelp("Options", opts);
				return;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		RmiClient rmiClient = new RmiClient();
		rmiClient.initEnv();
		rmiClient.startCmdEnv();
	}

}
