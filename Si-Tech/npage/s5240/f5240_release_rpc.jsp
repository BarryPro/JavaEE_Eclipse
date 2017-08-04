   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
********************/
%>
              
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");           //工号
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");                 	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	Logger logger = Logger.getLogger("f5240_release_rpc.jsp");
		
	String mode_code = request.getParameter("mode_code");
	String group_id = request.getParameter("group_id");
	String sm_code = request.getParameter("sm_code");
	String direct_id = request.getParameter("direct_id");
	String op_code = request.getParameter("op_code");
	String before_ctrl_code = request.getParameter("before_ctrl_code");
	String end_ctrl_code = request.getParameter("end_ctrl_code");
	String begin_time = request.getParameter("begin_time");	
	String end_time = request.getParameter("end_time");
	String power_right = request.getParameter("power_right");
	String note = request.getParameter("note");
	String region_code = request.getParameter("region_code");	
	String[] group_id_array = group_id.split(",");
	String op_note="操作员:"+workNo+"对产品:"+mode_code+"进行产品发布";
	String cfg_login_accept = request.getParameter("cfg_login_accept");
	String district_code = request.getParameter("district_code");
	String markFlag = request.getParameter("markFlag");
  String nextModeCode = request.getParameter("nextModeCode");
	

	String errCode = "";                                               
	String errMsg = "";                                            
	String[] acceptList = null;
		
	String paramsIn[] = new String[22];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5240";
	paramsIn[3]=cfg_login_accept;
	paramsIn[4]=mode_code;
	//paramsIn[5]=group_id_array;
	paramsIn[6]=sm_code;
	paramsIn[7]=direct_id;
	paramsIn[8]=op_code;
	paramsIn[9]=before_ctrl_code;
	paramsIn[10]=end_ctrl_code;
	paramsIn[11]=begin_time;
	paramsIn[12]=end_time;
	paramsIn[13]=power_right;
	paramsIn[14]=note;
	paramsIn[15]=org_code;
	paramsIn[16]=ip_Addr;
	paramsIn[17]=op_note;
	paramsIn[18]=region_code;
	paramsIn[19]=district_code;
	paramsIn[20]=markFlag;
  paramsIn[21]=nextModeCode;
	
	//acceptList = impl.callService("s5240Cfm",paramsIn,"2");
%>

    <wtc:service name="s5240Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
			<wtc:param value="<%=paramsIn[4]%>" />	
			<wtc:params value="<%=group_id_array%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />
			<wtc:param value="<%=paramsIn[11]%>" />
			<wtc:param value="<%=paramsIn[12]%>" />
			<wtc:param value="<%=paramsIn[13]%>" />
			<wtc:param value="<%=paramsIn[14]%>" />
			<wtc:param value="<%=paramsIn[15]%>" />
			<wtc:param value="<%=paramsIn[16]%>" />
			<wtc:param value="<%=paramsIn[17]%>" />
			<wtc:param value="<%=paramsIn[18]%>" />
			<wtc:param value="<%=paramsIn[19]%>" />															
			<wtc:param value="<%=paramsIn[20]%>" />	
			<wtc:param value="<%=paramsIn[21]%>" />		
		</wtc:service>

<%	
	errCode=code;
	errMsg=msg;
			
%>    
var response = new AJAXPacket();
response.data.add("retFlag","submit");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);