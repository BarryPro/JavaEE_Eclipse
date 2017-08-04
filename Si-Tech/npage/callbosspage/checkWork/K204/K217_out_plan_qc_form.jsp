<%
  /*
   * 功能: 计划外质检
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%!
	public  String getCurrDateStr(String str) {
		  if(str.equals("")){
		    	return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		  }else{
				 	java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
							"yyyyMMdd");
				 	return objSimpleDateFormat.format(new java.util.Date())+" "+str;
		  }
	}
%>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	if(opCode == null || "".equals(opCode)){
			opCode = "K217";
	}
	if(opName == null || "".equals(opName)){
			opName = "对流水进行质检";
	}
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
/***************获得考评对象流水、考评内容流水开始******************/
	String contect_id     = request.getParameter("content_id");
	String object_id      = request.getParameter("object_id");
	String contact_id     = request.getParameter("serialnum");//被检流水
	String isOutPlanflag  = request.getParameter("isOutPlanflag");
	String staffno        = (String)request.getParameter("staffno");//被检工号
	String evterno        = (String)session.getAttribute("kfWorkNo");//质检工号
	String plan_id        = WtcUtil.repNull(request.getParameter("plan_id"));
	String tabId          = WtcUtil.repNull(request.getParameter("tabId"));//tab页面的id值
/***************获得考评对象流水、考评内容流水结束******************/
%>

<%
/***************获得质检对象类别开始******************/
	String sqlGetObjectName = "SELECT object_name FROM dqcobject WHERE trim(object_id) = '" + object_id + "'";
	String objectName = "";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=sqlGetObjectName%>"/>
	</wtc:service>
	<wtc:array id="objectNames" scope="end"/>
<%
	if(objectNames.length>0){
	  	objectName = objectNames[0][0];
}
/***************获得质检对象类别结束******************/
%> 

<%
/***************获得考评内容开始******************/
	String sqlGetContentName = "SELECT name FROM dqccheckcontect WHERE trim(object_id) = '" + object_id + "' AND contect_id = '" + contect_id + "'";
	String contentName = "";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=sqlGetContentName%>"/>
	</wtc:service>
	<wtc:array id="contentNames" scope="end"/>
<%
	if(objectNames.length>0){
	  	contentName = contentNames[0][0];
	}
/***************获得考评内容结束******************/
%>  

<%
/***************获得当前质检员已质检条数开始******************/
	String starttime = getCurrDateStr("00:00:00");
	String endtime = getCurrDateStr("23:59:59");
	String qccounts="0";
	String getQcCount = "select count(*) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>='"+starttime+"' and to_char(endtime,'yyyyMMdd hh24:mi:ss')<='"+endtime+"' and evterno='"+evterno+"'   and flag ='2' or flag='3'  and is_del='N' ";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=getQcCount%>"/>
	</wtc:service>
	<wtc:array id="qcCount" scope="end"/>
<%
	if(qcCount.length>0){
	  	qccounts=qcCount[0][0];
	}
/***************获得当前质检员已质检条数结束******************/
%>  	
  
<%
/***************获得当前质检员待整理条数开始******************/
	String getQcTempCount = "select count(*) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>='"+starttime+"' and evterno='"+evterno+"' and flag='0'  and is_del='N'";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=getQcTempCount%>"/>
	</wtc:service>
	<wtc:array id="qcTempCount" scope="end"/>
<%
/***************获得当前质检员待整理条数结束******************/
%>

<%
/***************获得通话信息开始******************/
	String nowYYYYMM = contact_id.substring(0, 6);
	String tableName = "dcallcall" + nowYYYYMM;
	String sqlCallcall = "select caller_phone, decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心'),call_cause_id,callcausedescs,vertify_passwd_flag from " + tableName + " where contact_id='" + contact_id + "'";
%>
	<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlCallcall%>"/>
	</wtc:service>
	<wtc:array id="callcallList" scope="end"/>
<%
/***************获得通话信息结束******************/
%>

<%
/***************获得质检信息开始******************/
	String sqlQcDetail = "select decode(t1.check_type,'0','实时质检','1','事后质检'),decode(t1.check_kind,'0','自动分派','1','人工指定'),decode(t1.check_class,'0','评语评分','1','评语','2','评分'),t4.object_name,t5.name,t1.check_type,t1.check_kind,t1.plan_id,t1.current_times "
	                     +"from dqcplan t1,dqcobject t4,dqccheckcontect t5 "
	                     +"where  t1.object_id=t4.object_id(+) and t1.content_id=t5.contect_id(+)  and trim(t1.content_id)='" + contect_id + "' and trim(t1.object_id) = '"+object_id+"'　and trim(t5.object_id) = '"+object_id+"' and (t5.contect_id) = '" + contect_id + "' and t1.plan_id='"+plan_id+"'";
%>
	<wtc:service name="s151Select" outnum="9">
	<wtc:param value="<%=sqlQcDetail%>"/>
	</wtc:service>
	<wtc:array id="qcDetailList" scope="end"/>

<%
/***************获得质检信息结束********************/	

/***************获得已质检次数开始******************/
	String completedCounts="";//实际完成质检条数
	String sqlGetTimes = "select current_times from dqcloginplan " + 
	                     "where  object_id='" + object_id + "' and content_id='" + contect_id + 
	                     "' and plan_id='" + plan_id + "' and login_no='" + staffno + "'";
%>
	<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlGetTimes%>"/>
	</wtc:service>
	<wtc:array id="qcgetTimeList" scope="end"/>
<%
	if(qcgetTimeList.length>0){
			if("".equals(qcgetTimeList[0][0].trim())){
			  	completedCounts="1";
			}else{
				  int temp =Integer.parseInt(qcgetTimeList[0][0])+1;
				  completedCounts=temp+"";
			}
	}
/***************获得已质检次数结束******************/
%>

<%
/***************获得考评项列表开始******************/
String sqlStr="select t.item_id, t.item_name, decode(substr(to_char(trim(low_score)),0,1),'.','0'||trim(low_score),low_score), decode(substr(to_char(trim(high_score)),0,1),'.','0'||trim(high_score),high_score) " +
              "from dqccheckitem t where trim(t.contect_id)='" + contect_id + "' and trim(object_id) = '"+object_id+"' and is_leaf='Y'"+" and is_scored='Y' "+
              " and bak1='Y' " + "order by t.item_id";
%>
	<wtc:service name="s151Select" outnum="6">
	<wtc:param value="<%=sqlStr%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>
<%
/***************获得考评项列表结束******************/
%>

<%
/***************获得质检流水开始******************/
	String sqlGetSerialNum = "select '"+nowYYYYMM+"'||lpad(seq_qc_result.nextval,13,'0') from dual";
	//获得质检流水
%>
	<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlGetSerialNum%>"/>
	</wtc:service>
	<wtc:array id="serialNum" scope="end"/>
<%
/***************获得质检流水结束******************/
%>

<%
/***************获得该考评内容总分开始******************/
	String getTotalScoreSql = "select sum(high_score) from dqccheckitem " +
  	                        "where object_id='" + object_id + "' and contect_id='" + contect_id + "' and is_leaf='Y' "+" and is_scored='Y' "+ " and bak1='Y' ";
%>
	<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=getTotalScoreSql%>"/>
	</wtc:service>
	<wtc:array id="totalScore" scope="end"/>
<%
/***************获得该考评内容总分结束******************/
%>

<%
/***************记录质检开始信息（质检起始时间等）开始******************/
	//临时保存（0）状态
	String checktype = "";
	String kind = "";
	String score= "";
	String vertify_passwd_flag = "";
	if(qcDetailList.length>0){
		  checktype = qcDetailList[0][5];
		  kind = qcDetailList[0][6];
	}
	if(totalScore.length>0){
	  	score=totalScore[0][0];
	}
	if(callcallList.length>0){
	  	vertify_passwd_flag=callcallList[0][4];
	}
	//checkflag表是未进行的质检复核，只要打开质检复核的页面checkflag设置为0，即临时保存的质检复核结果checkflag为0，提交的质检古河checkflag为1
	String sqlInsertQcInfo = "insert into dqcinfo(serialnum, recordernum, starttime, flag, objectid, contentid, staffno, evterno,checktype,kind,is_del,outplanflag,checkflag,score,vertify_passwd_flag) " +
	                         "values (:v1,:v2, sysdate, '4',:v3,:v4,:v5,:v6,:v7,:v8,'N',:v9,'-1','',:v10)";
%>
  <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			 <wtc:param value="<%=sqlInsertQcInfo%>"/>
			 <wtc:param value="dbchange"/>
			 <wtc:param value="<%=serialNum[0][0]%>"/>
			 <wtc:param value="<%=contact_id%>"/>
			 <wtc:param value="<%=object_id%>"/>
			 <wtc:param value="<%=contect_id%>"/>
			 <wtc:param value="<%=staffno%>"/>
			 <wtc:param value="<%=evterno%>"/>
			 <wtc:param value="<%=checktype%>"/>
			 <wtc:param value="<%=kind%>"/>
			 <wtc:param value="<%=isOutPlanflag%>"/>
			 <wtc:param value="<%=vertify_passwd_flag%>"/>
	</wtc:service>
<%
/***************记录质检开始信息（质检起始时间等）结束******************/

/***************更新DCALLCALLYYYYMM中当前流水的质检员工号和是否质检标识开始******************/
  String sqlUpdDcallcall="update "+tableName+" set QC_LOGIN_NO=:v1,QC_FLAG='Y' where contact_id=:v2";
 %>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			 <wtc:param value="<%=sqlUpdDcallcall%>"/>
			 <wtc:param value="dbchange"/>
			 <wtc:param value="<%=evterno%>"/>
			 <wtc:param value="<%=contact_id%>"/>
	</wtc:service>
 <%
/***************更新DCALLCALLYYYYMM中当前流水的质检员工号和是否质检标识结束******************/
	/***************获得来电原因内容开始******************/
	//获取来电原因
	String tmp_callcause_id = (callcallList.length>0)?callcallList[0][2]:"";
	
	if(tmp_callcause_id.startsWith(",")){
	  	tmp_callcause_id = tmp_callcause_id.substring(1,tmp_callcause_id.length());
	}
	if(tmp_callcause_id.endsWith(",")){
	  	tmp_callcause_id = tmp_callcause_id.substring(0,tmp_callcause_id.length()-1);
	}
	
  String sqlGetCauseInfo = "select callcause_id,caption,fullname from dcallcausecfg where callcause_id in("+tmp_callcause_id+")";

%>
  <wtc:service name="s151Select" outnum="3">
  		<wtc:param value="<%=sqlGetCauseInfo%>"/>
  </wtc:service>
  <wtc:array id="causeInfo" scope="end"/>
  	
<%
 	String tmpInfo = "";
 	String tmpId ="";
 	
	for(int i=0;i<causeInfo.length;i++){
			tmpInfo += causeInfo[i][2]+",";
			tmpId += causeInfo[i][0]+",";
	}
	
	if(tmpInfo.endsWith(",")){
	  	tmpInfo = tmpInfo.substring(0,tmpInfo.length()-1);
	  	tmpInfo = tmpInfo.trim();
	}
	
	if(tmpId.endsWith(",")){
	  	tmpId = tmpId.substring(0,tmpId.length()-1);
	  	tmpId = tmpId.trim();
	}
 /***************获得来电原因内容结束******************/
%>
 
<html>
<head>
<script>

/**
  *质检完毕返回处理函数
  */
function doProcessSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="saveQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("成功记录考评结果！",2);
				}else{
					rdShowConfirmDialog("记录考评结果失败！",2);
				}
		}
	  //保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *质检完毕，保存质检结果
  *
  */
function saveQcInfo() {
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","请稍后...");

		//获得考评项得分
    var scoreValues    = new Array();
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }
    
    //获得考评项id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//获得流水号
		var serialnum = document.getElementById("serialnum").value;
		//内容概况
    var contentinsum = document.getElementById("contentinsum").value;
    //处理情况
    var handleinfo = document.getElementById("handleinfo").value;
    //改进建议
    var improveadvice = document.getElementById("improveadvice").value;
    //综合评价
    var commentinfo = document.getElementById("commentinfo").value;

    
    //差错等级id
    var error_level_id = document.getElementById("error_level_id").value;
    //差错等级
    var error_level_text = document.getElementById("error_level_text").value;
    //差错类别id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //差错类别
    var error_class_texts = document.getElementById("error_class_texts").value;
    //来电原因id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //来电原因
    var service_class_texts = document.getElementById("service_class_texts").value;
    //总得分
    var totalScore = document.getElementById("totalScore").value;
    //质检时长
    var handleTime = document.getElementById("handleTime").innerHTML;
    //听取录音时长
    var listenTime = document.getElementById("listenTime").innerHTML;
    //整理时长
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //总时长
    var totalTime = document.getElementById("totalTime").innerHTML; 
    
		chkPacket.data.add("retType", "saveQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
	  chkPacket.data.add("contact_id", "<%=contact_id%>");
	  chkPacket.data.add("plan_id", "<%=plan_id%>");// 质检计划id
	  chkPacket.data.add("completedCounts", "<%=completedCounts%>");//质检计划执行条数
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);

		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "1");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);	
		chkPacket.data.add("totalTime", totalTime);	
		chkPacket.data.add("staffno","<%=staffno%>");
		
	  core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,true);
		chkPacket =null;
}


/**
  *临时保存返回处理函数
  */
function doProcessTempSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="tempSaveQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("临时保存质检结果成功！",2);
				}else{
					rdShowConfirmDialog("临时保存质检结果失败！",1);
				}
		}
		//保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		closeWin();
}


/**
  *
  *临时保存质检结果
  *
  */
function tempSaveQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","请稍后...");
		//获得考评项得分
    var scoreValues    = new Array();
    
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //获得考评项id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//获得流水号
		var serialnum = document.getElementById("serialnum").value;
		//内容概况
    var contentinsum = document.getElementById("contentinsum").value;
    //处理情况
    var handleinfo = document.getElementById("handleinfo").value;
    //改进建议
    var improveadvice = document.getElementById("improveadvice").value;
    //综合评价
    var commentinfo = document.getElementById("commentinfo").value;
    
    
    //差错等级id
    var error_level_id = document.getElementById("error_level_id").value;
    //差错等级
    var error_level_text = document.getElementById("error_level_text").value;
    //差错类别id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //差错类别
    var error_class_texts = document.getElementById("error_class_texts").value;
    //来电原因id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //来电原因
    var service_class_texts = document.getElementById("service_class_texts").value;
    //总得分
    var totalScore = document.getElementById("totalScore").value;
    //质检时长
    var handleTime = document.getElementById("handleTime").innerHTML;
    //听取录音时长
    var listenTime = document.getElementById("listenTime").innerHTML;
    //整理时长
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //总时长
    var totalTime = document.getElementById("totalTime").innerHTML;    

		chkPacket.data.add("retType", "tempSaveQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);

		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "0");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);
		chkPacket.data.add("completedCounts", "<%=completedCounts%>");//质检计划执行条数	
		chkPacket.data.add("staffno","<%=staffno%>");
		chkPacket.data.add("plan_id", "<%=plan_id%>");// 质检计划id
		<!--参数false表示同步执行-->
		core.ajax.sendPacket(chkPacket, doProcessTempSaveQcInfo, false);
		chkPacket =null;
}

/**
  *放弃返回处理函数
  */
function doProcessGiveUpQcInfo(packet) {
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="giveUpQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("成功放弃质检！",2);
				}else{
					rdShowConfirmDialog("放弃质检失败！",1);
				}
		}
		//保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *放弃质检
  *
  */
function giveUpQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","请稍后...");
	//获得考评项得分
    var scoreValues    = new Array();
    
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //获得考评项id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//获得流水号
		var serialnum = document.getElementById("serialnum").value;
		//内容概况
    var contentinsum = document.getElementById("contentinsum").value;
    //处理情况
    var handleinfo = document.getElementById("handleinfo").value;
    //改进建议
    var improveadvice = document.getElementById("improveadvice").value;
    //综合评价
    var commentinfo = document.getElementById("commentinfo").value;

    
    //差错等级id
    var error_level_id = document.getElementById("error_level_id").value;
    //差错等级
    var error_level_text = document.getElementById("error_level_text").value;
    //差错类别id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //差错类别
    var error_class_texts = document.getElementById("error_class_texts").value;
    //来电原因id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //来电原因
    var service_class_texts = document.getElementById("service_class_texts").value;
    //放弃原因id
    var give_up_reason_ids = document.getElementById("give_up_reason_ids").value;    
    //放弃原因
    var give_up_reason_texts = document.getElementById("give_up_reason_texts").value;
    //总得分
    var totalScore = document.getElementById("totalScore").value;
    //质检时长
    var handleTime = document.getElementById("handleTime").innerHTML;
    //听取录音时长
    var listenTime = document.getElementById("listenTime").innerHTML;
    //整理时长
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //总时长
    var totalTime = document.getElementById("totalTime").innerHTML; 

		chkPacket.data.add("retType", "giveUpQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);

		
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("give_up_reason_ids", give_up_reason_ids);
		chkPacket.data.add("give_up_reason_texts", give_up_reason_texts);	
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "4");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);
		chkPacket.data.add("completedCounts", "<%=completedCounts%>");//质检计划执行条数
		chkPacket.data.add("staffno","<%=staffno%>");
		chkPacket.data.add("plan_id", "<%=plan_id%>");// 质检计划id
		core.ajax.sendPacket(chkPacket, doProcessGiveUpQcInfo, true);
		chkPacket =null;
}

//显示通话详细信息
function getCallDetail(){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
	  path = path + "?contact_id=" + '<%=contact_id%>';
	  path = path + "&start_date=" + '<%=nowYYYYMM%>';
	  window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
}

//选择考评等级后改变分数和总分
function changeScore(i){
		var scorei = document.getElementById("score"+i);
		var itemleveli = document.getElementById("itemlevel"+i);
		scorei.value=itemleveli.options[itemleveli.selectedIndex].value;
		sumScore();
}

function checkIsSendTip(){
		var tipCheckBox = document.getElementById("sendTip");
		
		if(tipCheckBox.checked==true){
				window.openWinMid("K217_send_qc_result_tip.jsp","质检结果提醒",150, 400);
		}else{
				saveQcInfo();
		}
}

/**
 *功能：记录质检结果通知
*/
function doQcCfm(flag){
	  var totalScore = document.getElementById("totalScore").value;	
		var mypacket = new AJAXPacket("../K203/K203_appOrCfm_rpc.jsp","正在发送请求，请稍候......");
		mypacket.data.add("belongno","");
		mypacket.data.add("submitno","<%=evterno%>");
		mypacket.data.add("type",0);
		mypacket.data.add("serialnum","<%=serialNum[0][0]%>");
		mypacket.data.add("staffno","<%=staffno%>");
		mypacket.data.add("evterno","<%=evterno%>");
		mypacket.data.add("apptitle","流水号：<%=contact_id%> 考评得分："+totalScore);                   	
		mypacket.data.add("content","");  
		mypacket.data.add("flag",flag);  	
		core.ajax.sendPacket(mypacket,doQcCfmdoProcess,true);
		mypacket=null;     
}

//发送通知回调函数
function doQcCfmdoProcess(packet){	
		var flag = packet.data.findValueByName("flag");
		toSendMsg(flag);
}

//add by hanjc for 中测 begin
//发送电子邮件提醒
function doMailCfm(){
	 var path='<%=request.getContextPath()%>/npage/callbosspage/K083/K083_mailSend.jsp?mailcontent=请查看流水号：<%=contact_id%>的评分结果';
	 var obj = openWinMid(path,'邮件提醒',650,850);
}
//add by hanjc for 中测 end

//发送质检结果通知提醒
function toSendMsg(flag){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","正在发送通知，请稍候......");
		mypacket.data.add("description","质检结果");//不能超过10位
		mypacket.data.add("send_login_no","<%=evterno%>");
		mypacket.data.add("receive_login_no","<%=staffno%>");
		mypacket.data.add("cityid","");
		mypacket.data.add("content","请查看流水号：<%=contact_id%>的评分结果");
		mypacket.data.add("msg_type",0);
		mypacket.data.add("title","质检结果通知");
	  mypacket.data.add("bak",flag);
	  core.ajax.sendPacket(mypacket,toSendMsgdoProcess,true);
		mypacket=null;
}

//发送质检结果通知提醒回调函数
function toSendMsgdoProcess(packet){
		var retCode = packet.data.findValueByName("retCode");
		saveQcInfo();
}

/*-------------听取录音功能开始-----------------*/
function doLisenRecord(filepath,contact_id,idname){
		window.parent.top.document.getElementById("recordfile").value     = filepath;
		window.parent.top.document.getElementById("lisenContactId").value = contact_id;
		window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
		window.parent.top.document.getElementById(idname).click();
}
function ListenPause(idname){
}

/**
	*初始化时获取录音地址
	*/
function initCheckCallListen(id,idname){
		if(id==''){
				return;
		}
		
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","");
		packet.data.add("contact_id",id);
		packet.data.add("idname",idname);
		core.ajax.sendPacket(packet,doProcessGetInitPath,false);
		packet=null;
}	
	
function doProcessGetInitPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id"); 
   var idname      = packet.data.findValueByName("idname");
   window.parent.top.document.getElementById("recordfile").value     = file_path;
	 window.parent.top.document.getElementById("lisenContactId").value = contact_id;
	 window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
}

/**
  *录音听取调用
  *
  *id:     流水ID
  *idname: opcode
  */
function checkCallListen(id,idname){
		if(id==''){
		return;
		}
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","");
		packet.data.add("contact_id",id);
		packet.data.add("idname",idname);
		core.ajax.sendPacket(packet,doProcessGetPath,false);
		packet=null;
}

function doProcessGetPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id"); 
   var idname      = packet.data.findValueByName("idname"); 
 
   if(flag=='Y'){
   		doLisenRecord(file_path,contact_id,idname);
   }else{
   		getCallListen(contact_id,idname);
   }
}

function getCallListen(id,idname){
		if(id==''){
				return;
		}	
		var path = "<%=request.getContextPath()%>"+"/npage/callbosspage/checkWork/K217/K217_getCallListen.jsp?flag_id="+id;
		openWinMid(path,'录音听取',650,850);
}

/*--------------听取录音功能结束----------------*/

/*----------------放音计时开始--------------*/

var ListenTimer = null;
function ListenTimeStart(){ 
		var listenTime=document.getElementById("listenTime").innerHTML;
		listenTime=parseInt(listenTime)+1; 
	  document.getElementById("listenTime").innerHTML =listenTime;
	  window.ListenTimer = window.setTimeout("ListenTimeStart()",1000);
}

function ListenTimePause(){
		clearTimeout(window.ListenTimer);
}

function ListenTimeStop(){
		ListenTimePause();
}

function ListenTimeEnd(){
		ListenTimeStop();
}
/*----------------放音计时结束--------------*/

/*--------------计时器开始----------------*/
window.onload=function(){
		setTimer();
		initCheckCallListen('<%=contact_id%>','K042');
}
var scan = "";
function setTimer(){
		scan = setInterval("timer()",1000);
}

//结束质检时长
function finishedTimer(){
		clearInterval(scan);
}

function timer(){
		var handleTime = document.getElementById("handleTime").innerHTML; 
		var listenTime = document.getElementById("listenTime").innerHTML;
		handleTime=parseInt(handleTime)+1;
		var totalTime = handleTime;
		document.getElementById("handleTime").innerHTML=handleTime;
		document.getElementById("totalTime").innerHTML=totalTime;
}

/*----------------计时器结束--------------*/

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//关闭当前窗口
function closeWin(){
		var tabId='<%=tabId%>';
		var isClosed = document.getElementById("isClosed").value;
		if(tabId!=''&& isClosed=='false'){
	    parent.parent.removeTab(tabId);
	  }
}
</script>

<style>
.content_02
{
	font-size:12px;
}
#tabtit
{
	height:23px;
	padding:0px 0 0 12px;
}
#tabtit ul
{
	height:23px;
	position:absolute;
}
#tabtit ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit .normaltab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}

/*---------------听取录音按钮style开始-------*/
#callSearch
{
	height:1.2%;
	width:100%;
	padding:4px 2px;
	font-size:12px;
	z-index:1000000000000;
}

#callSearch img
{
	width:16px;
	height:16px;
	cursor:pointer;
}

/*---------------听取录音按钮style结束------------*/

#subScore{
border:1px solid #FFF;
}
</style>

</head>
<body>
<form name="form1">
<input type="hidden" name="serialnum" id="serialnum" value="<%=(serialNum.length>0)?serialNum[0][0]:""%>"/>
	<div id="Operation_Table">
    <div class="title">
    	质检信息
<% 
    	         if(isOutPlanflag.equals("0")){
%>
    	         	：今天该计划质检，你已完成<%=qccounts%>条，待整理条数<%=(qcTempCount.length>0)?qcTempCount[0][0]:"0"%>条
<%
    	         }
%>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue">考评类别</td>
        <td>
		<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][0]:""%>"/>
        </td>

        <td class="blue">考评方式</td>
        <td>
     	<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][1]:""%>"/>
        </td>

      	<td class="blue">流水号</td>
        <td>
        <input type="text" name="" id=""  size="25" readonly value="<%=contact_id%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">计划类型</td>
        <td>
        <%if("1".equals(isOutPlanflag)){%>
        		<input type="text" name="" id="" size="10" readonly value=""/>
        <%}else{%>
		       <input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][2]:""%>"/>
		    <%}%>
        </td>

        <td class="blue">对象类别</td>
        <td>
     	<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][3] : objectName%>"/>
        </td>

      	<td class="blue">被检人</td>
        <td>
        <input type="text" name="" id="" size="25"  readonly value="<%=staffno%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">考评内容</td>
        <td>
		<input type="text" name="" id="" size="10" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][4]: contentName%>"/>
        </td>

        <td class="blue">来电号码</td>
        <td>
     	<input type="text" name="" id="" size="10" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][0]);}%>"/>
        </td>

      	<td class="blue">归属地</td>
        <td>
        <input type="text" name="" id="" size="25"  readonly value="<%if(callcallList.length>0){out.println(callcallList[0][1]);}%>"/>
        </td>
      </tr>
    </table>

	<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
	<tr>
	<td>
		<input type="checkbox" name="sendTip" id="sendTip" value=""/>发送结果通知 &nbsp;&nbsp;&nbsp;
		<input type="button" name="" value="监视"/>
	</td>
	<td align="right">
		<input type="button" name="" value="指定新的计划"/>
		<input type="button" name="" value="查看基本信息" onclick="getCallDetail();"/>
		<input type="button" name="" value="选择培训建议"/>
	</td>
	</tr>
	</table>
</div>


<div id="Operation_Table">
  <div class="title">
    评分项目 &nbsp;子项得分合计 &nbsp;
  	<input type="text" disabled id="subScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:""%>"/> &nbsp;
  </div>
  <table id="tb2" width="100%" height="25" border="0" align="center" cellpadding="2px" cellspacing="0">
	  <tr>
	    <td>序号</td>
	    <td>名称</td>
	    <td>最低分</td>
	    <td>最高分 </td>
	    <td>得分</td>
	    <td>考评等级</td>    
	  </tr>

<%
	for(int i = 0; i < queryList.length; i++){
			out.println("<tr>");
			out.println("<td class='Blue' width='30px'>"+i+"</td>");
			out.println("<td class='Blue'>");
			out.println(queryList[i][1]);
			out.println("<input type='hidden' name='itemId' value='"+queryList[i][0]+"'/>");
			out.println("</td>");
			out.println("<td class='Blue' width='40px'>"+queryList[i][2]+"</td>");
			out.println("<td class='Blue' width='40px'>"+queryList[i][3]+"</td>");
	    out.println("<td class='Blue' width='10px'><input type='text' name='score"+i+"' id='score"+i+"' size='6' maxlength='6' onblur='sumScore();' value='"+queryList[i][3]+"' onkeyup=\"value=value.replace(/[^\\d]/g,'') \"onbeforepaste=\"clipboardData.setData('text',clipboardData.getData('text').replace(/[^\\d]/g,''))\"/></td>");
			out.println("<td class='Blue' width='50px'>");
			out.println("<select style='width:100px;' name='itemlevel"+i+"' id='itemlevel"+i+"' onchange='changeScore("+i+");'>");		
%>
	    <wtc:qoption name="s151Select" outnum="2">
	    <wtc:sql>select decode(substr(to_char(trim(score)),0,1),'.','0'||trim(score),trim(score)), decode(substr(to_char(trim(score)),0,1),'.','0'||trim(score),trim(score))||'->'||level_name from dqcckectitemlevel where item_id=<%=(queryList.length>0)?queryList[i][0]:""%> and content_id='<%=contect_id%>' and object_id='<%=object_id%>' order by score desc </wtc:sql>
	    </wtc:qoption>
<%
	    out.println("</select>");
			out.println("</td>");
			out.println("</tr>");
	}
%>
</table>

</div>

<div id="Operation_Table">
	<div class="title">有效评语(<%=qccounts%>)条 &nbsp;</div>
	<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
		<tr>
		<td align="right">差错等级</td>
		<td>
		<input type="text" name="error_level_text" id="error_level_text" size="10" value="" readonly/>
		<input type="hidden" name="error_level_id" id="error_level_id" value=""/>
		<input type="button" name="btn_error_level" value="选择" onclick="show_select_error_level_win();"/>
		</td>
		<td align="right">差错类别</td>
		<td>
		<input type="text" name="error_class_texts" id="error_class_texts" size="10" value="" readonly/>
		<input type="hidden" name="error_class_ids" id="error_class_ids" value=""/>
		<input type="button" name="btn_error_class" value="选择" onclick="show_select_error_class_win();"/>
		</td>
		<td align="right">来电原因</td>
		<td>
		<input type="text" name="service_class_texts" id="service_class_texts" size="10" value="<%=tmpInfo%>" readonly/>
		<input type="hidden" name="service_class_ids" id="service_class_ids" value="<%=tmpId%>"/>
		<!--放弃原因隐藏域-->
		<input type="hidden" name="give_up_reason_ids" id="give_up_reason_ids" />
		<input type="hidden" name="give_up_reason_texts" id="give_up_reason_texts" />			
		</td>
	</tr>
	</table>
</div>

<div id="Operation_Table">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<div class="content_02">
			<div id="tabtit">
				<ul>
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">1 内容概况</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 处理情况</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 改进建议</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 综合评价</li>
					<!--add for 中测 start-->
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">5 培训建议</li>
					<!--add for 中测 finished-->
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
		    	<textarea id="contentinsum" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="commentinfo" cols="70" rows="3"></textarea>
			</div>

		</div>

		</td>
	</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer" width="100%">
        <div id="callSearch">
        <!--add for 中测 start-->
        权重：<input type="text" name="testWeight" id="testWeight" size="6" value="" />&nbsp;
        <!--add for 中测 end-->
				总分：<input type="text" name="totalScore" id="totalScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:""%>" readonly/>
				<input name="confirm" onClick="tempSaveQcInfo();finishedTimer();" type="button" class="b_foot" value="临时保存">
				<input name="confirm" onClick="checkIsSendTip();finishedTimer();" type="button" class="b_foot" value="质检完毕">
				<input name="confirm" onClick="rdShowMessageDialog('设为案例！',1);finishedTimer();" type="button" class="b_foot" value="设为案例">
				<input name="confirm" onClick="show_select_give_up_reason_win()" type="button" class="b_foot_long" value="放弃">
				<!--	<input name="back" onClick="grpClose();" type="button" class="b_foot" value="取消">-->
		    <b id="K042" onclick="checkCallListen('<%=contact_id%>','K042');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k042.gif" alt="放音" /></b>
		    <b id="K043" onclick="checkCallListen('<%=contact_id%>','K043');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k043.gif" alt="停止放音" /></b>
		    <b id="K044" onclick="checkCallListen('<%=contact_id%>','K044');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k044.gif" alt="暂停放音" /></b>
		    <b id="K064" onclick="checkCallListen('<%=contact_id%>','K064');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k064.gif" alt="继续放音" /></b>
		    <b id="K045" onclick="checkCallListen('<%=contact_id%>','K045');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k045.gif" alt="快进" /></b>
		    <b id="K046" onclick="checkCallListen('<%=contact_id%>','K046');return false;"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k046.gif" alt="快退" /></b>
      </div>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="left" >质检开始：</td>     <td align="left" ><%=getCurrDateStr("")%></td>
			<td align="left" >质检结束：</td>     <td align="left" >&nbsp;</td>
			<td align="left" >处理时长：</td>     <td align="left" id="handleTime">0</td>

		</tr>
		<tr>
			<td align="left" >放音/监听时长：</td><td align="left" id="listenTime">0</td>
			<td align="left" >整理时长：</td>     <td align="left" id="adjustTime">0</td>
			<td align="left" >总时长：</td>       <td align="left" id="totalTime">0</td>
		</tr>		
	</table>	
	<!--隐藏域isSaved为false 表示当前结果未进行任何保存操作，包括放弃操作-->
	<input type='hidden' name='isSaved' id='isSaved' value='false'>
	<!--隐藏域isSaved结束------------->
	<!--隐藏域isClosed为false 用于控制关闭tab页方法只可调用一次-->
	<input type='hidden' name='isClosed' id='isClosed' value='false'>
	<!--隐藏域isClosed结束------------->
</div>

</form>
</body > 
</html>

<script language="javascript">

function grpClose(){
		window.opener = null;
		top.close();
}

/**
  *考评项录入框失去焦点后，计算当前得分
  */
function sumScore(){
		var inputs = document.getElementsByTagName('input');
		var objTotalScore = document.getElementById("totalScore");
		var subScore = document.getElementById("subScore");
		var totalScore = 0;
		
		for(var i = 0; i < inputs.length; i++){
				if(inputs[i].name.substring(0,5) == 'score'){
						totalScore += parseFloat(inputs[i].value);
				}
		}
		
		objTotalScore.value = totalScore;
		subScore.value = totalScore;
}

function g(o){
		return document.getElementById(o);
}
function HoverLi(n){
		//for(var i=1;i<=4;i++)
		//modify for 中测 将4改为5
		for(var i=1;i<=5;i++){
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
}

function ccc(){
		if(rdShowConfirmDialog("是否确定提交？")){
		}
}

/**
  *弹出选择放弃原因的窗口
  */
function show_select_give_up_reason_win(){
		var returnValue = window.showModalDialog("./K217_get_give_up_reason.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		if(typeof(returnValue) != "undefined"){
				var give_up_reason_texts = document.getElementById("give_up_reason_texts");
				var give_up_reason_ids   = document.getElementById("give_up_reason_ids");
				var temp = returnValue.split('_');
				give_up_reason_texts.value = trim(temp[0]);
				give_up_reason_ids.value = trim(temp[1]);
				
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_level = temp1.split(',');
				var ids_temp_level = temp2.split(',');
				give_up_reason_texts.value="";
				for(var i=0; i<texts_temp_level.length-1; i++){
							if(i!=0&&i%2==0){
							give_up_reason_texts.value +='<br>';
					}
					if(i!=texts_temp_level.length-1){
				    	give_up_reason_texts.value += texts_temp_level[i] + ',';
				  }  
		}
		giveUpQcInfo();
		finishedTimer();
	 }
}

/**
  *弹出选择差错等级的窗口
  */
function show_select_error_level_win(){
		var returnValue = window.showModalDialog("./K217_get_error_level.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		if(typeof(returnValue) != "undefined"){
				var error_level_text = document.getElementById("error_level_text");
				var error_level_id   = document.getElementById("error_level_id");
				var temp = returnValue.split('_');
				error_level_text.value = trim(temp[0]);
				error_level_id.value = trim(temp[1]);
				
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_level = temp1.split(',');
				var ids_temp_level = temp2.split(',');
				error_level_text.value="";
				for(var i=0; i<texts_temp_level.length-1; i++){
						if(i!=0&&i%2==0){
								error_level_text.value +='<br>';
						}
						if(i!=texts_temp_level.length-1){
					    	error_level_text.value += texts_temp_level[i] + ',';
					  } 
				}
		}
}

/**
  *弹出选择差错类别的窗口
  */
function show_select_error_class_win(){
		var returnValue = window.showModalDialog("./K217_get_error_class.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		
		if(typeof(returnValue) != "undefined"){
				var error_class_texts = document.getElementById("error_class_texts");
				var error_class_ids  = document.getElementById("error_class_ids");
				var temp = returnValue.split('_');
				error_class_texts.value = trim(temp[0]);
				error_class_ids.value   = trim(temp[1]);
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_arr = temp1.split(',');
				var ids_temp_arr = temp2.split(',');
				error_class_texts.value="";
				
				for(var i=0; i<texts_temp_arr.length-1; i++){
					
						if(i!=0&&i%2==0){
								error_class_texts.value +='<br>';
						}
						
						if(i!=texts_temp_arr.length-1){
						  	error_class_texts.value += texts_temp_arr[i] + ',';
						}
				}
		}
}

/**
  *弹出选择来电原因的窗口
  */
function show_select_service_class_win(){
		if(<%=callcallList.length%>==0||trim('<%=(callcallList.length>0)?callcallList[0][2]:""%>')==""){
				rdShowMessageDialog("该流水无对应的来电原因!",1); 
		}else{
				var returnValue = window.showModalDialog("./K217_get_service_class.jsp?call_cause_id=<%=(callcallList.length>0)?callcallList[0][2]:""%>&call_cause_desc=<%=(callcallList.length>0)?callcallList[0][3]:""%>",'',"dialogWidth=800px;dialogHeight=350px");
				
				if(typeof(returnValue) != "undefined"){
						var service_class_texts = document.getElementById("service_class_texts");
						var service_class_ids   = document.getElementById("service_class_ids");
						var temp = returnValue.split('_');
						service_class_texts.value = trim(temp[0]);
						service_class_ids.value   = trim(temp[1]);
				}
		}
}

//去左空格;
function ltrim(s){
  	return s.replace( /^\s*/, "");
}

//去右空格;
function rtrim(s){
		return s.replace( /\s*$/, "");
}

//去左右空格;
function trim(s){
		return rtrim(ltrim(s));
}

</script>
