<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 家庭客户成员管理
   * 版本: 1.0
   * 日期: 2013-4-25 13:46:01
   * 作者: yansca
   * 版权: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<head>
	<title>家庭客户成员管理</title>
	<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String activePhoneG645  = request.getParameter("activePhone");
	%>
	<script language="JavaScript">
		
		 function queryInfo(){
        if(!check(frmg645)){
            return false;
        }
        var myPacket = new AJAXPacket("fg645_show.jsp","正在获取信息，请稍候......");
		    myPacket.data.add("phoneNo",$("#phoneNo").val());
	    	myPacket.data.add("opCode",'<%=opCode%>');
	    	myPacket.data.add("opName",'<%=opName%>');
		    core.ajax.sendPacketHtml(myPacket,doQueryInfo);
		    myPacket =null;
    }
    
    function doQueryInfo(data){
    	  $("#showdiv").empty().append(data);
        var retCode = $("#retCode").val();
        var retMsg = $("#retMsg").val();
        if(retCode!="000000"){
             rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
             window.location.href="fg645_main.jsp?activePhone=<%=activePhoneG645%>&opCode=<%=opCode%>&opName=<%=opName%>";
        }
    }
	
	</script>
<body>
<form id="frmg645" name="frmg645" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">查询条件</td>
			<td>
				  <select id="queryId" name="queryId">
				  	      <option>服务号码</option>
			    </select>
			</td>
			<td class="blue">条件信息</td>
			<td>
				<input type="text" id="phoneNo" name="phoneNo"  v_must="1" v_type="mobphone" maxlength="11" value="<%=activePhoneG645%>" readonly="readonly" class="InputGrey" />
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="查询" onclick="queryInfo()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<div id="showdiv"></div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>