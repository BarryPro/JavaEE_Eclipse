<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "7413";
	String opName = "动力100业务包退订";

	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String[][] agentInfo = (String[][])arr.get(2);
	String[][] pass = (String[][])arr.get(4);
	String ip_Addr = agentInfo[0][2];
	String workno = baseInfo[0][2];
	String workname = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String nopass  = pass[0][0];
	String Department = baseInfo[0][16];
	String regionCode = Department.substring(0,2);
	String districtCode = Department.substring(2,4);

	String sqlStr = "";

	//取运行省份代码 -- 为吉林增加，山西可以使用session
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
%>   
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end"/>
<%
	String ProvinceRun = "";
	if (result2.length != 0) 
	{
		ProvinceRun = result2[0][0];
	}

	//	取工号密码和GROUP_ID
	String GroupId = "";
	String OrgId = "";
	if(ProvinceRun.equals("20"))  //吉林
	{	
		sqlStr = "select group_id,'unknown' FROM dLoginMsg where login_no='"+workno+"'";
%>   
<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>
<%
	if ( result1.length != 0) 
	{
		GroupId = result1[0][0];
		OrgId = result1[0][1];
	}
	}
	else
	{
		GroupId = baseInfo[0][21];
		OrgId = baseInfo[0][23];
	}
%>

<HEAD>
<title><%=opName%></title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<SCRIPT type=text/javascript>

core.loadUnit("debug");
core.loadUnit("rpccore");
onload=function(){
    core.rpc.onreceive = doProcess;
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";
	if(retType == "checkbackfee")
	{
		if(retCode=="000000")
		{
			var backprepay = packet.data.findValueByName("backprepay");
			var nobackprepay = packet.data.findValueByName("nobackprepay");
			if(backprepay == ".00"){
				backprepay = "0.00";
			}
			if(nobackprepay == ".00"){
				nobackprepay = "0.00";
			}
			document.frm.grpbackprepay.value = backprepay;
			document.frm.grpnobackprepay.value = nobackprepay;
		}
		else
		{
            rdShowMessageDialog("查询可用预存出错");
            return false;
		}
	}
    //---------------------------------------
    if(retType == "GrpCustInfo") //用户集团用户销户时客户信息查询
    {
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.cust_name.value = retname;
			document.frm.unit_id.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1：" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            return false;
        }
     }
	 if(retType == "getSysAccept")
     {
        if(retCode == "000000")
        {
          	var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
					
			document.frm.sure.disabled = true;
	    	page = "f7413Cfm.jsp";
	    	frm.action=page;
	    	frm.method="post";
	    	frm.submit();
        }else{
          	rdShowMessageDialog("查询流水出错,请重新获取！");
			return false;
        }
    }
     //---------------------------------------
     if(retType == "checkPwd") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;
            }
            else
            {
                rdShowMessageDialog("客户密码校验成功！",2);
                document.frm.sysnote.value = "动力100业务包退订";
                document.frm.tonote.value = "动力100业务包退订";
                document.frm.sure.disabled = false;
            }
        }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！");
    		return false;
        }
     }
}

//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
    var pageTitle = "集团客户选择";
    var fieldName = "身份证号|集团客户ID|集团客户名称|集团用户ID|集团用户编号 |集团用户名称|业务包代码|业务包名称|集团ID|付费帐户|品牌名称";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "11|0|1|2|3|4|5|6|7|8|9|10|";
    var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code|product_name|unit_id|account_id|sm_name|";
    var cust_id = document.frm.cust_id.value;
    if(document.frm.iccid.value == "" &&
       	document.frm.cust_id.value == "" &&
       	document.frm.unit_id.value == "" &&
       	document.frm.user_no.value == "")
    {
        rdShowMessageDialog("请输入身份证号、集团客户ID、集团ID或集团用户编号进行查询！",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
      	rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
      	rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(document.frm.user_no.value == "0")
    {
    	frm.user_no.value = "";
        rdShowMessageDialog("集团用户编号不能为0！",0);
    	return false;
    }

    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s7411/fpubgrpusr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&user_no=" + document.all.user_no.value;
    path = path + "&op_code=" + document.all.op_code.value;
    path = path + "&run_code=" + document.all.run_code.value;
    path = path + "&regionCode=" + document.all.region_code.value;

    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=yes,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
  	var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code|product_name|unit_id|account_id|sm_name|";
  	if(retInfo ==undefined)
    {   return false;   }

	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");

    }
    /**调RPC来回填预存**/
    var rpc_account_id= document.all.account_id.value;
    var checkbackfee_Packet = new RPCPacket("/npage/s3096/backfee.jsp","正在查询预存,请稍候......");
    checkbackfee_Packet.data.add("retType","checkbackfee");
    checkbackfee_Packet.data.add("account_id",rpc_account_id);
	core.rpc.sendPacket(checkbackfee_Packet);
	delete(checkbackfee_Packet);
}

function check_HidPwd()
{
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    if(cust_id == ""){
    	rdShowMessageDialog("请先进行查询操作！");
    	return false;
    }
    var checkPwd_Packet = new RPCPacket("/npage/s3096/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.rpc.sendPacket(checkPwd_Packet);
	delete(checkPwd_Packet);
}

function getSysAccept()
{
	var getSysAccept_Packet = new RPCPacket("/npage/s3096/pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.rpc.sendPacket(getSysAccept_Packet);
	delete(getSysAccept_Packet);
}

function refMain(){

    var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.
    //说明：检测分成两类,一类是数据是否是空,另一类是数据是否合法.
    if(check(frm))
    {
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("集团用户名称："+document.frm.grp_name.value+",必须输入!!");
            document.frm.grp_name.select();
            return false;
        }
        if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("业务包产品ID必须输入!!");
            document.frm.grp_id.select();
            return false;
        }
		getSysAccept();
    }
}

</script>
</HEAD>
<BODY>
<FORM action="" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>
 	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
    <TABLE cellSpacing="0">         	
      	<TR>
      	  	<TD width="15%" class="blue">
      	    	身份证号
      	  	</TD>
      	  	<TD width="35%">
      	      	<input name=iccid class="button" id="iccid" maxlength="18" v_type="string" v_must=1 v_name="身份证号" index="1">
      	      	<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor：hand" value=查询>
      	      	<font class="orange">*</font>
      	  	</TD>
      	  	<TD  width="15%" class="blue">
      	  		集团客户ID
      	 	</TD>
      	  	<TD width="35%">
      	    	<input class="button" type="text" name="cust_id" maxlength="18" v_type="0_9" v_must=1 v_name="客户ID" index="2">
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">
      	     	集团ID
      	  	</TD>
      	  	<TD>
	  	  		<input name=unit_id class="button" id="unit_id"  maxlength="10" v_type="0_9" v_must=1 v_name="集团ID" index="3">
      	  		<font class="orange">*</font>
      	  	</TD>
      	  	<TD class="blue">
      	  		集团用户编号
      	  	</TD>
      	  	<TD>
      	    	<input class="button" name="user_no" size="20" v_must=1 v_type=string v_name="集团用户编号" index="4">
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">
      	  		集团客户名称
      	  	</TD>
      	  	<TD COLSPAN="3">
      	    	<input class="button" name="cust_name" size="20" readonly v_must=1 v_type=string v_name="客户名称" index="4">
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">集团用户ID</TD>
      	  	<TD>
      	    	<input name="grp_id" type="text" class="button" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="3">
      	    	<font class="orange">*</font>
      	  	</TD>
      	  	<TD class="blue">集团用户名称</TD>
      	  	<TD>
      	    	<input name="grp_name" type="text" class="button" size="20" maxlength="60" readonly v_must=1 v_maxlength=60 v_type="string" v_name="集团用户名称" index="4">
      	  		<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">业务包付费帐户</TD>
      	  	<TD>
      	    	<input name="account_id" type="text" class="button" size="20" maxlength="12" readonly v_type="0_9" v_must=1 v_name="集团付费帐户" index="5">
      	    	<font class="orange">*</font>
      	  	</TD>
      	  	<TD class="blue">业务包名称</TD>
      	  	<TD>
      	    	<input class="button" type="text" name="product_name" size="20" readonly v_must=1 v_type="string" v_name="集团主产品：" index="6"> 
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>      	
      	
      	<TR>
      	  	<TD class="blue">可退预存</TD>
      	  	<TD>
      	    	<input name="grpbackprepay" type="text" class="button" size="20" readonly v_name="可退预存">
      	  	</TD>
      	  	<TD class="blue">不可退预存</TD>
      	  	<TD>
      	    	<input name="grpnobackprepay" type="text" class="button" size="20" readonly v_name="不可退预存">
      	  	</TD>
      	</TR>

      	<TR>
      	   	<TD class="blue">集团客户密码</TD>
      	  	<TD COLSPAN="3">
      	  	<%if(!ProvinceRun.equals("20"))  //不是吉林
			 	{
			%>       
      	    <jsp:include page="/page/common/pwd_1.jsp">
      	    <jsp:param name="width1" value="15%"  />
	  	    <jsp:param name="width2" value="35%"  />
	  	    <jsp:param name="pname" value="custPwd"  />
	  	    <jsp:param name="pwd" value=""  />
 	  	    </jsp:include>
 	  	      
 	  	 	<%}else{%>
 	  	     	<input name=custPwd type="password" class="button" id="custPwd" size="14" maxlength="6" v_must=1>
     		<%  } %>
     			<input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=校验>
      	      	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	    <TD class="blue">系统备注</TD>
      	    <TD  colspan="3">
      	     	<input class="button" name="sysnote" size="60" readonly>
      	    </TD>
      	</TR>
      	<TR>
      	    <TD class="blue">用户备注</TD>
      	    <TD colspan="3">
      	    	<input class="button" name="tonote" size="60">
      	    </TD>
      	</TR>
      	<TR>
      	    <TD colspan="4" align=center id="footer">
      	    	<input class="b_foot" name="sure"  type=button value="确认"  onclick="refMain()" disabled>
      	    	<input class="b_foot" name="reset1"  onClick="" type=reset value="清除" >
      	    	<input class="b_foot" name="close"  onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value="关闭">
      	    </TD>
			<input class="button" type="hidden" name="sm_name"  value="">
      	</TR>
    </TABLE>
<%@ include file="/npage/include/footer.jsp" %> 
<input type="hidden" name="product_code" value="">
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="op_type" value="1">
<input type="hidden" name="grp_no" value="0">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号 -->
<input type="hidden" name="op_code"  value="<%=opCode%>">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
<input type="hidden" name="run_code"  value="A">   
</FORM>
</BODY>
</HTML>
