<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2017/3/3 ������ 10:59:40-------------------
 
 -------------------------��̨��Ա��chenlina--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	
	String ipt_unitId     = WtcUtil.repNull(request.getParameter("ipt_unitId"));
	String sel_opType     = WtcUtil.repNull(request.getParameter("sel_opType"));
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String iVpmnIdNoVal   = "";
	
	
	//7����׼�����
	String paraAray[] = new String[9];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = ipt_unitId;  
	paraAray[8] = sel_opType;  

	String serverName = "sm459Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
	<wtc:array id="serverResult2" scope="end" start="0"  length="1"  />
	<wtc:array id="serverResult" scope="end" start="1"  length="1" />
<%
	retCode = code;
	retMsg = msg;
 
	
	if(serverResult2.length>0){
			iVpmnIdNoVal = serverResult2[0][0];
			iVpmnIdNoVal = iVpmnIdNoVal.trim();
	}
	//ƴװ��������
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--hejwa--------����------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
	
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}


	System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("iVpmnIdNoVal","<%=iVpmnIdNoVal%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
