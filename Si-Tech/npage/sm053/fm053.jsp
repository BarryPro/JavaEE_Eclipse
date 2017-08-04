<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>	
<%
  request.setCharacterEncoding("GBK");

%>

<html>
<head>
<title>用户密码修改</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String trueOpCode = "1234";
	String inputType="0";
	String changType="0";
	String op_code=request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String phone_no=request.getParameter("activePhone");
	String regionCode= (String)session.getAttribute("regCode");
	String org_code = (String)session.getAttribute("orgCode");
	
	String work_no = (String)session.getAttribute("workNo");
	String iLoginAccept = "0";
  String iChnSource = "01";
  String iUserPwd = "";
	String dWorkNo = (String)session.getAttribute("workNo");
	String dNopass = (String)session.getAttribute("password");
	
	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0];
%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%	
		String loginAccept = "";
		loginAccept = sLoginAccept;
%>

 	<wtc:service name="s1234Init" routerKey="region" routerValue="<%=regionCode%>"  outnum="48" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=trueOpCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=dNopass%>"/>		
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>

<%
	ArrayList custDoc = new ArrayList();		
	if(result1!=null&&result1.length>0){
    for(int i=0;i<result1[0].length;i++){
    	custDoc.add(result1[0][i]);
    }
  }
  String sm_name = "";
  sm_name = (String)custDoc.get(3);
  
  String sqIdtype = "select id_type,id_name from sidtype";
%>

<%        
    
    StringBuffer sq2StringBuffer = new StringBuffer();
    sq2StringBuffer.append("select hand_fee ,trim(favour_code) from snewFunctionFee where region_code='");
    sq2StringBuffer.append((String)custDoc.get(20));
    sq2StringBuffer.append("' and function_code='");
    sq2StringBuffer.append(trueOpCode);
    sq2StringBuffer.append("'");
    String baseHandFeeString = sq2StringBuffer.toString();
    System.out.println("  CallCRMPD   " + baseHandFeeString );
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	  <wtc:sql><%=baseHandFeeString%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="baseHandFeeArr" scope="end"/>
<% 
		if(baseHandFeeArr!=null&&baseHandFeeArr.length>0){
			custDoc.add(baseHandFeeArr[0][0]);
			custDoc.add(baseHandFeeArr[0][1]);
		}else{
			custDoc.add("");
			custDoc.add("");	
		}    
        

%>
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:sql><%=sqIdtype%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="sIdTypeStr" scope="end"/>
<%
	boolean hfrf=false;
	if(((String)custDoc.get(49)).trim().equals("") || ((String)custDoc.get(49)).trim().equals("0")){
		hfrf=true; 
	}else{
  	int favFlag = 0 ;
		for(int i = 0 ; i < temfavStr.length ; i ++){
			if(temfavStr[i][0].trim().equals(((String)custDoc.get(50)).trim())){
				favFlag = 1;
				i = 99;
			}
		}
			
		if(favFlag==0){
			hfrf=true;
		}
	}
%>

<script language="javascript">
	function submitt(){
		getAfterPrompt();
		if(document.frm.t_new_pass.value.length==0){
			rdShowMessageDialog("新密码不得为空！");
			return;
		}
		if(document.frm.t_new_pass.value.trim().len() != 6){
			rdShowMessageDialog("新密码的长度应该是6位");
			return;
		}
		
		if(!forNonNegInt(document.frm.t_new_pass)){
			return;
		}
		
		if(document.frm.t_conf_pass.value.trim().len()==0){
			rdShowMessageDialog("校验密码不能为空!");
			return;				
		}
		
		if(!forNonNegInt(document.frm.t_conf_pass)){
			return;
		}
		
		if(document.frm.t_new_pass.value!=document.frm.t_conf_pass.value){
			rdShowMessageDialog("两次输入的密码不一致！");
			return;
		}
		
	
		if(document.all.asNotes.value.trim().len()==0){	
				 document.all.asNotes.value="操作员"+document.frm.workNo.value+"进行用户密码修改(渠道协同)";
		  }
			
  	
  		document.frm.action="submit.jsp";
  		document.frm.submit();
	}


</script>
</head>
<body>
<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
	
	<table cellspacing="0">
		<tr>
		<td class="blue" width="13%">用户名称</td>
		<td>
			<input type="text" readonly class="InputGrey" name="t_cus_name" id="t_cus_name" value="<%=(String)custDoc.get(4)%>">
		</td>
		<jsp:include page="/npage/common/pwd_2.jsp">
			<jsp:param name="width1" value="13%"/>
			<jsp:param name="width2" value=""/>
			<jsp:param name="pname" value="t_new_pass"/>
			<jsp:param name="pcname" value="t_conf_pass"/>
		</jsp:include>
		</tr>
		<tr>
	    <td class="blue" nowrap>用户归属地区</td>
	    <td>
	        <input type="text" readonly class="InputGrey" name="t_region" id="t_region" value="<%=(String)custDoc.get(21)%>">
	    </td>
	    <td class="blue">归属市县</td>
	    <td>
	        <select name="s_city" id="s_city" disabled>
	        	<option value="<%=(String)custDoc.get(22)%>"><%=(String)custDoc.get(23)%></option>
	        </select>
	    </td>
	    <td class="blue">归属网点</td>
	    <td>
	        <select name="s_spot" id="s_spot" disabled>
	        	<option value="<%=(String)custDoc.get(24)%>"><%=(String)custDoc.get(25)%></option>       	
	        </select>
	    </td>
	</tr>
	<tr>
	    <td class="blue">用户状态</td>
	    <td>
	        <select name="s_cus_status" disabled>
	        	<option value="<%=(String)custDoc.get(27)%>"><%=(String)custDoc.get(28)%></option>    
	        </select>
	    </td>
	    <td class="blue">用户类别</td>
	    <td style="display:none">
	        <select name="s_cus_level" disabled>
	            <option value="<%=(String)custDoc.get(6)%>"><%=(String)custDoc.get(30)%></option>
	        </select>
	    </td>
	    <td>
	        <select name="s_cus_type" disabled>
	             <option value="<%=(String)custDoc.get(7)%>"><%=(String)custDoc.get(31)%></option>     	     	
	        </select>
	    </td>
	    <td class="blue">证件类型</td>
	    <td>
	        <select name="s_idtype" disabled>
	        	<option value="<%=(String)custDoc.get(9)%>"><%=(String)custDoc.get(10)%></option>
	        </select>
	    </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">&nbsp;</td>
	    <td>
	        <input type="text" class="InputGrey" size="30" name="t_cus_address" id="t_cus_address" value="<%=(String)custDoc.get(8)%>" readonly>
	    </td>
	    <td class="blue">&nbsp;</td>
	    <td>
			&nbsp;
	    </td>
	    <td class="blue">&nbsp;</td>
	    <td>
	        <input type="hidden" class="InputGrey" name="aaa" id="aaa" value="<%=((String)custDoc.get(11)).trim()%>" readonly>
	    </td>
	</tr>
	<tr>
	    <td class="blue">证件地址</td>
	    <td>
	        <input type="text" size="30" class="InputGrey" name="t_id_address" id="t_id_address" value="<%=(String)custDoc.get(19)%>" readonly>
	    </td>
	    <td class="blue">证件有效期</td>
	    <td>
	        <input type="text" class="InputGrey" name="t_id_valid" id="t_id_valid" value="<%=(String)custDoc.get(29)%>" readonly>
	
	    </td>
	    <td class="blue">证件号码</td>
	    <td>
	        <!--<input type="hidden" class="InputGrey" name="t_comm_name" id="t_comm_name" value="<%=(String)custDoc.get(14)%>" readonly>-->
	        <input type="text" class="InputGrey" name="t_idno" id="t_idno" value="<%=((String)custDoc.get(11)).trim()%>" readonly>
	    </td>
	</tr>
	<tr>
	    <td class="blue">联系人姓名</td>
	    <td style="display:none">
	        <input type="hidden" class="InputGrey" name="t_comm_phone" id="t_comm_phone" value="<%=(String)custDoc.get(33)%>" readonly>
	    </td>
	    <td>
	    	<input type="text" class="InputGrey" name="t_comm_name" id="t_comm_name" value="<%=(String)custDoc.get(32)%>" readonly>
	    </td>
	    <td class="blue">联系人地址</td>
	    <td>
	        <input type="text" size="30" class="InputGrey" readonly name="t_comm_address" id="t_comm_address" value="<%=(String)custDoc.get(34)%>">
	    </td>
	    <td class="blue">联系人邮编</td>
	    <td>
	        <input type="text" size="30" class="InputGrey" readonly name="t_comm_postcode" id="t_comm_postcode" value="<%=(String)custDoc.get(35)%>">
	    </td>
	</tr>
	<tr>
	    <td class="blue" nowrap>联系人通讯地址</td>
	    <td>
	        <input type="text" size="30" class="InputGrey" readonly name="t_comm_comm" id="t_comm_comm" value="<%=(String)custDoc.get(36)%>">
	    </td>
	    <td class="blue" nowrap>联系人传真</td>
	    <td>
	        <input type="text" class="InputGrey" readonly name="t_comm_fax" id="t_comm_fax" value="<%=(String)custDoc.get(37)%>">
	    </td>
	    <td class="blue" nowrap>联系人EMAIL</td>
	    <td>
	        <input type="text" class="InputGrey" readonly name="t_comm_email" id="t_comm_email" value="<%=(String)custDoc.get(38)%>">
	    </td>
	</tr>
	<tr>
	    <td class="blue">用户性别</td>
	    <td>
	        <select name="s_cus_sex" disabled>
	        	<option value="<%=(String)custDoc.get(39)%>"><%=(String)custDoc.get(40)%></option>     
	        </select>
	    </td>
	    <td class="blue">出生日期</td>
	    <td>
	        <input type="text" class="InputGrey" readonly name="t_birth" id="t_birth" value="<%=(String)custDoc.get(41)%>">
	    </td>
	    <td class="blue">职业类型</td>
	    <td>
	        <select name="s_busi_type" disabled>
	        	<option value="<%=(String)custDoc.get(42)%>"><%=(String)custDoc.get(43)%></option>
	        </select>
	    </td>
	</tr>
	<tr>
	    <td class="blue">学历</td>
	    <td>
	        <select name="s_edu" disabled>
	        	<option value="<%=(String)custDoc.get(44)%>"><%=(String)custDoc.get(45)%></option>
	        </select>
	    </td>
	    <td class="blue">用户爱好</td>
	    <td>
	        <input type="text" class="InputGrey" readonly name="t_cus_love" id="t_cus_love" value="<%=(String)custDoc.get(46)%>">
	    </td>
	    <td class="blue">用户习惯</td>
	    <td>
	        <input type="text" class="InputGrey" readonly name="t_cus_habit" id="t_cus_habit" value="<%=(String)custDoc.get(47)%>">
	    </td>
	</tr>
	<tr style="display:none">
	    <td class="blue"> 担保人名称</td>
	    <td>
	        <input id=Text2 type=text size=17 name=asCustName maxlength=20
	               value="<%=(String)custDoc.get(12)%>"
	               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
	    </td>
	    <td class="blue">担保人联系电话</td>
	    <td>
	        <input id=Text2 type=text size=17 name=asCustPhone maxlength=20 value="<%=(String)custDoc.get(13)%>">
	    </td>
	    <td>联系地址</td>
	    <td colspan=2>
	        <input id=Text2 type=text size=17 name=asContractAddress maxlength=20
	               value="<%=(String)custDoc.get(17)%>"
	               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
	    </td>
	</tr>
	<tr style="display:none">
	    <td class="blue"> 担保人证件类型</td>
	    <td>
	        <select size=1 name=asIdType>
	            <%for (int i = 0; i < sIdTypeStr.length; i++) {%>
	            <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%>
	            </option>
	            <%}%>
	        </select>
	    </td>
	    <td class="blue">证件号码</td>
	    <td>
	        <input id=Text2 type=text size=17 name=asIdIccid maxlength=20 value="<%=(String)custDoc.get(15)%>" >
	    </td>
	    <td class="blue">证件地址</td>
	    <td colspan=2>
	        <input id=Text2 type=text size=17 name=asIdAddress maxlength=20
	               value="<%=(String)custDoc.get(16)%>"
	               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
	    </td>
	</tr>
	<tr>
	    <td nowrap width="10%" class="blue">手续费</td>
	    <td nowrap width="23%">
	        <input type="text" index="3" name="t_handFee" id="t_handFee" readonly value="<%=((String)custDoc.get(48)).trim()%>" v_type=float v_name="手续费">
	    </td>
	    <td nowrap width="10%" class="blue">实收</td>
	    <td nowrap width="24%">
	        <input type="text" index="4" name="t_factFee" id="t_factFee" onKeyUp="getFew()" v_type=float v_name="实收" <%if(hfrf){%>value="<%=((String)custDoc.get(48)).trim()%>" readonly<%}%>>
	    </td>
	    <td nowrap width="10%" class="blue"> 找零</td>
	    <td nowrap width="23%">
	        <input type="text" name="t_fewFee" id="t_fewFee" readonly>
	    </td>
	</tr>
	<tr>
	    <td nowrap width="10%" class="blue">系统备注</td>
	    <td nowrap colspan="5" bgcolor="eeeeee">
	        <input type="text" name="t_sys_remark" id="t_sys_remark" size="45" readonly>
	    </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">用户备注</td>
	    <td nowrap colspan="5">
	        <input id=Text2 type=text size=45 name=asNotes maxlength=30 value=""
	               onKeyUp="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" v_must=0 v_maxlength=60
	               v_type=string v_name="用户备注">
	    </td>
	</tr>
	</table>
	
	<jsp:include page="/npage/public/hwReadCustCard.jsp">
		<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
		<jsp:param name="showBody" value="01"  />
		<jsp:param name="sopcode" value="<%=opCode%>"  />
	</jsp:include>
	
	<table>
	<tr>
	  <td nowrap colspan="6" id="footer">
	      <input class="b_foot" type="button" name="b_submit" value="确认" onClick="submitt()" onKeyUp="if(event.keyCode==13){submitt()}">
	      <input class="b_foot" type="button" name="b_clear" value="清除" onClick="doClear()">
	      <input class="b_foot" type="button" name="b_close" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
	  </td>
	</tr>
	</table>
	
	<input type="hidden" name="phoneNo" id="phoneNo" value="<%=phone_no%>" />
	<input type=hidden name=loginAccept value="<%=loginAccept%>">
	<input type=hidden name=opCode value="<%=op_code%>">
	<input type=hidden name=trueOpCode value="<%=trueOpCode%>">
	<input type=hidden name=opName value="<%=opName%>">
	<input type=hidden name=workNo value="<%=dWorkNo%>">
	<input type=hidden name=nopass value="<%=dNopass%>">
	<input type=hidden name=orgCode value="<%=org_code%>">
	<input type=hidden name=rCusNew value="0">
	<input type=hidden name=idNo value="<%=phone_no%>">
	<input type="hidden" name=phonePass value="<%=((String)custDoc.get(5)).trim()%>">
	<input type=hidden name=payFee value="<%=((String)custDoc.get(48)).trim()%>">
	<input type=hidden name=opType value="0">
	<input type=hidden name=opFlag value="1">
	<input type=hidden name=selfIpAddr value="<%=request.getRemoteAddr()%>">
	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>