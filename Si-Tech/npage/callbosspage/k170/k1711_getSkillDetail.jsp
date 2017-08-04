<%
  /*
   * 功能: 
　 * 版本: 1.0.0
　 * 日期: 2009/01/18
　 * 作者: pengtw
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
	String opCode = "";
	String opName = "显示所选的技能队列";
	String orgCode = (String)session.getAttribute("orgCode");
 	String regionCode = orgCode.substring(0,2);
	
	
 String serial_no = WtcUtil.repNull(request.getParameter("serial_no"));
 String sql_dloginlog="select t.sign_in_skills,t.ccno from dloginlog t where t.serial_no=:serial_no";
 String param="serial_no="+serial_no;
 //String sql_dagskillqueue="select skill_queud_name from dagskillqueue t where t.skill_queue_id=:skill_queue_id and t.sub_cc_no=:sub_cc_no";
 String skill_queue_id="";
 String sub_cc_no="";    
%>
          <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
						<wtc:param value="<%=sql_dloginlog%>"/>
						<wtc:param value="<%=param%>"/>
					  </wtc:service>
					<wtc:array id="rowsC4"  scope="end"/>
<%
          if(rowsC4.length>0){
             skill_queue_id=rowsC4[0][0];
             sub_cc_no=rowsC4[0][1];
             String skillListStr_temp[]=skill_queue_id.split(",");
			       String skill_temp="";			       
			       for(int i=0;i<skillListStr_temp.length;i++ ){
				         if(i!=skillListStr_temp.length-1){
			              skill_temp+="'"+skillListStr_temp[i]+"',";	
			           }else{
			    	        skill_temp+="'"+skillListStr_temp[i]+"'";
			           }
			       }
			       skill_queue_id=skill_temp;
          }
String param_1="sub_cc_no="+sub_cc_no;
String sql_dagskillqueue="select skill_queud_name from dagskillqueue t where t.skill_queue_id in ("+skill_queue_id+") and t.sub_cc_no=:sub_cc_no";
System.out.println("$$$$$$$$$$$$$$$$$$$$$$sql_dagskillqueue="+sql_dagskillqueue);
%>
          <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sql_dagskillqueue%>"/>
						<wtc:param value="<%=param_1%>"/>
					  </wtc:service>
					<wtc:array id="results"  scope="end"/>
<%						
String result_skills="";
if(results.length>0){
   for(int i=0;i<results.length;i++){
       result_skills+=results[i][0]+"\r";
   }
}
%>
<script>
//alert('<%=result_skills%>');
</script>
<html>
<head runat="server">
<title>显示所选的技能队列</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/FormText.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css"
			rel="stylesheet" type="text/css"></link>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

</head>

<body >
<form name="sitechform" id="sitechform" >
	
<%@ include file="/npage/include/header.jsp" %>    
	 
			<div id="Operation_Table">			
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  align="center">		
				<tr>
					<th align="center">所选技能队列</th>
				</tr>
				<tr>
					<td><textarea name="continueResolve" id="continueResolve"  cols='50' rows='8' readonly><%=result_skills%></textarea>
					        
        </tr>
	     
			</table>
		
		</div>
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
