<%
    /********************
     version v1.0
     ������: si-tech
     *
     ********************/
%>
	<%@ page contentType="text/html; charset=GBK" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
	<%@ page import="java.text.*"%>

<%
	 String opCode = "e972";
	 String opName = "�������";	

  request.setCharacterEncoding("GBK");
	String retCode = "999999";
	String retMsg = "";
 
	String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String user_id=WtcUtil.repNull(request.getParameter("user_id"));
	String new_cus_id=WtcUtil.repNull(request.getParameter("new_cus_id"));
  String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
  String broadPhone=WtcUtil.repNull(request.getParameter("broadPhone"));

	
  String work_no = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
	String paraStr[]=new String[57];	//20091201 fengry ��String[44]��ΪString[45]
	paraStr[0]=WtcUtil.repNull(request.getParameter("loginAccept"));
	paraStr[1]="01";
 	paraStr[2]=opCode;
	paraStr[3]=work_no;
	paraStr[4]=nopass;
	paraStr[5]=srv_no;
	paraStr[6]="";
	paraStr[7]=broadPhone;
	paraStr[8]=org_code;
  paraStr[9]=user_id;
	paraStr[10]=new_cus_id; 

  paraStr[11] = request.getParameter("regionCode") + request.getParameter("districtCode") + "999";
	paraStr[12]= WtcUtil.repNull(request.getParameter("custName")); 
	String tmppwd = WtcUtil.repNull(request.getParameter("custPwd"));
  paraStr[13]= Encrypt.encrypt(tmppwd);
	paraStr[14]=WtcUtil.repNull(request.getParameter("custStatus")); 
	paraStr[15]="00";//WtcUtil.repNull(request.getParameter("custGrade"));
	paraStr[16]=WtcUtil.repNull(request.getParameter("custAddr")); 	
	paraStr[17] = WtcUtil.repNull(request.getParameter("idType"));
	paraStr[17] = paraStr[17].substring(0,paraStr[17].indexOf("|"));    //֤�����ͣ�0-���֤
  paraStr[18]= WtcUtil.repNull(request.getParameter("idIccid")); 
	paraStr[19]=WtcUtil.repNull(request.getParameter("idAddr")); 
	paraStr[20]=WtcUtil.repNull(request.getParameter("idValidDate"));
	if(paraStr[20].compareTo("")==0)
	{	  
/*
	*��������
	  int toy=Integer.parseInt(new SimpleDateFormat("yyyy", Locale.getDefault()).format(new Date())); 
      String tomd= new SimpleDateFormat("MMdd", Locale.getDefault()).format(new Date());  
	  paraStr[16]=String.valueOf(toy+10)+tomd;
*/
		Calendar cc = Calendar.getInstance();
		cc.setTime(new Date());
		cc.add(Calendar.YEAR, 10);
		Date _tempDate = cc.getTime();
		paraStr[20] = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(_tempDate);
	}
	paraStr[21]=WtcUtil.repNull(request.getParameter("newContactPerson")); 
	paraStr[22]=WtcUtil.repNull(request.getParameter("newContactPhone"));
	paraStr[23]=WtcUtil.repNull(request.getParameter("contactAddr"));
	paraStr[24] = WtcUtil.repNull(request.getParameter("contactPost"));
	if(paraStr[24].compareTo("")==0)
	{	paraStr[24] = " ";	}
	paraStr[25] = WtcUtil.repNull(request.getParameter("contactMAddr")); 	
	paraStr[26] = WtcUtil.repNull(request.getParameter("contactFax")); 
	if(paraStr[26].compareTo("")==0)
	{	paraStr[26] = " ";	}	
    paraStr[27] = WtcUtil.repNull(request.getParameter("contactMail")); 
	if(paraStr[27].compareTo("")==0)
	{	paraStr[27] = " ";	}
	paraStr[28]  = WtcUtil.repNull(request.getParameter("custSex"));  	//�ͻ��Ա�
	paraStr[29]  = WtcUtil.repNull(request.getParameter("birthDay")); //��������
	if(paraStr[29] .compareTo("") == 0)
	{
 	  if(paraStr[18].trim().length()==15 && paraStr[17].equals("0")) 
		paraStr[29] ="19"+paraStr[18].substring(6,8)+paraStr[18].substring(8,12);
	  else if(paraStr[18].trim().length()==18 && paraStr[17].equals("0")) 
        paraStr[29]=paraStr[18].substring(6,10)+paraStr[18].substring(10,14);
	  else
        paraStr[29]="19491001";
	} 
	paraStr[30] = WtcUtil.repNull(request.getParameter("professionId")); 
	paraStr[31] = WtcUtil.repNull(request.getParameter("vudyXl")); //ѧ��
	paraStr[32] = WtcUtil.repNull(request.getParameter("custAh")); //�ͻ����� 
	if(paraStr[32].length() == 0)
	{	paraStr[32] = "";	}
	paraStr[33] = WtcUtil.repNull(request.getParameter("custXg")); //�ͻ�ϰ��
	if(paraStr[33].compareTo("") == 0)
	{	paraStr[33] = "";	}

  paraStr[34]=WtcUtil.repNull(request.getParameter("oriHandFee"));
	paraStr[35]=WtcUtil.repNull(request.getParameter("t_handFee"));
  paraStr[36]=WtcUtil.repNull(request.getParameter("t_sys_remark"));
  paraStr[37]=WtcUtil.repSpac(request.getParameter("t_op_remark"));
	paraStr[38]=request.getRemoteAddr();
	paraStr[39]=WtcUtil.repNull(request.getParameter("assuName"));
	paraStr[40]=WtcUtil.repNull(request.getParameter("assuPhone"));
	paraStr[41]=WtcUtil.repNull(request.getParameter("assuIdType"));
	paraStr[42]=WtcUtil.repNull(request.getParameter("assuId"));
	paraStr[43]=WtcUtil.repNull(request.getParameter("assuIdAddr"));
	paraStr[44]=WtcUtil.repNull(request.getParameter("assuAddr"));
	paraStr[45]=WtcUtil.repNull(request.getParameter("assuNote"));
	paraStr[46]=WtcUtil.repNull(request.getParameter("xinYiDu"));
	paraStr[47]=WtcUtil.repNull(request.getParameter("print_query"));
	
		/*����������*/
	String responsibleName = WtcUtil.repStr(request.getParameter("responsibleName"),"");
	/*��������ϵ��ַ*/
	String responsibleAddr = WtcUtil.repStr(request.getParameter("responsibleAddr"),"");
	/*������֤������*/
	String responsibleType = WtcUtil.repStr(request.getParameter("responsibleType"),"");
	responsibleType = responsibleType.substring(0,responsibleType.indexOf("|"));
	/*������֤������*/
	String responsibleIccId = request.getParameter("responsibleIccId");
	
	String zerenrenstrss=responsibleType+"|"+responsibleIccId+"|"+responsibleName+"|"+responsibleAddr;	
	
	paraStr[48]=WtcUtil.repNull(request.getParameter("isJSX"));
	
	/*����������*/
	String gestoresName = request.getParameter("gestoresName");
	/*��������ϵ��ַ*/
	String gestoresAddr = request.getParameter("gestoresAddr");
	/*������֤������*/
	String gestoresIdType = request.getParameter("gestoresIdType");
	gestoresIdType = gestoresIdType.substring(0,gestoresIdType.indexOf("|"));
	
	String xsjbrxx=WtcUtil.repStr(request.getParameter("xsjbrxx"),"0");
	/*������֤������*/
	String gestoresIccId = request.getParameter("gestoresIccId");
	System.out.println("-----------gaopeng---------gestoresName------------------------------"+gestoresName);
	System.out.println("-----------gaopeng---------gestoresAddr------------------------------"+gestoresAddr);
	System.out.println("-----------gaopeng---------gestoresIdType------------------------------"+gestoresIdType);
	System.out.println("-----------gaopeng---------gestoresIccId------------------------------"+gestoresIccId);
	
	/*ʵ��ʹ��������*/
	String realUserName = WtcUtil.repStr(request.getParameter("realUserName"),"");
	/*ʵ��ʹ���˵�ַ*/
	String realUserAddr = WtcUtil.repStr(request.getParameter("realUserAddr"),"");
	/*ʵ��ʹ����֤������*/
	String realUserIccId = WtcUtil.repStr(request.getParameter("realUserIccId"),"");
	/*ʵ��ʹ����֤������*/
	String realUserIdType = WtcUtil.repStr(request.getParameter("realUserIdType"),"");
	
	paraStr[49] = gestoresName;
	paraStr[50] = gestoresAddr;
	paraStr[51] = gestoresIdType;
	paraStr[52] = gestoresIccId;
	
	paraStr[53] = realUserIdType;
	paraStr[54] = realUserIccId;
	paraStr[55] = realUserName;
	paraStr[56] = realUserAddr;
	
	
	
	
	//20091201 begin �������������Ϣ��:�Ƿ����������־~�������ʱ��
	String GoodPhoneFlag=WtcUtil.repNull(request.getParameter("GoodPhoneFlag"));
	String GoodPhoneDate=WtcUtil.repNull(request.getParameter("GoodPhoneDate"));	
	//20091201 end
   for(int i = 0; i<paraStr.length; i++)
   	System.out.println("#########################fe972Cfm->paraStr["+i+"]->"+paraStr[i]);
   	
		/**********************************************************************
		 *@ �������ƣ�sE972Cfm
		 *@ �������ڣ�2012/08/05
		 *@ ����汾: Ver1.0
		 *@ ������Ա��chenlina
		 *@ �����������������ȷ�Ϸ���
		 *@input parameter information
		 *@inparam0		loginAccept			��ˮ	�������룬������������ڷ�����ȡ��ˮ
		 *@inparam1   chnSource			������ʶ
		 *@inparam2		opCode				��������
		 *@inparam3		loginNo				��������
		 *@inparam4		loginPasswd			������������
		 *@inparam5		iPhoneNo			�������
		 *@inparam6		userPwd				�û�����
		 *@inparam7		cfmLogin			����˺�
		 *@inparam8		orgCode				�������Ź���
		 *@inparam9		idNo				�û�ID
		 *@inparam10	newCustID			�¿ͻ�ID
		 *--------------------------------------------------------------*
		 *@inparam11	vNOrg				�¿ͻ���������
		 *@inparam12	vNName				�¿ͻ�����
		 *@inparam13	vNPwd				�¿ͻ�����
		 *@inparam14	vNStatus			�¿ͻ�״̬
		 *@inparam15	vNGrade				�¿ͻ�����
		 *@inparam16	vNHomeAddr			�¿ͻ���ַ
		 *@inparam17	vNIdType			�¿ͻ�֤������
		 *@inparam18	vNIdNum				�¿ͻ�֤������
		 *@inparam19	vNIdAddr			�¿ͻ�֤����ַ
		 *@inparam20	vNIdDate			�¿ͻ�֤����Ч��
		 *@inparam21	vNConName			�¿ͻ���ϵ������
		 *@inparam22	vNConTel			�¿ͻ���ϵ�˵绰
		 *@inparam23	vNConAddr			�¿ͻ���ϵ�˵�ַ
		 *@inparam24	vNConPostNum		�¿ͻ���ϵ���ʱ�
		 *@inparam25	vNConPostAddr		�¿ͻ���ϵ��ͨѶ��ַ
		 *@inparam26	vNConFax			�¿ͻ���ϵ�˴���
		 *@inparam27	vNConEMail			�¿ͻ���ϵ�˵�������
		 *@inparam28	vNSex				�¿ͻ��Ա�
		 *@inparam29	vNBirth				�¿ͻ���������
		 *@inparam30	vNWork				�¿ͻ�ְҵ����
		 *@inparam31	vNEduLevel			�¿ͻ�ѧ��
		 *@inparam32	vNLove				�¿ͻ�����
		 *@inparam33	vNHabit				�¿ͻ�ϰ��
		 *--------------------------------------------------------------*
		 *@inparam34	payFee				Ӧ��
		 *@inparam35	realFee				ʵ��
		 *@inparam36	systemNote			ϵͳ��ע
		 *@inparam37	opNote				�û���ע
		 *@inparam38	ipAddr				IP��ַ
		 *--------------------------------------------------------------*
		 *@inparam39	cust_name			����������
		 *@inparam40    contact_phone		��������ϵ�绰
		 *@inparam41    id_type				������֤������
		 *@inparam42    id_iccid			������֤������
		 *@inparam43    id_address	 		������֤����ַ
		 *@inparam44    contact_address		��������ϵ��ַ
		 *@inparam45    notes				������ע
		 *@inparam46    iCreditValue		������
		 *@inparam47    chPrintQueryFlag		�Ƿ������ѯ�굥
		 *@			�������������Ϣ�� 20091201 add by fengry
		 *--------------------------------------------------------------*
		
		 *@output parameter information
		 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO
		 */
		/********************************************************************/


    //SPubCallSvrImpl im1210=new SPubCallSvrImpl();
    //String[] fg=im1210.callService("s1238Cfm", paraStr,"2");
%>
		<wtc:service name="sE972Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/> 
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/> 
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>	
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/> 
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/> 
		<wtc:param value="<%=paraStr[12]%>"/>
		<wtc:param value="<%=paraStr[13]%>"/>
		<wtc:param value="<%=paraStr[14]%>"/>
		<wtc:param value="<%=paraStr[15]%>"/> 
		<wtc:param value="<%=paraStr[16]%>"/>
		<wtc:param value="<%=paraStr[17]%>"/>	
		<wtc:param value="<%=paraStr[18]%>"/>
		<wtc:param value="<%=paraStr[19]%>"/> 
		<wtc:param value="<%=paraStr[20]%>"/>
		<wtc:param value="<%=paraStr[21]%>"/> 
		<wtc:param value="<%=paraStr[22]%>"/>
		<wtc:param value="<%=paraStr[23]%>"/>
		<wtc:param value="<%=paraStr[24]%>"/>
		<wtc:param value="<%=paraStr[25]%>"/> 
		<wtc:param value="<%=paraStr[26]%>"/>
		<wtc:param value="<%=paraStr[27]%>"/>	
		<wtc:param value="<%=paraStr[28]%>"/>
		<wtc:param value="<%=paraStr[29]%>"/>
		<wtc:param value="<%=paraStr[30]%>"/>
		<wtc:param value="<%=paraStr[31]%>"/> 
		<wtc:param value="<%=paraStr[32]%>"/>
		<wtc:param value="<%=paraStr[33]%>"/>
		<wtc:param value="<%=paraStr[34]%>"/>
		<wtc:param value="<%=paraStr[35]%>"/> 
		<wtc:param value="<%=paraStr[36]%>"/>
		<wtc:param value="<%=paraStr[37]%>"/>	
		<wtc:param value="<%=paraStr[38]%>"/>
		<wtc:param value="<%=paraStr[39]%>"/> 
		<wtc:param value="<%=paraStr[40]%>"/>
		<wtc:param value="<%=paraStr[41]%>"/> 
		<wtc:param value="<%=paraStr[42]%>"/>
		<wtc:param value="<%=paraStr[43]%>"/>
		<wtc:param value="<%=paraStr[44]%>"/>
		<wtc:param value="<%=paraStr[45]%>"/>
		<wtc:param value="<%=paraStr[46]%>"/>
		<wtc:param value="<%=paraStr[47]%>"/>
		
			
			<%
		    String loginacceptJTrc=WtcUtil.repNull(request.getParameter("loginacceptJT"));
		    String pinjiecanshu="";
          if(!"".equals(loginacceptJTrc)) {
          pinjiecanshu="1";
          }else {
          pinjiecanshu="";
        	}
          
    /*��ѡ��λ����ʱ,�ٴ�ֵ*/
    	if(paraStr[48].equals("1")||xsjbrxx.equals("1")){
    	String inputStr11 = paraStr[49]+"|"+paraStr[51]+"|"+paraStr[52]+"|"+paraStr[50]+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|"+zerenrenstrss ;
    %>
    
      <wtc:param value="<%=inputStr11%>"/>
    <%
    	}else{
    	String inputStr22 = ""+"|"+""+"|"+""+"|"+""+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|"+"|"+"|"+"|" ;
    %>	
    	<wtc:param value="<%=inputStr22%>"/>
    <%	
    	}
    %>					
			
		</wtc:service>
		<wtc:array id="s1238CfmArr" scope="end"/>



<%
	 	System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
		String s1238LoginAccept = s1238CfmArr.length>0?s1238CfmArr[0][1]:"";
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraStr[0]+"&pageActivePhone="+srv_no+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
	  System.out.println("--------------ͳһ�Ӵ�url----:"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
	 	System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
%>


<%	
		String vPostFlag = s1238CfmArr.length>0?s1238CfmArr[0][0]:"";		
		retCode = retCode1==""?retCode:retCode1;
		retMsg = retMsg1;
		System.out.println("--liujian--e972--retCode=" + retCode);
    if(retCode != null && retCode.equals("000000"))
    {
      String vPostContent = "";
      if(vPostFlag.equals("Y"))
      {
        vPostContent = ",���û�������ʼ��ʵ�ҵ���������û������ʼĵ�ַ";
      }

%>
      <script language="javascript">
	     	 rdShowMessageDialog("��������ɹ���",2);  
         removeCurrentTab();
	    </script>
<%
   }else{
%>
   <script>
	   rdShowMessageDialog('����<%=retCode%>��'+'<%=retMsg%>�������²�����');
	   removeCurrentTab();
	 </script>
<%
   }
%>
