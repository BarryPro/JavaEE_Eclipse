<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ӫ���ݷ��� fb902
   * �汾: 1.0
   * ����: 2010/12/02
   * ����: ningtn
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%
	String opCode="b902";
	String opName="������Ӫ���ݷ���";
	String work_no = (String)session.getAttribute("workNo");
	String today  = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Ӫҵ��</title>
		
		<script type="text/javascript">
			function callDraw(){
				if($("#groupId").val() == ""){
			      rdShowMessageDialog("��ѡ����֯�ڵ�!");
			      return;
		         }
				form1.action="fb902_sub.jsp?opCode=<%=opCode%>";
				form1.submit();
			}
			function selectGroup(){
    	        window.open("grouptree.jsp",'_blank','height=600,width=300,scrollbars=yes');
	        }
		</script>	
	</head>
	<body>
<FORM method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">������Ӫ���ݷ���</div>
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
    		<td>��ѯʱ��</td>
    		<td>
    		   <input type="text" name="time" id="time" v_type="date" v_must="1" onblur="checkElement(this)" value="<%=today%>" /><font color="orange">*YYYYMMDD    eg��20101225</font>
    		</td>
    	</tr>	
    	<tr>
			<td colspan="6" align="center" id="footer">
			<input class="b_foot" name="submits" type="button" onclick="callDraw()" value="��ѯ" />
			<input class="b_foot" name="reee"    type="button" onClick="form1.reset()" value="���"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="�ر�"/>
			</td>
		</tr>
    </table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>	