<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-11 ҳ�����,�޸���ʽ
     *
     ********************/
%>
	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ include file="/npage/common/serverip.jsp" %>
	<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
	<%@ page import="java.text.*"%>

<%
	 String opCode = "m058";
	 String opName = "ʵ���Ǽ�";	

  request.setCharacterEncoding("GBK");
	String retCode = "999999";
	String retMsg = "";
	 String ipAddr = realip; 
 
	String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String user_id=WtcUtil.repNull(request.getParameter("user_id"));
	String new_cus_id=WtcUtil.repNull(request.getParameter("new_cus_id"));
	String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
	String is_sPwdAuthChk_sel=WtcUtil.repNull(request.getParameter("is_sPwdAuthChk_sel"));
	
	String printAddFlag = WtcUtil.repNull(request.getParameter("printAddFlag"));
	String backCode = WtcUtil.repNull(request.getParameter("backCode"));
	
	System.out.println("---------------is_sPwdAuthChk_sel------------------->"+is_sPwdAuthChk_sel);
 %>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
 <%
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "m058";
	String nopass = (String)session.getAttribute("password");
	
		/*����������*/
	String responsibleName = WtcUtil.repStr(request.getParameter("responsibleName"),"");
	/*��������ϵ��ַ*/
	String responsibleAddr = WtcUtil.repStr(request.getParameter("responsibleAddr"),"");
	/*������֤������*/
	String responsibleType = WtcUtil.repStr(request.getParameter("responsibleType"),"");
	System.out.println("---------------responsibleType------------------->"+responsibleType);
	responsibleType = responsibleType.substring(0,responsibleType.indexOf("|"));
	/*������֤������*/
	String responsibleIccId = request.getParameter("responsibleIccId");
	
	/*�ļ���*/
	String serviceFileName = request.getParameter("serviceFileName");
	/*�ļ�ȫ·��*/
	String serviceFilePath = request.getParameter("serviceFilePath");
	
	
	String zerenrenstrss=responsibleType+"|"+responsibleIccId+"|"+responsibleName+"|"+responsibleAddr;		
	
	
	
	String paraStr[]=new String[57];	//20091201 fengry ��String[44]��ΪString[45]
	paraStr[0]=sLoginAccept;
 	paraStr[1]=op_code;
	paraStr[2]=work_no;
	paraStr[3]=nopass;
	paraStr[4]=org_code;
	paraStr[5]=user_id;
	paraStr[6]=new_cus_id; 

	paraStr[7] = request.getParameter("regionCode") + request.getParameter("districtCode") + "999";
	paraStr[8]= WtcUtil.repNull(request.getParameter("custName")); 
	String tmppwd = WtcUtil.repNull(request.getParameter("custPwd"));
	//paraStr[9]= WtcUtil.encrypt(tmppwd);
    paraStr[9]= Encrypt.encrypt(tmppwd);
	paraStr[10]=WtcUtil.repNull(request.getParameter("custStatus")); 
	paraStr[11]="00";//WtcUtil.repNull(request.getParameter("custGrade"));
	paraStr[12]=WtcUtil.repNull(request.getParameter("custAddr")); 	
	paraStr[13] = WtcUtil.repNull(request.getParameter("idType"));
	System.out.println("gaopeng============="+paraStr[13]);
	paraStr[13] = paraStr[13].substring(0,paraStr[13].indexOf("|"));    //֤�����ͣ�0-���֤
	paraStr[14]= WtcUtil.repNull(request.getParameter("idIccid")); 
	paraStr[15]=WtcUtil.repNull(request.getParameter("idAddr")); 
	paraStr[16]=WtcUtil.repNull(request.getParameter("idValidDate"));
	if(paraStr[16].compareTo("")==0)
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
		paraStr[16] = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(_tempDate);
	}
	paraStr[17]=WtcUtil.repNull(request.getParameter("contactPerson")); 
	paraStr[18]=WtcUtil.repNull(request.getParameter("contactPhone"));
	paraStr[19]=WtcUtil.repNull(request.getParameter("contactAddr"));
	paraStr[20] = WtcUtil.repNull(request.getParameter("contactPost"));
	if(paraStr[20].compareTo("")==0)
	{	paraStr[20] = " ";	}
	paraStr[21] = WtcUtil.repNull(request.getParameter("contactMAddr")); 	
	paraStr[22] = WtcUtil.repNull(request.getParameter("contactFax")); 
	if(paraStr[22].compareTo("")==0)
	{	paraStr[22] = " ";	}	
    paraStr[23] = WtcUtil.repNull(request.getParameter("contactMail")); 
	if(paraStr[23].compareTo("")==0)
	{	paraStr[23] = " ";	}
	paraStr[24]  = WtcUtil.repNull(request.getParameter("custSex"));  	//�ͻ��Ա�
	paraStr[25]  = WtcUtil.repNull(request.getParameter("birthDay")); //��������
	if(paraStr[25] .compareTo("") == 0)
	{
 	  if(paraStr[14].trim().length()==15 && paraStr[13].equals("0")) 
		paraStr[25] ="19"+paraStr[14].substring(6,8)+paraStr[14].substring(8,12);
	  else if(paraStr[14].trim().length()==18 && paraStr[13].equals("0")) 
        paraStr[25]=paraStr[14].substring(6,10)+paraStr[14].substring(10,14);
	  else
        paraStr[25]="19491001";
	} 
	paraStr[26] = WtcUtil.repNull(request.getParameter("professionId")); 
	paraStr[27] = WtcUtil.repNull(request.getParameter("vudyXl")); //ѧ��
	paraStr[28] = WtcUtil.repNull(request.getParameter("custAh")); //�ͻ����� 
	if(paraStr[28].length() == 0)
	{	paraStr[28] = "";	}
	paraStr[29] = WtcUtil.repNull(request.getParameter("custXg")); //�ͻ�ϰ��
	if(paraStr[29].compareTo("") == 0)
	{	paraStr[29] = "";	}

  paraStr[30]=WtcUtil.repNull(request.getParameter("oriHandFee"));
	paraStr[31]=WtcUtil.repNull(request.getParameter("t_handFee"));
  paraStr[32]=WtcUtil.repNull(request.getParameter("t_sys_remark"));
  paraStr[33]=WtcUtil.repSpac(request.getParameter("t_op_remark"));
	paraStr[34]=request.getRemoteAddr();
	paraStr[35]=WtcUtil.repNull(request.getParameter("assuName"));
	paraStr[36]=WtcUtil.repNull(request.getParameter("assuPhone"));
	paraStr[37]=WtcUtil.repNull(request.getParameter("assuIdType"));
	paraStr[38]=WtcUtil.repNull(request.getParameter("assuId"));
	paraStr[39]=WtcUtil.repNull(request.getParameter("assuIdAddr"));
	paraStr[40]=WtcUtil.repNull(request.getParameter("assuAddr"));
	paraStr[41]=WtcUtil.repNull(request.getParameter("assuNote"));
	/* update �������ȡ����ݲ��ɼ������������ϻ����½��ͻ���,Ĭ�ϴ�0 for ���ڹ��ֹ�˾�����Ż�M058ʵ���ƵǼ������������������ʾ@2015/2/11 */
	//paraStr[42]=WtcUtil.repNull(request.getParameter("xinYiDu"));
	paraStr[42]= "0";
	paraStr[43]=WtcUtil.repNull(request.getParameter("print_query"));
	//20091201 begin ����ʵ���Ǽ�������Ϣ��:�Ƿ�����ʵ���ǼǱ�־~����ʵ���Ǽ�ʱ��
	String GoodPhone_List = "";
	//String GoodPhoneFlag=WtcUtil.repNull(request.getParameter("GoodPhoneFlag"));
	//String GoodPhoneDate=WtcUtil.repNull(request.getParameter("GoodPhoneDate"));	
	//GoodPhone_List = GoodPhoneFlag + "~" + GoodPhoneDate + "~";
	paraStr[44]=GoodPhone_List;
	paraStr[45]=WtcUtil.repNull(request.getParameter("card2flag"));
	paraStr[48]=WtcUtil.repNull(request.getParameter("isJSX"));
	
	/*20131216 gaopeng 2013/12/16 16:01:31 ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭������Ϣ start*/
	/*����������*/
	String gestoresName = request.getParameter("gestoresName");
	/*��������ϵ��ַ*/
	String gestoresAddr = request.getParameter("gestoresAddr");
	/*������֤������*/
	String gestoresIdType = request.getParameter("gestoresIdType");
	gestoresIdType = gestoresIdType.substring(0,gestoresIdType.indexOf("|"));
	/*������֤������*/
	String gestoresIccId = request.getParameter("gestoresIccId");
	System.out.println("-----------gaopeng---------gestoresName------------------------------"+gestoresName);
	System.out.println("-----------gaopeng---------gestoresAddr------------------------------"+gestoresAddr);
	System.out.println("-----------gaopeng---------gestoresIdType------------------------------"+gestoresIdType);
	System.out.println("-----------gaopeng---------gestoresIccId------------------------------"+gestoresIccId);
	
	paraStr[49] = gestoresName;
	paraStr[50] = gestoresAddr;
	paraStr[51] = gestoresIdType;
	paraStr[52] = gestoresIccId;
	
	/*20131216 gaopeng 2013/12/16 16:01:31 ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭������Ϣ end*/

	/*ʵ��ʹ��������*/
	String realUserName = WtcUtil.repStr(request.getParameter("realUserName"),"");
	/*ʵ��ʹ���˵�ַ*/
	String realUserAddr = WtcUtil.repStr(request.getParameter("realUserAddr"),"");
	/*ʵ��ʹ����֤������*/
	String realUserIccId = WtcUtil.repStr(request.getParameter("realUserIccId"),"");
	/*ʵ��ʹ����֤������*/
	String realUserIdType = WtcUtil.repStr(request.getParameter("realUserIdType"),"");

	paraStr[53] = realUserIdType;
	paraStr[54] = realUserIccId;
	paraStr[55] = realUserName;
	paraStr[56] = realUserAddr;




	//20091201 end
   for(int i = 0; i<paraStr.length; i++)
   	
		/*@service information
		 *@name                                         s1238Cfm
		 *@description                      ʵ���Ǽ�
		 *@author                                       lixg
		 *@created                                      20031208 08:52:1
		 *@input parameter information
		 *@inparam0     loginAccept             ��ˮ    �������룬������������ڷ�����ȡ��ˮ
		 *@inparam1     opCode                  ���ܴ���
		 *@inparam2     loginNo                 ��������
		 *@inparam3     loginPasswd             ��������
		 *@inparam4     orgCode                 �������Ź���
		 *@inparam5     idNo                    �û�ID
		 *@inparam6     newCustID               �¿ͻ�ID-
		 *--------------------------------------------------------------*
		 *@inparam7     vNOrg                   �¿ͻ���������
		 *@inparam8     vNName                  �¿ͻ�����
		 *@inparam9     vNPwd                   �¿ͻ�����
		 *@inparam10    vNStatus                �¿ͻ�״̬
		 *@inparam11    vNGrade                 �¿ͻ�����
		 *@inparam12    vNHomeAddr              �¿ͻ���ַ
		 *@inparam13    vNIdType                �¿ͻ�֤������
		 *@inparam14    vNIdNum                 �¿ͻ�֤������
		 *@inparam16    vNIdDate                �¿ͻ�֤����Ч��
		 *@inparam17    vNConName               �¿ͻ���ϵ������
		 *@inparam18    vNConTel                �¿ͻ���ϵ�˵绰
		 *@inparam19    vNConAddr               �¿ͻ���ϵ�˵�ַ
		 *@inparam20    vNConPostNum            �¿ͻ���ϵ���ʱ�
		 *@inparam21    vNConPostAddr           �¿ͻ���ϵ��ͨѶ��ַ
		 *@inparam22    vNConFax                �¿ͻ���ϵ�˴���
		 *@inparam23    vNConEMail              �¿ͻ���ϵ�˵�������
		 *@inparam24    vNSex                   �¿ͻ��Ա�
		 *@inparam25    vNBirth                 �¿ͻ���������
		 *@inparam26    vNWork                  �¿ͻ�ְҵ����
		 *@inparam27    vNEduLevel              �¿ͻ�ѧ��
		 *@inparam28    vNLove                  �¿ͻ�����
		 *@inparam29    vNHabit                 �¿ͻ�ϰ��
		 *--------------------------------------------------------------*
		 *@inparam30    payFee                  Ӧ��
		 *@inparam31    realFee                 ʵ��
		 *@inparam32    systemNote              ϵͳ��ע
		 *@inparam33    opNote                  �û���ע
		 *@inparam34    ipAddr                  IP��ַ
		 *--------------------------------------------------------------*
		 *@inparam35    cust_name               ����������
		 *@inparam36    contact_phone   ��������ϵ�绰
		 *@inparam37    id_type                 ������֤������
		 *@inparam38    id_iccid                ������֤������
		 *@inparam39    id_address              ������֤����ַ
		 *@inparam40    contact_address ��������ϵ��ַ
		 *@inparam41    notes                   ������ע
		 *@inparam43    �Ƿ������ѯ�굥
		 *@inparam44    ����ʵ���Ǽ�������Ϣ�� 20091201 add by fengry
		 *@inparam45    �Ƿ�ɹ�ɨ��
		 *--------------------------------------------------------------*
		
		 *@output parameter information
		 *@outparam     loginAccept             ��ˮ    �����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO
		 */

    //SPubCallSvrImpl im1210=new SPubCallSvrImpl();
    //String[] fg=im1210.callService("s1238Cfm", paraStr,"2");
    
%>
		<wtc:service name="sm389Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="errCode" retmsg="errMsg" outnum="4" >
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
		<wtc:param value="<%=paraStr[44]%>"/>		<!-- 20091201 add by fengry -->						 	
		<wtc:param value="<%=paraStr[45]%>"/>		<!-- 20131021 add by zhangyan -->
		<%	
			  String loginacceptJTrc=WtcUtil.repNull(request.getParameter("loginacceptJT"));
		    String pinjiecanshu="";
          if(!"".equals(loginacceptJTrc)) {
          pinjiecanshu="1";
          }else {
          pinjiecanshu="";
        	}
        	
    /*��ѡ��λ����ʱ,�ٴ�ֵ*/
    	if(paraStr[48].equals("1")){
	    	//String inputStr11 = paraStr[49]+"|"+paraStr[51]+"|"+paraStr[52]+"|"+paraStr[50];
	    	String inputStr11 = paraStr[49]+"|"+paraStr[51]+"|"+paraStr[52]+"|"+paraStr[50]+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|" +is_sPwdAuthChk_sel+"|"+zerenrenstrss+"|01|";
    %>
    
      <wtc:param value="<%=inputStr11%>"/>
    <%
    	}else{
    		String inputStr22 = ""+"|"+""+"|"+""+"|"+""+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|"+is_sPwdAuthChk_sel+"|"+"|"+"|"+"|"+"|01|";
    %>	
    	<wtc:param value="<%=inputStr22%>"/>
    <%	
    	}
    %>				
    
		
		<wtc:param value="<%=serviceFileName%>"/>
		<wtc:param value="<%=serviceFilePath%>"/>
		<wtc:param value="<%=ipAddr%>"/>
						 	
		</wtc:service>
		<wtc:array id="result1" start="0" length="2" scope="end" />
		<wtc:array id="result2" start="2" length="2" scope="end" />
			
		<%
			/*
				transOUT = Add_Ret_Value(GPARM32_0,iPhoneNo);--�����ֻ�����
				transOUT = Add_Ret_Value(GPARM32_1,oRetMsg);--������Ϣ
				transOUT = Add_Ret_Value(GPARM32_2,tmp_buf);   �ɹ�����
				transOUT=Add_Ret_Value(GPARM32_3,loginAccept);--������ˮ
			
			
			*/
		
		%>
<%
System.out.println("=========================errCode================================   "+errCode);

if(errCode.equals("000000")){

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	
</script>
</head>
<body>
<form name="form1" id="form1" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div>
	<div class="title">
		<div id="title_zi">��λ����ʵ���Ǽ�-�������</div>
	</div>
			<table>

			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>������ˮ</td>
				<td><%=result2[0][1]%>&nbsp;&nbsp<font class="orange">����ˮ������m390�����ѯ  ��ѯʹ��</font></td>
			</tr>

		</table>
		<table>
			<%if(errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">����ɹ��ĺ��������<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>�ֻ�����</th>
				<th>ʧ��ԭ��</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>

		</table>
	<table cellspacing="0">
  <tr>
  	<td id="footer" colspan="3">
  		<input type="button" name="back" class="b_foot" value="�ر�" onClick="removeCurrentTab()"  >
  	</td>
  </tr>
  </table>
	</div>
    <%@ include file="/npage/include/footer.jsp"%>
   </form>
</body>
<%
} else {
	%>
	<script language="javascript">
		rdShowMessageDialog("����ʧ�ܣ��������<%=errCode%>,����ԭ��<%=errMsg%>.");
		removeCurrentTab();
	</script>
	<%
}
%>

