<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2017/3/6 ����һ 14:40:08-------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	
	String in_unitid     = WtcUtil.repNull(request.getParameter("in_unitid"));//���ű���
	String in_ecid   = WtcUtil.repNull(request.getParameter("in_ecid"));//EC���ű���
	String in_productofferId = WtcUtil.repNull(request.getParameter("in_productofferId"));//������ϵid
	String in_starttime   = WtcUtil.repNull(request.getParameter("in_starttime"));
	String in_endtime   = WtcUtil.repNull(request.getParameter("in_endtime"));
	String sel_opType   = WtcUtil.repNull(request.getParameter("sel_opType"));

			
				                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//��׼�����
	String paraAray[] = new String[13];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                	 	 //�ֻ�����
	paraAray[6] = "";                                       //��������
	paraAray[7] = in_unitid;                                       //���ű���
	paraAray[8] = in_ecid;                                       //EC���ű���
	paraAray[9] = in_productofferId;                                       //������ϵID
	paraAray[10] = in_starttime;                                       //�鵵���ڿ�ʼ
	paraAray[11] = in_endtime;                                       //�鵵���ڽ���
	paraAray[12] = sel_opType;                                       //sel_opType

	String serverName = "sm461Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="6" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="4"  />
		<wtc:array id="result_t2" scope="end" start="4"  length="2" />
<%


	retCode = result_t2[0][0];
	retMsg  = result_t2[0][1];
System.out.println("--duming--------retCode="+retCode);
System.out.println("--duming--------retMsg="+retMsg);
	if("000000".equals(retCode)){

	//ƴװ��������
	for(int i=0;i<result_t1.length;i++){

%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<result_t1[i].length;j++){
				System.out.println("--duming--------����------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+result_t1[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=result_t1[i][j]%>";
<%		
		}
	}
	}else{
			System.out.println("============  ʧ��==========");
		}
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

	retMsg = retMsg.trim();
	System.out.println("--duming--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
