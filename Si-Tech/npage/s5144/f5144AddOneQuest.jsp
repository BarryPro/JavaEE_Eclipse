<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%
    String opName="�����ʷ�FAQ-��������ʹ�";
    String opCode = "5144";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String faq_id = request.getParameter("faq_id");
	String op_name = "�����ʷ�FAQ-��������ʹ�";
%>

<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head> 
<body>
	<form name="frm" method="post">
	 <%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">�����ʷ�FAQ-��������ʹ�</div>
		</div>			
      <table cellspacing="0">
        <tr> 
          <td class="blue">����</td>
          <td> 
            <input type="text" name="quest" maxlength="30" size=72 value="" class="button" >
          </td>
        </tr>

        <tr> 
          <td class="blue">��</td>
          <td> 
            <textarea wrap="soft" name="answer" rows=3 cols=60 ></textarea>
          </td>
        </tr>
        <tr >
          <td class="blue">����Ȩ��</td>
          <td > 
            <input type="radio" name="privs" value="128" > ����Ա
            <input type="radio" name="privs" value="32" > ӪҵԱ
            <input type="radio" name="privs" value="8" > ��½�ͻ�
            <input type="radio" name="privs" value="2"  checked> ����
          </td>
        </tr>
        <tr id = "footer"> 
          <td colspan="2" align="center">
            <input type="button" class= "b_foot" value="ȷ��" onclick="doAdd()"/>
            <input type="button" class= "b_foot" value="ȡ��" onclick="cancel()"/>
          </td>
        </tr>
      </table>
         <input type="hidden" name="faq_id" value="<%=faq_id%>"/>
          <%@ include file="/npage/include/footer.jsp" %>
  </form>
  </body>
</html>

<script language="javascript">

  function doAdd()
  { 
    if (document.frm.quest.value == "") 
    {
        rdShowMessageDialog("���ⲻ��Ϊ�գ����������룡");
          document.frm.quest.focus();
          return false;
    }
    else if (document.frm.answer.value == "")
    {
        rdShowMessageDialog("�𰸲���Ϊ�գ����������룡");
          document.frm.answer.focus();
        return false;
    } 
    else if(document.frm.answer.value.length > 150)
    {
        rdShowMessageDialog("�𰸳��ȴ���150���ַ������������룡");
        return false;
    }
     else
     {
       document.frm.target="_self";
       document.frm.action="./f5144AddQuest.jsp";
       document.frm.submit();
     } 
  }
  
  function cancel()
  {
     document.frm.action="./f5144Main.jsp";
     document.frm.submit();
  }
  
</script>
