<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming ��2017/3/25 ������ 13:32:08��-------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String iImeiNo         = WtcUtil.repNull(request.getParameter("iImeiNo"));
	String optype         = WtcUtil.repNull(request.getParameter("optype"));
	String iMember_No         = WtcUtil.repNull(request.getParameter("iMember_No"));

	
		

	
	System.out.println("--duming----iImeiNo-------------"+iImeiNo);
	System.out.println("--duming----optype-------------"+optype);
	System.out.println("--duming----iMember_No-------------"+iMember_No);
	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	String serverName="";

	if("add".equals(optype)){

	String iSale_Price         = WtcUtil.repNull(request.getParameter("fee"));

			 serverName = "sm461Cfm";

	System.out.println("--duming----fee-------------"+iSale_Price);
	//��׼�����
	String paraAray[] = new String[10];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                	 	 //�ֻ�����
	paraAray[6] = "";                                       //��������
	paraAray[7] = iImeiNo;                                       //imei����
	paraAray[8] = iMember_No;                                       //��Ա�ն����к�
	paraAray[9] = iSale_Price;                                       //Ѻ��



	try{
%>
		<wtc:service name="<%=serverName%>" outnum="8" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="6"  />
		<wtc:array id="result_t2" scope="end" start="6"  length="2" />
<%
	retCode = result_t2[0][0];
	retMsg = result_t2[0][1];
System.out.println("--duming--------retCode="+retCode);
System.out.println("--duming--------retMsg="+retMsg);
	//ƴװ��������
	for(int i=0;i<result_t1.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<result_t1[i].length;j++){
				System.out.println("--duming--------����------serverName=["+serverName+"]--------result_t1["+i+"]["+j+"]------->"+result_t1[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=result_t1[i][j]%>";
<%		
		}
	}


	
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}


	System.out.println("--duming--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
response.data.add("iSale_Price",<%=iSale_Price%>);
response.data.add("optype","<%=optype%>");
core.ajax.receivePacket(response);



<%	
	}

%> 	


<%
	if("del".equals(optype)){
			 serverName = "sm461Cfm_In";

			 //��׼�����
	String paraAray[] = new String[9];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                	 	 //�ֻ�����
	paraAray[6] = "";                                       //��������
	paraAray[7] = iImeiNo;                                       //imei����
	paraAray[8] = iMember_No;                                       //��Ա�ն����к�



	try{
%>
		<wtc:service name="<%=serverName%>" outnum="9" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="7"  />
		<wtc:array id="result_t2" scope="end" start="7"  length="2" />
<%
	retCode = result_t2[0][0];
	retMsg = result_t2[0][1];
System.out.println("--duming--------retCode="+retCode);
System.out.println("--duming--------retMsg="+retMsg);
	//ƴװ��������
	for(int i=0;i<result_t1.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<result_t1[i].length;j++){
				System.out.println("--duming--------����------serverName=["+serverName+"]--------result_t1["+i+"]["+j+"]------->"+result_t1[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=result_t1[i][j]%>";
<%		
		}
	}


	
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}


	System.out.println("--duming--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
response.data.add("optype","<%=optype%>");
core.ajax.receivePacket(response);


<%	
	}

%> 	
