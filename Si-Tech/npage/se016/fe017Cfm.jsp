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
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "e017";	
	String opName = "ѫ�¶һ���Ʒ�����޸�";	//header.jsp��Ҫ�Ĳ���   
	//��ȡsession��Ϣ	
	String loginNo = (String)session.getAttribute("workNo");    //���� 
	String nopass = (String)session.getAttribute("password");		
	String regionCode = (String)session.getAttribute("regCode"); 
	String loginAccept=request.getParameter("loginAccept");//��ȡ��ˮ
	String chnSource="01";
	String iregionCode = request.getParameter("regionCode");							//���д���
	String giftCode = request.getParameter("giftCode");					//��Ʒ����
	String giftName = request.getParameter("giftName");		//��Ʒ����
	String giftDescribe = request.getParameter("giftDescribe");				//��Ʒ����
	String medalCount = request.getParameter("medalCount");			//��ѫ����
	String startTime = request.getParameter("startTime");	//��ʼʱ��
	String endTime = request.getParameter("endTime");		//����ʱ�� 
	String groupId = request.getParameter("groupId");							//��ȡӪҵ�������޸ĺ�
	String oldGroupId = request.getParameter("oldGroupId");							//	��ȡӪҵ�������޸�ǰ
	
	String opNote = request.getParameter("opNote");								//��ע
	String retMsg = null;

	/****************����  sE017Cfm  ***********************/
 
	%>
	<wtc:service name="sE017Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=chnSource%>"/>		
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=nopass%>"/>			
		<wtc:param value=" "/>
		<wtc:param value=" "/>		
	  <wtc:param value="<%=iregionCode%>"/>								
		<wtc:param value="<%=giftCode%>"/>			
		<wtc:param value="<%=giftName%>"/>	
		<wtc:param value="<%=giftDescribe%>"/>	
		<wtc:param value="<%=medalCount%>"/>						
		<wtc:param value="<%=startTime%>"/>	
		<wtc:param value="<%=endTime%>"/>	
		<wtc:param value="<%=oldGroupId%>"/>				
		<wtc:param value="<%=groupId%>"/>	
	  <wtc:param value="<%=opNote%>"/>	
	</wtc:service>	
	<%    
	String returnCode="0";  //�������	        
	String returnMsg=""; //������Ϣ
		
	returnCode=retCode1; //�������	
	returnMsg=retMsg1;//������Ϣ
	

	if("000000".equals(returnCode)){
		retMsg = "ѫ�¶һ���Ʒ�����޸ĳɹ�";
		%>
		
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
        window.location="/npage/se016/fe016_login.jsp?opCode=e017&opName=ѫ�¶һ���Ʒ�����޸�";
		</script>
	<%}else{
		retMsg = returnMsg;%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	<%}
	

%>


