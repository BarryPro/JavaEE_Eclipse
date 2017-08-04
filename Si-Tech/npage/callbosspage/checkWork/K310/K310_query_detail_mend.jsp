<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 计划明细修改
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String myParams1="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

//modified by liujied 20091015      
String primarykey = request.getParameter("primarykey");
String[] condition = primarykey.split("_");
%>

<%
//String strSql = " select distinct PLAN_TIME,MIN_TIME,MAX_TIME,ALERT_DAYS,"
//              +"ALERT_VALUE from DQCLOGINPLAN "
//              +"where trim(plan_id) || '_' || trim(object_id) || '_' || "
//              +"trim(content_id) || '_' || trim(login_no) = '" + primarykey + "'";
/*
String qcPlanDetail = "select distinct to_char(PLAN_TIME),to_char(MIN_TIME),to_char(MAX_TIME),to_char(ALERT_DAYS),"
                    + "ALERT_VALUE from DQCLOGINPLAN "
                    + "where trim(plan_id) = '"+condition[0]+"'"
                    + "and trim(object_id) = '"+condition[1]+"'"
                    + "and trim(content_id) = '"+condition[2]+"'"
                    + "and trim(login_no) = '"+condition[3]+"'";	*/
                    
String qcPlanDetail = "select distinct to_char(PLAN_TIME),to_char(MIN_TIME),to_char(MAX_TIME),to_char(ALERT_DAYS),"
                    + "ALERT_VALUE from DQCLOGINPLAN "
                    + "where trim(plan_id) = :condition0 "
                    + "and trim(object_id) = :condition1 "
                    + "and trim(content_id) = :condition2 "
                    + "and trim(login_no) = :condition3 ";
myParams = "condition0="+condition[0]+",condition1="+condition[1]+",condition2="+condition[2]+",condition3="+condition[3] ;

String limitFetch = "select to_char(plan_time),to_char(min_time),to_char(max_time) from dqcplan "
                +"where plan_id = :condition00 ";
myParams1 = "condition00="+condition[0] ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="7">
  <wtc:param value="<%=qcPlanDetail%>"/>
  <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList"  start="0" length="6" scope="end"/>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
  <wtc:param value="<%=limitFetch%>"/>
  <wtc:param value="<%=myParams1%>"/>
</wtc:service>
<wtc:array id="limit_list"  start="0" length="3" scope="end"/>

<html>
<head>
  <title>修改详细计划</title>
  <meta http-equiv=Content-Type content="text/html; charset=GBK">
    <link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
    <link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
    <link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
    <script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
    <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
	
/*对返回值进行处理*/
function doProcessAddQcContent(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode=="000000"){
				similarMSNPop("修改成功！");
				window.returnValue = 'reload';
				setTimeout("window.close()",1500);
		}else{
				similarMSNPop("修改失败！");
				return false;
		}
}

//验证质检计划次数
function checkPlanTimes(plan_times,min_times,max_times){
    var limit_max_time = document.getElementById("limit_max_time").value;
    var limit_min_time = document.getElementById("limit_min_time").value;
    var limit_plan_time = document.getElementById("limit_plan_time").value;
    
    var planTimes = plan_times-0;
    var minTimes  = min_times-0;
    var maxTimes  = max_times-0;
    if(planTimes > maxTimes){
        return 1;
    }else if(minTimes > planTimes){
        return 2;
    }else if(maxTimes > limit_max_time){
        return 3;
    }else if(minTimes < limit_min_time){
        return 4;
    }else if(planTimes > limit_plan_time){
        return 5;
    }else{
        return 0;
    }
}
//modified by liujied 20091015 修改质检计划明细                              
function submitQcContent(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K310/K310_query_detail_update.jsp","请稍后...");
    var MIN_TIME    = document.getElementById("MIN_TIME").value;
    var MAX_TIME    = document.getElementById("MAX_TIME").value;
    var PLAN_TIME   = document.getElementById("PLAN_TIME").value;
    var ALERT_DAYS   = document.getElementById("ALERT_DAYS").value;
    var ALERT_VALUE   = document.getElementById("ALERT_VALUE").value;
    
    if(MIN_TIME == ''){
				similarMSNPop("没有输入计划考评最低门限！");
				return false;
    }
    if( MAX_TIME == ''){
				similarMSNPop("没有输入计划考评最高门限！");
				return false;
    }
    //added by liujied 20091015
    if(checkPlanTimes(PLAN_TIME,MIN_TIME,MAX_TIME) == 1){
        similarMSNPop("计划考评次数超出计划考评最高门限！");
        return false;
    }
    if(checkPlanTimes(PLAN_TIME,MIN_TIME,MAX_TIME) == 2)
    {
        similarMSNPop("计划最低门限超出计划考评次数！");
        return false;
    }
    if(checkPlanTimes(PLAN_TIME,MIN_TIME,MAX_TIME) == 3)
    {
        similarMSNPop("不可超过总计划最高门限！");
        return false;
    }
    if(checkPlanTimes(PLAN_TIME,MIN_TIME,MAX_TIME) == 4)
    {
        similarMSNPop("不可小于总计划最低门限！");
        return false;
    }
    if(checkPlanTimes(PLAN_TIME,MIN_TIME,MAX_TIME) == 5)
    {
        similarMSNPop("不可超过总计划计划次数！");
        return false;
    }
    //本页变量  
    chkPacket.data.add("primarykey",'<%=primarykey%>');
    chkPacket.data.add("MIN_TIME", MIN_TIME);
    chkPacket.data.add("MAX_TIME", MAX_TIME);
    chkPacket.data.add("PLAN_TIME", PLAN_TIME);
    chkPacket.data.add("ALERT_DAYS", ALERT_DAYS);
    chkPacket.data.add("ALERT_VALUE", ALERT_VALUE);
    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,true);
    chkPacket =null;
}
</script>
</head>
<body>
  
  <form  name="sitechform" id="sitechform">
    <div id="Main">
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	  			<!--updated by tangsong 20100831 新样式下该背景不美观
	  			<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	    		-->
	    		<td valign="top">
	    <div id="Operation_Title"><B>修改详细计划</B></div>
            <div id="Operation_Table">
              <div class="title"></div>  
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	        
                <tr>
                  <td width=30% class="blue">计划质检次数</td>
                  <td width="70%">  
	 	    <input id="PLAN_TIME" name="PLAN_TIME" value='<%=queryList[0][0]%>' v_must="1" v_type="int" onBlur="checkElement(this);"/><font class="orange">*</font>     
                  </td>
                </tr>
                <tr>
                  <td width=30% class="blue">质检次数最低门限</td>
                  <td width="70%">  
	 	    <input id="MIN_TIME" name="MIN_TIME" value='<%=queryList[0][1]%>' v_must="1" v_type="int" onBlur="checkElement(this);"/><font class="orange">*</font>     
                  </td>
                </tr>
                <tr>
                  <td width=30% class="blue">质检次数最高门限</td>
                  <td width="70%">  
	 	    <input id="MAX_TIME" name="MAX_TIME" value='<%=queryList[0][2]%>' v_must="1" v_type="int" onBlur="checkElement(this);"/><font class="orange">*</font>     
                  </td>
                </tr>
                <tr>
                  <td width=30% class="blue">报警间隔（天）</td>
                  <td width="70%">  
	 	    <input id="ALERT_DAYS" name="ALERT_DAYS" value='<%=queryList[0][3]%>' v_must="1" v_type="int" onBlur="checkElement(this);"/><font class="orange">*</font>     
                  </td>
                </tr>
                <tr>
                  <td width=30% class="blue">报警值（质检次数）</td>
                  <td width="70%">  
	 	    <input id="ALERT_VALUE" name="ALERT_VALUE" value='<%=queryList[0][4]%>' v_must="1" v_type="int" onBlur="checkElement(this);"/><font class="orange">*</font>
                    <input type="hidden" name="limit_plan_time" value='<%=limit_list[0][0]%>' />
                    <input type="hidden" name="limit_min_time" value='<%=limit_list[0][1]%>' />
                    <input type="hidden" name="limit_max_time" value='<%=limit_list[0][2]%>' />
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td id="footer"  align=right> 
                    <input class="b_foot" name="submit" type="button" value="确认" onclick="submitQcContent()">
        	      <input class="b_foot" name="reset1" type="button"  onclick="window.close()" value="退出">
                      </td>
                    </tr>  
                  </table>
                </div>
                <br/>          
              </td>
              <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
            </tr>
            
            <tr>
              <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
              <td valign="bottom">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
                  <tr>
                    <td height="1"></td>
                  </tr>
                </table>
              </td>
              <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
            </tr>
          </table>
          
        </div>
        
      </form>
    </body>
  </html>
 




