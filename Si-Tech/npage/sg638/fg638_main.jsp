<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��ͥ�ͻ�����
   * �汾: 1.0
   * ����: 2013-4-19 9:54:49
   * ����: yansca
   * ��Ȩ: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<head>
	<title>��ͥ�ͻ�����</title>
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
	        	rdShowMessageDialog("����������!",0);
	        	 return false;
	        }
	        
	        var myPacket = new AJAXPacket("fg638_show.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
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
    	    rdShowMessageDialog("�������1��"+checkRetCode+"<br>������Ϣ1��"+checkRetMsg,0);
    	}else{
			//$("#showdiv").empty().append(data);
	        var retCode = $("#retCode").val();
	        var retMsg = $("#retMsg").val();
	        if(retCode!="000000"){      	  
	        	    rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
	              	window.location.href="fg638_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	        } 
    		
    	}
    	
    }
    
  <%--   function checkPwd(){
    	var myPacket = new AJAXPacket("fg638_checkPwd.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
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
      	    rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
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
			<td class="blue">��ѯ����</td>
			<td>
				  <select id="queryId" name="queryId">
				  	      <option>�������</option>
			    </select>
			</td>
			<td class="blue">������Ϣ</td>
			<td>
				<input type="text" id="phoneNo" name="phoneNo"  v_must="1" v_type="mobphone" maxlength="11"/><font class="orange">*</font>
			</td>
			<td class="blue">����</td>
			<td>
				<input type="password" id="passWord" name="passWord"  v_must="1" maxlength="6"/><font class="orange">*</font>
				<!-- <input type="button" name="check" class="b_foot" value="У��" onClick="checkPwd();"> -->
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="��ѯ" onclick="queryInfo()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
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
