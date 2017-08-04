<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String owner_type = "";
	String contract_person = "";
	String contract_phone = "";
	String cust_name="";
	String sql = "select owner_type,contact_person,contact_phone,cust_name from dcustdoc where cust_id="+gCustId;
  
//  String ssss = "通过custId[" + gCustId + "]查询";
//  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
%>

  <wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=nopass%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=ip%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value="<%=gCustId%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
  
  <wtc:array id="rows" scope="end"/>
<% 		
	if(rows.length==0||rows[0].length==0){
		//System.out.println("-- zhouby ----rows.length is zero-----------");				
	}else{
		owner_type = rows[0][10];
		contract_person = rows[0][16];
		contract_phone = rows[0][17];
		cust_name = rows[0][5];
		
		if(cust_name != null && !"".equals(cust_name)){
			if(cust_name.length() == 2 ){
				
				cust_name = cust_name.substring(0,1)+"*";
			}
			if(cust_name.length() == 3 ){
				
				cust_name = cust_name.substring(0,1)+"**";
			}
			if(cust_name.length() == 4){
			
				cust_name = cust_name.substring(0,2)+"**";
			}
			if(cust_name.length() > 4){
				
				cust_name = cust_name.substring(0,2)+"******";
			}
		}
		
		/**
		System.out.println("-- zhouby ----ims-----------10 " + owner_type);				
		System.out.println("-- zhouby ----ims-----------16 " + contract_person);				
		System.out.println("-- zhouby ----ims-----------17 " + contract_phone);				
		System.out.println("-- zhouby ----ims-----------15 " + cust_name);				
		*/
	}
%>
<TABLE cellSpacing=0 id="userBaseInfoTab">
	<TR class=t2>
		<Td class="blue">用户名</Td>
		<TD>
			<input name="userName" id="userName" maxlength="50" class="InputGrey" readonly /> 
			<font class="orange">*</font>  
		</TD>
		<td class="blue">处理级别 </td>
	  <TD>
			<select name="dealLevel" disabled>
				<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		  	 <wtc:sql>select trim(deal_level),level_name from sServOrderDealLevel</wtc:sql>
		 	  </wtc:pubselect>
			 <wtc:array id="result_t2" scope="end"/>
				<% 
				
						for(int jjj=0;jjj<result_t2.length;jjj++){
						System.out.println("--------------result_t2["+jjj+"][0]------------"+result_t2[jjj][0]);
							%>
								<option value="<%=result_t2[jjj][0]%>"  ><%=result_t2[jjj][1]%></option>
							<%
				}
				%>
			</select>
		</TD>
		<td class="blue">用户归属 </td>
		<td>
			<input type="text"  value="<%=groupId%>" name="userGroupName" 
			 v_name="userGroupName"  v_must="1" id="userGroupName" 
			  class="InputGrey" readonly />
			<input type="hidden" name="userGroupId" id="userGroupId" > 
			<font class="orange">*</font>  
		</TD>		
	</TR>
<TR class=t2>
	<jsp:include page="/npage/common/pwd_2.jsp">
					  <jsp:param name="width1" value=""  />
					  <jsp:param name="width2" value=""  />
					  <jsp:param name="pname" value="userpwd"  />
					  <jsp:param name="pcname" value="userpwdcfm"  />
	</jsp:include>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
	<td class="blue">用户级别</td>
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
	
</TR>
<TR class=t2>
	<td class="blue">用户类型 </td>
	<td colspan="5">
		<input type="text" name="userType1" id="userType1" 
		 value="集团" readonly class="InputGrey"/>
		 <!-- 关于融合通信相关产品BOSS营业受理改造和资费需求 by ningtn -->
		 <!-- 付费类型 预付费 -->
		 <input type="hidden" name="billModeCd" value="B" />
		 <!-- 入网方式 普通开户 -->
		 <input type="hidden" name="openType" value="01" />
	</td>
</TR>
<%@ include file="/npage/s1104/realUserInfo.jsp" %>
</table>
<script>
		var owner_type = '<%=owner_type%>';
		document.all.userName.value = "<%=cust_name%>";//设置用户名称
		document.getElementById("userType").disabled = true;//用户级别置灰
</script>