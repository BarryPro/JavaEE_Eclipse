<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String owner_type = "";
	String contract_person = "";
	String contract_phone = "";
	String cust_name="";
	
		String ZSCustName11="";
	
	//String sql = "select owner_type,contact_person,contact_phone,cust_name from dcustdoc where cust_id="+gCustId;
%>

<!-- 2013/07/23 14:12:23 gaopeng ����BOSSϵͳ��ѯ�ͻ�������ع����Ż�������  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="40" >
      <wtc:param value="<%=sysAcceptl%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=nopass%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="����cust_id:[<%=gCustId%>]���в�ѯ"/>
      <wtc:param value="<%=gCustId%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
    
	<wtc:array id="resultGetCust2" scope="end" >
	</wtc:array>
<% 		
	System.out.println("------resultGetCust2.length-----------"+resultGetCust2.length);				
	if(resultGetCust2.length==0){
		System.out.println("------resultGetCust2.length is zero-----------");				
	}else{
		owner_type = resultGetCust2[0][10];
		contract_person = resultGetCust2[0][11];
		contract_phone = resultGetCust2[0][12];
		cust_name = resultGetCust2[0][5];
		System.out.println("owner_type in q001============="+owner_type);			
		System.out.println("cust_name in q001============="+cust_name);
		
					if(!("").equals(cust_name)) {
	
			if(cust_name.length() == 2 ){
				ZSCustName11 = cust_name.substring(0,1)+"*";
			}
			if(cust_name.length() == 3 ){
				ZSCustName11 = cust_name.substring(0,1)+"**";
			}
			if(cust_name.length() == 4){
				ZSCustName11 = cust_name.substring(0,2)+"**";
			}
			if(cust_name.length() > 4){
				ZSCustName11 = cust_name.substring(0,2)+"******";
			}
		}
		
	}
%>
 
<TABLE cellSpacing=0 id="userBaseInfoTab">
  <TR class=t2>
    <Td class="blue"  width="12%">�û���</Td>
    <TD><input type="hidden" name="userName" id="userName" class="required haveSpe" maxlength="50">
    	 <input type="text" name="userName11" id="userName11" class="required haveSpe" maxlength="50"> <font class="orange">*</font>
    	 <input type="hidden" name="userName22" id="userName22" class="required haveSpe" maxlength="50">  
    	 <input type="hidden" name="userName122" id="userName122" value="<%=cust_name%>" />  
    	</TD>
		<!--<td class="blue"  width="12%">��ϵ��</TD>
    <TD><input type="text" name="contactCustName" id="contactCustName" class="required" maxlength="15"> <font class="orange">*</font>  </TD>
		<TD class="blue" width="12%">��ϵ�绰</TD>
    <TD><input type="text" name="contactPhone" id="contactPhone" class="required andCellphone"> <font class="orange">*</font> </TD>
     ���û�����ϵ�˺���ϵ�绰���ƣ�������Դ���֣����Ҹ���Ϊ��װ��ϵ�ˣ���װ��ϵ�绰-->
		<TD class="blue" width="12%">������ </td>
 	  <TD>
			<select name="dealLevel" disabled >
				<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  			<wtc:sql>select trim(deal_level),level_name from sServOrderDealLevel</wtc:sql>
 	  		</wtc:pubselect>
	 			<wtc:array id="result_t2" scope="end"/>
				<% 
					for(int jjj=0;jjj<result_t2.length;jjj++){
					System.out.println("--------------result_t2["+jjj+"][0]------------"+result_t2[jjj][0]);
				%>
					<option value="<%=result_t2[jjj][0]%>"  ><%=result_t2[jjj][1]%></option>
					<%}%>
		
		</select>
	</TD>
		<TD class="blue" width="12%">�û����� </TD>
		<TD>
			<input type="text"  value="<%=groupId%>" name="userGroupName"  v_name="userGroupName"  v_must="1"  id="userGroupName" class="required" readonly>
			<input type="hidden" name="userGroupId" id="userGroupId" > <font class="orange">*</font>  
		</TD>	
	</TR>
	<TR class=t2>
		<jsp:include page="/npage/common/pwd_4977.jsp">
						  <jsp:param name="width1" value=""  />
						  <jsp:param name="width2" value=""  />
						  <jsp:param name="pname" value="userpwd"  />
						  <jsp:param name="pcname" value="userpwdcfm"  />
		</jsp:include>
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
		<TD class="blue">�������� </TD>
  	<TD>
			<select name="billModeCd" id="billModeCd"  >
				<option value="B">Ԥ����</option>
				<option value="A">�󸶷�</option>
			</select>
		</TD>
	</TR>
	<TR class=t2>
	  <TD class="blue">�û�����</TD>
	  <TD>
	  	<%
	  	String sqlUserType = "select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode  where REGION_CODE ='" + regionCode + "' and owner_code='00' order by OWNER_CODE"; 
	  	System.out.println("---------sqlUserType-----------------------------"+sqlUserType);	
	  	%>
			<select name="userType" id="userType">
				<wtc:qoption name="sPubSelect" outnum="2">
			    <wtc:sql><%=sqlUserType%></wtc:sql>	
			   </wtc:qoption>
			</select>
		</TD>  
		<TD class="blue">������ʽ </TD>
	  <TD>
			<select name="openType" id="openType">
				<option value="01">��ͨ����</option>
				<!--<option value="02">�����̷���</option>-->
			</select>
		</TD>
		<TD class="blue" style=display:none>͸֧��� </TD>
	  <TD style=display:none><input type="text" name="limitOwe" id="limitOwe" class="forReal" value="0" readonly /></TD>
	  <TD class="blue">�û�����</TD>
	  <TD>
	  	<input type="text" name="userType1" id="userType1"  value="����" readonly />
	  </TD>
	</TR>
 
	<TR class=t2>
		<TD class="blue" style=display:none >�Ƿ���Ź�ע </TD>
	  <TD style=display:none>
			<select name="addCmgr">
				<option value="Y">��</option>
				<option value="N" selected>��</option>
			</select>
		</TD>
		<TD class="blue" style=display:none>ԤռID</TD>
	  <TD style=display:none><input type="text" name="yzID" id="yzID"  value="" > </TD>
	</TR>

	<TR style=display:none >
				<TD  nowrap   class=blue >
			  	<div align="left">��������</div>
			  </TD>
				 <TD  nowrap  >
				  	<select name ="is_not_adward"  onchange="isnotawardhange()">
				 		 <option class='button' value='Y' >��</option>
				  	<option class='button' value='N' selected>��</option>
				  	</select>
				</TD> 
				<TD nowrap class=blue  width=15%> 
			  	<div align="left">���ͳ�ֵ��</div>
			  </TD>
				<TD nowrap  colspan="3"> 
					<select name ="largess_card" onchange="changelargesscard()">
					<option class='button' value='Y' >��</option>
					<option class='button' value='N' selected>��</option>
					</select>
       </TD> 
	</TR>
	<%@ include file="/npage/s1104/realUserInfo.jsp" %>
</TABLE>
<script>
		var owner_type = '<%=owner_type%>';
		if(owner_type == '01'||owner_type == '02')
		{
			document.all.userName.value = "<%=cust_name%>";//�����û�����
			document.all.userName11.value = "<%=ZSCustName11%>";
			document.all.userName22.value = "<%=ZSCustName11%>";
		}else{
			document.all.userName.value = "<%=cust_name%>";//�����û�����
			document.all.userName11.value = "<%=cust_name%>";
			document.all.userName22.value = "<%=cust_name%>";
		}
		document.getElementById("userType").disabled = true;//�û������û�
</script>