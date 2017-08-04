<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "5144";
  String opName = "资费FAQ-问题和答案列表";
  String work_no = (String)session.getAttribute("workNo");
  String work_name = (String)session.getAttribute("workName");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode = org_code.substring(0,2);
  String ip_Addr = request.getRemoteAddr();  
  String op_code = "5144";
  int loginRight = 0;
  String faq_id = request.getParameter("faq_id");
  String Keyword = request.getParameter("Keyword");
  String questIdArr [][] = null;
  String questArr [][] = null;
  String answerArr [][] = null;
  String paraArray[] = new String[4];
    
  paraArray[0] = work_no;
  paraArray[1] = org_code.substring(0,2);
  paraArray[2] = faq_id;
  paraArray[3] = Keyword;
  
  //result = impl.callFXService("s5144Qry",paraArray,"4","region",org_code.substring(0,2));
  
%>
           <wtc:service name="s5144Qry" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="4" >
			       <wtc:params value="<%=paraArray%>"/>
			</wtc:service>
			<wtc:array id="result0" start="0" length="1" scope="end" />
			<wtc:array id="result1" start="1" length="1" scope="end" />
			<wtc:array id="result2" start="2" length="1" scope="end" />
			<wtc:array id="result3" start="3" length="1" scope="end" />
<%   
  String op_name = "资费FAQ-问题和答案列表";
  
  if(!errCode.equals("000000"))
  {
%>
<script language="javascript">
    rdShowMessageDialog("<%=errMsg%>");
    window.parent.opener="";
    window.parent.close();
</script>
<%
  }
  
  if(result0 != null&&result1 != null && result2 != null && result3 != null)
  {
    //loginRight = Integer.parseInt(result0[0][0]);
    loginRight = 128;
    questIdArr = result1;
    questArr   = result2;
    answerArr  = result3;
  }
%>


<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

</head> 
<body>
  <form name="frm" method="post" action="f5144Main.jsp">
<%@ include file="/npage/include/header.jsp" %>
      <table cellspacing="0">
        <tr>
        <td class="blue"><b>关键字</td>
        <td >
            <input type="text" name="Keyword" />&nbsp;
            <input type="button" onclick="doQry()" class="b_text" value="查询"/>
        </td>
            <input type="hidden" name="faq_id" value="<%=faq_id%>"/>
            <input type="hidden" name="quest_id" />
        </tr>
      </table>
  </form>

     <table cellspacing="0">

      <tr>
        <td colspan="2" class="blue"><b>问题列表</b>
        </td>
        
<%                                                                                 
    if(loginRight == 128) //管理员                                               
    {                                                                            
%>                                                                                 
        <td align="center">                                        
            <input type="button" class="b_text" onclick="doAddOne()" value="新增"/> 
        </td> 
<%                                                                                                                              
    }
    else
    {
%>
    	<td></td>
<% 
    }                                                                            
%>                                                                                 
      </tr>
<%
  for(int index = 0; index < questIdArr.length; index ++)
  {
%>
      <tr>
        <td align="center"><%=index+1%></td>
        <td style="word-break:break-all"><font color="#0000ff"><b>问：<%=questArr[index][0]%></b></font></td>
        <td align="center">
<%
      if(loginRight == 128) //管理员
      { 
%>
		<input type="button" onclick="doModify('<%=questIdArr[index][0]%>')" class="b_text" value="修改"/>&nbsp;
		<input type="button" onclick="doDelete('<%=questIdArr[index][0]%>')" class="b_text" value="删除"/>
<%
      }
%>
        </td>
      </tr>
      <tr >
        <td>&nbsp;</td>
        <td>答：<%=answerArr[index][0].replaceAll("\n","<br>")%></td>
        <td >&nbsp;</td>
      </tr>
<%
  }
%>
     </table>

 
  <P>
  	 <%@ include file="/npage/include/footer.jsp" %>	
</form>
  </body>
</html>

<script language="javascript">
  function doQry()
  {
    document.frm.target="_self";
    document.frm.submit();
  }
  
  function doModify(quest_id)
  {
      document.frm.quest_id.value = quest_id;
      document.frm.target="_self";
      document.frm.action="./f5144ModQuest.jsp";
      document.frm.submit();

  }
  
  function doDelete(quest_id)
  {
    if(rdShowConfirmDialog('确定要删除此记录吗？')==1)
    {
        document.frm.quest_id.value = quest_id;
        document.frm.target="_self";
        document.frm.action="./f5144DelQuest.jsp";
        document.frm.submit();
    }
    else
    {
        return;
    }
  }

  function doAddOne()
  {
      document.frm.target="_self";
      document.frm.action="./f5144AddOneQuest.jsp";
      document.frm.submit();

  }

</script>
