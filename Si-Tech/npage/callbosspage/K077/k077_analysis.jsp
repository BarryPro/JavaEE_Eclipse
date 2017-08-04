<%
  /*
   * 功能: 客户端版本升级查询
　 * 版本: 1.0
　 * 日期: 2009/10/28
　 * 作者: fangyuan
　 * 版权: sitech
 　*/
%>
 
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>

<html>
<head>
<style>
		img{
				cursor:hand;
		}
</style>	
<title>客户端升级情况统计</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/nresources/default/css/nextPages.css" ></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" language="javascript" src="/njs/si/base.js"></script>
<SCRIPT type="text/javascript" language=javascript src="/njs/si/ajax.js"></SCRIPT>
<SCRIPT type="text/javascript" language=javascript src="FusionCharts.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}	
%>
<%
	String opCode="K076";
  String opName="客户端升级情况统计";
   String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
	//登录工号
	String kf_longin_no = (String) session.getAttribute("workNo");
	/**获取查询条件**/
	//当前页码
	String pageNow = WtcUtil.repNull(request.getParameter("page"));
	if(pageNow.equals("")){
		pageNow = "1";
	}
	String pagesize = WtcUtil.repNull(request.getParameter("pagesize"));
	if(pagesize.equals("")){
		pagesize = "10";
	}
	String totalCount = "0";

	String upd_starttime = WtcUtil.repNull(request.getParameter("upd_starttime"));
	String upd_endtime = WtcUtil.repNull(request.getParameter("upd_endtime"));
	String issuccess = WtcUtil.repNull(request.getParameter("issuccess"));
	String version_no = WtcUtil.repNull(request.getParameter("version_no"));
	//String client_ip = WtcUtil.repNull(request.getParameter("client_ip"));
	String lbl_starttime="";
	String lbl_endtime="";
	
	String sql_condition = " 1=1 ";
	String params = "";
	if(!upd_starttime.equals("")){
			sql_condition += " and update_time>=to_date(:upd_starttime,'yyyy-mm-dd hh24:mi:ss') ";
			lbl_starttime = upd_starttime;
			params = params+",upd_starttime="+upd_starttime;
	}
	if(!upd_endtime.equals("")){
			sql_condition += " and update_time<=to_date(:upd_endtime,'yyyy-mm-dd hh24:mi:ss') ";
			lbl_endtime = upd_endtime;
			params = params+ ",upd_endtime="+upd_endtime;
	}
	if(!version_no.equals("")){
			sql_condition += " and version=':version_no' ";
			params = params+ ",version="+version_no;
			
	}
	if(params.length()!=0){
		params=params.substring(1);
	}
	
	/*
	if(!issuccess.equals("")){
			sql_condition += " and success_flag='"+issuccess+"' ";
	}
	if(!client_ip.equals("")){
			sql_condition += " and client_ip='"+client_ip+"' ";
	}
	*/

%>

<%

	String sql_temp = "select decode(success_flag,'Y','成功','失败') success_flag,to_char(count(distinct(client_ip)),'999999') count from dcallclientupd where  "
	+ sql_condition 
	+ "  group by success_flag order by success_flag desc";
	
	System.out.println(sql_temp);
	System.out.println(params);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
		<wtc:param value="<%=sql_temp%>"/>
		<wtc:param value="<%=params%>"/>
</wtc:service>
<wtc:array id="tmpData" scope="end" />
	<%
	
	
	%>
	
	
	
<script language="javascript">
	//提交
	function submitInputCheck(){
		document.sitechform.page.value = "1";
		document.sitechform.submit();
	}
	
	
	function saveCondition(){
		
		document.sitechform.version_no.value = "<%=version_no%>";
		document.sitechform.upd_starttime.value = "<%=upd_starttime%>";
		document.sitechform.upd_endtime.value = "<%=upd_endtime%>"; 
	}
</script>
</head>

<body onload="saveCondition()">
<form id=sitechform name=sitechform>
	
	<input type="hidden" name="page" value="<%=pageNow%>">
	<input type="hidden" name="pagesize" value="<%=pagesize%>">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<div id="Operation_Table" style="width: 100%;">	
		<div class="title">
		 	<div id="title_zi">客户端升级情况查询</div>
		</div>
		<table>	 
     <tr >
      <td class='Blue' >升级开始时间</td>
          <td  nowrap >
			  <input id="upd_starttime" name ="upd_starttime" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.upd_starttime);">
		    <img onclick="WdatePicker({el:$dp.$('upd_starttime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
	  	

	  
 
       <td class='Blue' >升级结束时间</td>
          <td  nowrap >
			  <input id="upd_endtime" name ="upd_endtime" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onfocus="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.upd_endtime);">
		    <img onclick="WdatePicker({el:$dp.$('upd_endtime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
      <td class='Blue'>版本号</td>
      <td  nowrap >
			  <input name ="version_no" type="text" id="version_no"  value="">
		  </td>	  
	    	  
     </tr>
     <tr >
      <td colspan="8" align="center" id="footer">    
       <input name="search" type="button" class="b_foot" id="search" value="查询" onClick="submitInputCheck();">
       <input name="delete_value" type="reset" class="b_foot"  id="reset" value="重置">
      
      </td>
     </tr>
		</table>
		<!--
		<div class="title">
			<div id="title_zi">客户端升级记录列表</div>
		</div>
		<table cellspacing="0">	
			<tr> 
        <th align="center" class="blue" width="10%" nowrap >结果</th>
        <th align="center" class="blue" width="8%" nowrap >次数</th>

        
      
    	</tr>
    	-->
<%
		String subcap = "";
		if(!lbl_endtime.equals("")&&!lbl_starttime.equals("")){
			subcap=lbl_starttime+" - "+lbl_endtime;
		}else if(lbl_endtime.equals("")){
			subcap=lbl_starttime+" - 至今";
		}else if(lbl_starttime.equals("")){
			subcap="截止 "+lbl_endtime;
		}
		


	    String strXML = "<graph caption='升级结果统计' subCaption='"+subcap+"' decimalPrecision='0' showNames='1' numberSuffix=' 台'  pieSliceDepth='30' formatNumberScale='0' baseFontSize='12'>";

		for(int i=0;i<tmpData.length;i++){
		
		strXML += "<set name='升级" + tmpData[i][0] + "' value='" +tmpData[i][1]+ "' />";
%>
<%		
		}
		strXML += "</graph>";
%>
	
	</form>
	
	<%

	

	
	%>

	<jsp:include page="FusionChartsRenderer.jsp" flush="true"> 
                <jsp:param name="chartSWF" value="FCF_Pie3D.swf" /> 
                <jsp:param name="strURL" value="" /> 
                <jsp:param name="strXML" value="<%=strXML %>" /> 
                <jsp:param name="chartId" value="callcenter" /> 
                <jsp:param name="chartWidth" value="650" /> 
                <jsp:param name="chartHeight" value="450" />
                <jsp:param name="debugMode" value="false" /> 
                <jsp:param name="registerWithJS" value="false" />
    </jsp:include>

	
</body>
</html>
