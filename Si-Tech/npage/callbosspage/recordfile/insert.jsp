<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

    
    String login_no = (String)session.getAttribute("workNo");  //����		
    System.out.println("------loginNo1= "+session.getAttribute("workNo"));
    System.out.println("------loginNo2= "+session.getAttribute("kfWorkNo"));
    String contact_id = WtcUtil.repNull(request.getParameter("contact_id")); //�Ӵ�ID
    String kf_login_no = WtcUtil.repNull(request.getParameter("kf_login_no"));//�ͷ�����
    String filepath = WtcUtil.repNull(request.getParameter("filename")); //�ļ���
    String conveytype = WtcUtil.repNull(request.getParameter("conveytype")); //����
    
/** old sql:String sql= "insert into dconveyrecordfile (SERIAL_NO,CONTACT_ID,KF_LOGIN_NO,LOGIN_NO,FILEPATH,CONVEYTYPE,LISTENTIME)"+
		"select lpad(SEQ_CONVEYFILE.nextval,14,'0'),'"+contact_id+"','"+kf_login_no+"','"+login_no+"','"+filepath+"','"+conveytype+"',sysdate from dual";
*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String sql= "insert into dconveyrecordfile (SERIAL_NO,CONTACT_ID,KF_LOGIN_NO,LOGIN_NO,FILEPATH,CONVEYTYPE,LISTENTIME)"+
		"select lpad(SEQ_CONVEYFILE.nextval,14,0), :v1 , :v2 , :v3 , :v4 , :v5 ,sysdate from dual";

%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=contact_id%>"/>
	<wtc:param value="<%=kf_login_no%>"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=filepath%>"/>
	<wtc:param value="<%=conveytype%>"/>
</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "������־ʧ��";
	  }else{
	  	retCode = "000000";
	     retMsg = "������־�ɹ�";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","����ϵ����Ա");
	core.ajax.receivePacket(response);





