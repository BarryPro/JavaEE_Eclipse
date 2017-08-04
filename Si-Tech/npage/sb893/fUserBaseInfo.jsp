 <%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String owner_type = "";
	String contract_person = "";
	String contract_phone = "";
	String cust_name="";
	String sql = "select owner_type,contact_person,contact_phone,cust_name from dcustdoc where cust_id="+gCustId;
	System.out.println("sql-------->"+sql);
%>	 	
<wtc:service name = "sUserCustInfo"  outnum = "30" routerKey = "region" routerValue = "<%=regionCode%>"  
	retcode = "ret_codef" retmsg = "retMessagef"  >
	<wtc:param value = "0"/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
	<wtc:param value = "<%=ipAddr%>"/>
	<wtc:param value = "<%=opNote%>"/>
	<wtc:param value = "<%=gCustId%>"/>
	
	<wtc:param value = ""/>
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service> 
<wtc:array id="rows" scope="end"/>
<% 		
	System.out.println("------rows.length-----------"+rows.length);				
	if(rows.length==0||rows[0].length==0){
		System.out.println("------rows.length is zero-----------");				
	}else{
		owner_type = rows[0][10];
		contract_person = rows[0][16];
		contract_phone = rows[0][17];
		cust_name = rows[0][5];
		System.out.println("zhangyan owner_type in q001============="+owner_type);			
		System.out.println("zhangyan contract_person in q001============="+contract_person);			
		System.out.println("zhangyan contract_phone in q001============="+contract_phone);			
		System.out.println("zhangyan cust_name in q001============="+cust_name);			
	}
%>
<!-- weigp将密码和预占ID赋值 并把整个table隐藏 -->
<script type="text/javascript">
	$(document).ready(function(){
			if("<%=is_check_readcard_result%>"=="1"){
	}else {
		document.all.userpwdyuanlai.value="<%=custPwd%>";
		document.all.userpwdcfmyuanlai.value="<%=custPwd%>";
		$("#mimadis").hide();
		}
		$("#yzID").val("<%=occupId%>");
	});	
</script>
<TABLE cellSpacing=0 id="userBaseInfoTab" >
  <TR class=t2>
    <Td class="blue">用户名</Td>
    <TD><input name="userName" id="userName" class="required haveSpe" maxlength="50"> <font class="orange">*</font>  </TD>
	<td class="blue">联系人</td>
    <TD><input type="text" name="contactCustName" id="contactCustName" class="required" maxlength="15"> <font class="orange">*</font>  </TD>
	<td class="blue">联系电话</td>
    <TD><input type="text" name="contactPhone" id="contactPhone" class="required andCellphone"> <font class="orange">*</font> </TD>
</TR>
<TR class=t2>
	<td class="blue">原密码</td>
	<td class="blue"><input type="password" id="userpwdyuanlai" name="userpwdyuanlai"/></td>
	<td class="blue">原确认密码</td>
	<td class="blue"><input type="password" id="userpwdcfmyuanlai" name="userpwdcfmyuanlai"/></td>
	<td class="blue">付费类型 </td>
  <td>
	<select name="billModeCd" id="billModeCd">
		<option value="B">预付费</option>
		<option value="A">后付费</option>
	</select>
	</TD>
</TR>
<TR class=t2>
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
	<td class="blue">入网方式 </td>
  <td>
	<select name="openType" id="openType">
		<option value="01">普通开户</option>
		<option value="02">分销商返单</option>
	</select>
	</TD>
	<td class="blue">透支额度 </td>
    <TD>
	<input type="text" name="limitOwe" id="limitOwe" class="forReal" value="0" readonly />
	</TD>
</TR>
<TR class=t2>
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
	

	
	<td class="blue"><!--受理方案--> 预占ID</td>
  <td>
  <input type="text" name="yzID" id="yzID"  value="" >
	</TD>
	<td class="blue">用户归属 </td>
	<td>
		<input type="text"  value="<%=groupId%>" name="userGroupName"  v_name="userGroupName"  v_must="1"  id="userGroupName" class="required" readonly>
		<input type="hidden" name="userGroupId" id="userGroupId" > <font class="orange">*</font>  
	</TD>		
</tr>
</table>
<script>
		var owner_type = '<%=owner_type%>';
		if(owner_type == '01'||owner_type == '02')
		{
			document.all.contactCustName.value = "<%=contract_person%>";//设置联系人
			document.all.contactPhone.value = "<%=contract_phone%>";//设置联系标志
			document.all.userName.value = "<%=cust_name%>";//设置用户名称
		}
		document.getElementById("userType").disabled = true;//用户级别置灰
</script>