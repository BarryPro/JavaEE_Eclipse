<%
   /*
   * ����: ������֤ҳ��	
�� * �汾: v3.0
�� * ����: 2008/04/06
�� * ����: ranlf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
var retMsg = "";
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String verifyType = WtcUtil.repNull(request.getParameter("verifyType"));//��֤����:0�û�����;1���֤��;2���
   String verifyVal = WtcUtil.repNull(request.getParameter("verifyVal"));//����ֵ
   String validateVal = WtcUtil.repNull(request.getParameter("validateVal"));//������֤״̬
   String workNo = (String)session.getAttribute("workNo");
   String password = (String)session.getAttribute("password");
   String opCode =  WtcUtil.repNull(request.getParameter("opCode"));
   String phoneNo  = WtcUtil.repNull(request.getParameter("phoneNo"));
   String passFlag  = WtcUtil.repNull(request.getParameter("passFlag")); //�����ж������������ǲ��ǹ��ڼ򵥵ı�־
   Map tmap = (Map)session.getAttribute("contactTimeMap");
   
   /** add by zhanghonga@2008-09-16
     * ��Ϊ��������ߵ�������֤�������Ǳߵ���֤��ʽ��һ��.������������ֱ��ʹ�ñ���java�������ܵ�.
     * ����ֱ�Ӵ�ҳ�洫����ܺ������,ֱ�ӽ��бȽ�
   	 * verifyTypeΪ->0�����룬1�����֤��2���������
   	 ***/
   String returnFalg = "";
   if(verifyType.equals("0"))//�û�����
   {
   		verifyVal = Encrypt.encrypt(verifyVal);
   		String pwChckSqlStr = "select user_passwd from dcustmsg where phone_no = '"+phoneNo+"'";
%>
		  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=pwChckSqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="pwChckArr" scope="end" />  		
<%   	

			if(pwChckArr!=null&&pwChckArr.length>0){
			// yuanqs add 100820 ����������� begin
%>
    	<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="5">
				<wtc:param value="01"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=verifyVal%>"/>
				<wtc:param value="en"/>
				<wtc:param value=""/>
				<wtc:param value="<%=workNo%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end"/>
			var retCode = "<%=retCode%>";
			retMsg = "<%=retMsg%>";
			<%
					System.out.println("===========wanghfa============retCode=" + retCode);
					System.out.println("===========wanghfa============retMsg=" + retMsg);

					if ("000000".equals(retCode)) {
						 returnFalg = "1";
			  		 Map map = (Map)session.getAttribute("contactInfoMap");
					   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
					   if(contactInfo!=null)
					   {
					   	contactInfo.setPasswdVal(verifyVal,(2-Integer.parseInt(verifyType)));//���û��������MAP
					   	contactInfo.setPasswd_status(validateVal);  //
							String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
							System.out.println("====wanghfa==== " + phoneNo + "|" + opCode + ", " + dateStr);
							tmap.put(phoneNo + "|x", dateStr);
							tmap.put("x|" + opCode, "pwdValidate");
					   }
						for (int i = 0; i < result.length; i ++ ) {
							for (int j = 0; j < result[i].length; j ++) {
								System.out.println("=========wanghfa==========result[" + i + "][" + j + "]" + result[i][j]);
							}
						}
					} else {
						tmap.put("x|" + opCode, "pwdUnValidate");
					}
					
			
			%>
			if ("000000" != retCode) {
				//	rdShowMessageDialog("<%=retMsg%>");
			} 
<% 
			// yuanqs add 100820 ����������� end
				/*if(Encrypt.checkpwd2(pwChckArr[0][0],verifyVal)!=0){//�û���֤ͨ��
					 returnFalg = "1";
		  		 Map map = (Map)session.getAttribute("contactInfoMap");
				   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
				   if(contactInfo!=null)
				   {
				   	contactInfo.setPasswdVal(verifyVal,(2-Integer.parseInt(verifyType)));//���û��������MAP
				   	contactInfo.setPasswd_status(validateVal);  //
				   }					
				}*/
			}
			
				//	   if(workNo.equals("jalj0h")) returnFalg = "1";//�����ӡ��������hejwa ��ʱ���� ��ɺ�ɾ��
		   //System.out.println("hjwlog---------------workNo---------------"+workNo);
		   
   } else if (verifyType.equals("2")){
       %>
       <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
       <wtc:service name="sPassCheck" retcode="passCheckCode" retmsg="passCheckMsg"  outnum="1">
    		<wtc:param value="<%=loginAccept%>"/>
    		<wtc:param value="01"/>
    		<wtc:param value="<%=opCode%>"/>
    		<wtc:param value="<%=workNo%>"/>
    		<wtc:param value="<%=password%>"/>
    		<wtc:param value="<%=phoneNo%>"/>
    		<wtc:param value=""/>
    		<wtc:param value="<%=verifyVal%>"/>
    		<wtc:param value="0"/>
	   </wtc:service>
       
       retMsg = "<%=passCheckMsg%>";
       <%
       if ("000000".equals(passCheckCode)){
       		 /*2014/12/24 10:31:41 gaopeng �����Ż�ƾ�����֤��4G����ҵ��������ӡ���ݵ����� 
       		 	 �޸��������У��ɹ���,��session�д洢opcode|phoneNo Ϊ��֤�ɹ���־
       		 */
       		 String RandomPubFlag = (String)session.getAttribute("RandomPubFlag");
       		 if(RandomPubFlag != null && !"".equals(RandomPubFlag)){
       		 /*2014/12/24 10:41:21 ɾ��session�е�RandomPubFlag��Ϣ*/
       		 	session.removeAttribute("RandomPubFlag");
       		 }
       		 session.setAttribute("RandomPubFlag",phoneNo+"|true");
           returnFalg = "1";
           
           Map map = (Map)session.getAttribute("contactInfoMap");
		   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
		   if(contactInfo!=null){
		   	   contactInfo.setPasswdVal(verifyVal,(2 - Integer.parseInt(verifyType)));//���û��������MAP
		   	   contactInfo.setPasswd_status(validateVal);  //
			   String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
			   tmap.put(phoneNo + "|x", dateStr);
			   tmap.put("x|" + opCode, "pwdValidate");
		   } else {
			   tmap.put("x|" + opCode, "pwdUnValidate");
		   }
       } else {
           returnFalg = "";
       }
   }
   else//���֤��
   	{
   	/***add by zhanghonga end****/
%>
			<wtc:service name="sUserPWChck" outnum="1">
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=opCode%>"/>
					<wtc:param value="0"/>
					<wtc:param value="<%=phoneNo%>"/>
					<wtc:param value="<%=verifyType%>"/>
					<wtc:param value="<%=verifyVal%>"/>
			</wtc:service>
		  <wtc:array id="rows" scope="end"/>
<%
		   returnFalg = rows.length>0?rows[0][0]:"";
		   

		   
		   if(returnFalg.equals("1"))//�û���֤ͨ��
		  	{
		  		 Map map = (Map)session.getAttribute("contactInfoMap");
				   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
				   if(contactInfo!=null&&(!passFlag.equals("1")))
				   {
				   	contactInfo.setPasswdVal(verifyVal,(2-Integer.parseInt(verifyType)));//�Ѿ���֤
				   	contactInfo.setPasswd_status(validateVal); 
						String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
						System.out.println("====wanghfa==== " + phoneNo + "|" + opCode + ", " + dateStr);
						tmap.put(phoneNo + "|x", dateStr);
						tmap.put("x|" + opCode, "pwdValidate");
				   }
		  	}	else {
					tmap.put("x|" + opCode, "pwdUnValidate");
				}
		}
%>

	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("flag","<%=returnFalg%>");
	response.data.add("retMsg",retMsg); //yuanqs add 100823 ������֤����
	core.ajax.receivePacket(response);


	
