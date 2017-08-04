<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 计划外质检
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:		mixh 2009/02/26  补全质检信息
   *            tangsong 2010/04/11 所有通知方式都向dqcresultaffirm表插入质检确认数据
   * modify by yinzx 20100506 
  1. sql语句优化
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
		opCode = "K214";
}
if(opName == null || "".equals(opName)){
		opName = "修改质检结果";
}
%>



<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>

<%
/***************获得考评对象流水、考评内容流水开始******************/
String contect_id = request.getParameter("content_id");
String mod_flag  = request.getParameter("mod_flag");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
if(null==mod_flag||"".equals(mod_flag)){
		mod_flag = "0";
}
String object_id  = request.getParameter("object_id");
String serialnum = request.getParameter("serialnum");//当前质检流水
String isOutPlanflag = WtcUtil.repNull(request.getParameter("isOutPlanflag"));
String staffno = (String)request.getParameter("staffno");//被检工号
String evterno = (String)session.getAttribute("workNo");//质检工号
String workNo  = (String)session.getAttribute("workNo");   //090922 修改为boss工号
String isAdjust = (String)request.getParameter("isAdjust");//判断是否是质检结果整理，isAdjust的值为K206为质检结果整理，否则为质检结果修改
String tabId   = WtcUtil.repNull(request.getParameter("tabId"));//tab页面的id值
/***************获得考评对象流水、考评内容流水结束******************/
%>

<%
/***************获得质检对象类别开始******************/
String sqlGetObjectName = "SELECT object_name FROM dqcobject WHERE  object_id  = :object_id ";
myParams = "object_id="+object_id.trim();
String objectName = "";
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=sqlGetObjectName%>"/>
		<wtc:param value="<%=myParams%>"/>
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
String sqlGetContentName = "SELECT name FROM dqccheckcontect WHERE  object_id  = :object_id AND  contect_id  = :contect_id ";
myParams = "object_id="+object_id.trim()+",contect_id="+contect_id.trim();
String contentName = "";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=sqlGetContentName%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="contentNames" scope="end"/>
<%
if(objectNames.length>0){
  	contentName = contentNames[0][0];
}
/***************获得考评内容结束******************/
%>  

<%
/***************获得通话流水开始******************/
String serialnumTemp = serialnum;
String sqlGetContactId ="" ;
String contact_id="";
//i为99为测试数据，实际操作中应为无限循环，用于质检复核时查找通话流水id。涉及到的sql语句效率较高，且质检复核一般不会超过
//三次，即循环一般不会超过三次。但理论上质检复核可以无限进行。故使用无限循环，不会影响程序的运行。
for(int i=0;i<99;i++){
		sqlGetContactId = "select recordernum from dqcinfo where serialnum=:serialnumTemp ";
		myParams = "serialnumTemp="+serialnumTemp;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=sqlGetContactId%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="sqlGetcontactIdList" scope="end"/>
	
<%
 if(sqlGetcontactIdList.length>0){
   	serialnumTemp=sqlGetcontactIdList[0][0];
 }else break;
 			contact_id=serialnumTemp;
}
/***************获得通话流水结束******************/
%>

<%
/***************获得质检信息开始******************/
String sqlCallcallSerialnum = "SELECT recordernum,to_char(endtime,'yyyyMMdd hh24:mi:ss'),errorlevelid,errorclassid,qcserviceclassid,errorleveldesc,errorclassdesc,serviceclassdesc,to_char(outplanflag),decode(checkreasondesc,null,'',checkreasondesc) " + 
                              "FROM dqcinfo where serialnum=:serialnum ";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="10">
		<wtc:param value="<%=sqlCallcallSerialnum%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="sqlCallcallSerialnumList" scope="end"/>
	
<%
if(sqlCallcallSerialnumList.length>0){
  	isOutPlanflag=sqlCallcallSerialnumList[0][8];
}
/***************获得质检信息结束******************/
%>

<%
/***************获得通话信息开始******************/
String nowYYYYMM ="";
String endtime="";

if(sqlCallcallSerialnumList.length>0){
	  nowYYYYMM = contact_id.substring(0, 6);
	  endtime=sqlCallcallSerialnumList[0][1];
}

String tableName = "dcallcall" + nowYYYYMM;
//updated by tangsong 20100528 增加客户级别
//String sqlCallcall = "select caller_phone, decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心'),call_cause_id from " + tableName + " where contact_id=:contact_id ";
	String sqlCallcall = "select caller_phone, decode(region_code, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心'),call_cause_id,callcausedescs,vertify_passwd_flag,"
	                   + "t.usertype,"
	                   + "(select t1.accept_name from scallgradecode t1 where t1.user_class_id=t.usertype) usertypeDesc,"
	                   + "decode(t.statisfy_code,null,'未处理',(select s.satisfy_name from ssatisfytype s where s.satisfy_code = t.statisfy_code)) STATISFY_CODE"
	                   + " from " + tableName + " t where t.contact_id=:contact_id ";
myParams = "contact_id="+contact_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
		<wtc:param value="<%=sqlCallcall%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="callcallList" scope="end"/>
	
<%
/***************获得通话信息结束******************/
%>

<%
String sqlQcDetail = "";

if(!"0".equals(isOutPlanflag)){
/***************获得质检（质检计划）信息开始******************/
		sqlQcDetail = "select '','','',t4.object_name,t5.name,t1.check_type,t1.check_kind "
		              +"from dqcplan t1,dqcobject t4,dqccheckcontect t5 "
		              +"where  t1.object_id=t4.object_id(+) and t1.content_id=t5.contect_id(+)  and  t1.content_id =:contect_id and  t1.object_id  = :object_id　and  t5.object_id  = :object_id1 ";
		myParams = "contect_id="+contect_id+",object_id="+object_id+",object_id1="+object_id;
}else{
		sqlQcDetail = "select decode(t1.check_type,'0','实时质检','1','事后质检'),decode(t1.check_kind,'0','自动分派','1','人工指定'),decode(t1.check_class,'0','评语评分','1','评语','2','评分'),t4.object_name,t5.name,t1.check_type,t1.check_kind "
	                +"from dqcplan t1,dqcobject t4,dqccheckcontect t5 "
	                +"where  t1.object_id=t4.object_id(+) and t1.content_id=t5.contect_id(+)  and  t1.content_id =:contect_id and  t1.object_id  = :object_id　and  t5.object_id  = :object_id1 ";
	  myParams = "contect_id="+contect_id+",object_id="+object_id+",object_id1="+object_id;
}
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
		<wtc:param value="<%=sqlQcDetail%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcDetailList" scope="end"/>
<%
/***************获得质检（质检计划）信息结束******************/
%>

<%
/***************获得质检时间信息开始******************/
String sqlQcTimeDetail = "select to_char(STARTTIME,'yyyy-MM-dd hh24:mi:ss'),to_char(ENDTIME,'yyyy-MM-dd hh24:mi:ss'),to_char(DEALDURATION),to_char(LISDURATION),to_char(ARRDURATION) from DQCINFO t1 where  t1.serialnum =:serialnum ";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
		<wtc:param value="<%=sqlQcTimeDetail%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcTimeList" scope="end"/>
<%
/***************获得质检时间信息结束******************/
System.out.println("qcTimeList.length:==============================================================");
System.out.println("qcTimeList.length:"+qcTimeList.length);
System.out.println("qcTimeList:"+qcTimeList[0][2]);
%>

<%
/***************判断是否是复核开始******************/
String sqlGetCheckInfo = "select to_char(count(*)) from DQCINFO t1 where trim(t1.serialnum)=:serialnum  ";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=sqlGetCheckInfo%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcCheckList" scope="end"/>
<%
/***************判断是否是复核结束******************/
%>

<%
/***************获得考评项列表开始******************/
String sqlStr="select t.item_id, t.item_name, decode(substr(to_char(trim(t.low_score)),0,1),'.','0'||trim(t.low_score),t.low_score), decode(substr(to_char(trim(t.high_score)),0,1),'.','0'||to_char(trim(t.high_score)),to_char(t.high_score)),t.note  " +
              " from dqccheckitem t where  t.contect_id =:contect_id and  object_id  = :object_id and is_leaf='Y' "+" and is_scored='Y' "+
              " and bak1='Y' " + " order by t.item_id";
myParams = "contect_id="+contect_id+",object_id="+object_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
/***************获得考评项列表结束******************/
%>

<%
/***************获得当前修改结果流水开始******************/
//最大的流水就是当前流水
String modserialnum="";
String getModSerialnumsql = "select to_char(max(modserialnum)) from dqcmodinfo where serialnum=:serialnum and modflag='1'";
myParams = "serialnum="+serialnum;
%>	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=getModSerialnumsql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="modserialnumList" scope="end"/>	
<%
if(modserialnumList.length>0){
  	modserialnum=modserialnumList[0][0];
}
/***************获得当前修改结果流水结束******************/
%>

<%
/***************获得考评项得分开始******************/
String[][] scoreList = new String[][]{};
String modCountsql = "select to_char(count(*)) from dqcmodinfo where serialnum=:serialnum ";
myParams = "serialnum="+serialnum;
%>	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=modCountsql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="modCountList" scope="end"/>	
<%
if(modCountList.length>0){ 
		 if(!(Integer.parseInt(modCountList[0][0])>0)){
				 String sqlStrScore="select decode(substr(to_char(trim(t.score)),0,1),'.','0'||to_char(trim(t.score)),to_char(t.score))  " +
				              " from dqcinfodetail t where  t.contentid  =:contect_id and  t.objectid  = :object_id and t.serialnum=:serialnum "+
				              " order by t.itemid";
		myParams = "contect_id="+contect_id+",object_id="+object_id+",serialnum="+serialnum;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
				<wtc:param value="<%=sqlStrScore%>"/>
				<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="scoreTempList" scope="end"/>
<%
 		scoreList=scoreTempList;
 		}else{
	/***************获得考评项得分开始******************/
				String sqlStrScore="select decode(substr(to_char(trim(t.score)),0,1),'.','0'||to_char(trim(t.score)),to_char(trim(t.score))) " +
				                   "from dqcmodinfodetail t " +
				                   "where modflag='1' and  t.contentid =:contect_id  and  t.objectid  = :object_id and t.modserialnum=:modserialnum "+
				                   "order by t.itemid";
			myParams = "contect_id="+contect_id+",object_id="+object_id+",modserialnum="+modserialnum; 
%>
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
						<wtc:param value="<%=sqlStrScore%>"/>
						<wtc:param value="<%=myParams%>"/>
				</wtc:service>
				<wtc:array id="scoreTempList" scope="end"/>
<%
 				scoreList=scoreTempList;
		}
}

/**************获得考评项得分结束******************/
%>
<%
/***************获得该考评内容总分开始******************/
String getTotalScoreSql = "select to_char(sum(t.score))  " +
              " from dqcinfodetail t where  t.contentid =:contect_id and  t.objectid  = :object_id  and t.serialnum=:serialnum ";
myParams = "contect_id="+contect_id+",object_id="+object_id+",serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:param value="<%=getTotalScoreSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="totalScore" scope="end"/>
<%
/***************获得该考评内容总分结束******************/
%>

<%
/***************获得当前质检员已质检条数开始******************/
String starttime = getCurrDateStr("00:00:00");
String endtimeTemp = getCurrDateStr("23:59:59");
String getQcCount = "select to_char(count(*)) from dqcinfo where starttime>=to_date(:starttime,'yyyyMMdd hh24:mi:ss') and  endtime <=to_date(:endtimeTemp,'yyyyMMdd hh24:mi:ss') and evterno=:evterno and flag <>'4'   and flag<>'0' and is_del='N' ";
myParams = "starttime="+starttime+",endtimeTemp="+endtimeTemp+",evterno="+evterno;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:param value="<%=getQcCount%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcCount" scope="end"/>
	
<%
/***************获得当前质检员已质检条数结束******************/
%>  	

<%
/***************获得当前质检员待整理条数开始******************/
String getQcTempCount = "select to_char(count(*)) from dqcinfo where  starttime>=to_date(:starttime,'yyyyMMdd hh24:mi:ss') and evterno=:evterno and flag='0'  and flag <>'4' and is_del='N'";
myParams = "starttime="+starttime+",evterno="+evterno;
/* guozw 修改前 未绑定变量
String getQcTempCount = "select to_char(count(*)) from dqcinfo where to_char(starttime,'yyyyMMdd hh24:mi:ss')>='"+starttime+"' and evterno='"+evterno+"' and flag='0'  and flag <>'4' and is_del='N'";
myParams = "starttime="+starttime+",evterno="+evterno;
*/
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=getQcTempCount%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="qcTempCount" scope="end"/>
	
<%
/***************获得当前质检员待整理条数结束******************/
%> 

<%
/***************取 1 内容概况 2 处理情况 3 改进建议 4 综合评价 信息******************/
String getInfoSql = "select t1.contentinsum,t1.handleinfo,t1.improveadvice,t1.commentinfo,t1.moddes  from DQCINFO t1 where  t1.serialnum ='" + serialnum + "'";
myParams = "serialnum="+serialnum;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
<wtc:param value="<%=getInfoSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="getInfoList" scope="end"/>
<html>
<head>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
<script>
	
	//在左边显示评分考评项说明
	function showReadMe(note){
		var note = note;
		if(""==note || note==undefined){
			note = "该评分项目前无相关说明！";
		}
		window.document.getElementById('readMeContent').innerText = note;
		window.document.getElementById('readMeContent').className = "blue";
	}
/**
  *弹出选择放弃原因的窗口
  */
function show_select_give_up_reason_win(){
		//增加判断输入信息不能过长
		var wordlength1 = document.getElementById('contentinsum').value.length;
		var wordlength2 = document.getElementById('handleinfo').value.length;
		var wordlength3 = document.getElementById('improveadvice').value.length;
		var wordlength4 = document.getElementById('commentinfo').value.length;
		var wordlength5 = document.getElementById('moddes').value.length;
		if(wordlength1>480){
			similarMSNPop("输入的内容概况信息长度过长！");
			document.getElementById('tb_1').click();
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
			document.getElementById('tb_4').click();
			document.getElementById('commentinfo').select();
			return false;
		}
		if(wordlength5>480){
			similarMSNPop("输入的修改说明信息长度过长！");
			document.getElementById('tb_5').click();
			document.getElementById('moddes').select();
			return false;
		}
		
		var returnValue = window.showModalDialog("./K214_get_give_up_reason.jsp",'',"dialogWidth=800px;dialogHeight=410px");
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
  *
  *放弃质检
  *
  */
function giveUpQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_save_plan_qc.jsp","请稍后...");
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
    var error_level_text = document.getElementById("error_level_texts").value;
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
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "4");
		chkPacket.data.add("objectid", "<%=object_id%>");
		chkPacket.data.add("contentid", "<%=contect_id%>");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);	
		core.ajax.sendPacket(chkPacket, doProcessGiveUpQcInfo, true);
		chkPacket =null;
}

/**
  *放弃返回处理函数
  */
function doProcessGiveUpQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		
		if(retType=="giveUpQcInfo"){
				if(retCode=="000000"){
						similarMSNPop("成功放弃质检！");
				}else{
						similarMSNPop("放弃质检失败！");
				}
		}
		
		//保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		//closeWin();
		setTimeout("closeWin()",2500);
}

/**
  *
  *临时保存质检结果
  *
  */
function tempSaveQcInfo(){
	//增加判断输入信息不能过长
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	var wordlength5 = document.getElementById('moddes').value.length;
	if(wordlength1>480){
		similarMSNPop("输入的内容概况信息长度过长！");
		document.getElementById('tb_1').click();
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
		document.getElementById('tb_4').click();
		document.getElementById('commentinfo').select();
		return false;
	}
	if(wordlength5>480){
		similarMSNPop("输入的修改说明信息长度过长！");
		document.getElementById('tb_5').click();
		document.getElementById('moddes').select();
		return false;
	}
	
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_save_plan_qc.jsp","请稍后...");
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
    var error_level_text = document.getElementById("error_level_texts").value;
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
    //added by tangsong 20100528 客户级别，来电号码，客户满意度
    var usertype = document.getElementById("usertype").value;
    var callerphone = document.getElementById("callerphone").value;
    var satisfyName = document.getElementById("satisfyName").value;
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
		chkPacket.data.add("callerphone",callerphone);
		chkPacket.data.add("usertype",usertype);
		chkPacket.data.add("satisfyName",satisfyName);
		<!--参数false表示同步执行-->
		core.ajax.sendPacket(chkPacket, doProcessTempSaveQcInfo, false);
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
				similarMSNPop("临时保存质检结果成功！");
				tmp = 0 ;
			}else{
				similarMSNPop("临时保存质检结果失败！");
				tmp = 0 ;
			}
	}
	//保存结果后将isSaved的值设为true
	document.getElementById("isSaved").value='true';
	setTimeout("closeWin()",2500);
}

/**

  *质检完毕返回处理函数

  */

function doProcessSaveQcInfo(packet) {
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="saveQcInfo"){
				if(retCode=="000000"){
					similarMSNPop("成功记录考评结果！");  
				}else{
					similarMSNPop("记录考评结果失败！");
				}
	   		window.returnValue='refresh';
		}
		
	  //保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		setTimeout("closeWin()",2500);
}
/**
  *
  *质检完毕，保存质检结果
  *
  */
function saveQcInfo() {
		var mod_flag = '<%=mod_flag%>';
		var flag = "2";
		if('<%=isAdjust%>'=='K206'){
	 			flag = "1";
  	}
		//增加判断输入信息不能过长
	var wordlength1 = document.getElementById('contentinsum').value.length;
	var wordlength2 = document.getElementById('handleinfo').value.length;
	var wordlength3 = document.getElementById('improveadvice').value.length;
	var wordlength4 = document.getElementById('commentinfo').value.length;
	var wordlength5 = document.getElementById('moddes').value.length;
	if(wordlength1>480){
		similarMSNPop("输入的内容概况信息长度过长！");
		document.getElementById('tb_1').click();
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
		document.getElementById('tb_4').click();
		document.getElementById('commentinfo').select();
		return false;
	}
	if(wordlength5>480){
		similarMSNPop("输入的修改说明信息长度过长！");
		document.getElementById('tb_5').click();
		document.getElementById('moddes').select();
		return false;
	}
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_save_modify_plan_qc.jsp","请稍后...");
		//zhengjiang 20091023 add 获得修改前考评项得分
		var scoreBefValues = new Array();
		for (var i = 0;i< parseInt('<%=queryList.length%>');i++){
				scoreBefValues[i] = document.getElementById("befScore"+i).value; 
		}
		//获得考评项得分
    var scoreValues    = new Array();
    for(var i = 0; i < parseInt('<%=queryList.length%>'); i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }
    //获得考评项id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
		//added by tangsong 20100531 被加分的考评项名称、被扣分的考评项名称
		var addedScoreItem = "";
		var lostScoreItem = "";
    for(var i = 0; i < itemIdObjs.length; i++){
    	itemIdValues[i] = itemIdObjs[i].value;
  		var highScore = Number(document.getElementById("highScore" + i).value);
  		var getScore = Number(document.getElementById("score" + i).value);
  		var itemName = document.getElementById("itemName" + i).value;
  		if (getScore > highScore) {
  			addedScoreItem += itemName + ",";
  		}
  		if (getScore < highScore) {
  			lostScoreItem += itemName + ",";
  		}
    }
    
		//获得流水号
		var serialnum = document.getElementById("serialnum").value;
			//获得考评对象id
		var content_id = document.getElementById("content_id").value;
			//获得考评内容id
		var object_id = document.getElementById("object_id").value;
		//内容概况
    var contentinsum = document.getElementById("contentinsum").value;
    //处理情况
    var handleinfo = document.getElementById("handleinfo").value;
    //改进建议
    var improveadvice = document.getElementById("improveadvice").value;
    //综合评价
    var commentinfo = document.getElementById("commentinfo").value;
    //修改说明
    var moddes = document.getElementById("moddes").value;
    //差错等级id
    var error_level_id = document.getElementById("error_level_id").value;
    //差错等级
    var error_level_texts = document.getElementById("error_level_texts").value;
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
    //added by tangsong 20100528 客户级别，来电号码，客户满意度
    var usertype = document.getElementById("usertype").value;
    var callerphone = document.getElementById("callerphone").value;
    var satisfyName = document.getElementById("satisfyName").value; 
		chkPacket.data.add("retType", "saveQcInfo");
		chkPacket.data.add("scoreBefValues",scoreBefValues);
	  chkPacket.data.add("scores", scoreValues);
	  chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("moddes", moddes);
		chkPacket.data.add("mod_flag", mod_flag);
	  chkPacket.data.add("contact_id", "<%=contact_id%>");
	  chkPacket.data.add("evterno", "<%=evterno%>");  	
		chkPacket.data.add("object_id", object_id);  
		chkPacket.data.add("content_id", content_id);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_texts", error_level_texts);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
    chkPacket.data.add("check_reason_ids", check_reason_ids);
		chkPacket.data.add("check_reason_texts", check_reason_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", flag);
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("endtime", "<%=endtime%>");
		chkPacket.data.add("nowYYYYMM", "<%=nowYYYYMM%>");
		//如果是质检结果整理则记录时长，质检结果修改不记录时长
    chkPacket.data.add("handleTime", handleTime);
	  chkPacket.data.add("listenTime", listenTime);
	  chkPacket.data.add("adjustTime", adjustTime);	
	  chkPacket.data.add("totalTime", totalTime);	
		chkPacket.data.add("usertype",usertype);
		chkPacket.data.add("callerphone",callerphone);
		chkPacket.data.add("satisfyName",satisfyName);
		chkPacket.data.add("addedScoreItem",addedScoreItem);
		chkPacket.data.add("lostScoreItem",lostScoreItem);
	  core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,false);
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
//zengzq add 20091021增加判断。根据当前分值，判断考评项等级选中的是哪个分数段
function checkSelected(i,curscore){
			var tmp_itemleveli;
			var tmp_itmeLevelNameArr;
			var tmp_scoreArr;
			var tmp_l_score;
			var tmp_h_score;
			var tmp_Arr = document.getElementById("itemlevel"+i).options;
			
			for(var j =0;j<tmp_Arr.length;j++){
					tmp_itmeLevelName = tmp_Arr[j].innerText;
					tmp_itmeLevelNameArr = tmp_itmeLevelName.split("->");
					tmp_scoreArr = tmp_itmeLevelNameArr[0].split("--");
					tmp_l_score = tmp_scoreArr[0];
					tmp_h_score = tmp_scoreArr[1];
					
					if(parseInt(curscore)>=parseInt(tmp_l_score) && parseInt(curscore)<=parseInt(tmp_h_score)){
							document.getElementById("itemlevel"+i).options[j].selected = true;
					}
			}
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
                
		//var scorei = document.getElementById("score"+i);
		//var itemleveli = document.getElementById("itemlevel"+i);
		//scorei.value=itemleveli.options[itemleveli.selectedIndex].value;
		//sumScore();
}

//added by tangsong 20100904 特殊的考评项:"业务问题"和"服务问题"
//"业务问题"和"服务问题"得分不计入总分，但若其中一项为差，整条流水得0分
//"业务问题"和"服务问题"需纳入报表统计，因此必须作为考评项
function changeScore2(i){
	var len = Number("<%=queryList.length%>");
	var itemleveli = document.getElementById("itemlevel"+i);
	var optionName = itemleveli.options[itemleveli.selectedIndex].innerText;
	var levelName = optionName.split("->")[1];
	for (var j=0;j<len;j++) {
		var tmpItemName = $("#itemName"+j).val();
		if (tmpItemName == "业务问题" || tmpItemName == "服务问题") {
			continue; //不执行下面的操作，继续循环
		}
		var options = document.getElementById("itemlevel"+j).options;
		if (levelName == "差") {
			//若"业务问题"和"服务问题"等级选择"差"，则其他非特殊考评项的都设为"差"
			for (var k=0;k<options.length;k++) {
				var tmpLevelName = options[k].innerText.split("->")[1];
				if (tmpLevelName == "差") {
					$("#itemlevel"+j).val(options[k].value);
					break;
				}
			}
			//各考评项得分为0，总分为0
			$("#score"+j).val("0");
			$("#subScore").val("0");
			$("#totalScore").val("0");
		} else {
			//若"业务问题"和"服务问题"等级选择"中"，则其他非特殊考评项的等级都设为"中"
			//考评项得分为"中"的分数
			for (var k=0;k<options.length;k++) {
				var tmpLevelName = options[k].innerText.split("->")[1];
				if (tmpLevelName == "中") {
					$("#itemlevel"+j).val(options[k].value);
					$("#score"+j).val(options[k].value.split("->")[0]);
					break;
				}
			}
			//总分为100
			$("#subScore").val("100");
			$("#totalScore").val("100");
		}
	}
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


/**
 *功能：记录质检结果通知
*/
function doQcCfm(flag){
	  var totalScore = document.getElementById("totalScore").value;
		var mypacket = new AJAXPacket("../K203/K203_appOrCfm_rpc.jsp","正在发送请求，请稍候......");
		mypacket.data.add("belongno","");
		mypacket.data.add("submitno","<%=workNo%>");
		mypacket.data.add("type",0);
		mypacket.data.add("serialnum","<%=serialnum%>");
		mypacket.data.add("staffno","<%=staffno%>");
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

function checkIsSendTip(){
	
	var tipCheckBox = document.getElementById("sendTip");
		
		if(tipCheckBox.checked==true){
				finishedTimer();
				var urlnotes = "../K217/K217_send_qc_result_tip.jsp?userId=<%=evterno%>&receiverPersons=<%=staffno%>&title=针对'<%=contact_id.trim()%>'流水的质检结果";	//修改by guozw2010-3-16
				window.openWinMid(urlnotes,"质检结果提醒",150, 400);
				saveQcInfo();
				finishedTimer();
		}else{
				saveQcInfo();
				finishedTimer();
		}
		/*
		var tipCheckBox = document.getElementById("sendTip");
		if(tipCheckBox.checked==true){
				window.openWinMid("../K217/K217_send_qc_result_tip.jsp","质检结果提醒",150, 400);
		}else{
				saveQcInfo();
		}*/
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
   /**add by hanjc 20090714 begin 临时保存当前听取录音的流水*/
   document.getElementById("lisenContactId").value = contact_id; 
   /**add by hanjc 20090714 end 临时保存当前听取录音的流水*/     
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

/*----------------计时器开始--------------*/
window.onload=function(){
		//为修改页面时，“临时保存”和“放弃”按钮不可用
		if("mod"=='<%=mod_flag%>'){
				document.getElementById("tmpSavButton").disabled=true;
				document.getElementById("giveUpButton").disabled=true;
		}
		
		//判断是否计时，修改页面：只听录音会计时，其他皆不计；整理页面：整理时长和总时长计时
		if('<%=isAdjust%>'=='K206'){
		 		setTimer();
		}
		
		//初始化时赋值听录音的条件
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
		var adjustTime = document.getElementById("adjustTime").innerHTML;
		var totalTime = document.getElementById("totalTime").innerHTML;
		adjustTime = parseInt(adjustTime)+1;
		totalTime = parseInt(totalTime)+1;
		document.getElementById("totalTime").innerHTML=totalTime;
		document.getElementById("adjustTime").innerHTML=adjustTime;
}
/*----------------计时器结束--------------*/

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth) {
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

//added by tangsong 20100411 向dqcresultaffirm表插入质检确认数据
function addAffirmData() {
	  var totalScore = document.getElementById("totalScore").value;
		var mypacket = new AJAXPacket("../K214/add_qc_result_affirm_data.jsp","正在发送请求，请稍候......");
		mypacket.data.add("belongno","");
		mypacket.data.add("submitno","<%=workNo%>");
		mypacket.data.add("type",0);
		mypacket.data.add("serialnum","<%=serialnum%>");
		mypacket.data.add("staffno","<%=staffno%>");
		mypacket.data.add("evterno","<%=workNo%>");
		mypacket.data.add("apptitle","流水号：<%=contact_id%> 考评得分："+totalScore);
		mypacket.data.add("content","");
		core.ajax.sendPacket(mypacket,donothing,true);
		mypacket=null;
}

function donothing() {

}
</script>

<style>
.content_02
{
	font-size:12px;
}

#tabtit_ts
{
	height:23px;
	padding:0px 0 0 12px;
}

#tabtit_ts ul
{
	height:23px;
	position:absolute;
}

#tabtit_ts ul li
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

#tabtit_ts .normaltab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit_ts .hovertab
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
#basetree td {
	padding:0;
	height:0;
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
	
<form name="form1">
<input type="hidden" name="serialnum" id="serialnum" value="<%=serialnum%>"/>
<div id="Operation_Table"><!-- guozw20090829 -->
	<div class="title"><div id="title_zi">
	<!--质检信息：今天该计划质检，你已完成<%=(qcCount.length>0)?qcCount[0][0]:"0"%>条，待整理条数<%=(qcTempCount.length>0)?qcTempCount[0][0]:"0"%>条-->
	质检信息<% 
	         if(isOutPlanflag.equals("0")){
	         %>
	         	：今天该计划质检，你已完成<%=(qcCount.length>0)?qcCount[0][0]:"0"%>条，待整理条数<%=(qcTempCount.length>0)?qcTempCount[0][0]:"0"%>条
	         <%
	         }
	         %>	
	</div></div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue">考评类别</td>
        <td>
		<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][0]:""%>"/>
        </td>
        <td class="blue">考评方式</td>
        <td>
     	<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][1]:""%>"/>
        </td>
      	<td class="blue">流水号</td>
        <td>
        <input type="text" name="" id="" size="25" readonly value="<%=contact_id%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">计划类型</td>
        <td>
		<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][2]:""%>"/>
        </td>
        <td class="blue">对象类别</td>
        <td>
     	<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][3] : objectName%>"/>
        </td>
      	<td class="blue">被检人</td>
        <td>
        <input type="text" name="" id="" size="25" readonly value="<%=staffno%>"/>
        </td>
      </tr>
      <tr>
      	<td class="blue">考评内容</td>
        <td>
		<input type="text" name="" id="" style="width:90%" readonly value="<%=(qcDetailList.length>0)?qcDetailList[0][4]: contentName%>"/>
        </td>
        <td class="blue">来电号码</td>
        <td>
     	<input type="text" name="callerphone" id="callerphone" style="width:90%" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][0]);}%>"/>
        </td>
      	<td class="blue">归属地</td>
        <td>
        <input type="text" name="" id="" size="25" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][1]);}%>"/>
        </td>
      </tr>
      
      <!-- added by tangsong 20100528 添加客户级别-->
      <tr>
        <td class="blue">客户级别</td>
        <td>
        	<input type="text" name="usertypeDesc" id="usertypeDesc" style="width:90%" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][6]);}%>"/>
        	<input type="hidden" name="usertype" id="usertype" value="<%if(callcallList.length>0){out.println(callcallList[0][5]);}%>"/>
        </td>
        <td class="blue">客户满意度</td>
        <td class="blue">
        	<input type="text" name="satisfyName" id="satisfyName" style="width:90%" readonly value="<%if(callcallList.length>0){out.println(callcallList[0][7]);}%>"/>
        </td>
        <td class="blue" colspan="2">&nbsp;</td>
      </tr>
      
	<tr>
	<td class="blue" colspan="2">
		<input type="checkbox" name="sendTip" id="sendTip" value=""/>&nbsp;&nbsp;&nbsp;&nbsp;发送结果通知 &nbsp;&nbsp;&nbsp;&nbsp;
		<!--input type="button" name="" class="b_text" value="监视" /-->
	</td>
	<td align="left" colspan="2">&nbsp;&nbsp;
		<!--input type="button" name="" class="b_text" value="指定新的计划" /-->
		<input type="button" name="" class="b_text" value="查看基本信息" onclick="getCallDetail();" />
		<!--input type="button" name="" class="b_text" value="选择培训建议" /--> 
	</td>
	<td colspan="2">&nbsp;&nbsp;</td>
	</tr>
	</table>
</div>

<!-- updated by tangsong 20100525 去掉考评项部分的滚动，改为全部展示
<div id="Operation_Table"  style="height:150px;width:99%;overflow:auto;">
-->
<div id="Operation_Table"  style="width:99%;overflow:auto;">
  <div class="title"><div id="title_zi">
    评分项目 &nbsp;子项得分合计 &nbsp;
  	<input type="text" disabled id="subScore" size="6" style="height:13px;" value="<%=(totalScore.length>0)?totalScore[0][0]:"0"%>" /> &nbsp;
  </div></div>
<table width="99%" height="25" border="0" align="left" cellpadding="0px" cellspacing="0">
  <tr>
	    <td class="blue" width="10%">序号</td>
	    <td class="blue" width="40%">名称</td>
	    <td class="blue" width="10%">最低分</td>
	    <td class="blue" width="10%">最高分 </td>
	    <td class="blue" width="10%">得分</td>
	    <td class="blue" width="20%">考评等级</td>   
  </tr>
<%
	String curscore="";
	for(int i = 0; i < queryList.length; i++){
	  if(scoreList.length==0){
	    curscore=queryList[i][3];
	  }else{
	  	curscore=scoreList[i][0];
	  }
		out.println("<tr>");
		//updated by tangsong 20100531 考评项名称和最高分的隐藏域
		//out.println("<td class='Blue' width='30px'>"+i+"</td>");
		out.println("<td class='Blue' width='30px'>"+i);
		out.println("<input type='hidden' id='itemName"+i+"' value='"+queryList[i][1]+"'/>");
		out.println("<input type='hidden' id='highScore"+i+"' value='"+queryList[i][3]+"'/>");
		out.println("<input type='hidden' name='befScore"+i+"' id='befScore"+i+"' value='"+curscore+"' >");
		out.println("</td>");
		out.println("<td class='Blue' width='40%' onclick=showReadMe('"+ queryList[i][4] +"')>");
		out.println(queryList[i][1]);
		out.println("<input type='hidden' name='itemId' value='"+queryList[i][0]+"'/>");
		out.println("</td>");
		out.println("<td class='Blue' width='40px'>"+queryList[i][2]+"</td>");
		out.println("<td class='Blue' width='40px'>"+queryList[i][3]+"</td>");
		out.println("<td class='Blue' width='10px'><input type='text' readonly='readonly' name='score"+i+"' id='score"+i+"' size='6' maxlength='6' value='"+curscore+"' /></td></td>");
		out.println("<td class='Blue' width='50px'>");
    if ("业务问题".equals(queryList[i][1])
     || "服务问题".equals(queryList[i][1])) {
			out.println("<select name='itemlevel"+i+"' id='itemlevel"+i+"' onchange='changeScore2("+i+");' style='width:100px;'>");
    } else {
			out.println("<select name='itemlevel"+i+"' id='itemlevel"+i+"' onchange='changeScore("+i+");' style='width:100px;'>");
    }
		//updated by tangsong 20100525 默认选中考评等级为'中'的一项
		String item_id= (queryList.length>0)?queryList[i][0]:"";
		String middleLevelSqlStr = "select t.value from (select decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||note||'->'||'"+queryList[i][3]+"' value, decode(substr(to_char(trim(low_score)),0,1),'.','0'||to_char(trim(low_score)),to_char(trim(low_score)))||'--'||decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||level_name text from dqcckectitemlevel where item_id="+item_id+" and content_id='"+contect_id+"' and object_id='"+object_id+"') t where t.text like '%中'";
		%>
		
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=middleLevelSqlStr%>"/>
		<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="middleLevelList" scope="end"/>	
		
		<%
			String defaultLevelValue = "";
			if (middleLevelList != null && middleLevelList.length > 0) {
				defaultLevelValue = (middleLevelList[0][0]==null)?"":middleLevelList[0][0];
			}
		%>

    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" value="<%=defaultLevelValue%>">
    <wtc:sql>select decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||note||'->'||'<%=queryList[i][3]%>',decode(substr(to_char(trim(low_score)),0,1),'.','0'||to_char(trim(low_score)),to_char(trim(low_score)))||'--'||decode(substr(to_char(trim(score)),0,1),'.','0'||to_char(trim(score)),to_char(trim(score)))||'->'||level_name from dqcckectitemlevel where item_id='<%=(queryList.length>0)?queryList[i][0]:""%>' and content_id='<%=contect_id%>' and object_id='<%=object_id%>' order by score desc </wtc:sql>
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
	//进行判段，根据当前分值判断选择哪个分数段
	checkSelected('<%=i%>','<%=curscore%>');
</script>
<%
//zengzq  end 20091017 select中的考评项无内容时，给添加一个默认值

	}
%>
</table>
</div>
<div id="Operation_Table" >
<div class="title"><div id="title_zi">有效评语(<%=(qcCount.length>0)?qcCount[0][0]:"0"%>)条 &nbsp;</div></div>
<table width="100%" height="25" border="0" align="center" cellpadding="4" cellspacing="0">
	<tr>
	<td class="blue" align="left" width="8%">差错等级</td>
	<td width="22%" >
	  <input type='text' name='error_level_texts' id='error_level_texts' style="width:90%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][5]:""%>' readonly />
		<input type="hidden" name="error_level_id" id="error_level_id" value="<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][2]:""%>"/>
		<!--input type="button" name="btn_error_level" class="b_text" value="选择" onclick="show_select_error_level_win();"/-->
	</td>
		<td class="blue" align="left" width="8%">差错类别</td>
	<td width="22%" >			
		<input type='text' name='error_class_texts' id='error_class_texts' style="width:70%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][6]:""%>' readonly/>
		<input type="hidden" name="error_class_ids" id="error_class_ids" value="<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][3]:""%>"/>
		<input type="button" name="btn_error_class" class="b_text" value="选择" onclick="show_select_error_class_win();"/>
	</td>
	<td class="blue" align="left" width="8%">评语范文</td>
		<td width="22%">
		<input type="button" name="btn_error_level" class="b_text" value="选择" onclick="show_select_error_level_win();">
		</td>
	</tr>
	<tr>
		<td class="blue" align="left" width="8%">来电原因</td>
	<td width="22%" >
	<input type='text' name='service_class_texts' id='service_class_texts' style="width:90%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][7]:""%>' readonly/>
	<input type="hidden" name="service_class_ids" id="service_class_ids" value="<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][4]:""%>"/>
          <!--放弃原因隐藏域-->
          <input type="hidden" name="give_up_reason_ids" id="give_up_reason_ids" />
          <input type="hidden" name="give_up_reason_texts" id="give_up_reason_texts" />
	</td>
               <!--liujied 增加评定原因 20091015 start -->
		<td class="blue" align="left" width="8%">评定原因</td>
		<td width="22%">
		<input type="text" name="check_reason_texts" id="check_reason_texts" style="width:70%" value='<%=(sqlCallcallSerialnumList.length>0)?sqlCallcallSerialnumList[0][9]:""%>' readonly/>
		<input type="hidden" name="check_reason_ids" id="check_reason_ids" value=""/>
		<input type="button" name="btn_check_reason" value="选择" class="b_text" onclick="show_select_check_reason_win();"/>
		</td>
		<td class="blue" colspan="2" width="8%">&nbsp;</td>
</tr>
</table>
</div>
<div id="Operation_Table"><!-- guozw20090828 -->
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<div class="content_02">
			<div id="tabtit_ts">
				<ul>
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">1 综合评价</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 处理情况</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 改进建议</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 内容概况</li>
					<%
					if("mod".equals(mod_flag.trim())){
					%>
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">5 修改说明</li>
					<%}%>
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
					<textarea id="commentinfo" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][3]:""%></textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][1]:""%></textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][2]:""%></textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="contentinsum" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][0]:""%></textarea>
			</div>
			<div class="undis" id="tbc_05">
				<textarea id="moddes" style="width:80%;" rows="5"><%=(getInfoList.length>0)?getInfoList[0][4]:""%></textarea>
			</div>		
		</div>
		</td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="blue" align="center" id="footer">
        <div id="callSearch">
				总&nbsp;分：<input type="text" name="totalScore" id="totalScore" size="6" value="<%=(totalScore.length>0)?totalScore[0][0]:"0"%>" readonly/>
				<input name="confirm" id="tmpSavButton" onClick="tempSaveQcInfo();finishedTimer();" type="button" class="b_foot" value="临时保存">
				<input name="confirm" onClick="checkIsSendTip();finishedTimer();" type="button" class="b_foot" value="质检完毕">
				<input name="confirm" onClick="rdShowMessageDialog('设为案例！',1);finishedTimer();" type="button" disabled class="b_foot" value="设为案例">
				<input name="confirm" id="giveUpButton" onClick="show_select_give_up_reason_win();" type="button" class="b_foot_long" value="放弃">
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
		<%if(qcTimeList.length>0){
		  int handleTime=0;
		  int listenTime=0;
		  int adjustTime=0;
		  int totalTime=0;
		  if(qcTimeList[0][2].length()>0){
		    handleTime=Integer.parseInt(qcTimeList[0][2]);
		  }
		  if(qcTimeList[0][3].length()>0){
		    listenTime=Integer.parseInt(qcTimeList[0][3]);
		  }
		  if(qcTimeList[0][4].length()>0){
		    adjustTime=Integer.parseInt(qcTimeList[0][4]);
		  }	
		  totalTime=	handleTime+listenTime+adjustTime;  
		%>
		<tr>
			<td align="left" class="blue">质检开始：</td>     <td align="left" ><%=(qcTimeList[0][0].length()>0)?qcTimeList[0][0]:"&nbsp;"%></td>
			<td align="left" class="blue">质检结束：</td>     <td align="left" ><%=(qcTimeList[0][1].length()>0)?qcTimeList[0][1]:"&nbsp;"%></td>
			<td align="left" class="blue">处理时长：</td>     <td align="left" id="handleTime"><%=handleTime%></td>
		</tr>
		<tr>
			<td align="left" class="blue">放音/监听时长：</td><td align="left" id="listenTime"><%=listenTime%></td>
			<td align="left" class="blue">整理时长：</td>     <td align="left" id="adjustTime"><%=adjustTime%></td>
			<td align="left" class="blue">总时长：</td>       <td align="left" id="totalTime"><%=totalTime%></td>
		</tr>
		<%}else{%>
     <tr>
			<td align="left" class="blue">质检开始：</td>     <td align="left" ><%=getCurrDateStr("")%></td>
			<td align="left" class="blue">质检结束：</td>     <td align="left" >&nbsp;</td>
			<td align="left" class="blue">处理时长：</td>     <td align="left" id="handleTime">0</td>
		 </tr>
		 <tr>
			<td align="left" class="blue">放音/监听时长：</td><td align="left" id="listenTime">0</td>
			<td align="left" class="blue">整理时长：</td>     <td align="left" id="adjustTime">0</td>
			<td align="left" class="blue">总时长：</td>       <td align="left" id="totalTime">0</td>
		</tr>
		<%}%>
	</table>	
</div>
	<input name="content_id" id="content_id" type="hidden" value="<%=contect_id%>"/>
	<input name="object_id" id="object_id" type="hidden" value="<%=object_id%>"/>	
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

</body>
</html>
<script language="javascript">

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
//updated by tangsong 20100905
function sumScore(){
		var objTotalScore = document.getElementById("totalScore");
		var subScore = document.getElementById("subScore");
		var totalScore = 0;
		//增加自动显示差错等级变量 zengzq add 20091103 
		var error_l_texts = "";
		var error_l_ids = ""; 
		
		var len = Number("<%=queryList.length%>");
		for(var i = 0; i < len; i++){
			var tmpItemName = $("#itemName"+i).val();
			if (tmpItemName != "业务问题" && tmpItemName != "服务问题") {
				totalScore += parseFloat($("#score"+i).val());
			}
		}
		objTotalScore.value = totalScore;
		subScore.value = totalScore;
		//增加自动调整显示差错等级start zengzq add 20091103 
		 if(parseInt(totalScore)>=200){
					 	error_l_texts = "特优";
					 	error_l_ids = "01";
			 }else if(totalScore>100 && totalScore<200){
			 			error_l_texts = "优";
					 	error_l_ids = "02";
			 }else if(totalScore==100){
			 			error_l_texts = "中";
					 	error_l_ids = "03";
			 }else if(totalScore<100){
			 			error_l_texts = "差";
					 	error_l_ids = "04";
			 }
		 document.getElementById("error_level_texts").value = error_l_texts;
		 document.getElementById("error_level_id").value = error_l_ids;
		 //增加自动调整显示差错等级end zengzq add 20091103 
}

function g(o){
		return document.getElementById(o);
}

function HoverLi(n){
		var fingure = '<%=mod_flag%>';
		var num = 0;
		if("mod"==fingure.trim()){
			num = 5;
		}else{
			num = 4;
		}
		for(var i=1;i<=num;i++)
		{
			g('tb_'+i).className='normaltab';
			g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
}

/**
  *弹出选择差错等级的窗口
  */
function show_select_error_level_win(){
		var returnValue = window.showModalDialog("../K217/K217_get_error_level.jsp",'',"dialogWidth=1000px;dialogHeight=530px");
	/*
		if(typeof(returnValue) != "undefined"){
					var error_level_texts = document.getElementById("error_level_texts");
					var error_level_id   = document.getElementById("error_level_id");
					var temp = returnValue.split('_');			
					error_level_texts.value = trim(temp[0]);
					error_level_id.value = trim(temp[1]);	
					var temp1= trim(temp[0]);
					var temp2= trim(temp[1]);
					var texts_temp_level = temp1.split(',');
					var ids_temp_level = temp2.split(',');
					error_level_texts.value="";
					
					for(var i=0; i<texts_temp_level.length-1; i++){
							if(i!=0&&i%2==0){
								error_level_texts.value +='<br>';
							}
							if(i!=texts_temp_level.length-1){
						    error_level_texts.value += texts_temp_level[i] + ',';
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
		}
}

/**
  *弹出选择来电原因的窗口
  */
function show_select_service_class_win(){
		if(<%=callcallList.length%>==0||trim('<%=(callcallList.length>0)?callcallList[0][2]:""%>')==""){
				similarMSNPop("该流水无对应的来电原因！"); 
		}else{
			  var returnValue = window.showModalDialog("../K217/K217_get_service_class.jsp",'',"dialogWidth=800px;dialogHeight=350px");
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
                                                     //comment by liujied 20091020
                                                     //check_reason_texts.value +='<br>';
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
	
	//added by tangsong 20100902 默认展开全部节点
	var itemObject = tree._globalIdStorageFind(0);
  for (var i=0; i<itemObject.childsCount; i++) {
  	getTreeListByNodeId(itemObject.childNodes[i].id);
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
//updated by tangsong 20100902
//begin
/*
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
*/
function getTreeListByNodeId(nodeId){
	if (nodeId == null) {
		nodeId = tree.getSelectedItemId();
		var varSubItems=tree.getSubItems(tree.getSelectedItemId());
		if(varSubItems!=null&&varSubItems!=''){
			return;
		}
	}
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_get_qc_item_child_tree.jsp?object_id=<%=object_id%>&content_id=<%=contect_id%>", "...");
	packet.data.add("parent_item_id",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,true);
}
//end

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

