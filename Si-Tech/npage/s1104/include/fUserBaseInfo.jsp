 <%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String owner_type = "";
	String contract_person = "";
	String contract_phone = "";
	String cust_name="";

	String ipAddrss = (String)session.getAttribute("ipAddr");
	String beizhussdese="根据custid=["+gCustId+"]进行查询"; 
	String ZSCustName11="";
	String ZSLianxiren11="";
	
%>
<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="1104" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
			<wtc:param value="<%=gCustId%>" />
</wtc:service>
<wtc:array id="rows"  scope="end"/> 

<% 		
	System.out.println("------rows.length-----------"+rows.length);				
	if(rows.length==0||rows[0].length==0){
		System.out.println("------rows.length is zero-----------");				
	}else{
		if(rows[0][0].equals("01")) {
		owner_type = rows[0][10];
		contract_person = rows[0][16];
		contract_phone = rows[0][17];
		cust_name = rows[0][5];
		System.out.println("owner_type in q001=====rows[0][0]========"+rows[0][0]);	
		System.out.println("owner_type in q001=======owner_type======"+owner_type);		
		System.out.println("owner_type in q001=======contract_person======"+contract_person);		
		System.out.println("owner_type in q001========contract_phone====="+contract_phone);		
		System.out.println("owner_type in q001============="+cust_name);		
		
		
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
		
			if(!("").equals(contract_person)) {
	
			if(contract_person.length() == 2 ){
				ZSLianxiren11 = contract_person.substring(0,1)+"*";
			}
			if(contract_person.length() == 3 ){
				ZSLianxiren11 = contract_person.substring(0,1)+"**";
			}
			if(contract_person.length() == 4){
				ZSLianxiren11 = contract_person.substring(0,2)+"**";
			}
			if(contract_person.length() > 4){
				ZSLianxiren11 = contract_person.substring(0,2)+"******";
			}
		}
		
		
		}	
	}
%>
<TABLE cellSpacing=0 id="userBaseInfoTab">
  <TR class=t2>
    <Td class="blue">用户名</Td>
    <TD><input type="hidden" name="userName" id="userName" class="required haveSpe" maxlength="50"> 
    	  <input type="text" name="userName11" id="userName11" class="required haveSpe" maxlength="50"><font class="orange">*</font>   
    	  <input type="hidden" name="userName22" id="userName22" class="required haveSpe" maxlength="50"> 
    	</TD>
	<td class="blue">联系人</td>
    <TD><input type="hidden" name="contactCustName" id="contactCustName"  maxlength="15" value="联系人"> 
    	  <input type="text"  value="联系人" name="contactCustName11" id="contactCustName11"   maxlength="50"><font class="orange">*</font>  
    	  <input type="hidden"  value="联系人" name="contactCustName22" id="contactCustName22"   maxlength="50">
    	</TD>
	<td class="blue">联系电话</td>
    <TD><input type="text" name="contactPhone" id="contactPhone" class="required andCellphone"> <font class="orange">*</font> </TD>
</TR>
<TR class=t2>
	<jsp:include page="/npage/common/pwd_2.jsp">
					  <jsp:param name="width1" value=""  />
					  <jsp:param name="width2" value=""  />
					  <jsp:param name="pname" value="userpwd"  />
					  <jsp:param name="pcname" value="userpwdcfm"  />
	</jsp:include>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
	<td class="blue">
	<%if(!opCode.equals("1104")){%>
		付费类型 
	<%}%>
	</td>
  <td>
	<select name="billModeCd" id="billModeCd">
		<option value="B">预付费</option>
		<option value="A">后付费</option>
	</select>
	</TD>
</TR>
<TR class=t2>
	<td class="blue">
		<%if(!opCode.equals("1104")){%>
			用户级别
		<%}%>
	</td>
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
	<td class="blue">入网方式 </td>
  <td>
	<select name="openType" id="openType">
		<option value="01" >普通开户</option>
		<option value="02">分销商返单</option>
	</select>
	</TD>
	<td class="blue">透支额度 </td>
    <TD>
	<input type="text" name="limitOwe" id="limitOwe" class="forReal" value="0" readonly />
	</TD>
</TR>
<TR class=t2>
	<td class="blue">
		<%if(!opCode.equals("1104")){%>
			处理级别
		<%}%>
	</td>
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
	<td class="blue"><span id="sfgz1">是否短信关注 </span></td>
  <td colspan=3 >
	<select name="addCmgr" id="sfgz2">
		<option value="Y">是</option>
		<option value="N" selected>否</option>
	</select>
	</TD>
	
</TR>
<tr id="sfzl">
				<TD  nowrap   class=blue >
			  	<div align="left">入网有礼活动</div>
			  	<input type="hidden" name="goodphone">
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
				<select id=innetCode align="left" name=innetCode  index="3" style=display:none>
        </select>
			  <select  align="left" name=dnInnetCode style=display:none>
<%
					//style=display:none
      		String sqlStr12 = 
			  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +"b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             +" and a.mode_code (+)= b.mode_code"
             +" and b.region_code = c.region_code"
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'dn'"
			 +" and b.sm_code = c.sm_code"
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
             
             System.out.println("动感地带入网代码  sqlStr12===="+sqlStr12);
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="7">
								<wtc:sql><%=sqlStr12%></wtc:sql>
								</wtc:pubselect>
							 <wtc:array id="result12" scope="end" />
               <%
    					if(retCode12.equals("000000")){
       				 	for(int i=0;i<result12.length;i++){
                         	 out.println("<option class='button'  mainCode='"+result12[i][2]+"' mainName='"+result12[i][3]+"' subCount='"+result12[i][4].trim()+"' value='" + result12[i][0] + "'>" + result12[i][1] + "</option>");
                }
              }
%>
  </select>  	 
  </TD> 
</tr>
<TR class=t2>
	<td class="blue"  style="display:none">是否邮寄 </td>
  <td   style="display:none">
	<select name="isPost" id="isPost" onchange="doPostInfo()">
		<option value="0">是</option>
		<option value="1" selected >否</option>
	</select>
	</TD>
	

	<td class="blue">是否预约选号开户</td>
	<td>
		<select id="yz" onchange="changeyz()">
			<option value="N" selected="selected">--否--</option>
			<option value="Y">--是--</option>
		</select>
	</td>
	<td class="blue"><!--受理方案--> 预占ID</td>
  <td>
  <input type="text" name="yzID" id="yzID"  value="" readonly>
	</TD>
	<td class="blue">
		用户归属
	</td>
	<td>
		<input type="text"  value="<%=groupId%>" name="userGroupName"  v_name="userGroupName"  v_must="0"  id="userGroupName" class="required" readonly>
		<input type="hidden" name="userGroupId" id="userGroupId" > <font class="orange">*</font>  
	</TD>		
</tr>

<%
	if("g784".equals(opCode)||"g785".equals(opCode)){
%>
<tr>
	<td class="blue">使用证件类型 </td>
	<td >
		<select id="isType" name="isType" onchange="">
		    <option value="1" selected = "selected">录取通知书</option>
		    <option value="2">直销队</option>
		</select>
		<input type="hidden" name="isType1" id="isType1" value="1" >
	</td>
	<td class="blue">返费规则 </td>
	<td id="feeTypes">
		<select id="isFeeTypes" name="isFeeTypes" onchange="">
			<option value="1" selected = "selected">返费规则2</option>
			<option value="2">返费规则1</option>
		</select>
		<input type="hidden" name="isFeeTypes1" id="isFeeTypes1" value="1" >
	</td>
</tr>

<%	
	}
%>
<% /*2014/05/28 9:19:24 gaopeng 物联网行车卫士 展示信息*/
	if("Y".equals(carSaveFlag)){
%>
	<tr>
			<td class="blue">车主姓名</td>
			<td><input type="text"  value="" name="OwnerName" id="OwnerName" v_must="0" maxlength="20"  >  </td>
			<td class="blue">车主身份证号</td>
			<td><input type="text"  value="" name="OwnerID" id="OwnerID" v_must="0" maxlength="100"  > </td>
			<td class="blue">车主手机号码</td>
			<td><input type="text"  value="" name="OwnerMobile" id="OwnerMobile" v_must="0" maxlength="20"  > </td>
	</tr>
	<tr>
			<td class="blue">终端模组序列号</td>
			<td><input type="text"  value="" name="ModuleSerialNumber" id="ModuleSerialNumber" v_must="0" maxlength="30"  > </td>
			<td class="blue">安装点</td>
			<td><input type="text"  value="" name="InstallationPoints" id="InstallationPoints" v_must="0" maxlength="50"  > </td>
			<td class="blue">安装人员</td>
			<td><input type="text"  value="" name="InstallationPerson" id="InstallationPerson" v_must="0" maxlength="20"  > </td>
	</tr>
	<tr>
			<td class="blue">安装人员联系方式</td>
			<td><input type="text"  value="" name="InstalPerCon" id="InstalPerCon" v_must="0" maxlength="50"  > </td>
			<td class="blue">车架号</td>
			<td><input type="text"  value="" name="FrameNumber" id="FrameNumber"  maxlength="30"  ></td>
			<td class="blue">车牌号</td>
			<td><input type="text"  value="" name="PlateNumber" id="PlateNumber"  maxlength="15"  ></td>
	</tr>	
<%}%>
<%@ include file="/npage/s1104/realUserInfo.jsp" %>
</table>
<script> 
		var owner_type = '<%=owner_type%>';
		if(owner_type == '01'||owner_type == '02')
		{
			document.all.contactCustName.value = "<%=contract_person%>";//设置联系人
			document.all.contactCustName11.value = "<%=ZSLianxiren11%>";//设置联系人
			document.all.contactCustName22.value = "<%=ZSLianxiren11%>";//设置联系人
			document.all.contactPhone.value = "<%=contract_phone%>";//设置联系标志
			document.all.userName.value = "<%=cust_name%>";//设置用户名称
			document.all.userName11.value = "<%=ZSCustName11%>";//设置用户名称
			document.all.userName22.value = "<%=ZSCustName11%>";//设置用户名称
			
			
		}
		document.getElementById("userType").disabled = true;//用户级别置灰
</script>