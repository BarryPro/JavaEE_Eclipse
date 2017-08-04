<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 家庭客户信息查询
   * 版本: 1.0
   * 日期: 2013-4-30 10:51:33
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
	<title>家庭客户信息查询</title>
	<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
	%>
	<script language="JavaScript">
		
		 function queryInfo(){
			 var phone_no= $("#phoneNo").val();
			 //alert("phone_no="+phone_no);
        if(!check(frmg646)){
            return false;
        }
        var myPacket = new AJAXPacket("fg646_show.jsp","正在获取信息，请稍候......");
		    myPacket.data.add("phoneNo",phone_no);
	    	myPacket.data.add("opCode",'<%=opCode%>');
	    	myPacket.data.add("opName",'<%=opName%>');
	    	//myPacket.data.add("finishFlag",$("#finishFlag").val());
		    core.ajax.sendPacketHtml(myPacket,doQueryInfo);
		    myPacket =null;
    }
    
    function doQueryInfo(data){
    	  $("#showdiv").empty().append(data);
        var retCode = $("#retCode").val();
        var retMsg = $("#retMsg").val();
        if(retCode!="000000"){
             rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
             window.location.href="fg646_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        }
        frmg646.query.disabled = true;
    }
    
   function checkPwd()
   {
   	  if(!check(frmg646)){
          return false;
      }
      var userPasswd = document.frmg646.userPasswd.value;
      //alert("userPasswd="+userPasswd);
      
       var myPacket = new AJAXPacket("fg646_checkPwd.jsp","正在获取信息，请稍候......");
	    myPacket.data.add("phoneNo",$("#phoneNo").val());
	    myPacket.data.add("passWord",userPasswd);
  		myPacket.data.add("opCode",'<%=opCode%>');
  		myPacket.data.add("opName",'<%=opName%>');
	    core.ajax.sendPacketHtml(myPacket,doCheckPwd);
	    myPacket =null;
      
 
  }
  
  function doCheckPwd(data){
	 $("#showdiv").empty().append(data);
  	 var retCode = $("#checkRetCode").val();
     var retMsg = $("#checkRetMsg").val();
	
    
	if(retCode != "000000"){
			frmg646.userPasswd.value = "";
			rdShowMessageDialog(retMsg,0);
			frmg646.query.disabled = true;
		    return false;	        	
	} else{
			rdShowMessageDialog("密码校验成功！",2);
			frmg646.query.disabled = false;
	}
	 
 }
	
	</script>
<body>
<form id="frmg646" name="frmg646" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
			<!-- <td class="blue">家庭客户状态</td>
			<td>
				  <select id="finishFlag" name="finishFlag">
				  	      <option value="0" selected="selected">生效</option>
				  	      <option value="2">已解散</option>
			    </select>
			</td> -->
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
			    <jsp:include page="/npage/common/pwd_1.jsp">
		          <jsp:param name="width1" value="16%"  />
		          <jsp:param name="width2" value="34%"  />
		          <jsp:param name="pname" value="userPasswd"  />
		          <jsp:param name="pwd" value="accountPasswd"  />
	            </jsp:include>
	        <input name=chkPass type=button onClick="checkPwd();" class="b_text" style="cursor:hand" id="chkPass" value=校验>
          <font class="orange">*</font>
    	</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" id="query" name="query" class="b_foot" value="查询" onclick="queryInfo()" disabled="disabled"  />
				&nbsp;
				<input type="button" id="close" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<div id="showdiv"></div>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>