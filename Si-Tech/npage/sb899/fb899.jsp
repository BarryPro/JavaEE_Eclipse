<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ϵ������ fb901
   * �汾: 1.0
   * ����: 2010/11/30
   * ����: wanglm
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%	request.setCharacterEncoding("GBK");%>
<%
	String opCode="b899";
	String opName="Ӫҵ��״̬ʵʱչʾ";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	String today  = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>Ӫҵ��״̬ʵʱչʾ</TITLE>
</HEAD>
<script type="text/javascript" src="validate_time.js"></script>
<script language="javascript" >
	function selectGroup(){
    	window.open("grouptree.jsp",'_blank','height=600,width=300,scrollbars=yes');
	}
	function doSubmit(){
		if($("#groupId").val() == ""){
			rdShowMessageDialog("��ѡ����֯�ڵ�!");
			return;
		}
	   	form1.action = "fb899_sub.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	   	form1.submit();
	}
</script>
<body>	
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">Ӫҵ��״̬ʵʱչʾ</div>
    </div>
    <table cellSpacing="0">
    	<tr>
    		<td class="blue">��֯�ڵ�</td>
    		<td>
    			<input type="hidden" name="groupId" id="groupId">
    			<input type="text" name="groupName" id="groupName" class="InputGrey" readonly />
    			<font color="orange">*</font>
    			<input type="button" name="selectBtn" class="b_text" value="ѡ��" onclick="selectGroup()" />
    		</td>
    		<td class="blue">
	            չʾʱ��	
	        </td>	
	        <td>
	       	    <input id="showTime" type="text"  name="showTime"  v_type="new_date" v_must="1" onblur="checkElement1(this)" value="<%=today%>" /> 
	        </td>
    	</tr>	
    	<tr>
			<td colspan="6" align="center" id="footer">
			<input class="b_foot" name="submits" type="button" onclick="doSubmit()" value="ȷ��" />
			<input class="b_foot" name="reee"    type="button" onClick="form1.reset()" value="���"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="�ر�"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
    		
    			