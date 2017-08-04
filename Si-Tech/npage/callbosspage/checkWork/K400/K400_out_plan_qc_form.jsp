<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 自动考评
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * 说明: 请将制表符设置为4个空格
   * update: mixh 2009/08/14 添加被质检工号
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
	if(opCode == null || "".equals(opCode)){
			opCode = "K400";
	}
	if(opName == null || "".equals(opName)){
			opName = "自动质检";
	}
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	/***************获得请求中的参数begin******************/
	String contect_id     = WtcUtil.repNull(request.getParameter("content_id"));     //实际为content（考评内容），db中该字段拼写错误，此处与db保持一致
	String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
	String contact_id     = WtcUtil.repNull(request.getParameter("serialnum"));      //被检流水
	String isOutPlanflag  = WtcUtil.repNull(request.getParameter("isOutPlanflag"));  //计划外质检标志
	String staffno        = WtcUtil.repNull(request.getParameter("staffno"));        //被检工号
	String plan_id        = WtcUtil.repNull(request.getParameter("plan_id"));        //计划ID（计划内质检）
	String group_flag     = WtcUtil.repNull(request.getParameter("group_flag"));        //多人(1),个人(0)考评
	
	if(group_flag==null ||"".equals(group_flag)||"null".equals(group_flag)||"NULL".equals(group_flag)){
			group_flag = "1" ;
	}
	
	String tabId          = WtcUtil.repNull(request.getParameter("tabId"));          //tab页面的id值
	String evterno        = (String)session.getAttribute("kfWorkNo");                //质检工号 平台工号
	String workNo        	= (String)session.getAttribute("workNo");   //090922 修改为boss工号
	String objectName     = WtcUtil.repNull(request.getParameter("qc_objectvalue")); //获得质检对象类别
	String contentName    = WtcUtil.repNull(request.getParameter("qc_contentvalue"));//获得考评内容开始
	String out_returnVal = request.getParameter("out_returnVal");   //剩余流水串	
	String returnNum = request.getParameter("returnNum");						//自动考评条数
	//String tempQcCount    = replaceNull(request.getParameter("tempQcCount"), "0");    //质检员待整理的质检记录数目
	String checktype      = "";                      //考评类别
	String kind           = "";                      //考评方式
	String score          = "";                      //总分
	String vertify_passwd_flag = "";                //是否校验密码	
	
	plan_id = (null == plan_id || "null".equals(plan_id)) ? "":plan_id.trim();
	
	/***************获得请求中的参数end******************/
%>

<%
	/***************获取被质检（复核）人员姓名 begin******************/
	String loginName = "";
	String work_staffno = "";
	String sqlGetLoginName  = "SELECT v2.login_name,v2.login_no " + 
	                          "FROM dloginmsgrelation v1, dloginmsg v2 " + 
	                          "WHERE :staffno = v1.boss_login_no AND v1.boss_login_no = v2.login_no"; 
	myParams = "staffno="+staffno;        
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
	<wtc:param value="<%=sqlGetLoginName%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="loginNameList" scope="end"/>	
<%
	if(loginNameList.length > 0){
	  	loginName = loginNameList[0][0];
	  	work_staffno = loginNameList[0][1];
	}

	/***************获取被质检（复核）人员姓名 end******************/
%>

<%
	/***************获得当前质检员已质检条数开始******************/
	String starttime = getCurrDateStr("00:00:00");
	String endtime = getCurrDateStr("23:59:59");
	String qccounts="0";
	// flag '0','临时保存','1','已提交','2','已提交已修改','3','已确认','4','放弃')
	String getQcCount = "select to_char(nvl(count(*),0)) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>= :starttime and to_char(endtime,'yyyyMMdd hh24:mi:ss')<= :endtime and trim(evterno)= :workNo and (flag='1' or flag ='2' or flag='3')  and trim(is_del)='N' and plan_id = :plan_id " ;
myParams = "starttime="+starttime+",endtime="+endtime+",workNo="+workNo+",plan_id="+plan_id ;

%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=getQcCount%>"/>
	<wtc:param value="<%=myParams%>"/>
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
	String getQcTempCount = "select to_char(nvl(count(*),0)) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>= :starttime and trim(evterno)= :workNo  and trim(flag)='0'  and trim(is_del)='N' and plan_id = :plan_id " ;
	myParams = "starttime="+starttime+",workNo="+workNo.trim()+",plan_id="+plan_id ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=getQcTempCount%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="qcTempCount" scope="end"/>
<%
	/***************获得当前质检员待整理条数结束******************/
%>

<%
	/***************获得通话信息开始************前移******/
	String nowYYYYMM   = contact_id.substring(0, 6);
	String nowYYYYMMDD = contact_id.substring(0, 8);
	String tableName   = "dcallcall" + nowYYYYMM;
	String sqlCallcall = "select caller_phone, decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心'),call_cause_id,callcausedescs,vertify_passwd_flag from " + tableName + " where trim(contact_id)= :contact_id ";
	myParams = "contact_id="+contact_id.trim() ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="5">
	<wtc:param value="<%=sqlCallcall%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="callcallList" scope="end"/>
<%
	if(callcallList.length>0){
		vertify_passwd_flag=callcallList[0][4];
	}
	/***************获得通话信息结束******************/
%>

<%
/***************获得质检信息开始**************前移****/
	String sqlQcDetail = "select decode(t1.check_type,'0','实时质检','1','事后质检'),decode(t1.check_kind,'0','自动分派','1','人工指定'),decode(t1.check_class,'0','评语评分','1','评语','2','评分'),t4.object_name,t5.name,t1.check_type,t1.check_kind,t1.plan_id,to_char(t1.current_times) "
	                     +"from dqcplan t1,dqcobject t4,dqccheckcontect t5 "
	                     +"where  t1.object_id=t4.object_id(+) and t1.content_id=t5.contect_id(+)  and trim(t1.content_id)= :contect_id and trim(t1.object_id) = :object_id　and trim(t5.object_id) = :object_id and (t5.contect_id) = :contect_id and t1.plan_id= :plan_id";
	myParams = "contect_id="+contect_id+",object_id="+object_id+",object_id="+object_id+",contect_id="+contect_id+",plan_id="+plan_id ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="9">
	<wtc:param value="<%=sqlQcDetail%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="qcDetailList" scope="end"/>

<%
	if(qcDetailList.length>0){
		checktype = qcDetailList[0][5];
		kind = qcDetailList[0][6];
	}


/***************获得质检信息结束********************/	
%>

<%
/***************获得已质检次数开始******************/
	String completedCounts="";//实际完成质检条数
	String sqlGetTimes = "select to_char(current_times) from dqcloginplan " + 
	                     "where  object_id= :object_id and content_id= :contect_id and plan_id= :plan_id and login_no= :work_staffno";
  myParams = "object_id="+object_id+",contect_id="+contect_id+",plan_id="+plan_id+",work_staffno="+work_staffno ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sqlGetTimes%>"/>
	<wtc:param value="<%=myParams%>"/>
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
String sqlStr="select t.item_id, t.item_name, decode(substr(to_char(trim(low_score)),0,1),'.','0'||to_char(trim(low_score)),to_char(low_score)), decode(substr(to_char(trim(high_score)),0,1),'.','0'||to_char(trim(high_score)),to_char(high_score)),t.note " +
              "from dqccheckitem t where trim(t.contect_id)= :contect_id and trim(object_id) = :object_id and is_leaf='Y' and is_scored='Y' "+
              " and bak1='Y' " + "order by t.item_id";
myParams = "contect_id="+contect_id+",object_id="+object_id ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>	
<%
/***************获得考评项列表结束******************/
%>

<%
/***************获得质检流水开始******************/
	String sqlGetSerialNum = "select :nowYYYYMMDD||lpad(seq_qc_result.nextval,11,'0') from dual";
	myParams = "nowYYYYMMDD="+nowYYYYMMDD;
	//获得质检流水
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sqlGetSerialNum%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="serialNum" scope="end"/>
<%
/***************获得质检流水结束******************/
%>

<%
/***************获得该考评内容总分开始******************/
	String getTotalScoreSql = "select to_char(sum(high_score)) from dqccheckitem " +
  	                        "where object_id = :object_id and contect_id = :contect_id and is_leaf='Y' "+" and is_scored='Y' "+ " and bak1='Y' ";
 myParams = "object_id="+object_id+",contect_id="+contect_id ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=getTotalScoreSql%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="totalScore" scope="end"/>
<%
	if(totalScore.length>0){
		score=totalScore[0][0];
	}
/***************获得该考评内容总分结束******************/
%>


<%
/***************进入页面即插入质检信息及质检详细信息 kangxq 20090806 begin******************/
/*zengzq modify 090829 增加 判断是单人考评还是多人考评字段group_flag  0为单人，1为多人*/
	String sqlInitQcinfo = "INSERT INTO dqcinfo(serialnum, recordernum, outplanflag, staffno, objectid, contentid, score, starttime, flag, evterno, checktype, kind, is_del, checkflag, vertify_passwd_flag, plan_id, login_name,group_flag) " + 
	                       "VALUES('"+serialNum[0][0] + "','"+contact_id.trim()+"','"+isOutPlanflag+"','"+work_staffno+"','"+object_id.trim()+"','"+contect_id.trim()+"','"+totalScore[0][0]+"',sysdate,'0','"+workNo.trim()+"','"+checktype+"','"+kind+"','N','-1','"+vertify_passwd_flag+"','"+plan_id+"', '" + loginName + "','" + group_flag + "')";
	String[] sqlStrs   = new String[queryList.length + 1];
	StringBuffer sb = new StringBuffer();
	for(int i = 0; i < queryList.length; i++){
		/**sb.append("INSERT INTO dqcinfodetail(serialnum, objectid, contentid, itemid,score) VALUES('"+serialNum[0][0]+"','"+object_id.trim()+"','"+contect_id+"','"+queryList[i][0]+"','"+queryList[i][3]+"')");
		*/
		sb.append("INSERT INTO dqcinfodetail(serialnum, objectid, contentid, itemid,score) VALUES( :v1, :v2, :v3, :v4, :v5)");
		sb.append("&&"+serialNum[0][0]+"^"+object_id.trim()+"^"+contect_id+"^"+queryList[i][0]+"^"+queryList[i][3]);
		
		sqlStrs[i] = sb.toString();
		sb.delete(0, sb.length());
	}
	sqlStrs[queryList.length] = sqlInitQcinfo;
%>
	<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	    <wtc:param value=""/>
	    <wtc:param value="dbchange"/>
	    <wtc:params value="<%=sqlStrs%>"/>
	</wtc:service>
	
<%
/***************进入页面即插入质检信息及质检详细信息 kangxq 20090806 end******************/
%> 

<%
/***************更新DCALLCALLYYYYMM中当前流水的质检员工号和是否质检标识开始******************/
/**String sqlUpdDcallcall="update " + tableName + " set QC_LOGIN_NO='" + evterno + "',QC_FLAG='Y' where contact_id='" + contact_id + "'";
*/

String sqlUpdDcallcall="update " + tableName + " set QC_LOGIN_NO= :v1 ,QC_FLAG='Y' where contact_id= :v2 ";

%>
<wtc:service name="sPubModifyKfCfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlUpdDcallcall%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=evterno%>"/>
	<wtc:param value="<%=contact_id%>"/>
	</wtc:service>
<%
/***************更新DCALLCALLYYYYMM中当前流水的质检员工号和是否质检标识结束******************/
%>
	
<%
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
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
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
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
<script>

//在左边显示评分考评项说明 zengzq add 20091012
	function showReadMe(note){
		var note = note;
		if(""==note || note==undefined){
			note = "该评分项目前无相关说明！";
		}
		window.document.getElementById('readMeContent').innerText = note;
		window.document.getElementById('readMeContent').className = "blue";
	}

/**
  *质检完毕返回处理函数
  */
function doProcessSaveQcInfo(packet){
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");
	var opCode='<%=opCode%>';
	var haveNum = document.getElementById("haveNum").value;
	var out_returnVal = '<%=out_returnVal%>';
	var getReturnVal;
	 	
	if(retType=="saveQcInfo"){
			if(retCode=="000000"){
				similarMSNPop("成功记录考评结果！");
			}else{
				similarMSNPop("记录考评结果失败！");
			}
	}
	//保存结果后将isSaved的值设为true
	document.getElementById("isSaved").value='true';
	
	/*取返回的第一条记录*/
			if(out_returnVal.length>0){
					var loc = out_returnVal.indexOf("_",0);
					if(loc>0){
							getReturnVal = out_returnVal.substr(0,loc);
							out_returnVal = out_returnVal.substring(loc + 1,out_returnVal.length);
					}else{
							getReturnVal = out_returnVal;
					}
					
					var getArr = getReturnVal.split("-");
					var serialnum = getArr[0];
					var staffno = getArr[1];
					var qc_flag = getArr[2];
					/*
					for(var i=0;i<getArr.length;i++){
						alert(getArr[i]);
					}
					*/
					//var tabId = opCode + getArr[0];
			}
			if(parseInt(haveNum)>0){
					 window.autoCheckForm.action="K400_out_plan_qc_form.jsp?opCode=<%=opCode%>&opName=<%=opName%>&object_id=<%=object_id%>&content_id=<%=contect_id%>&isOutPlanflag=<%=isOutPlanflag%>&plan_id=<%=plan_id%>&qc_objectvalue=<%=objectName%>&qc_contentvalue=<%=contentName%>&out_returnVal=" + out_returnVal + "&serialnum=" + serialnum + "&staffno=" + staffno + "&qc_flag=" + qc_flag + "&returnNum=" + haveNum + "&tabId=<%=tabId%>";
				 	 window.autoCheckForm.method='post';
				   window.autoCheckForm.submit(); 
			}else{
					setTimeout("closeWin()",2000);
			}
		
}

/**
  *
  *质检完毕，保存质检结果
  *
  */
function saveQcInfo() {
	//判断输入信息不能过长
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	if(wordlength1>480){
		similarMSNPop("输入的内容概况信息长度过长！");
		document.getElementById('tb_4').click();
		document.getElementById('contentinsum').select();
		return false;
	}
	if(wordlength2>480){
		similarMSNPop("输入的处理情况信息长度过长！");
		document.getElementById('tb_2').click();
		document.getElementById('handleinfo').select();
		return false;
	}
	if(wordlength3>480){
		similarMSNPop("输入的改进建议信息长度过长！");
		document.getElementById('tb_3').click();
		document.getElementById('improveadvice').select();
		return false;
	}
	if(wordlength4>480){
		similarMSNPop("输入的综合评价信息长度过长！");
		document.getElementById('tb_1').click();
		document.getElementById('commentinfo').select();
		return false;
	}
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
    //评定原因id
    var check_reason_ids = document.getElementById("check_reason_ids").value;
    //评定原因
    var check_reason_texts = document.getElementById("check_reason_texts").value;
  
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
    //取页面保存的流水条数信息
		var haveNum = document.getElementById("haveNum").value; 
		//定制案例
    var remarkflag = document.getElementById("idremarkFlag").value; 
		
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
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "1");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);	
		chkPacket.data.add("totalTime", totalTime);	
		chkPacket.data.add("staffno","<%=work_staffno%>");
		chkPacket.data.add("haveNum", haveNum);// 从页面隐藏域中取值
		chkPacket.data.add("out_returnVal", "<%=out_returnVal%>");// 尚未被质检的流水
		//录入典型案例信息
		if(remarkflag == "01"){
				chkPacket.data.add("idremarkFlag",remarkflag);//
			}
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
		var opCode='<%=opCode%>';
		var haveNum = document.getElementById("haveNum").value;
		var out_returnVal = '<%=out_returnVal%>';
		var getReturnVal; 
		if(retType=="tempSaveQcInfo"){
				if(retCode=="000000"){
					similarMSNPop("临时保存质检结果成功！");
				}else{
					similarMSNPop("临时保存质检结果失败！");
				}
		}
		//保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		
		/*取返回的第一条记录*/
			if(out_returnVal.length>0){
					var loc = out_returnVal.indexOf("_",0);
					if(loc>0){
							getReturnVal = out_returnVal.substr(0,loc);
							out_returnVal = out_returnVal.substring(loc + 1,out_returnVal.length);
					}else{
							getReturnVal = out_returnVal;
					}
					
					var getArr = getReturnVal.split("-");
					var serialnum = getArr[0];
					var staffno = getArr[1];
					var qc_flag = getArr[2];
					/*
					for(var i=0;i<getArr.length;i++){
						alert(getArr[i]);
					}
					*/
					//var tabId = opCode + getArr[0];
			}
		if(parseInt(haveNum)>0){
				 window.autoCheckForm.action="K400_out_plan_qc_form.jsp?opCode=<%=opCode%>&opName=<%=opName%>&object_id=<%=object_id%>&content_id=<%=contect_id%>&isOutPlanflag=<%=isOutPlanflag%>&plan_id=<%=plan_id%>&qc_objectvalue=<%=objectName%>&qc_contentvalue=<%=contentName%>&out_returnVal=" + out_returnVal + "&serialnum=" + serialnum + "&staffno=" + staffno + "&qc_flag=" + qc_flag + "&returnNum=" + haveNum + "&tabId=<%=tabId%>";
			 	 window.autoCheckForm.method='post';
			   window.autoCheckForm.submit(); 
		}else{
				setTimeout("closeWin()",2000);
		}
}


/**
  *
  *临时保存质检结果
  *
  */
function tempSaveQcInfo(){
	//判断输入信息不能过长
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	if(wordlength1>480){
		similarMSNPop("输入的内容概况信息长度过长！");
		document.getElementById('tb_4').click();
		document.getElementById('contentinsum').select();
		return false;
	}
	if(wordlength2>480){
		similarMSNPop("输入的处理情况信息长度过长！");
		document.getElementById('tb_2').click();
		document.getElementById('handleinfo').select();
		return false;
	}
	if(wordlength3>480){
		similarMSNPop("输入的改进建议信息长度过长！");
		document.getElementById('tb_3').click();
		document.getElementById('improveadvice').select();
		return false;
	}
	if(wordlength4>480){
		similarMSNPop("输入的综合评价信息长度过长！");
		document.getElementById('tb_1').click();
		document.getElementById('commentinfo').select();
		return false;
	}
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
    //评定原因id
    var check_reason_ids = document.getElementById("check_reason_ids").value;
    //评定原因
    var check_reason_texts = document.getElementById("check_reason_texts").value;
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
    //取页面保存的流水条数信息
		var haveNum = document.getElementById("haveNum").value; 
		   
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
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
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
		chkPacket.data.add("staffno","<%=work_staffno%>");
		chkPacket.data.add("plan_id", "<%=plan_id%>");// 质检计划id
		
		chkPacket.data.add("contact_id", "<%=contact_id%>");  //话务流水
		chkPacket.data.add("haveNum", haveNum);// 从页面隐藏域中取值
		chkPacket.data.add("out_returnVal", "<%=out_returnVal%>");// 尚未被质检的流水
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
		var opCode='<%=opCode%>';
		var haveNum = document.getElementById("haveNum").value;
		var out_returnVal = '<%=out_returnVal%>';
		var getReturnVal;  
		
		if(retType=="giveUpQcInfo"){
				if(retCode=="000000"){
					similarMSNPop("成功放弃质检！");
				}else{
					similarMSNPop("放弃质检失败！");
				}
		}
		//保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		
		/*取返回的第一条记录*/
			if(out_returnVal.length>0){
					var loc = out_returnVal.indexOf("_",0);
					if(loc>0){
							getReturnVal = out_returnVal.substr(0,loc);
							out_returnVal = out_returnVal.substring(loc + 1,out_returnVal.length);
					}else{
							getReturnVal = out_returnVal;
					}
					
					var getArr = getReturnVal.split("-");
					var serialnum = getArr[0];
					var staffno = getArr[1];
					var qc_flag = getArr[2];
			}
			if(parseInt(haveNum)>0){
					 window.autoCheckForm.action="K400_out_plan_qc_form.jsp?opCode=<%=opCode%>&opName=<%=opName%>&object_id=<%=object_id%>&content_id=<%=contect_id%>&isOutPlanflag=<%=isOutPlanflag%>&plan_id=<%=plan_id%>&qc_objectvalue=<%=objectName%>&qc_contentvalue=<%=contentName%>&out_returnVal=" + out_returnVal + "&serialnum=" + serialnum + "&staffno=" + staffno + "&qc_flag=" + qc_flag + "&returnNum=" + haveNum + "&tabId=<%=tabId%>";
				 	 window.autoCheckForm.method='post';
				   window.autoCheckForm.submit(); 
			}else{
					setTimeout("closeWin()",2000);
			}
}
//设为案例
function remarkMessage(){
	if(rdShowConfirmDialog("设为典型案例需提交质检结果，您是否确定？")=="1"){
			document.getElementById("idremarkFlag").value = "01";
			checkIsSendTip();finishedTimer();	//质检结束
	 }else{
	 	return false;
	 	}

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
    //评定原因id
    var check_reason_ids = document.getElementById("check_reason_ids").value;
    //评定原因
    var check_reason_texts = document.getElementById("check_reason_texts").value;
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
		//取页面保存的流水条数信息
		var haveNum = document.getElementById("haveNum").value; 
		
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
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
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
		chkPacket.data.add("staffno","<%=work_staffno%>");
		chkPacket.data.add("plan_id", "<%=plan_id%>");// 质检计划id
		chkPacket.data.add("contact_id", "<%=contact_id%>");  //话务流水
		chkPacket.data.add("haveNum", haveNum);// 从页面隐藏域中取值
		chkPacket.data.add("out_returnVal", "<%=out_returnVal%>");// 尚未被质检的流水
		
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
    var tmpVal = itemleveli.options[itemleveli.selectedIndex].value;
    var tmpArr = tmpVal.split("->");
    scorei.value = tmpArr[0];
    //getLevelValue();
    sumScore();
}

//zengzq add 20091016增加质检模板将选中的等级描述内容拼起来在评价内容中显示
//modified by liujied 20091016 getLenth change to getLength,for
//you want to get the "length" of the list,rturnVal change to
//returnVal,I think you want to got a returned value
//

function getLevelValue(){
		document.getElementById("commentinfo").value = "";
    var getLength = '<%=queryList.length>0?queryList.length:0 %>';
    var returnVal = "";
    var itemleveli = "";
    var tmpVal1 = "";
    var tmpArr;
    var count = 0;
    
    for(var i=0;i < parseInt(getLength); i++){
         itemleveli = document.getElementById("itemlevel"+i);
         tmpVal = itemleveli.options[itemleveli.selectedIndex].value;
         tmpArr = tmpVal.split("->");
         if(tmpArr.length<2){
              continue;
         }else{
         		//zengzq add 20091030 若选择为等级最高分数段，则不记录不在综合评价中增加描述信息
            if(tmpArr[1]=="" || tmpArr[1]=="undefined" || parseInt(tmpArr[0])==parseInt(tmpArr[2])){
					  		continue;
					  }
              count++;
              if(i == parseInt(getLength)-1){
									returnVal = returnVal + count + ":" + tmpArr[1] +"。"+ "\n";
							}else{
						 			returnVal = returnVal + count + ":" + tmpArr[1] +";"+ "\n";
							}
         }
    }
    
    if(!(""==returnVal) && returnVal!="undefined"){
	  		document.getElementById("commentinfo").value = returnVal;
	  }
}

function checkIsSendTip(){
		var tipCheckBox = document.getElementById("sendTip");
		
		if(tipCheckBox.checked==true){
				window.openWinMid("../K217/K217_send_qc_result_tip.jsp","质检结果提醒",150, 400);
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
		mypacket.data.add("submitno","<%=workNo%>");
		mypacket.data.add("type",0);
		mypacket.data.add("serialnum","<%=serialNum[0][0]%>");
		mypacket.data.add("staffno","<%=work_staffno%>");
		mypacket.data.add("evterno","<%=workNo%>");
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


//发送质检结果通知提醒
function toSendMsg(flag){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","正在发送通知，请稍候......");
		mypacket.data.add("description","质检结果");//不能超过10位
		mypacket.data.add("send_login_no","<%=evterno%>");
		mypacket.data.add("receive_login_no","<%=work_staffno%>");
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
/**
  *播放录音文件
  *
  */
function doLisenRecord(filepath,contact_id,idname){
		window.parent.top.document.getElementById("recordfile").value     = filepath;
		window.parent.top.document.getElementById("lisenContactId").value = contact_id;
		window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
		window.parent.top.document.getElementById(idname).click();
}

function ListenPause(idname){
}

/**
  *当质检TAB页面打开的时候初始化时获取录音地址，使得直接点击接续工具条上的播放按钮即可播放录音文件。
  *注：此方法没有考虑到如果有多条流水的情况,我没有修改 add by hanjc at 20090714
  *
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

/**
  *initCheckCallListen回调函数
  *
  */
function doProcessGetInitPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id"); 
   var idname      = packet.data.findValueByName("idname");
   /**add by hanjc 20090714 begin 临时保存当前听取录音的流水*/
   document.getElementById("lisenContactId").value = contact_id; 
   /**add by hanjc 20090714 end 临时保存当前听取录音的流水*/     
   window.parent.top.document.getElementById("recordfile").value     = file_path;
   window.parent.top.document.getElementById("lisenContactId").value = contact_id;
   window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
}

/**
  *录音听取调用，返回录音文件路径
  *参数说明：
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

/**
  *checkCallListen回调函数
  *
  */
function doProcessGetPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id");
   var idname      = packet.data.findValueByName("idname"); 
 
   if(flag=='Y'){//单挑录音则听取该录音
   		doLisenRecord(file_path,contact_id,idname);
   }else{//多条录音则打开录音选择文件
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
	    	parent.parent.removeTab(tabId.trim());
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
<table style="table-layout:fixed;">
<tr>
<td valign='top' style="width:170px;height:100%;border-right:3px solid #DFE8F6;">
		<input type="button" name="cTree" class="b_text" value="考评树" onclick="HoverLiTmp(1);"/>
		<input type="button" name="rMe" class="b_text" value="说明" onclick="HoverLiTmp(2);"/>	
				
		<div id="checkTree" class="dis">	
		<table width="100%">
		<tr>
			<td valign="top" width="100%">
			<div id="basetree" ></div>
			</td>
			<td valign=top width="100%">
			<div id="childtree"></div>
			</td>
		</tr>
		</table>
		</div>
		<div id="readMe" class="undis" >
			<div id="Operation_Table" style="width:120%;" >
			<table cellspacing="0">
				<tr>
					<td valign="top" id = "readMeContent" class="blue">请选择右侧评分项!</td>
				</tr>
			</table>
			</div>
		</div>
</td>
<td>
	
	<form name="autoCheckForm">
		<input type="hidden" name="haveNum" id="haveNum" value="0"/>
		<input type="hidden" name="group_flag" id="group_flag" value="<%=group_flag%>"/>
	</form>
<form name="form1">
<input type="hidden" name="serialnum" id="serialnum" value="<%=(serialNum.length>0)?serialNum[0][0]:""%>"/>
	<div id="Operation_Table" >
    <div class="title"><div id="title_zi">
    	质检信息
<% 
    	         if(isOutPlanflag.equals("0")){
%>
    	         	：今天该计划质检，你已完成<%=qccounts%>条，待整理条数<%=(qcTempCount.length>0)?qcTempCount[0][0]:"0"%>条
<%
    	         }
%>
    </div></div>
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
        <input type="text" name="" id="" size="25"  readonly value="<%=work_staffno%>"/>
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
	<tr>
	<td class="blue" colspan="2">
		<input type="checkbox" name="sendTip" id="sendTip" value=""/>发送结果通知 &nbsp;&nbsp;&nbsp;
		<!--input type="button" name="" class="b_text" value="监视"/-->
	</td>
	<td align="left" colspan="2">&nbsp;&nbsp;
		<%
		if(Integer.parseInt(returnNum)>1){
		%>
		<input type="button" name="" class="b_text" onClick="gotoNextCheck();" value="下一条"/>
		<%
		}else{
		%>
		<input type="button" name="" class="b_text" disabled onClick="gotoNextCheck();" value="下一条"/>
		<%
		}
		%>
		
		<!--input type="button" name="" class="b_text" value="指定新的计划"/-->
		<input type="button" name="" class="b_text" value="查看基本信息" onclick="getCallDetail();"/>
		<!--input type="button" name="" class="b_text" value="选择培训建议"/-->
	</td>
	<td colspan="2">&nbsp;&nbsp;</td>
	</tr>
	</table>
</div>



<div id="Operation_Table"  style="height:150px;width:99%;overflow:auto;">
  <div class="title"><div id="title_zi">
    评分项目 &nbsp;子项得分合计 &nbsp;
  	<input type="text" disabled id="subScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:""%>"/> &nbsp;
  </div></div>
  <table id="tb2" width="100%" height="25" border="0" align="center" cellpadding="0px" cellspacing="0">
	  <tr>
	    <td class="blue" width="10%">序号</td>
	    <td class="blue" width="40%">名称</td>
	    <td class="blue" width="10%">最低分</td>
	    <td class="blue" width="10%">最高分 </td>
	    <td class="blue" width="10%">得分</td>
	    <td class="blue" width="20%">考评等级</td>    
	  </tr>

<%
	for(int i = 0; i < queryList.length; i++){
			out.println("<tr>");
			out.println("<td class='Blue' width='30px'>"+i+"</td>");
			out.println("<td class='Blue' width='40%' onclick=showReadMe('"+ queryList[i][4] +"')>");
			out.println(queryList[i][1]);
			out.println("<input type='hidden' name='itemId' value='"+queryList[i][0]+"'/>");
			out.println("</td>");
			out.println("<td class='Blue' width='40px'>"+queryList[i][2]+"</td>");
			out.println("<td class='Blue' width='40px'>"+queryList[i][3]+"</td>");
      //zengzq 20091017 将原来onblur调用的sumScore()调整为judgeWidth方法 用于判断当前输入的分数值是否在选择等级分值段中 
	    out.println("<td class='Blue' width='10px'><input type='text' name='score"+i+"' id='score"+i+"' size='6' maxlength='6' onblur='judgeWidth("+i+");' value='"+queryList[i][3]+"' onkeyup=\"value=value.replace(/[^-?\\d+$]/g,'') \"onbeforepaste=\"clipboardData.setData('text',clipboardData.getData('text').replace(/[^\\d]/g,''))\"/></td>");
			out.println("<td class='Blue' width='50px'>");
      //zengzq add 20091017 增加style属性 固定select宽度 
      out.println("<select style='width:100px;' name='itemlevel"+i+"' id='itemlevel"+i+"' onchange='changeScore("+i+");' style='width:80%'>");
      //增加记录评分项最高分在查询第一项。queryList[i][3](zengzq 20091030)
			%>
	    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
	    <wtc:sql>
	    	select decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||note||'->'||'<%=queryList[i][3]%>', decode(substr(to_char(trim(low_score)),0,1),'.','0'||to_char(trim(low_score)),to_char(trim(low_score)))||'--'||decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||level_name from dqcckectitemlevel where item_id=<%=(queryList.length>0)?queryList[i][0]:""%> and content_id='<%=contect_id%>' and object_id='<%=object_id%>' order by score desc 
	    </wtc:sql>
	    </wtc:qoption>
<%
	    	out.println("</select>");
				out.println("</td>");
				out.println("</tr>");
            //zengzq  start 20091017 select中的考评项无内容时，给添加一个默认值
%>
<script>
	if(document.getElementById("itemlevel"+ '<%=i%>').options.length<1){
		//document.getElementById("itemlevel"+ '<%=i%>').options.add(new Option('<%=queryList[i][2]%>'+"--"+'<%=queryList[i][3]%>'+"->"+"默认等级",'<%=queryList[i][3]%>'+"->"+"默认等级") );
		document.getElementById("itemlevel"+ '<%=i%>').options[0] = new Option('<%=queryList[i][2]%>'+"--"+'<%=queryList[i][3]%>'+"->"+"默认等级",'<%=queryList[i][3]%>');
	}
</script>
<%
//zengzq  end 20091017 select中的考评项无内容时，给添加一个默认值

	}
%>
</table>
</div>

<div id="Operation_Table">
	<div class="title"><div id="title_zi">有效评语(<%=qccounts%>)条 &nbsp;</div></div>
	<%
			//增加自动调整显示差错等级信息 start zengzq add 20091103 
			 String toScore = (totalScore.length>0)?totalScore[0][0]:"0";
			 //zengzq modify 如果toScore值为空值是，将其更新为0 20091231
			 toScore = (toScore.length()>0)?toScore:"0";
			 String error_l_texts = "";
			 String error_l_ids = "";
			 if(Integer.parseInt(toScore)>=101){
					 	error_l_texts = "特优";
					 	error_l_ids = "01";
			 }else if(Integer.parseInt(toScore)>=91 && Integer.parseInt(toScore)<=100){
			 			error_l_texts = "优";
					 	error_l_ids = "02";
			 }else if(Integer.parseInt(toScore)>=81 && Integer.parseInt(toScore)<=90){
			 			error_l_texts = "良";
					 	error_l_ids = "03";
			 }else if(Integer.parseInt(toScore)>=70 && Integer.parseInt(toScore)<=80){
			 			error_l_texts = "中";
					 	error_l_ids = "04";
			 }else if(Integer.parseInt(toScore)<=69){
			 			error_l_texts = "差";
					 	error_l_ids = "05";
			 }
			 //增加自动调整显示差错等级信息 end zengzq add 20091103
		%>
	<table width="100%" height=25 border=0 align="center" cellpadding="4" cellspacing="0">
		<tr>
		<td class="blue" align="left" width="8%">差错等级</td>
		<td width="22%">
		<input type="text" name="error_level_text" id="error_level_text" size="30" value="<%=error_l_texts%>" readonly />
		<input type="hidden" name="error_level_id" id="error_level_id" value="<%=error_l_ids%>"/>
		<!--input type="button" name="btn_error_level" class="b_text" value="选择" onclick="show_select_error_level_win();"/-->
		</td>
		<td class="blue" align="left" width="8%">差错类别</td>
		<td width="22%">
		<input type="text" name="error_class_texts" id="error_class_texts" size="16" value="" readonly/>
		<input type="hidden" name="error_class_ids" id="error_class_ids" value=""/>
		<input type="button" name="btn_error_class" class="b_text" value="选择" onclick="show_select_error_class_win();"/>
		</td>
		<td class="blue" align="left" width="8%">评语范文</td>
		<td width="22%">
	<!--	<input type="text" name="error_level_text" id="error_level_text" size="30" value="<%=error_l_texts%>" readonly />-->
		<input type="hidden" name="error_level_id" id="error_level_id_answer" value="<%=error_l_ids%>"/>
		<input type="button" name="btn_error_level" class="b_text" value="选择" onclick="show_select_error_level_win();">
		</td>
	</tr>
	<tr>
		<td class="blue" align="left" width="8%">来电原因</td>
		<td width="22%">
		<input type="text" name="service_class_texts" id="service_class_texts" size="30" value="<%=tmpInfo%>" readonly/>
		<input type="hidden" name="service_class_ids" id="service_class_ids" value="<%=tmpId%>"/>
		<!--放弃原因隐藏域-->
		<input type="hidden" name="give_up_reason_ids" id="give_up_reason_ids" />
		<input type="hidden" name="give_up_reason_texts" id="give_up_reason_texts" />			
		</td>
    <!--liujied 增加评定原因 20091015 start -->
		<td class="blue" align="left" width="8%">评定原因</td>
		<td width="22%">
		<input type="text" name="check_reason_texts" id="check_reason_texts" size="16" value="" readonly/>
		<input type="hidden" name="check_reason_ids" id="check_reason_ids" value=""/>
		<input type="button" name="btn_check_reason" value="选择" class="b_text" onclick="show_select_check_reason_win();"/>
		</td>
		<td class="blue" colspan="6" width="8%">&nbsp;</td>
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
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">1 综合评价</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 处理情况</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 改进建议</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 内容概况</li>
				</ul>
			</div>
			<div class="dis" id="tbc_01" name=""><!-- 综合评价 -->
		    	<textarea id="commentinfo" cols="110" rows="5"></textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" cols="110" rows="5"></textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" cols="110" rows="5"></textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="contentinsum" cols="110" rows="5"></textarea>
			</div>
		</div>

		</td>
	</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="blue" align="center" id="footer" width="100%">
        <div id="callSearch">
				总分：<input type="text" name="totalScore" id="totalScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:""%>" readonly/>
				<input name="confirm" onClick="tempSaveQcInfo();finishedTimer();" type="button" class="b_foot" value="临时保存">
				<input name="confirm" onClick="checkIsSendTip();finishedTimer();" type="button" class="b_foot" value="质检完毕">
				<input name="confirm" onClick="remarkMessage();" type="button" class="b_foot" value="设为案例">
				<input name="remarkFlag" type="hidden" id="idremarkFlag"><!-- 判断是典型案例还是质检保存 -->
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
			<td class="blue" align="left" >质检开始：</td>     <td class="blue" align="left" ><%=getCurrDateStr("")%></td>
			<td class="blue" align="left" >质检结束：</td>     <td class="blue" align="left" >&nbsp;</td>
			<td class="blue" align="left" >处理时长：</td>     <td class="blue" align="left" id="handleTime">0</td>
		</tr>
		<tr>
			<td class="blue" align="left" >放音/监听时长：</td><td class="blue" align="left" id="listenTime">0</td>
			<td class="blue" align="left" >整理时长：</td>     <td class="blue" align="left" id="adjustTime">0</td>
			<td class="blue" align="left" >总时长：</td>       <td class="blue" align="left" id="totalTime">0</td>
		</tr>		
	</table>	
	<!--隐藏域isSaved为false 表示当前结果未进行任何保存操作，包括放弃操作-->
	<input type='hidden' name='isSaved' id='isSaved' value='false'>
	<!--隐藏域isSaved结束------------->
	<!--隐藏域isClosed为false 用于控制关闭tab页方法只可调用一次-->
	<input type='hidden' name='isClosed' id='isClosed' value='false'>
	<!--隐藏域isClosed结束------------->
	<!--隐藏域lisenContactId为当前质检听取录音的流水号-->
	<input type='hidden' name='lisenContactId' id='lisenContactId' value=''>
	<!--隐藏域lisenContactId结束------------->	

</div>

</form>

</td>
</tr>
</table>
</body > 
</html>

<script language="javascript">

function grpClose(){
		window.opener = null;
		top.close();
}
/*点击下一条，进入选择该考评结束方式 zengzq add 20090831*/
function gotoNextCheck(){
		var haveNum = parseInt('<%=returnNum%>') -1;
		document.getElementById("haveNum").value = haveNum;
		
		window.openWinMid("./K400_sureCheckType.jsp","选择当前流水考评方式",150, 400);
		//window.showModalDialog("./K400_sureCheckType.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		
}
function te1st(){
	window.close();
}

/**
  * 进行判断，当前输入的分值必须在等级范围之内
  * zengzq 20091017
  */
function judgeWidth(i){
	var itemleveli = document.getElementById("itemlevel"+i);
	var itmeLevelName = itemleveli.options[itemleveli.selectedIndex].innerText;
	var itmeLevelNameArr = itmeLevelName.split("->");
	var scoreArr = itmeLevelNameArr[0].split("--");
	var l_score = scoreArr[0];
	var h_score = scoreArr[1];
	var  s_score = "score"+i;
	var curr_score = document.getElementById(s_score).value;
	if(parseInt(curr_score)>parseInt(h_score) || parseInt(curr_score)<parseInt(l_score)){
			similarMSNPop("输入的分数不在选择的等级分数段，设置的分数回复为该分数段最高分！");
			document.getElementById(s_score).value = h_score;
			document.getElementById(s_score).select();
	}
	sumScore();
}  

/**
  *考评项录入框失去焦点后，计算当前得分
  */
function sumScore(){
		var inputs = document.getElementsByTagName('input');
		var objTotalScore = document.getElementById("totalScore");
		var subScore = document.getElementById("subScore");
		var totalScore = 0;
		//增加自动显示差错等级变量 start zengzq add 20091103 
		var error_l_texts = "";
		var error_l_ids = ""; 
		//增加自动显示差错等级变量 end zengzq add 20091103 
		for(var i = 0; i < inputs.length; i++){
				if(inputs[i].name.substring(0,5) == 'score'){
						totalScore += parseFloat(inputs[i].value);
				}
		}
		
		objTotalScore.value = totalScore;
		subScore.value = totalScore;
		//增加自动调整显示差错等级 start zengzq add 20091103 
		 if(parseInt(totalScore)>=101){
					 	error_l_texts = "特优";
					 	error_l_ids = "01";
			 }else if(totalScore>=91 && totalScore<=100){
			 			error_l_texts = "优";
					 	error_l_ids = "02";
			 }else if(totalScore>=81 && totalScore<=90){
			 			error_l_texts = "良";
					 	error_l_ids = "03";
			 }else if(totalScore>=70 && totalScore<=80){
			 			error_l_texts = "中";
					 	error_l_ids = "04";
			 }else if(totalScore<=69){
			 			error_l_texts = "差";
					 	error_l_ids = "05";
			 }
			 document.getElementById("error_level_text").value = error_l_texts;
			 document.getElementById("error_level_id").value = error_l_ids;
			//增加自动调整显示差错等级 end zengzq add 20091103
}

function g(o){
		return document.getElementById(o);
}
function HoverLi(n){
		for(var i=1;i<=4;i++){
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
}

/**
  *弹出选择放弃原因的窗口
  */
function show_select_give_up_reason_win(){
	//判断输入信息不能过长
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	if(wordlength1>480){
		similarMSNPop("输入的内容概况信息长度过长！");
		document.getElementById('tb_4').click();
		document.getElementById('contentinsum').select();
		return false;
	}
	if(wordlength2>480){
		similarMSNPop("输入的处理情况信息长度过长！");
		document.getElementById('tb_2').click();
		document.getElementById('handleinfo').select();
		return false;
	}
	if(wordlength3>480){
		similarMSNPop("输入的改进建议信息长度过长！");
		document.getElementById('tb_3').click();
		document.getElementById('improveadvice').select();
		return false;
	}
	if(wordlength4>480){
		similarMSNPop("输入的综合评价信息长度过长！");
		document.getElementById('tb_1').click();
		document.getElementById('commentinfo').select();
		return false;
	}
		var returnValue = window.showModalDialog("../K217/K217_get_give_up_reason.jsp",'',"dialogWidth=800px;dialogHeight=420px");
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
  *弹出选择放弃原因的窗口 重写方法，解决窗口被挡住问题 
  *zengzq 20090909
  */
function mult_show_select_give_up_reason_win(returnValue){
	//判断输入信息不能过长
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	if(wordlength1>480){
		similarMSNPop("输入的内容概况信息长度过长！");
		document.getElementById('tb_4').click();
		document.getElementById('contentinsum').select();
		return false;
	}
	if(wordlength2>480){
		similarMSNPop("输入的处理情况信息长度过长！");
		document.getElementById('tb_2').click();
		document.getElementById('handleinfo').select();
		return false;
	}
	if(wordlength3>480){
		similarMSNPop("输入的改进建议信息长度过长！");
		document.getElementById('tb_3').click();
		document.getElementById('improveadvice').select();
		return false;
	}
	if(wordlength4>480){
		similarMSNPop("输入的综合评价信息长度过长！");
		document.getElementById('tb_1').click();
		document.getElementById('commentinfo').select();
		return false;
	}
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
		var returnValue = window.showModalDialog("../K217/K217_get_error_level.jsp",'',"dialogWidth=1000px;dialogHeight=530px");
		/*if(typeof(returnValue) != "undefined"){
				var error_level_text = document.getElementById("commentinfo");
				var error_level_id   = document.getElementById("error_level_id_answer");
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
		}*/
		if(typeof(returnValue) != "undefined"){
				document.getElementById("commentinfo").value = returnValue;
		}
}

/**
  *弹出选择差错类别的窗口
  */
function show_select_error_class_win(){
		var returnValue = window.showModalDialog("../K217/K217_get_error_class.jsp",'',"dialogWidth=720px;dialogHeight=350px");
		
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
				similarMSNPop("该流水无对应的来电原因！");
		}else{
				var returnValue = window.showModalDialog("../K217/K217_get_service_class.jsp?call_cause_id=<%=(callcallList.length>0)?callcallList[0][2]:""%>&call_cause_desc=<%=(callcallList.length>0)?callcallList[0][3]:""%>",'',"dialogWidth=800px;dialogHeight=350px");
				
				if(typeof(returnValue) != "undefined"){
						var service_class_texts = document.getElementById("service_class_texts");
						var service_class_ids   = document.getElementById("service_class_ids");
						var temp = returnValue.split('_');
						service_class_texts.value = trim(temp[0]);
						service_class_ids.value   = trim(temp[1]);
				}
		}
}
//added by liujied 20091016
function show_select_check_reason_win(){
		var returnValue = window.showModalDialog("../K217/K217_get_check_reason.jsp",'',"dialogWidth=720px;dialogHeight=350px");
		
		if(typeof(returnValue) != "undefined"){
				var check_reason_texts = document.getElementById("check_reason_texts");
				var check_reason_ids  = document.getElementById("check_reason_ids");
				var temp = returnValue.split('_');
				check_reason_texts.value = trim(temp[0]);
				check_reason_ids.value   = trim(temp[1]);
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_arr = temp1.split(',');
				var ids_temp_arr = temp2.split(',');
				check_reason_texts.value="";
				
				for(var i=0; i<texts_temp_arr.length-1; i++){
					
						if(i!=0&&i%2==0){
								check_reason_texts.value +='<br>';
						}
						
						if(i!=texts_temp_arr.length-1){
						  	check_reason_texts.value += texts_temp_arr[i] + ',';
						}
				}
		}
}

/*
 *初始化树的第一层节点
 */
function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");	
	tree.enableCheckBoxes(0);
	tree.enableDragAndDrop(0);
	tree.enableTreeLines(true);
	tree.setOnClickHandler(onNodeClick);
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_create_qc_item_tree_xml.jsp?content_id=<%=contect_id%>&object_id=<%=object_id%>");
	//树的根节点为0
	var subItemsArr = tree.getAllSubItems("0").split(',');
	for(var i = 0; i < subItemsArr.length; i++){
		if(tree.getUserData(subItemsArr[i], 'isleaf') != 'Y'){
			tree.setItemImage2(subItemsArr[i],'folderClosed.gif','folderClosed.gif','folderClosed.gif');
		}
	}
}


/**
  *响应鼠标单击事件，选中当前节点，并展示当前节点下的子结点
  */
function onNodeClick(){
	if(tree.getSelectedItemId() == '0'){
		return;
	}
	getTreeListByNodeId();
}

//根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}

	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_get_qc_item_child_tree.jsp?object_id=<%=object_id%>&content_id=<%=contect_id%>", "...");
	packet.data.add("parent_item_id",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,true);
}

//getTreeListByNodeId的回调函数
function doProcessGetList(packet){
	var childNodeList = packet.data.findValueByName("worknos");
	var nodeId        = packet.data.findValueByName("nodeId");
	insertChildNodeList(childNodeList);
}

/**
  *树的生成逻辑
  */
function insertChildNodeList(retData){
	//alert("begin insertChildNodeList....");
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
   	var str = new Array();

   	//判断该节点写是否有子节点，如果有判断过滤一下当前节点值是否与数据库里的值一致
	if(varSubItems != null && varSubItems != ''){
		str=varSubItems.split(",");
		for(var i=0;i<retData.length;i++){
			//过滤当前节点下子节点与数据库是否相同
			if(!isStr(retData[i][0],str)){
				tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ;
				tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
				tree.setUserData(retData[i][0],"isscored",retData[i][4]);
				tree.setUserData(retData[i][0],"object_id",retData[i][5]);
			}
     	}
	}else{//如果当前节点下无子节点，则在其当前节点下新增子节点
		for(var i = 0; i < retData.length; i++){
			tree.insertNewItem(retData[i][1], retData[i][0], retData[i][2], 0, 0, 0, 0, 'TOP');
			tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
			tree.setUserData(retData[i][0],"isscored",retData[i][4]);
			tree.setUserData(retData[i][0],"object_id",retData[i][5]);
		}
	}
	//alert("end insertChildNodeList....");
}

//判断一个字符串是否在数组中出现
function isStr(strtreeData,str){
		if(str!=null){
				for(var j=0;j<str.length;j++){
						if(strtreeData.trim()==str[j].trim()){
								return true;
						}
				}
		}
		return false;
}

function HoverLiTmp(n){
		if(n==1){
			document.getElementById('checkTree').className='dis';
			document.getElementById('readMe').className='undis';
		}
		if(n==2){
			document.getElementById('checkTree').className='undis';
			document.getElementById('readMe').className='dis';
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

//初始话树
initBaseTree();
</script>
