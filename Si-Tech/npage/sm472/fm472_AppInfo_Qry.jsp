<%
/********************

 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming 2017.4.24------------------
���ڲ�������ص�����ҵ��֧��ϵͳ�����֪ͨ
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
			var retArray = new Array();//���巵������
<%	
				
				String sqlStrl2 = "";
			 String regionCode     = (String)session.getAttribute("regCode");
			 String iProductId        = WtcUtil.repNull(request.getParameter("iProductId"));
       sqlStrl2 ="SELECT code_id,code_desc FROM pd_unicodedef_dict WHERE code_class = 'DXSPLL' and code_name = '"+iProductId+"' and sysdate between eff_date and exp_date order by code_id";	
  	
  	System.out.println("--duming--------retMsg------serverName=["+iProductId+"]---------"+sqlStrl2);
  	String retCode        = "";
	  String retMsg         = "";
try{

 %>
	  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStrl2%>" />
		</wtc:service>
		<wtc:array id="sqlResult2" scope="end" />
<%

retCode = code;
	retMsg = msg; 
//ƴװ��������
	for(int i=0;i<sqlResult2.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<sqlResult2[i].length;j++){
				System.out.println("--duming--------����------serverName------serverResult["+i+"]["+j+"]------->"+sqlResult2[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=sqlResult2[i][j]%>";
<%		
		}
	}
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+"��������ϵ����Ա";
}

System.out.println("--duming--------retCode-----server--------"+retCode);
System.out.println("--duming--------retMsg------serverN--------"+retMsg);
	
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
