<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) ��2017/3/6 ����һ 13:32:08��-------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String ipt_llCardNo   = WtcUtil.repNull(request.getParameter("ipt_llCardNo"));
	
	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	String itype          = "";
	
	
	//7����׼�����
	String paraAray[] = new String[11];
	
	paraAray[0] = "0";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] =  "";                                       //�û�����
	paraAray[7] =  ipt_llCardNo;                                       //����������
	paraAray[8] =  "";                                       //ע����Ϣ
	paraAray[9] =  "";                                       //ҵ����ˮ��
	paraAray[10] = "";                                       //ҵ����ˮ��

	String serverName = "si127Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming1-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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
	if(serverResult.length>0){
		itype = serverResult[0][10];
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}


	System.out.println("--duming1--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming1--------retMsg------serverName=["+serverName+"]---------"+retMsg);
	System.out.println("--duming1--------itype------serverName=["+serverName+"]---------"+itype);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("itype","<%=itype%>");
core.ajax.receivePacket(response);
