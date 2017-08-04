<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 添加家庭成员
   * 版本: 1.0
   * 日期: 2013-4-26 17:56:59
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
	<title>添加家庭成员</title>
	<%
		String opCode = request.getParameter("opCode");
		String custId = request.getParameter("custId");
		
		String opName = "添加家庭成员";
	%>
	<script language="JavaScript">
		
		 function queryInfo(){
        if(!check(frmg645)){
            return false;
        }
        var myPacket = new AJAXPacket("fg645_addShow.jsp","正在获取信息，请稍候......");
		    myPacket.data.add("phoneNo",$("#phoneNo").val());
		    myPacket.data.add("custId",'<%=custId%>');
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
             window.location.href="fg645_add.jsp?opCode=<%=opCode%>&custId=<%=custId%>";
        }
    }
	
	</script>
<body>
<form id="frmg645" name="frmg645" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">查询客户信息</div>
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
				<input type="text" id="phoneNo" name="phoneNo"  v_must="1" v_type="mobphone" maxlength="11"/><font class="orange">*</font>&nbsp;&nbsp;&nbsp;<input type="button" name="query" class="b_foot" value="查询" onclick="queryInfo()" />
			</td>
		</tr>
	</table>
	 <table cellSpacing="0">
        <tr> 
          <td id="footer" >
			        <input class="b_foot"  id="b_close" name="b_close"    onclick="javascript:window.close();" type="button" value="关闭" />
			    </td>
        </tr>
    </table>
	<div id="showdiv"></div>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>