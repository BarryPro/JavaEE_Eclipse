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
    String opName="修改资费FAQ-问题和答案修改";
    String opCode = "5144";
	String workNo   = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr  = request.getRemoteAddr();  
	String nopass  = (String)session.getAttribute("password");       //登陆密码 
	String regionCode = org_code.substring(0,2);
	String faq_id = request.getParameter("faq_id");
	String quest_id = request.getParameter("quest_id");
	String op_name = "修改资费FAQ-问题和答案修改";
  
  
  String sql = "select quest, answer, request_privs from dfaqlist where quest_id='" +quest_id+ "'";
  System.out.println("sql="+sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="3">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%  
  String QuestStr = "";
  String AnswerStr = "";
  String request_privs = "";

  if(result!=null)
  {
    QuestStr = result[0][0];
    AnswerStr = result[0][1];
    request_privs = result[0][2];
  }
  else
  {
%>
    <script language="javascript" >
    alert("数据库查询错误");
    window.close();
    </script>
<%    
  }
%>

<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

</head> 
<body >
    <form name="frm" method="post">
    	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">修改资费FAQ-问题和答案修改</div>
		</div>	    	
    	<input type="hidden" name="request_privs" maxlength="8" value="<%=request_privs%>" >
      <table cellspacing="0">
        <tr > 
          <td class="blue">问题</td>
          <td > 
            <input type="text" name="quest" maxlength="30" size=72 value="<%=QuestStr%>" class="button" >
          </td>
        </tr>
    	<tr> 
          <td class="blue">答案</td>
          <td> 
            <textarea wrap="soft" name="answer" rows=3 cols=60 ><%=AnswerStr%></textarea>
          </td>
    </tr>
    
    <tr >                                                                 
      <td class="blue>发布权限</td>                                                       
      <td>                                                                     
        <input type="radio" name="privs" value="128" onclick="changePrivs()"> 管理员       
        <input type="radio" name="privs" value="32" onclick="changePrivs()"> 营业员
        <input type="radio" name="privs" value="8" onclick="changePrivs()"> 登陆客户       
        <input type="radio" name="privs" value="2" onclick="changePrivs()"> 公开           
      </td>                                                                                
    </tr>                                                                                  
    <tr id = "footer"> 
       <td colspan="2" align="center">
          <input class = "b_foot" type="button" value="确定" onclick="modify()"/>
          <input class = "b_foot" type="button" value="取消" onclick="cancel()"/>
       </td>
    </tr>
   </table>
         <input type="hidden" name="faq_id" value="<%=faq_id%>"/>
         <input type="hidden" name="quest_id" value="<%=quest_id%>"/>
         <%@ include file="/npage/include/footer.jsp" %>
  </form>
  </body>
</html>

<script language="javascript">

  function modify()
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
        rdShowMessageDialog("答案长度大于150个字符！");
        return false;
    }
     else
     {
       document.frm.target="_self";
       document.frm.action="./f5144UpdateQuest.jsp";
       document.frm.submit();
     } 
  }
  
  function cancel()
  {
     document.frm.action="./f5144Main.jsp";
     document.frm.submit();
  }
  
  	function chgContent()
    {
        var k=0;
        for(k=0;k<document.all.privs.length;k++)
        {
            if(document.all.privs[k].value==document.all.request_privs.value)
            {
        		document.all.privs[k].checked = true;
            }
        }
    }
    
    function changePrivs()
	{
		for(var i=0; i< document.all.privs.length; i++)
		{
			if(document.all.privs[i].checked)
			{
				document.all.request_privs.value=document.all.privs[i].value;
			}
		}
	}
	
</script>
