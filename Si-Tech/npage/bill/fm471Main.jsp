<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/04/24 liangyl 一体化 黑龙江移动一体化运营项目计划
* 作者: liangyl
* 版权: si-tech
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>
<head>
<title>公务测试号转入</title>
<%
	
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String workNo     = (String)session.getAttribute("workNo");
  	String password   = (String)session.getAttribute("password");
  	String regionCode = (String)session.getAttribute("regCode");
    String phoneNo = request.getParameter("activePhone");
    String custName = "";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"
	routerValue="<%=regionCode%>" id="loginAccept" />
<%
    String paraAray[] = new String[9];
    paraAray[0] = loginAccept;
    paraAray[1] = "01";
    paraAray[2] = opCode;
    paraAray[3] = workNo;
    paraAray[4] = password;
    paraAray[5] = activePhone;
    paraAray[6] = "";
    paraAray[7] = "";
    paraAray[8] = "通过phoneNo[" + activePhone + "]查询客户信息";
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40">
	<wtc:param value="<%=paraAray[0]%>" />
	<wtc:param value="<%=paraAray[1]%>" />
	<wtc:param value="<%=paraAray[2]%>" />
	<wtc:param value="<%=paraAray[3]%>" />
	<wtc:param value="<%=paraAray[4]%>" />
	<wtc:param value="<%=paraAray[5]%>" />
	<wtc:param value="<%=paraAray[6]%>" />
	<wtc:param value="<%=paraAray[7]%>" />
	<wtc:param value="<%=paraAray[8]%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
</wtc:service>
<wtc:array id="result_t2" scope="end" />
<%
      if(!"000000".equals(retCode2)){
  %>
<script language=javascript>
          rdShowMessageDialog("retcode：<%=retCode2%><br>retmsg：<%=retMsg2%>",0);
          removeCurrentTab();
        </script>
<%
      }else{
		if(result_t2.length>0){
			custName = result_t2[0][5];
		}
      }
    /*end by diling @2012/5/8 17:23:28*/
%>
<script language=javascript>
function go_cfm(){
	$("#confirm").attr("disabled","disabled");
	var packet = new AJAXPacket("fm471Cfm.jsp","请稍后...");
	packet.data.add("opCode","<%=opCode%>");
	packet.data.add("opName","<%=opName%>");
    packet.data.add("phoneNo",$("#phoneNo").val());
    packet.data.add("custName",$("#custName").val());
    packet.data.add("oaNum",$("#oaNum").val());
    packet.data.add("yanqiMonth",$("#yanqiMonth").val());
    packet.data.add("time",new Date());
	core.ajax.sendPacket(packet,do_cfm);
	packet =null;
}
function do_cfm(packet){
	var error_code = packet.data.findValueByName("errCode");//返回代码
    var error_msg =  packet.data.findValueByName("errMsg");//返回信息
    $("#confirm").attr("disabled","");
    if(error_code!="000000"){//调用服务失败
      	rdShowMessageDialog(error_code+":"+error_msg);
    	return false;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    }
}

</script>
</head>
<body>

	<form name="frm" method="post" >
		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<table cellspacing="0">
			<tr>
				<td class="blue">手机号码</td>
				<td><input type="text" class="button"  id="phoneNo" name="phoneNo"
					value="<%=phoneNo%>" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="blue">客户名称</td>
				<td><input type="text" class="button" id="custName"
					name="custName" value="<%=custName%>" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="blue">OA编号</td>
				<td><input class="button" type="text" id="oaNum" name="oaNum"
					size="20" maxlength="30"> <font color="orange">*</font></td>
			</tr>
			<tr>
				<td class="blue">延期月份</td>
				<td>
					<select id="yanqiMonth" name="yanqiMonth">
						<option value="1">1月</option>
						<option value="2">2月</option>
						<option value="3">3月</option>
						<option value="4">4月</option>
						<option value="5">5月</option>
						<option value="6">6月</option>
						<option value="7">7月</option>
						<option value="8">8月</option>
						<option value="9">9月</option>
						<option value="10">10月</option>
						<option value="11">11月</option>
						<option value="12">12月</option>
					</select>
					<font color="orange">*</font></td>
			</tr>
			<tr>
				<td colspan="2" id="footer">
					<div align="center">
						<input class="b_foot" type="button" id="confirm" name="confirm" value="确认"
							onClick="go_cfm()">
						<input class="b_foot" type=button name=back value="清除" 
							onClick="frm.reset()">
						<input class="b_foot" type=button name=qryP value="关闭"
							onClick="removeCurrentTab();">
					</div>
				</td>
			</tr>
		</table>
		<%@ include file="/npage/include/footer_simple.jsp"%>
	</form>
</body>
</html>