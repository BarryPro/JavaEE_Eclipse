<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: liangyl 2016/12/08 ʡ��ħ�ٺ�ƽ̨�㲥���ܺ�֧�����ܿ�������
   * ����: liangyl
   * ��Ȩ: si-tech
  */
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	                      
  	String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String sql_str =  "select IMEI_CODE FROM DMOBILEHEMSG WHERE ID_NO in(select id_no from dcustmsg where phone_no =:phoneNo) and op_code ='m414'";
	String sql_param = "phoneNo="+phoneNo;
	//7����׼�����
	String paraAray[] = new String[2];
	
	paraAray[0] = sql_str;                                       // 
	paraAray[1] = sql_param;                                     // 

	String serverName = "TlsPubSelCrm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
	//ƴװ��������
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
