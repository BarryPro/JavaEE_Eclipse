<%
  /*
   * 功能: 工单结果查询 1100
   * 版本: 1.0
   * 日期: 2014/11/3
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	String workNo = (String)session.getAttribute("workNo");		//操作工号
	String password = (String)session.getAttribute("password");	//工号密码
	String regCode = (String)session.getAttribute("regCode");
  String opCode 	= request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String opNote = workNo+"进行了"+opCode+"[工单结果查询]操作";
%>
<%!
	public static String subString(String text, int length, String endWith) {
		int textLength = text.length();
		int byteLength = 0;
		StringBuffer returnStr = new StringBuffer();
		for (int i = 0; i < textLength && byteLength < length ; i++) {
			String str_i = text.substring(i, i + 1);
			if (str_i.getBytes().length == 1) {// 英文
				byteLength++;
			} else  {// 中文
				if(byteLength>length-2){
					break;
				}else{
					byteLength += 2;
				}
			}
			returnStr.append(str_i);
		}
		try {
			if (byteLength < text.getBytes("GBK").length) {// getBytes("GBK")每个汉字长2，getBytes("UTF-8")每个汉字长度为3
				returnStr.append(endWith);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return returnStr.toString();
	}
%>

	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sM196Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<SCRIPT type=text/javascript>
			alert("工单结果查询失败！错误代码：<%=retCode%>错误信息：<%=retMsg%>");
			window.close();
		</SCRIPT>
<%
	}
String endWith="";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<SCRIPT type=text/javascript>
			function saveToQryInfo(){
				var selListReltsVal = $("input[@name=selListRelts][@checked]").val();
				var v_orderStatus = $("input[@name=selListRelts][@checked]").attr("v_orderStatus"); //我们接收订单的时候，订单状态
				var v_orderReslt = $("input[@name=selListRelts][@checked]").attr("v_orderReslt"); //集团规范返回，是否通过、超时
				if(typeof(selListReltsVal) == "undefined"){
					rdShowMessageDialog("请选择一项查询结果进行提交！");
				  return false;
				}
				if(v_orderStatus == "U" || v_orderStatus == "J"){ //订单状态正常，或者集团下发工单
					if(v_orderReslt != "1"){ //验证不通过，或者超时 
						rdShowMessageDialog("工单验证不通过或者验证超时，不允许继续办理业务！");
					  return false;
					}
				}else{ //超时
					rdShowMessageDialog("工单状态超时，不允许继续办理业务！");
				  return false;
				}
				
				var v_custName = $("input[@name=selListRelts][@checked]").attr("v_custName");//客户编码 
				var v_idIccid = $("input[@name=selListRelts][@checked]").attr("v_idIccid"); //客户名称
				var v_idAddr = $("input[@name=selListRelts][@checked]").attr("v_idAddr"); //客户地址
				var v_validDate = $("input[@name=selListRelts][@checked]").attr("v_validDate"); //证件有效期
				var v_loginacceptJT = $("input[@name=selListRelts][@checked]").attr("v_loginacceptJT"); //证件有效期
				var v_validDates = "";
				if(v_validDate.indexOf("-") != -1){
					v_validDate = v_validDate.split("-");
					if(v_validDate.length >= 3){
						v_validDates = v_validDate[0]+v_validDate[1]+v_validDate[2]; 
					}
				}
				window.returnValue=v_custName+"~"+v_idIccid+"~"+v_idAddr+"~"+v_validDates+"~"+v_loginacceptJT;
				window.close(); 
			}
		</SCRIPT>
		<TITLE>工单结果查询</TITLE>
	</HEAD>

	<BODY>
		<FORM method=post name="fPubSimpSel">   
		<%@ include file="/npage/include/header_pop.jsp" %>

			<div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">工单结果查询</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th></th>
					<th>客户姓名</th>
					<th>证件号码</th>
					<th>证件地址</th>
					<th>验证结果</th>
					<th>验证不通过类型</th>
					<th>验证结果文字描述</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='7'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
						if(!"".equals(ret[i][0])){ //工单下发工号存在，则一定存在信息
						String idAddr = ret[i][3];
							if(idAddr.getBytes("GBK").length>60){
								idAddr =subString(idAddr,60,endWith);
							}
%>
							<tr align="center" id="row_<%=i%>">
								<td><input type="radio" id="selListRelts<%=i%>" name="selListRelts" value="<%=ret[i][0]%>" v_custName="<%=ret[i][1]%>" v_idIccid="<%=ret[i][2]%>" v_idAddr="<%=idAddr%>" v_orderStatus="<%=ret[i][8]%>" v_orderReslt="<%=ret[i][5]%>" v_validDate="<%=ret[i][9]%>" v_loginacceptJT="<%=ret[i][10]%>" /></td>
								<td><%=ret[i][1]%></td>
								<td><%=ret[i][2]%></td>
								<td><%=idAddr%></td>
								<td>
									<%if("1".equals(ret[i][5])){%>
											验证通过
									<%}else if("2".equals(ret[i][5])){%>
											验证不通过
									<%}else{%>
											验证超时
									<%}%>
								</td>
								<td>
									<%if("".equals(ret[i][6])){%>
											无
									<%}else{%>
											<%=ret[i][6]%>
									<%}%>
								</td>
								<td>
									<%if("".equals(ret[i][7])){%>
											无
									<%}else{%>
											<%=ret[i][7]%>
									<%}%>
								</td>
							</tr>
<%
						}
					}
				}
%>
				<tr>
				  <td colspan="7" align="center" id="footer">
				    <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确认" onClick="saveToQryInfo()" />   
				    <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="window.close();" />
				  </td>
				</tr>
			</table>
	</div>
</div>
		<%@ include file="/npage/include/footer_pop.jsp" %>
		</FORM>
	</BODY>
</HTML>    
