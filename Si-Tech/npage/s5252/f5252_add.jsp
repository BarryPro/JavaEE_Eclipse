 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-04 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%

	String opCode = "5252";	
	String opName = "���г�ֵ������ע��";	//header.jsp��Ҫ�Ĳ���   

	String loginAccept = getMaxAccept();
  	
	//��ȡsession��Ϣ	
	//String loginNo = baseInfoSession[0][2];
	String loginNo = (String)session.getAttribute("workNo");    //���� 
	String nopass = (String)session.getAttribute("password");
		
	String groupId = request.getParameter("groupId");							//�����̱��
	String agentName = request.getParameter("agentName");					//����������
	String agentAddress = request.getParameter("agentAddress");		//�����̵�ַ
	String regionCode = request.getParameter("regionCode");				//���д���
	String districtCode = request.getParameter("districtCode");		//���ش���
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
	String opNote = request.getParameter("opNote");								//��ע
	//begin add by zhenghan 2009-07-09 ����"�����Ƿ�Ϊ��˾��������ʵ������"
	String entryType = request.getParameter("entryType");					//��ע
	String Entity_groupId = request.getParameter("Entity_groupId");	//�����Ƿ�Ϊ��˾��������ʵ������
	if("0".equals(entryType))
	{
		Entity_groupId="";
	}
	//end
	//20141009����G3����������
	String isgThree =  request.getParameter("is_ghtree");	
	String g3roleCode =  request.getParameter("g3roleCode");	
	String gthreePhone = request.getParameter("gthree_phone");
	String parterid = request.getParameter("parterid");	
	
	String retMsg = null;
	String returnCode="0";
 	String returnMsg="";

	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList = new ArrayList();
	String mysql = "select contract_passwd from dconmsg where contract_no = '" + UserCode + "'";
	String outParaNums = "1";
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=outParaNums%>">
		<wtc:sql><%=mysql%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="retList" scope="end" />
	
	<%

	//retList = impl.sPubSelect(outParaNums,mysql,"region",regionCode);
	//System.out.println("retList================"+retList.length);
	//System.out.println("retList================"+retList[0][0]);
	//System.out.println("retCode1================"+retCode1);
	//System.out.println("retMsg1================"+retMsg1);
	String[][] retListString = null;

	if(retList != null){
		//retListString = (String[][])retList.get(0);
		retListString=retList;
		
 		if(retList.length==0){
			System.out.println("�˻�������");
		}
		if(1==Encrypt.checkpwd1(UserPassword,retListString[0][0])){
			String[] paraStrIn = new String[28];
			paraStrIn[0] = loginNo;                   //����
			paraStrIn[1] = nopass;                    //��������
			paraStrIn[2] = groupId;                 	//�����̱�� 
			paraStrIn[3] = agentName;									//����������
			paraStrIn[4] = agentAddress;							//�����̵�ַ
			paraStrIn[5] = regionCode;								//���д���
			paraStrIn[6] = districtCode;							//���ش���
			paraStrIn[7] = legalPresent;							//���˴�������
			paraStrIn[8] = legalId;										//���˴������֤��
			paraStrIn[9] = angentClass;								//��������
			paraStrIn[10] = zip;											//�ʱ�
			paraStrIn[11] = contactName;							//��ϵ������
			paraStrIn[12] = contactId;								//��ϵ�����֤��
			paraStrIn[13] = contactPhone;							//��ϵ�˵绰
			paraStrIn[14] = bankName;									//��������
			paraStrIn[15] = accountNo;								//��Ӧ�ʺ�
			paraStrIn[16] = deposit;									//Ѻ����
			paraStrIn[17] = pb_size;									//���ҳߴ�
			paraStrIn[18] = signTime;									//ǩԼʱ��			
			paraStrIn[19] = agentPhone;               //�����ֻ�����
			paraStrIn[20] = UserCode;                 //�˺�
			paraStrIn[21] = opNote;                   //��ע��Ϣ8
		  paraStrIn[22] = loginAccept;
		  paraStrIn[23] = Entity_groupId;            //�������ڵ�ʵ������
		  //add by wanglz 20141009
		  paraStrIn[24] = isgThree;									 //�Ƿ�����G3��Ʒ
		  paraStrIn[25] = g3roleCode;								 //G3��ɫ
		  paraStrIn[26] = gthreePhone;               //G3��½�ֻ���
			paraStrIn[27] = parterid;                  //�����̴���
		  
			String srvName = "s5252Cfm"; //������1
			//String outParaNums1 = "0"; //�����������
			String outParaNums1 = "0"; //�����������
			//impl.callFXService(srvName, paraStrIn,outParaNums1,"region",regionCode);
			System.out.println("===========================");
 			%>
 			<wtc:service name="<%=srvName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
				<wtc:param value="<%=paraStrIn[0]%>"/>
				<wtc:param value="<%=paraStrIn[1]%>"/>
				<wtc:param value="<%=paraStrIn[2]%>"/>
				<wtc:param value="<%=paraStrIn[3]%>"/>
				<wtc:param value="<%=paraStrIn[4]%>"/>
				<wtc:param value="<%=paraStrIn[5]%>"/>
				<wtc:param value="<%=paraStrIn[6]%>"/>
				<wtc:param value="<%=paraStrIn[7]%>"/>
				<wtc:param value="<%=paraStrIn[8]%>"/>
				<wtc:param value="<%=paraStrIn[9]%>"/>
				<wtc:param value="<%=paraStrIn[10]%>"/>
				<wtc:param value="<%=paraStrIn[11]%>"/>
				<wtc:param value="<%=paraStrIn[12]%>"/>
				<wtc:param value="<%=paraStrIn[13]%>"/>
				<wtc:param value="<%=paraStrIn[14]%>"/>
				<wtc:param value="<%=paraStrIn[15]%>"/>
				<wtc:param value="<%=paraStrIn[16]%>"/>
				<wtc:param value="<%=paraStrIn[17]%>"/>
				<wtc:param value="<%=paraStrIn[18]%>"/>
				<wtc:param value="<%=paraStrIn[19]%>"/>
				<wtc:param value="<%=paraStrIn[20]%>"/>
				<wtc:param value="<%=paraStrIn[21]%>"/>		
				<wtc:param value="<%=paraStrIn[22]%>"/>				
				<wtc:param value="<%=paraStrIn[23]%>"/>		
				<wtc:param value="<%=paraStrIn[24]%>"/>	
				<wtc:param value="<%=paraStrIn[25]%>"/>	
				<wtc:param value="<%=paraStrIn[26]%>"/>	
				<wtc:param value="<%=paraStrIn[27]%>"/>
			</wtc:service>
			
 			<%
 				System.out.println("+++++++++++++++++++++++++++");				
 			
				returnCode = retCode2 ;//�������
				System.out.println("returnCode999999999:"+returnCode);
				returnMsg = retMsg2; //������Ϣ
				System.out.println("returnMsg99999999:"+returnMsg);
		
			if(returnCode.equals("000000")){
				retMsg = "���г�ֵ������ע��ɹ�";
			}else{
				retMsg = returnMsg;
			}

		}else{
			retMsg = "��ֵ�ʻ��������������";
		}
	}
	if(retMsg.equals("���г�ֵ������ע��ɹ�")){
%>

	<script language="JavaScript">	  
	    rdShowMessageDialog("<%=retMsg%>",2);
	    history.go(-1);
	</script>
<%}else{%>
	<script language="JavaScript">	  
	    rdShowMessageDialog("<%=retMsg%>",0);
	    history.go(-1);
	</script>
<%}%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+returnCode+"&retMsgForCntt="+returnMsg+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+agentPhone+"&opBeginTime="+opBeginTime+"&contactId="+agentPhone+"&contactType=user";%>
<jsp:include page="<%=url%>" flush="true" />
