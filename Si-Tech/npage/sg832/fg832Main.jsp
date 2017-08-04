<%
  /*
   * 功能:宽带营销案绑定信息查询(g832)
   * 版本: 1.0
   * 日期: 2013/07/15 10:10:01
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		//String phoneNo = (String)request.getParameter("activePhone");
		//流水号
 		String loginAccept = getMaxAccept();
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		function doQryIt1()
		{
			if(!check(form_g832))
			{
				return false;
			}
			//手机号码
			var iPhoneNo = $("input[name='iPhoneNo']").val().trim();
			//宽带号码
			var iCfmLogin = $("input[name='iCfmLogin']").val().trim(); 
			if(iPhoneNo.length==0 && iCfmLogin.length==0)
			{
				rdShowMessageDialog("手机号码与宽带号码至少选择一个输入！",1);
				return false;
			}
				var getdataPacket = new AJAXPacket("fg832Qry.jsp","正在获得数据，请稍候......");
  			getdataPacket.data.add("iLoginAccept","<%=loginAccept%>");
  			getdataPacket.data.add("iChnSource","01");
  			getdataPacket.data.add("iOpCode","<%=opCode%>");
  			getdataPacket.data.add("iOpName","<%=opName%>");
  			getdataPacket.data.add("iLoginNo","<%=loginNo%>");
  			getdataPacket.data.add("iLoginPwd","");
  			getdataPacket.data.add("iPhoneNo",iPhoneNo);
  			getdataPacket.data.add("iUserPwd","<%=noPass%>");
  			getdataPacket.data.add("iOpNote","宽带营销案绑定信息查询");
  			getdataPacket.data.add("iCfmLogin",iCfmLogin);
  			core.ajax.sendPacketHtml(getdataPacket,myRetFunc);
  			getdataPacket = null;
		}
		function myRetFunc(data)
		{
				//找到添加表格的div
				var markDiv=$("#intablediv"); 
				//清空原有表格
				markDiv.empty();
				//压入数据
				markDiv.append(data);
			
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="form_g832">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div id="koManage">
	<table>
		<tr>
			<td width="15%" class="blue">手机号码</td>
			<td width="35%">
				<input type="text"  name="iPhoneNo" value="" v_type="mobphone" onblur="checkElement(this)"/>
			</td>
			<td width="15%" class="blue">宽带号码</td>
			<td width="35%">
				<input type="text" name="iCfmLogin" value=""/>
			</td>
		</tr>
	</table>
	<div id="intablediv">
	</div>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="查询" onclick="doQryIt1()" id="doQryIt">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="清除" onclick="javascript:window.location.href='/npage/sg832/fg832Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value="关闭" id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!--ko对象 script区域-->
<script language="javascript">
	var myViewModel = {
					/*offerId:ko.observable("<%=opCode%>")*/
		};
		ko.applyBindings(myViewModel,$("#koManage")[0]);
</script>

</html>
