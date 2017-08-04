<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="javax.servlet.ServletInputStream" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="jxl.*" %>

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	ArrayList retArray = new ArrayList();
	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String[][] agentInfo = (String[][])arr.get(2);
	String workNo = baseInfo[0][2];
	String workName = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String[][] password1 = (String[][])arr.get(4);//读取工号密码 
	String pass = password1[0][0];
	String ip_Addr = agentInfo[0][2]; 
	String op_code = "5145";
	String op_name = "导入资费FAQ问题";
	String Message = "";
	
	String faq_id = request.getParameter("faq_id");
	System.out.println("faq_id="+faq_id);
	String quest_id = "00";

	String paraArray[] = new String[4];
	String login_accept = "";
	boolean continueFlag = true;

    comImpl co=new comImpl();
    Workbook workbook;
    Sheet sheet ;
    
    String quest;
    String answer;
    Cell value;
    String result[] = null;
    String []dataRow = null;
    List goodList = new ArrayList();
    List badList = new ArrayList();
    List al = null;
    String sql = "select to_char(SEQ_FAQ_QUEST_ID.nextval) from dual";
	
	ServletInputStream is = request.getInputStream();
	int bytesRead = 0;
	
	byte[] junk = new byte[1024];
	bytesRead = is.readLine(junk, 0, junk.length);
	bytesRead = is.readLine(junk, 0, junk.length);
	bytesRead = is.readLine(junk, 0, junk.length);
	bytesRead = is.readLine(junk, 0, junk.length);
	
	workbook = Workbook.getWorkbook(is);
	
	sheet = workbook.getSheet(0);
	int max_rows = sheet.getRows();
	int max_columns = sheet.getColumns();
	
	paraArray[0] = faq_id;
	
	if( continueFlag )
	{		
		for(int i=0; i < max_rows; i++)
		{
			al = co.spubqry32("1",sql);
			
			if(al != null)
			{
				String [][]rows = (String[][])al.get(0);
				quest_id = rows[0][0];
			}
			else
			{
				continueFlag = false;
				throw new Exception("取得操作流水失败!");
			}
			
			paraArray[1] = quest_id;
			
			value = sheet.getCell(0,i);
			if( value != null)
			{
				quest = value.getContents();
			}
			else
			{
				quest = "";
			}
			
			value = sheet.getCell(1,i);
			if( value != null)
			{
				answer = value.getContents();
			}
			else
			{
				answer = "";
			}
			
			if(quest.length() > 30 || answer.length() > 300)
			{
				dataRow = new String[3];
				dataRow[0] = quest;
				dataRow[1] = answer;
				dataRow[2] = "问题或者答案过长";
				badList.add(dataRow);
				continue;
			}
			
			paraArray[2] = quest;
			paraArray[3] = answer;
				
			result = impl.callService("s5144AddQuest",paraArray,"1","region",org_code.substring(0,2));

			int errCode = impl.getErrCode();
			String errMsg = impl.getErrMsg();
			if(errCode == 0)
			{
				dataRow = new String[3];
				dataRow[0] = quest_id;
				dataRow[1] = quest;
				dataRow[2] = answer;
				goodList.add(dataRow);
			}
			else
			{
				dataRow = new String[3];
				dataRow[0] = quest;
				dataRow[1] = answer;
				dataRow[2] = errMsg;
				badList.add(dataRow);
			}
		}
	}
	workbook.close(); 
%>
<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link href="<%=request.getContextPath()%>/css/jl.css"  rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css">
</head> 
<body bgcolor="#FFFFFF" text="#000000" background="<%=request.getContextPath()%>/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
    
    <table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
          <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workNo%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workName%>
          	</td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="73%"> 
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b><%=op_name%></b></font></td>
                      <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="289" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%"> 
            <table border="0" cellspacing="0" cellpadding="2" align="right">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>  
    <form name="frm" action="f5145_5.jsp" method="post">
	<input type="hidden" name="quest_id" value="" >
	<input type="hidden" name="privsStr" value="" >
	<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
   	 <tr><td>
      <table border="0" cellspacing="2" cellpadding="2" align="center" width="100%" style="word-break:break-all">
      	<tr bgcolor="#E8E8E8"> 
      		<td colspan="3">导入成功问题列表</td>
      	</tr>
      	<tr bgcolor="#E8E8E8"> 
      		<td width="40%">问题</td>
      		<td width="40%">答案</td>
      		<td width="20%">发布权限</td>
      	</tr>
<%
		for( int i = 0; i < goodList.size(); i++)
		{
			String []row = (String [])goodList.get(i);
%>
      	<tr bgcolor="#E8E8E8"> 
      		<td>&nbsp;<%=row[1]%>
      		</td>
      		<td>&nbsp;<%=row[2]%>
      		<input type="hidden" name="quest_id" value="<%=row[0]%>" >
      		</td>
      		<td>
      			<input type="radio" name="privs<%=row[0]%>" value="128"> 管理员
				<input type="radio" name="privs<%=row[0]%>" value="32"> 营业员<br>
				<input type="radio" name="privs<%=row[0]%>" value="8"> 登陆客户
				<input type="radio" name="privs<%=row[0]%>" value="2" checked> 公开
      		</td>
      	</tr>
<%
		}
%>
      	<tr bgcolor="#E8E8E8"> 
      		<td ></td>
      		<td ><input type="button" value="发布" onclick="doNext()"></td>
      		<td ></td>
      	</tr>
		<tr bgcolor="#E8E8E8"> 
      		<td colspan="3">导入失败问题列表</td>
      	</tr>
      	<tr bgcolor="#E8E8E8"> 
      		<td>问题
      		</td>
      		<td>答案
      		</td>
      		<td>
      			失败原因
      		</td>
      	</tr>
<%
		for( int i = 0; i < badList.size(); i++)
		{
			String []row = (String [])badList.get(i);
%>
      	<tr bgcolor="#E8E8E8"> 
      		<td>&nbsp;<%=row[0]%>
      		</td>
      		<td>&nbsp;<%=row[1]%>
      		</td>
      		<td>
      			&nbsp;<%=row[2]%>
      		</td>
      	</tr>
<%
		}
%>
      </table>
    </td></tr>
	</table>
    </form>
  </body>
</html>

<script language="javascript">
	function doNext()
	{
		var privsStr = "|";
		for(var i=0; i< document.frm.quest_id.length; i++)
		{
			if(document.frm.quest_id[i].value != "")
			{
				var tmp = getPrivs("privs"+document.frm.quest_id[i].value);
				privsStr += document.frm.quest_id[i].value+"|";
				privsStr += tmp + "|";
			}
		}
		document.frm.privsStr.value=privsStr;
		document.frm.submit();
	}
	
	function getPrivs(objName)
	{
		var obj = eval("document.all."+objName);
		for(var x = 0; x <= obj.length ; x++)
		{
			if(obj[x].checked)
			{
				return obj[x].value;
			}
		}
	}
</script>