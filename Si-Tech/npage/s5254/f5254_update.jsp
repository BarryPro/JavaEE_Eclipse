 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-07 ҳ�����,�޸���ʽ
	********************/
%>  
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	String opCode = "5254";	
	String opName = "���г�ֵ�������޸�";	//header.jsp��Ҫ�Ĳ���   
	
  	String myretFlag="",myretMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
  	
	//��ȡsession��Ϣ	
	String loginNo = (String)session.getAttribute("workNo");    //���� 
	String nopass = (String)session.getAttribute("password");		
	String regionCode = (String)session.getAttribute("regCode"); 
	
	String loginAccept=getMaxAccept();
	System.out.println("loginAccept==================="+loginAccept);
	String groupId = request.getParameter("groupId");							//�����̱��
	String agentName = request.getParameter("agentName");					//����������
	String agentAddress = request.getParameter("agentAddress");		//�����̵�ַ
	String agtStatus = request.getParameter("agtStatus");				//��ֵ�ʻ�״̬
	String regionCode2 = request.getParameter("regionCode");			//���д���
	String districtCode2 = request.getParameter("districtCode");	//���ش���
	String legalPresent = request.getParameter("legalPresent");		//���˴������� 
	String legalId = request.getParameter("legalId");							//���˴������֤��
	String angentClass = request.getParameter("angentClass");			//��������
	String zip = request.getParameter("zip");											//�ʱ�
	String contactName = request.getParameter("contactName");			//��ϵ������
	String contactId = request.getParameter("contactId");					//��ϵ�����֤
	String contactPhone = request.getParameter("contactPhone");		//��ϵ�˵绰
	String bankName = request.getParameter("bankName");						//��������
	String accountNo = request.getParameter("accountNo");					//��Ӧ�ʺ�
	String deposit = request.getParameter("deposit");							//Ѻ����
	String pb_size = request.getParameter("pb_size");							//���ҳߴ�
	String signTime = request.getParameter("signTime");						//ǩԼʱ��	
	String agentPhone = request.getParameter("agentPhone");				//�����ֻ���
	String UserPassword = request.getParameter("UserPassword");		//�ʻ�����
	String UserCode = request.getParameter("UserCode");						//��ֵ�ʻ�����
	String UserStatus = request.getParameter("UserStatus");				//��ֵ�ʻ�״̬
	String opNote = request.getParameter("opNote");								//��ע
	
	String isG3= request.getParameter("is_ghtree");
	String g3roleCode  = request.getParameter("g3roleCode");
	String gThreePhone = request.getParameter("gthree_phone");
	String parterId = request.getParameter("parterid");
	
	System.out.println("ningtn  5254  agentPhone " + agentPhone);
	//begin add by zhenghan 2009-07-09 ����"�����Ƿ�Ϊ��˾��������ʵ������"
	String entryType = request.getParameter("entryType");					//��ע
	String Entity_groupId = request.getParameter("Entity_groupId");	//�����Ƿ�Ϊ��˾��������ʵ������
	if("0".equals(entryType))
	{
		Entity_groupId="";
	}
	//end
	
	String retMsg = null;
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	

	/****************����  sDemoGetMsg  ***********************/
  
	String[] paraStrIn = new String[30];

	paraStrIn[0] = loginNo;                   //����
	paraStrIn[1] = nopass;                    //��������
	paraStrIn[2] = groupId;                 	//�����̱�� 
	paraStrIn[3] = agentName;									//����������
	paraStrIn[4] = agentAddress;							//�����̵�ַ
	paraStrIn[5] = agtStatus;									//������״̬
	paraStrIn[6] = regionCode2;								//���д���
	paraStrIn[7] = districtCode2;							//���ش���
	paraStrIn[8] = legalPresent;							//���˴�������
	paraStrIn[9] = legalId;										//���˴������֤��
	paraStrIn[10] = angentClass;							//��������
	paraStrIn[11] = zip;											//�ʱ�
	paraStrIn[12] = contactName;							//��ϵ������
	paraStrIn[13] = contactId;								//��ϵ�����֤��
	paraStrIn[14] = contactPhone;							//��ϵ�˵绰
	paraStrIn[15] = bankName;									//��������
	paraStrIn[16] = accountNo;								//��Ӧ�ʺ�
	paraStrIn[17] = deposit;									//Ѻ����
	paraStrIn[18] = pb_size;									//���ҳߴ�
	paraStrIn[19] = signTime;									//ǩԼʱ��			
	paraStrIn[20] = agentPhone;               //�����ֻ�����
	paraStrIn[21] = UserCode;                 //�˺�
	paraStrIn[22] = UserStatus;								//��ֵ�ʻ�״̬
	paraStrIn[23] = opNote;                   //��ע��Ϣ
	paraStrIn[24] = loginAccept; 
	paraStrIn[25] = Entity_groupId;            //�������ڵ�ʵ������
	
	paraStrIn[26] = isG3;            					//�Ƿ�G3���۴�����
	paraStrIn[27] = g3roleCode;            		//g3��ɫ
	paraStrIn[28] = gThreePhone;            	//��½�绰��
	paraStrIn[29] = parterId;                 //����������
	
	String srvName = "s5254Cfm";              //������
	//String outParaNums = "0";                 //�����������
	//impl.callFXService(srvName, paraStrIn,outParaNums,"region",regionCode);
	%>
	
	<wtc:service name="<%=srvName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:params value="<%=paraStrIn%>"/>
	</wtc:service>
	
	<%    
	String returnCode="0";  //�������	        
	String returnMsg=""; //������Ϣ
		
		returnCode=retCode1; //�������
		System.out.println("returnCode=============:"+returnCode);		
		returnMsg=retMsg1;//������Ϣ
		System.out.println("returnMsg===========:"+returnMsg);
	

	if("000000".equals(returnCode)){
		retMsg = "���г�ֵ�������޸ĳɹ�";
		%>
		
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
		    history.go(-1);
		</script>
	<%}else{
		retMsg = returnMsg;%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	<%}
	

%>

<% 
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+returnCode+"&retMsgForCntt="+returnMsg+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+agentPhone+"&opBeginTime="+opBeginTime+"&contactId="+agentPhone+"&contactType=user";
%>

<jsp:include page="<%=url%>" flush="true" />
