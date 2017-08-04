<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%
    String opName="新增资费FAQ-新增问题和答案";
    String opCode = "5144";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String faq_id = request.getParameter("faq_id");
	String op_name = "新增资费FAQ-新增问题和答案";
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
			<div id="title_zi">新增资费FAQ-新增问题和答案</div>
		</div>			
      <table cellspacing="0">
        <tr> 
          <td class="blue">问题</td>
          <td> 
            <input type="text" name="quest" maxlength="30" size=72 value="" class="button" >
          </td>
        </tr>

        <tr> 
          <td class="blue">答案</td>
          <td> 
            <textarea wrap="soft" name="answer" rows=3 cols=60 ></textarea>
          </td>
        </tr>
        <tr >
          <td class="blue">发布权限</td>
          <td > 
            <input type="radio" name="privs" value="128" > 管理员
            <input type="radio" name="privs" value="32" > 营业员
            <input type="radio" name="privs" value="8" > 登陆客户
            <input type="radio" name="privs" value="2"  checked> 公开
          </td>
        </tr>
        <tr id = "footer"> 
          <td colspan="2" align="center">
            <input type="button" class= "b_foot" value="确定" onclick="doAdd()"/>
            <input type="button" class= "b_foot" value="取消" onclick="cancel()"/>
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
        rdShowMessageDialog("问题不能为空，请重新输入！");
          document.frm.quest.focus();
          return false;
    }
    else if (document.frm.answer.value == "")
    {
        rdShowMessageDialog("答案不能为空，请重新输入！");
          document.frm.answer.focus();
        return false;
    } 
    else if(document.frm.answer.value.length > 150)
    {
        rdShowMessageDialog("答案长度大于150个字符，请重新输入！");
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
