<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.config.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="com.sitech.boss.pub.exception.BOException"%>
<%@ page errorPage="/page/common/errorpage.jsp"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
  ArrayList arr = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfo = (String[][])arr.get(0);
  String workno = baseInfo[0][2];  
  String orgcode = (String)session.getAttribute("orgCode");
  String regionCode = orgcode.substring(0,2);  

	String op_code = "4871";
	String region_code="";
  String group_id = request.getParameter("group_id");
  String limit_type = request.getParameter("limit_type");
  String limit_day_beg = request.getParameter("limit_day_beg");
	String limit_day_end = request.getParameter("limit_day_end");
	String limit_month_beg = request.getParameter("limit_month_beg");
	String limit_month_end = request.getParameter("limit_month_end");
	String limit_day_spe = request.getParameter("limit_day_spe");
	String limit_month_spe = request.getParameter("limit_month_spe");
	String phone_no = request.getParameter("msg_no");
	
	String sqlStr = "select distinct substr(org_code,1,2) from dloginmsg where group_id = '"+group_id+"'";
	String[][] result = new String [][]{};
%>
	<wtc:pubselect name="TlsPubSelBoss" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
	result = result1;
	region_code = result[0][0];
	
	String[] inParas = new String[10];
	
  inParas[0] = workno;
	inParas[1] = region_code;
	inParas[2] = limit_type;
	inParas[3] = limit_day_spe;
	inParas[4] = limit_day_beg;
	inParas[5] = limit_day_end;
	inParas[6] = limit_month_spe;
	inParas[7] = limit_month_beg;
	inParas[8] = limit_month_end;
	inParas[9] = phone_no;

	for(int i=0;i<inParas.length;i++){
		System.out.println("--------->"+inParas[i]);
	}
%>

<wtc:service name="s4871Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="return_code" retmsg="return_message" outnum="2">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
</wtc:service>
<wtc:array id="result2" scope="end" />
	
<script language="JavaScript"	src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT type=text/javascript>
function ifprint(){
<%  
  if (return_code.equals("000000")){
%>
  	rdShowMessageDialog("限额设置成功！");
	  document.location.replace("s4871.jsp");
<%
	} else {
%>
    rdShowMessageDialog("限额设置失败！<br>错误代码：'<%=return_code%>'<br>错误信息：'<%=return_message%>'",0);
    history.go(-1);
<%
	}     
%>
}			
</SCRIPT>
<html>
<body onload="ifprint()">
</body>
</html>
