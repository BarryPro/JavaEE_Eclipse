<%
  /*
   * 关于“双十一”主题营销活动相关支撑功能的开发需求——18元套卡销售
   * 撤单 4  查出4 6 7的
   * 日期: 2013/11/01 15:16:43
   * 作者: gaopeng
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  String phoneNo = (String)request.getParameter("phoneNo");
  String retCode1="";
  String retMsg1="";

 String opnote =workNo+"进行"+opCode+"撤单";
/**
 *@        iLoginAccept              	流水
 *@        iChnSource              	   	渠道标识
 *@        iOpCode                 		操作代码
 *@        iLoginNo              	   	工号
 *@        iLoginPwd                   	工号密码
 *@        iPhoneNo              	   	手机号码
 *@        iUserPwd              	   	服务密码
 *@        iOpNote              	   	备注
 *@        iFlag              	   		0写卡1填写物流单号2配送录入3外呼4外呼失败5配送失败或用户拒收销号
 *@ 返回参数：
 *@        oRetCode						返回代码
 *@        oRetMsg						返回描述 
 *@        vPhoneNo						手机号码
 *@        vSimNo						SIM卡号
 *@        vSimType						SIM类型
 *@        vMailPerson					收货人姓名
 *@        vMailPhone					收货人电话
 *@        vMailAddress					收货人地址
 *@        vStreamNo					物流单号
 *@        vCompanyName					物流公司名称
 *@        vGroupId					    营业厅

*/
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<wtc:service name="sg530Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="27">
		<wtc:param value="<%=accept%>"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/>
  	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo%>"/>
  	<wtc:param value=""/>
  	<wtc:param value="<%=opnote%>"/>
  	<wtc:param value="6"/>
</wtc:service>

<wtc:array id="result" scope="end" />

<body>
<form name="frm" method="post" action="">
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" id="opName" value="<%=opName%>">
  <input type="hidden" name="sysAccept" value="<%=accept%>">
  <div class="title">
    <div id="title_zi">基本信息</div>
  </div>
  
  <table cellspacing="0">
		<tr> 
			<th>手机号码</th>
			<th>收货人姓名</th>
			<th>联系电话</th>
			<th>送货地址</th>
			<th></th>
		</tr>
		<%	
	if (retCode.equals("000000") && result.length > 0){
	System.out.println(result.length+"====gaopengSee");
			for(int i = 0; i < result.length; i++){
		%>
			<tr>
					<td><%=result[i][0]%></td>
					<td><%=result[i][1]%></td>
					<td><%=result[i][2]%></td>
					<td><%=result[i][3]%></td>
				  <td><input type="button" class="b_text" name="btnq" value="撤单" onclick="removeBill(<%=phoneNo%>)"/></td>
			</tr>		
		<%
					}
			}
		else{
		%>
			<script language="JavaScript">
							rdShowMessageDialog("错误代码："+"<%=retCode%>"+",错误信息："+"<%=retMsg%>");
					</script>
		<%
			}
		%>
		
  </table>
</form>
</body>
</html>