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

<!-- 2013/07/23 14:12:23 gaopeng 关于BOSS系统查询客户资料相关功能优化的需求  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="40" >
      <wtc:param value="<%=sysAcceptl%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=nopass%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="根据cust_id:[<%=gCustId%>]进行查询"/>
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
    <Td class="blue"  width="12%">用户名</Td>
    <TD><input type="hidden" name="userName" id="userName" class="required haveSpe" maxlength="50">
    	 <input type="text" name="userName11" id="userName11" class="required haveSpe" maxlength="50"> <font class="orange">*</font>
    	 <input type="hidden" name="userName22" id="userName22" class="required haveSpe" maxlength="50">  
    	 <input type="hidden" name="userName122" id="userName122" value="<%=cust_name%>" />  
    	</TD>
		<!--<td class="blue"  width="12%">联系人</TD>
    <TD><input type="text" name="contactCustName" id="contactCustName" class="required" maxlength="15"> <font class="orange">*</font>  </TD>
		<TD class="blue" width="12%">联系电话</TD>
    <TD><input type="text" name="contactPhone" id="contactPhone" class="required andCellphone"> <font class="orange">*</font> </TD>
     将用户的联系人和联系电话下移，放在资源部分，并且改名为安装联系人，安装联系电话-->
		<TD class="blue" width="12%">处理级别 </td>
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
		<TD class="blue" width="12%">用户归属 </TD>
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
		<TD class="blue">付费类型 </TD>
  	<TD>
			<select name="billModeCd" id="billModeCd"  >
				<option value="B">预付费</option>
				<option value="A">后付费</option>
			</select>
		</TD>
	</TR>
	<TR class=t2>
	  <TD class="blue">用户级别</TD>
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
		<TD class="blue">入网方式 </TD>
	  <TD>
			<select name="openType" id="openType">
				<option value="01">普通开户</option>
				<!--<option value="02">分销商返单</option>-->
			</select>
		</TD>
		<TD class="blue" style=display:none>透支额度 </TD>
	  <TD style=display:none><input type="text" name="limitOwe" id="limitOwe" class="forReal" value="0" readonly /></TD>
	  <TD class="blue">用户类型</TD>
	  <TD>
	  	<input type="text" name="userType1" id="userType1"  value="个人" readonly />
	  </TD>
	</TR>
 
	<TR class=t2>
		<TD class="blue" style=display:none >是否短信关注 </TD>
	  <TD style=display:none>
			<select name="addCmgr">
				<option value="Y">是</option>
				<option value="N" selected>否</option>
			</select>
		</TD>
		<TD class="blue" style=display:none>预占ID</TD>
	  <TD style=display:none><input type="text" name="yzID" id="yzID"  value="" > </TD>
	</TR>

	<TR style=display:none >
				<TD  nowrap   class=blue >
			  	<div align="left">入网有礼活动</div>
			  </TD>
				 <TD  nowrap  >
				  	<select name ="is_not_adward"  onchange="isnotawardhange()">
				 		 <option class='button' value='Y' >是</option>
				  	<option class='button' value='N' selected>否</option>
				  	</select>
				</TD> 
				<TD nowrap class=blue  width=15%> 
			  	<div align="left">赠送充值卡</div>
			  </TD>
				<TD nowrap  colspan="3"> 
					<select name ="largess_card" onchange="changelargesscard()">
					<option class='button' value='Y' >是</option>
					<option class='button' value='N' selected>否</option>
					</select>
       </TD> 
	</TR>
	<%@ include file="/npage/s1104/realUserInfo.jsp" %>
</TABLE>
<script>
		var owner_type = '<%=owner_type%>';
		if(owner_type == '01'||owner_type == '02')
		{
			document.all.userName.value = "<%=cust_name%>";//设置用户名称
			document.all.userName11.value = "<%=ZSCustName11%>";
			document.all.userName22.value = "<%=ZSCustName11%>";
		}else{
			document.all.userName.value = "<%=cust_name%>";//设置用户名称
			document.all.userName11.value = "<%=cust_name%>";
			document.all.userName22.value = "<%=cust_name%>";
		}
		document.getElementById("userType").disabled = true;//用户级别置灰
</script>