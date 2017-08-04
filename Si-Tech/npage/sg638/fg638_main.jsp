<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 家庭客户开户
   * 版本: 1.0
   * 日期: 2013-4-19 9:54:49
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
	<title>家庭客户开户</title>
	<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
	%>
	<script language="JavaScript">
		
		 function queryInfo(){
	        if(!check(frmg638)){
	            return false;
	        }
	        
	        var passWord = $("#passWord").val();
	        //alert("passWord="+passWord);
	        if(passWord==""){
	        	rdShowMessageDialog("请输入密码!",0);
	        	 return false;
	        }
	        
	        var myPacket = new AJAXPacket("fg638_show.jsp","正在获取信息，请稍候......");
		    myPacket.data.add("phoneNo",$("#phoneNo").val());
		    myPacket.data.add("passWord",$("#passWord").val());
	    	myPacket.data.add("opCode",'<%=opCode%>');
	    	myPacket.data.add("opName",'<%=opName%>');
		    core.ajax.sendPacketHtml(myPacket,doQueryInfo);
		    myPacket =null;
    }
    
    function doQueryInfo(data){
        $("#showdiv").empty().append(data);
    	var checkRetCode = $("#checkRetCode").val();
        var checkRetMsg = $("#checkRetMsg").val();
        if(checkRetCode!="000000"){   
    	    rdShowMessageDialog("错误代码1："+checkRetCode+"<br>错误信息1："+checkRetMsg,0);
    	}else{
			//$("#showdiv").empty().append(data);
	        var retCode = $("#retCode").val();
	        var retMsg = $("#retMsg").val();
	        if(retCode!="000000"){      	  
	        	    rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
	              	window.location.href="fg638_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	        } 
    		
    	}
    	
    }
    
  <%--   function checkPwd(){
    	var myPacket = new AJAXPacket("fg638_checkPwd.jsp","正在获取信息，请稍候......");
    	 myPacket.data.add("phoneNo",$("#phoneNo").val());
	    myPacket.data.add("passWord",$("#passWord").val());
    	myPacket.data.add("opCode",'<%=opCode%>');
    	myPacket.data.add("opName",'<%=opName%>');
	    core.ajax.sendPacketHtml(myPacket,doCheckRet);
	    myPacket =null;
    }
    
    function doCheckRet(data){
  	 // $("#showdiv").empty().append(data);
      var retCode = $("#checkRetCode").val();
      var retMsg = $("#checkRetMsg").val();
      if(retCode!="000000"){
      	    rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      } 
  } --%>
	
	</script>
<body>
<form id="frmg638" name="frmg638" method="POST" >
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
				<input type="text" id="phoneNo" name="phoneNo"  v_must="1" v_type="mobphone" maxlength="11"/><font class="orange">*</font>
			</td>
			<td class="blue">密码</td>
			<td>
				<input type="password" id="passWord" name="passWord"  v_must="1" maxlength="6"/><font class="orange">*</font>
				<!-- <input type="button" name="check" class="b_foot" value="校验" onClick="checkPwd();"> -->
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
	<iframe name="buzhou1" id="buzhou1" width="100%" height="330" style="display:none"></iframe>
    <iframe name="buzhou2" id="buzhou2" width="100%" height="210" style="display:none"></iframe>
    <iframe name="buzhou3" id="buzhou3" width="100%" height="1000" style="display:none"></iframe>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
