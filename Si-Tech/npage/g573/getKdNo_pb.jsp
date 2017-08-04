<%
/********************
 version v2.0
开发商: si-tech
*******************
xl 新增修改操作
增加对输入宽带号码 -->phone_no的判断 并将phone_no对应的contract_no输出

*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
            //得到输入参数
    String s_sm_code= "";
	String s_flag="";//0=成功 1=失败
    String phone_kd  = WtcUtil.repStr(request.getParameter("phone_input")," "); 
	String s_run_code="";
	String[] inParas_hm = new String[2];
	inParas_hm[0]="select sm_code,substr(run_code,2,1) from dcustmsg where phone_no=:s_no";
	inParas_hm[1]="s_no="+phone_kd;
%>
	<wtc:service name="TlsPubSelBoss"    retcode="retCode12" retmsg="retMsg12" outnum="2">
		<wtc:param value="<%=inParas_hm[0]%>"/>
		<wtc:param value="<%=inParas_hm[1]%>"/>
	</wtc:service>
	<wtc:array id="result12" scope="end" />
<%
	if(result12!=null&&result12.length>0){
		        s_sm_code= (result12[0][0]).trim();
				s_run_code= (result12[0][1]).trim();
				s_flag="0";
				
	 }else{
				s_flag="1";
		 }

%>	

var response = new AJAXPacket  ();
var s_flag = "<%=s_flag%>";
var s_sm_code = "<%=s_sm_code%>";
var s_run_code = "<%=s_run_code%>";
response.data.add("s_flag",s_flag);
response.data.add("s_sm_code",s_sm_code);
response.data.add("s_run_code",s_run_code);
core.ajax .receivePacket(response);


 
