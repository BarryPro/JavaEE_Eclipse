<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �ͻ���������1231/�޸�1230
   * �汾: 1.0
   * ����: 2009/1/14
   * ����: zhanghonga
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/common/pwd_comm.jsp" %>	
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�ͻ������޸�</title>
<%
    //comImpl co=new comImpl();
    String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
	String activePhone1=(String)request.getParameter("activePhone1")==null?"":(String)request.getParameter("activePhone1");
	
 	String dWorkNo = (String)session.getAttribute("workNo");				//��������
	String dNopass = (String)session.getAttribute("password");				//��������
    String loginName = (String)session.getAttribute("workName");			//����
    String org_code = (String)session.getAttribute("orgCode");				//��������
    String regionCode = (String)session.getAttribute("regCode");			//�������
	String[][] temfavStr=(String[][])session.getAttribute("favInfo");		//�Ż�Ȩ����Ϣ
	String opType=(String)request.getParameter("opType");					//��������
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	favStr[i]=temfavStr[i][0];
	String op_code = "1230";
	//=======================��ò�����ˮ
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%	
		//---------------�����ύҳ�������������-----------------------------
    	String ReqPageName=request.getParameter("ReqPageName");

 		//------------------�������------------------------------------------
 		String cus_id=WtcUtil.repNull(request.getParameter("cus_id"));
 		 if(cus_id.equals(""))
		{
				%> 
	    <script language="javascript">
 	      window.location="f1230.jsp?ReqPageName=main&retMsg=1";
 	  </script>
 	  <%
		}

		/**ȡ��������Ϣ�����￪ʼ**/
		String [] handFeeSqlArr = new String[2];
		handFeeSqlArr[0] = "select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=:regionCode and function_code=:functionCode";
		handFeeSqlArr[1] = "regionCode="+regionCode+",functionCode="+opCode;
%>
		<wtc:service name="TlsPubSelCrm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="handFeeRetCode" retmsg="handFeeRetMsg">
		<wtc:param value="<%=handFeeSqlArr[0]%>"/>
		<wtc:param value="<%=handFeeSqlArr[1]%>"/> 
		</wtc:service>
		<wtc:array id="handFeeArr" scope="end"/>
<%		
		boolean hfrf=false;
		String handFee = "";
		String favourCode = "";
		
		if(handFeeRetCode.equals("000000")){
			if(handFeeArr.length>0){
				handFee = handFeeArr[0][0].trim();
				favourCode = handFeeArr[0][1].trim();
				
				if(handFee.equals("")||handFee.equals("0")){
					hfrf=true;
				}else if(!WtcUtil.haveStr(favStr,favourCode)){
					hfrf=true;		
				}
			}
		}
		/**ȡ��������Ϣ���������**/
%>		
		
<%		
		/**ȡ�ͻ�������Ϣ-->�󶨱����Ĳ�ѯ��������,����û�ð󶨱��������**/
		String custAddInfoSql = "SELECT B.SEX_NAME, TO_CHAR (BIRTHDAY, 'YYYYMMDD'), TRIM(PROFESSION_NAME),TRIM (D.TYPE_NAME), TRIM (CUST_LOVE), TRIM (CUST_HABIT) FROM DCUSTDOCINADD A,SSEXCODE B,SPROFESSIONID C,SWORKCODE D WHERE CUST_ID = '"+cus_id+"' AND A.CUST_SEX = B.SEX_CODE AND A.PROFESSION_ID = C.PROFESSION_ID AND D.REGION_CODE = '"+regionCode+"'  AND A.EDU_LEVEL = D.WORK_CODE";;
%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="6" retcode="custAddInfoRetCode" retmsg="custAddInfoRetMsg">
			<wtc:sql><%=custAddInfoSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="custAddInfoArr" scope="end" />		
			
<%
		String sexName = "";							//�ͻ��Ա�
		String birthDay = "";							//��������
		String professionName= "";						//ְҵ����
		String eduLevel = "";							//ѧ��
		String custLove = "";							//�ͻ�����
		String custHabit = "";							//�ͻ�ϰ��
		if(custAddInfoRetCode.equals("000000")){
			if(custAddInfoArr.length>0){
				sexName = custAddInfoArr[0][0];  
				birthDay = custAddInfoArr[0][1]; 
				professionName = custAddInfoArr[0][2];
				eduLevel = custAddInfoArr[0][3]; 
				custLove = custAddInfoArr[0][4]; 
				custHabit = custAddInfoArr[0][5];
			}
		}
		
		/**�������
		for(int i=0;i<custAddInfoArr.length;i++){
			for(int j=0;j<custAddInfoArr[i].length;j++){
				System.out.println("################-->"+custAddInfoArr[i][j]);
			}
		}
		**/
		/**ȡ�ͻ�������Ϣ���������**/
%>
		
<%
		/**ȡ�ͻ���Ҫ��Ϣ:��дim.getCustDoc(cus_id,op_code,"region",org_code.substring(0,2))����**/		
		//ArrayList custDoc=im.getCustDoc(cus_id,op_code,"region",org_code.substring(0,2));
		/**		
		StringBuffer sq1 = new StringBuffer();
		sq1.append("select a.CUST_ID,a.REGION_CODE,a.DISTRICT_CODE,a.TOWN_CODE");
		sq1.append(",a.CUST_NAME,a.CUST_PASSWD,a.CUST_STATUS");
		sq1.append(",a.OWNER_GRADE,a.OWNER_TYPE,a.CUST_ADDRESS,a.ID_TYPE");
		sq1.append(",a.ID_ICCID,a.ID_ADDRESS,to_char(a.ID_VALIDDATE,'YYYYMMDD'),a.CONTACT_PERSON");
		sq1.append(",a.CONTACT_PHONE,a.CONTACT_ADDRESS,a.CONTACT_POST");
		sq1.append(",a.CONTACT_MAILADDRESS,a.CONTACT_FAX,a.CONTACT_EMAILL");
		sq1.append(",c.region_name from dcustdoc a,sRegionCode c where a.region_code=c.region_code and ");
		sq1.append("a.cust_id=");
		sq1.append(cus_id);
		**/
%>
	<wtc:service name="sCust1230Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="dcustDocInfoRetCode" retmsg="dcustDocInfoRetMsg" outnum="100" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=dWorkNo%>"/>	
    <wtc:param value="<%=dNopass%>"/>		
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value="<%=cus_id%>"/>
    <wtc:param value="<%=regionCode%>"/>
  </wtc:service>
  <wtc:array id="custDoc" scope="end"/>
<%		
    	if(custDoc==null||custDoc.length==0)
		{
			System.out.println("δ��ȡ���κοͻ���Ϣ");
		%>
	    <script language="javascript">
 	      window.location="f1230.jsp?ReqPageName=main&retMsg=2";
 	  </script>
 	  <%
		}
		
		/**ȡ�ͻ���Ҫ��Ϣ:��дim.getCustDoc(cus_id,op_code,"region",org_code.substring(0,2))�������������**/		
%>

<%
		/**��дim.s1210Index(cus_id,"region",init_region_code)����**/		 
		//String[] twoFlag=im.s1210Index(cus_id,"region",init_region_code);
		String[] paramIn = new String[2];
		paramIn[0] = "select trim(attr_code) from dcustMsg where cust_id=:cus_id  and substr(run_code,2,1)<'a' and rownum<2";
		paramIn[1] = "cust_id="+cus_id;
%>
		<wtc:service name="TlsPubSelCrm"  outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="attrCode" retmsg="attrMsg">
		<wtc:param value="<%=paramIn[0]%>"/>
		<wtc:param value="<%=paramIn[1]%>"/> 
		</wtc:service>
		<wtc:array id="fStr" scope="end"/>
<%		
		String temFlag = "";
		if(attrCode.equals("000000")){
			if(fStr.length==0){
				temFlag = "00000";
			}else{
				temFlag = fStr[0][0];	
			}
		}
		
		if(!temFlag.equals("")){
			String bigFlag = temFlag.substring(2, 4);
			String grpFlag = temFlag.substring(4, 5);
			
			String [] bigFalgSqlArr = new String[2];
			bigFalgSqlArr[0] = "select trim(card_name) from sBigCardCode where card_type=:bigFlag";
			bigFalgSqlArr[1] = "bigFlag="+bigFlag;
			
			String [] grpFlagSqlArr = new String[2];
			grpFlagSqlArr[0] = "select trim(grp_name) from sGrpBigFlag where grp_flag=:grpFlag";
			grpFlagSqlArr[1] = "grpFlag="+grpFlag;
%>
			<wtc:service name="TlsPubSelCrm"  outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="bigFlagCode" retmsg="bigFlagMsg">
			<wtc:param value="<%=bigFalgSqlArr[0]%>"/>
			<wtc:param value="<%=bigFalgSqlArr[1]%>"/> 
			</wtc:service>
			<wtc:array id="bigFlagArr" scope="end"/>	
				
			<wtc:service name="TlsPubSelCrm"  outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="grpFlagCode" retmsg="grpFlagMsg">
			<wtc:param value="<%=grpFlagSqlArr[0]%>"/>
			<wtc:param value="<%=grpFlagSqlArr[1]%>"/> 
			</wtc:service>
			<wtc:array id="grpFlagArr" scope="end"/>		
<%	
			String [] twoFlag = new String[2];
			if(bigFlagCode.equals("000000")){
				if(bigFlagArr.length>0){
					twoFlag[0] = bigFlagArr[0][0];
				}
			}
			
			if(grpFlagCode.equals("000000")){
				if(grpFlagArr.length>0){
					twoFlag[1] = grpFlagArr[0][0];
				}
			}
			
			if(twoFlag.length==0){
				System.out.println("δ��ȡ���û�һЩ�ؼ��Ļ�����Ϣ");
								%>
	    <script language="javascript">
 	      window.location="f1230.jsp?ReqPageName=main&retMsg=2";
 	  </script>
 	  <%
			}		
		}
		/**��дim.s1210Index(cus_id,"region",init_region_code)�������������**/	
%>		

<%
		if(request.getParameter("ReqPageName").equals("f1230"))
		{
          String passTrans=WtcUtil.repNull(request.getParameter("cus_pass"));
		  if(!passTrans.equals(""))
		  {
			String passFromPage=Encrypt.encrypt(passTrans);
//2010-8-20 15:51 wanghfa�޸� ������֤�޸� start
%>
		<script language=javascript>
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType","02");					//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo","<%=cus_id%>");	//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd","<%=passFromPage%>");	//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType","en");					//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum","");						//����
			checkPwd_Packet.data.add("loginNo","<%=loginName%>");		//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
			
			function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					rdShowMessageDialog(msg);
					window.location="f1230.jsp?activePhone1=<%=activePhone1%>";
				}
			}
		</script>
<%
/*
				if(0==Encrypt.checkpwd2(((String)custDoc[0][5]).trim(),passFromPage)){
					response.sendRedirect("f1230.jsp?ReqPageName=main&retMsg=3");
					return;
				}
*/
//2010-8-20 15:51 wanghfa�޸� ������֤�޸� end
		     
		  }
		}

	String pageOpCode = "1230";
	if(Integer.parseInt(opType) == 1)
	{
		pageOpCode = "1231";
	}
%>

<script language=javascript>
	var printFlag=9;
  function doProcess(packet)
  {
	var backString = packet.data.findValueByName("backString");
	var errMsg = packet.data.findValueByName("errMsg");
	var errCode = packet.data.findValueByName("errCode"); 
	var errCodeInt = parseInt(errMsg,10);
		
		if(errMsg==0){
			document.frm.backLoginAccept.value=backString[0][0];
			if(document.all.opCode.value == "1230")
			{
				rdShowMessageDialog("�ͻ������޸ĳɹ�!");
			}else
			{
				rdShowMessageDialog("�ͻ��������óɹ�!");
			}
			if(document.frm.t_handFee.value!=0){
				printBill();
			}
			else{
				window.location="f1230.jsp";
			
			}
		}else{
		    rdShowMessageDialog(errMsg);
			window.location="f1230.jsp";
		}
  }
function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.t_handFee;
    var fact=document.all.t_factFee;
    var few=document.all.t_fewFee;
    if(jtrim(fact.value).length==0)
    {
	  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
	  fact.value="";
	  fact.focus();
	  return;
    }
    if(parseFloat(fact.value)<parseFloat(fee.value))
    {
  	  rdShowMessageDialog("ʵ�ս��㣡");
	  fact.value="";
	  fact.focus();
	  return;
    }

	var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
	var tem2=tem1;
	if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
    few.value=(tem2/100).toString();
    few.focus();
  }
}

//----------------------------------------------------ȷ�Ϸ���---------------------------
function submitt(){
	getAfterPrompt();
		if(document.frm.t_new_pass.value!=document.frm.t_conf_pass.value){
			rdShowMessageDialog("������������벻һ�£�");
			return;
		}
		if(document.frm.t_new_pass.value.length==0){
			rdShowMessageDialog("�����벻��Ϊ�գ�");
			return;
		}
		if(!forNonNegInt(document.frm.t_new_pass)){
			return;
		}
		if(document.frm.t_op_remark.value.length==0){
			document.frm.t_op_remark.value="�ͻ�������";
		}
		checkPwdEasy(document.frm.t_new_pass.value);	//2010-8-13 9:34 wanghfa��� �ͻ�������������
}

//2010-8-9 8:43 wanghfa��� ��֤������ڼ� start
function checkPwdEasy(pwd) {
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("custId", "<%=cus_id%>");
	checkPwd_Packet.data.add("opCode", "<%=opCode%>");

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}

function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");

	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "0") {
		printCommit();
		if(printFlag!=1){
			return;
		}
		document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("submit.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("nopass",document.frm.nopass.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("opType",document.frm.opType.value);
		myPacket.data.add("opFlag",document.frm.opFlag.value);
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("idNo",document.frm.idNo.value);
		myPacket.data.add("payFee",document.frm.payFee.value);
		myPacket.data.add("realFee",document.frm.t_handFee.value);
		myPacket.data.add("ipAddr",document.frm.selfIpAddr.value);
		myPacket.data.add("oldPass",document.frm.oldPass.value);		
		myPacket.data.add("newPass",document.frm.t_new_pass.value);
		myPacket.data.add("systemRemark","systemRemark");
		myPacket.data.add("remark",document.frm.t_op_remark.value);

    	core.ajax.sendPacket(myPacket);
    	myPacket=null;
	}
}



</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<input type="hidden" name="cus_id" id="cus_id" value="<%=cus_id%>">
<input type="hidden" name="region_code" id="region_code" value="<%=((String)custDoc[0][1]).trim()%>">
<input type="hidden" name="cust_name" id="cust_name" value="<%=(String)custDoc[0][4]%>">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="main">
<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=handFee%>">
  <input type="hidden" name="oldPass" id="oldPass" value="<%=((String)custDoc[0][5]).trim()%>">
<%@ include file="/include/remark.htm" %>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
<table cellspacing="0">
	<tr id=showHideTr>
		<jsp:include page="/npage/common/pwd_2.jsp">
			<jsp:param name="width1" value="16%"  />
			<jsp:param name="width2" value="34%"  />
			<jsp:param name="pname" value="t_new_pass"  />
			<jsp:param name="pcname" value="t_conf_pass"  />
		</jsp:include>
		<td class="blue" nowrap>�ͻ�����</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_cus_name" id="t_cus_name" size="16" value="<%=(String)custDoc[0][4]%>" v_minlength=1 v_maxlength=60 v_type=string>
		</td>
	</tr>                
	<tr>
		<td class="blue" nowrap>�ͻ���������</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_region" id="t_region" size="16" value="<%=(String)custDoc[0][21]%>" readonly>
		</td>
		<td class="blue" nowrap>��������</td>
		<td>
			<input type="text" name="s_city" id="s_city" value="<%=(String)custDoc[0][2]%>" class="InputGrey" readOnly>
		</td>
		<td class="blue" nowrap>��������</td>
		<td colspan="5">
			<input type="text" name="s_spot" id="s_spot" value="<%=(String)custDoc[0][3]%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>�ͻ�״̬</td>
		<td>
			<input type="text" name="s_cus_status" value="<%=(String)custDoc[0][6]%>" class="InputGrey" readOnly>
		</td>
		<td class="blue" nowrap>�ͻ�����</td>
		<td>
			<input type="text" name="s_cus_level" value="<%=(String)custDoc[0][7]%>" class="InputGrey" readOnly>
		</td>
		<td class="blue" nowrap>�ͻ����</td>
		<td>
			<input type="text" name="s_cus_type"  value="<%=(String)custDoc[0][8]%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>�ͻ���ַ</td>
		<td>
			<input type="text" class="InputGrey" name="t_cus_address" id="t_cus_address" size="16" value="<%=(String)custDoc[0][9]%>" v_minlength=1 v_maxlength=60 v_type=string class="InputGrey" readOnly >
		</td>
		<td class="blue" nowrap>֤������</td>
		<td>
			<input type="text" name="s_idtype"  value="<%=(String)custDoc[0][10]%>" class="InputGrey" readOnly >
		</td>
		<td class="blue" nowrap>֤������</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_idno" id="t_idno" size="16" value="<%=(String)custDoc[0][11]%>" v_minlength=1 v_maxlength=20 v_type=int>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>֤����ַ</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_id_address" id="t_id_address" size="16" value="<%=(String)custDoc[0][12]%>" v_minlength=1 v_maxlength=60 v_type=string>
		</td>
		<td class="blue" nowrap>֤����Ч��</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_id_valid" id="t_id_valid" size="16" value="<%=(String)custDoc[0][13]%>" v_minlength=1 v_maxlength=8 v_type=date>
		</td>
		<td class="blue" nowrap>��ϵ������</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_comm_name" id="t_comm_name" size="16" value="<%=(String)custDoc[0][14]%>" v_minlength=1 v_maxlength=20 v_type=string>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>��ϵ�˵绰</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_comm_phone" id="t_comm_phone" size="16" value="<%=(String)custDoc[0][15]%>" v_minlength=1 v_maxlength=20 v_type=phone>
		</td>
		<td class="blue" nowrap>��ϵ�˵�ַ</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_comm_address" id="t_comm_address" size="16" value="<%=(String)custDoc[0][16]%>" v_minlength=1 v_maxlength=20 v_type=string>
		</td>
		<td class="blue" nowrap>��ϵ���ʱ�</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_comm_postcode" id="t_comm_postcode" size="16" value="<%=(String)custDoc[0][17]%>" v_minlength=1 v_maxlength=6 v_type=zip>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>��ϵ��ͨѶ��ַ</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_comm_comm" id="t_comm_comm" size="16" value="<%=(String)custDoc[0][18]%>" v_minlength=1 v_maxlength=60 v_type=string>
		</td>
		<td class="blue" nowrap>��ϵ�˴���</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_comm_fax" id="t_comm_fax" size="16" value="<%=(String)custDoc[0][19]%>" v_minlength=1 v_maxlength=30 v_type=phone>
		</td>
		<td class="blue" nowrap>��ϵ��EMAIL</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_comm_email" id="t_comm_email" size="16" value="<%=(String)custDoc[0][20]%>"  v_type=email>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>�ͻ��Ա�</td>
		<td>
			<input type="text" name="s_cus_sex" value="<%=sexName%>" class="InputGrey" readonly>
		</td>
		<td class="blue" nowrap>��������</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_birth" id="t_birth" size="16" value="<%=birthDay%>" v_minlength=1 v_maxlength=8 v_type=date>
		</td>
		<td class="blue" nowrap>ְҵ����</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="s_busi_type" value="<%=professionName%>"  >
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>ѧ��</td>
		<td>
			<input type="text" class="InputGrey" name="s_edu" value="<%=eduLevel%>" readOnly >
		</td>
		<td class="blue" nowrap>�ͻ�����</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_cus_love" id="t_cus_love" size="16" value="<%=custLove%>" v_minlength=1 v_maxlength=20 v_type=string>
		</td>
		<td class="blue" nowrap>�ͻ�ϰ��</td>
		<td>
			<input type="text" class="InputGrey" readOnly name="t_cus_habit" id="t_cus_habit" size="16" value="<%=custHabit%>" v_minlength=1 v_maxlength=20 v_type=string>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>������</td>
		<td>
			<input type="text" class="button" index="3" name="t_handFee" id="t_handFee" size="16" value="0.00" v_type=float <%if(hfrf){%>readonly<%}%>>
		</td>
		<td class="blue" nowrap>ʵ��</td>
		<td>
			<input type="text" class="button" index="4" name="t_factFee" id="t_factFee" size="16" onKeyUp="getFew()" v_type=float <%if(hfrf){%>readonly<%}%>>
		</td>
		<td class="blue" nowrap>����</td>
		<td>
			<input type="text" class="InputGrey" name="t_fewFee" id="t_fewFee" size="16" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>ϵͳ��ע</td>
		<td nowrap colspan="5">
			<input type="text" class="InputGrey" name="t_sys_remark" id="t_sys_remark" size="45" readonly>
		</td>
	</tr>
	<tr style="display:none">
		<td class="blue" nowrap>�û���ע</td>
		<td nowrap colspan="5">
			<input type="text" class="button" index="5" name="t_op_remark" id="t_op_remark" size="45" v_minlength=1 v_maxlength=60  v_type=string>
		</td>
	</tr>
</table>
<!-- ningtn 2011-7-12 08:33:59 ������ӹ��� -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
	<jsp:param name="sopcode" value="<%=pageOpCode%>"  />
</jsp:include>
<table>
	<tr>
		<td align="center" colspan="6" id="footer">
			<input class="b_foot" type="button" name="submit" value="ȷ��" onClick="submitt()" index="6" onKeyUp="if(event.keyCode==13){submitt()}">
			<input class="b_foot" type="button" name="b_clear" value="���" onClick="document.frm.t_new_pass.value='';document.frm.t_conf_pass.value='';document.frm.submit.disabled=false;">
			<input class="b_foot" type="button" name="b_back" value="�ر�" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
<input type=hidden name=loginAccept value="<%=printAccept%>">
<input type=hidden name=opCode value="<%=pageOpCode%>">
<input type=hidden name=workNo value="<%=dWorkNo%>">
<input type=hidden name=nopass value="<%=dNopass%>">
<input type=hidden name=orgCode value="<%=org_code%>">
<input type=hidden name=opType value="<%=opType%>">
<input type=hidden name=opFlag value="0">
<input type=hidden name=idNo value="<%=cus_id%>">
<input type=hidden name=payFee value="<%=handFee%>">
<input type=hidden name=selfIpAddr value="<%=request.getRemoteAddr()%>">
<input type=hidden name=backLoginAccept>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!-- ningtn 2011-7-12 08:35:36 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
<script language="javascript">
function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //��ʾ��ӡ�Ի��� 
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

    var pType="print";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode=<%=pageOpCode%> ;                   			 		//��������
	var phoneNo="";                  	 		//�ͻ��绰
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfn+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
	ret="confirm";
   if(typeof(ret)!="undefined")
   {
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {
       if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
       {
       	printFlag=1;
       }
     }
   }
}

function printInfo(printType)
{
    var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	
	var doType="";
	if(document.all.opType.value==0){
			doType="�޸�����";
		}else{
			doType="��������";
			}
    if(printType == "Detail")
    {
 		  note_info1+='<%=dWorkNo%> <%=loginName%>'+"|";
		  note_info2+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	      cust_info+="�ͻ�������" +document.all.cust_name.value+"|";
	      cust_info+="�ֻ����룺"+document.all.t_comm_phone.value+"|";
	      cust_info+="�ͻ���ַ��"+document.all.t_cus_address.value+"|";
	      cust_info+="֤�����룺"+document.all.t_idno.value+"|";

		  opr_info+="����ҵ��"+doType+"  ������ˮ��"+"<%=printAccept%>"+"|";
		  opr_info+="�ͻ����ƣ�"+document.all.cust_name.value+"  �ͻ�ID��"+"<%=cus_id%>"+"|";

	  
    }  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
    }
    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;		
}
</script>
<script>
function printBill(){
	 var infoStr="";                                                                         
	     infoStr+=" "+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+=document.frm.t_comm_phone.value+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+=document.frm.cust_name.value+"|";//�û�����                                                
	 infoStr+=document.frm.t_cus_address.value+"|";//�û���ַ 
	 infoStr+="�ֽ�"+"|";
		 infoStr+=document.frm.t_handFee.value+"|";                                                
	 infoStr+="�ͻ������޸ġ�*�����ѣ�"+document.frm.t_handFee.value+"*��ˮ�ţ�"+document.frm.backLoginAccept.value+"|";
	 location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f1230.jsp";                    
}
</script>
</html>
