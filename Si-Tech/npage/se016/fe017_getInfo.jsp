 <%
  /*
   * ����: ѫ�¶һ���Ʒ�����޸� e017
   * �汾: 1.0
   * ����: 2011/7/5
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>  
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	String opCode = "e017";	
	String opName = "ѫ�¶һ���Ʒ�����޸�";	//header.jsp��Ҫ�Ĳ���   
	//��ȡsession��Ϣ	
	String loginNo = (String)session.getAttribute("workNo");    //���� 
	String nopass = (String)session.getAttribute("password");		
	String regionCode = (String)session.getAttribute("regCode");           

	//������Ϣ���������
	String errCode = "0";
	String errMsg = "";
	String type = request.getParameter("type");
	String loginAccept=request.getParameter("loginAccept");//��ȡ��ˮ	
	String chnSource="01";
	String iregionCode = request.getParameter("regionCode");							//���д���	
	String giftCode = request.getParameter("giftCode");					//��Ʒ����	
  String groupId = request.getParameter("groupId");					//��ȡӪҵ��
	%>
  <wtc:service name="sE017Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=" "/>
		<wtc:param value=" "/>		
		<wtc:param value="<%=iregionCode%>"/>
		<wtc:param value="<%=giftCode%>"/>
		<wtc:param value="<%=groupId%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	<%
		errCode=retCode; //�������
		errMsg=retMsg;//������Ϣ
		String[][] retListString = null;
		String oLoginNo="";
		String oGiftName="";
		String oGiftDescribe="";
		String oMedalCount="";
		String oBeginTime="";
		String oEndTime="";
		String oGroupId="";
		String oGroupName="";
		String oOpNote="";
	if("000000".equals(errCode)){
		retListString=result;	
					
		if(retListString!=null&&retListString.length>0){			
			oLoginNo=retListString[0][0];
			oGiftName=retListString[0][1];
			oGiftDescribe=retListString[0][2];
			oMedalCount=retListString[0][3];
			oBeginTime=retListString[0][4];
			oEndTime=retListString[0][5];
			oGroupId=retListString[0][6];
			oGroupName=retListString[0][7];
			oOpNote=retListString[0][8];
		}
	}
%>

var response = new AJAXPacket();
response.data.add("type","<%=type%>");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("loginNo","<%=oLoginNo%>");
response.data.add("giftName","<%=oGiftName%>");
response.data.add("giftDescribe","<%=oGiftDescribe%>");
response.data.add("medalCount","<%=oMedalCount%>");
response.data.add("beginTime","<%=oBeginTime%>");
response.data.add("endTime","<%=oEndTime%>");
response.data.add("groupId","<%=oGroupId%>");
response.data.add("groupName","<%=oGroupName%>");
response.data.add("opNote","<%=oOpNote%>");
core.ajax.receivePacket(response);

