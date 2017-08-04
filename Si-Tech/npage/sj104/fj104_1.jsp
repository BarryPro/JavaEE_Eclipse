<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangwg @ 20170608
 ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String opCode = "J104";
	String opName = "魔百和机顶盒回库";
	String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String op_name =  "魔百和机顶盒回库";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=op_name%></TITLE>
		<script language=javascript>
			function isNumberString (InString,RefString){
				if(InString.length==0) return (false);
				for (Count=0; Count < InString.length; Count++)  {
				        TempChar= InString.substring (Count, Count+1);
				        if (RefString.indexOf (TempChar, 0)==-1)  
				        return (false);
				}
				return (true);
			}
			function doProcess(packet)
			{
				//使用RPC的时候,以下三个变量作为标准使用.
				var error_code = packet.data.findValueByName("errorCode");
				var error_msg =  packet.data.findValueByName("errorMsg");
				var verifyType = packet.data.findValueByName("verifyType");
				self.status="";
				if(verifyType=="phoneno"){
					if( parseInt(error_code) == 0 ){
						rdShowMessageDialog(error_msg,2);
						location.reload();
					}else{
						rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
						return false;
					}
				}
			}
			function docheck(){
				
				if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
					rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
					document.form1.phoneNo.focus();
					return false;
				}
				
				if(document.form1.PARM_VALUE.value.length!=1)
				{
					rdShowMessageDialog("请选择库存归属");
					return false;
				}
				
				if(document.form1.ImeiNo.value.length<15 || isNumberString(document.form1.ImeiNo.value,"1234567890")!=1) {
					rdShowMessageDialog("Imei格式验证不通过!!");
					document.form1.phoneNo.focus();
					return false;
				}
				
				if(document.form1.UnitId.value.length<32 || isNumberString(document.form1.UnitId.value,"1234567890ABCDEFabcdef")!=1) {
					rdShowMessageDialog("机顶盒ID格式验证不通过!!");
					document.form1.phoneNo.focus();
					return false;
				}
				
				var myPacket = new AJAXPacket("fj104_cfm.jsp","正在确认，请稍候......");
				myPacket.data.add("verifyType","phoneno");
				myPacket.data.add("phoneno",document.form1.phoneNo.value);  
				myPacket.data.add("imeino",document.form1.ImeiNo.value);  
				myPacket.data.add("unitid",document.form1.UnitId.value);  
				myPacket.data.add("typeid",document.form1.PARM_VALUE.value);  
	  			core.ajax.sendPacket(myPacket);
	 			myPacket=null;
			}
		</script>
	</HEAD>
	<BODY>
		<FORM action="fj104_Cfm.jsp" method=post name="form1" id="form1">
			<%@ include file="/npage/include/header.jsp"%>
			<div class="title">
        		<div id="title_zi">魔百和机顶盒回库</div>
    		</div>
			<table cellSpacing="0">
				<tr> 
					<td class=blue>手机号码</td>
					<td>
						<input type="text" size="20" name="phoneNo" id="phoneNo">
					</td>
					<td class=blue>库存归属</td>
					<td>
						<select name="PARM_VALUE">
						  <option value="2">待翻新</option> 				<!--待翻新:待翻新:2-->
						  <option value="3">故障</option>   				<!--故障机器:故障:3-->
						  <option value="5" selected>可再次销售</option>  	<!--可再次销售:复用:5-->
						</select>
					</td>
				</tr> 
				<tr> 
				
					<td class=blue>IMEI号</td>
					<td>
						<input type="text" size="40" name="ImeiNo" id="ImeiNo">
					</td>
					<td class=blue>机顶盒ID</td>
					<td>
						<input type="text" size="40" name="UnitId" id="UnitId">
					</td>
				</tr>
			</table>
			<table cellspacing="0">
				<tr>
					<td noWrap id="footer">
					<div align="center">
						<input type="button" name="next" class="b_foot" value="入库" onclick="docheck()"/>
						&nbsp;
						<input type="button" name="query" class="b_foot" value="清除" onclick="location.reload();" />
						&nbsp;
						<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
					</div>
					</td>
				</tr>
			</table>
		</FORM>
	</BODY
</html>