<%
/********************
 * version v2.0
 * ������: si-tech
 * create by wanglm @ 2010-8-9 
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%> 
  
<%    
   String opCode = "b284"; 
   String opName = "�û��������";
   String workNo = (String)session.getAttribute("workNo");
   String workName = (String)session.getAttribute("workName");
   String password = (String)session.getAttribute("password");
   String regionCode = (String)session.getAttribute("regCode");
%>

<HTML>
<HEAD>
<TITLE>�û��������</TITLE>
</HEAD>
<SCRIPT type=text/javascript>
	function doJudge(){
	  	var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][0345789]\d{9}$/;
	    var sInput = $("#phone").val();
	    if(sInput.search(patrn)==-1){
		showTip("#phone","��ʽ����ȷ,���������룡");
	    }else{
	       hiddenTip("#phone");
	       var chkPacket = new AJAXPacket("fb284_2.jsp","��ȴ���������");
           chkPacket.data.add("qd" , "01");	
		   chkPacket.data.add("opCode" , "<%=opCode%>");	
		   chkPacket.data.add("workNo" , "<%=workNo%>");	
		   chkPacket.data.add("password" , "<%=password%>");
		   chkPacket.data.add("phone" ,sInput );
		   chkPacket.data.add("phonePass" , "");
		   chkPacket.data.add("workName" , "<%=workName%>");
		   core.ajax.sendPacket(chkPacket,doPD);
		   chkPacket =null; 
	    }
	}
	function doPD(packet){
	   var code = packet.data.findValueByName("code");
	   rdShowMessageDialog(code);
	}
</script>
<BODY>
	 <form>
	 	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">�û��������</div>
		</div>
	    <table>
	      <tr>
	        <td class="blue">�������ֻ����� &nbsp;&nbsp;&nbsp;  <input type="text" id="phone" />&nbsp;&nbsp;&nbsp;   <input type="button"  onclick="doJudge()" value="ȷ��" class="b_foot" /></td>
	      </tr>
	    </table>
	    <div id="footer">
	    <input type="reset" value="����" class="b_foot" />
	    <input type="button" value="�ر�" class="b_foot" id="clo" onClick="removeCurrentTab()" />	
	    </div>
	    <%@ include file="/npage/include/footer.jsp" %>
	 </form>
</BODY>
</HTML>