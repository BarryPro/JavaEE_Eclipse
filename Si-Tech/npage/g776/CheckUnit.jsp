<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String cpid = WtcUtil.repStr(request.getParameter("cpid")," "); 
   String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
	 String retResult = "";
	 String ret_count="";
	 
	String[] inParas2 = new String[2];
	inParas2[0]="select to_char(count(*)),to_char(add_months(to_date(to_char(sysdate,'YYYYMM'),'YYYYMM'),-6),'YYYYMM'),to_char(sysdate,'YYYYMM') from dgrpusermsgadd where field_code = '1010' and field_value = '182' and id_no = :s_id_no ";
	inParas2[1]="s_id_no="+cpid;
	
	// 当前月 最多6个月
	String date_bf=""; 
	String date_now="";
%>
	 
	
	<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val==null||ret_val.length==0)
	{
		retResult="N";
	}
	else
	{
		retResult="Y";
		ret_count = ret_val[0][0];
		date_bf =  ret_val[0][1];
		date_now =  ret_val[0][2];
	}
%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var ret_count = "<%=ret_count%>"; 
response.data.add("retResult",retResult);
response.data.add("ret_count",ret_count);
var date_now = "<%=date_now%>";
response.data.add("date_now",date_now);
var date_bf = "<%=date_bf%>";
response.data.add("date_bf",date_bf);
core.ajax.receivePacket(response);



 
