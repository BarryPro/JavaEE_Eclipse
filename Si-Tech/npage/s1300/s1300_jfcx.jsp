<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String result[][];
	String opCode = "1302";
	String opName="账号缴费";
	String id_no  = request.getParameter("id_no");
  
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaa id_no is "+id_no);
	  %>
		<wtc:service name="bs_MarkMsgQry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
			<wtc:param value="<%=id_no%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
    result=result1;
	 


	//System.out.println("sql_str="+sql_str);

	int result_row = result.length;
	if (result_row==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("没有查询到用户积分记录!");
	history.go(-1);
</script>
<%	
	return;
	}
%>

<HTML><HEAD><TITLE>预存分类信息</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户当前积分</div>
		</div>
    <TABLE cellSpacing="0">
      <TBODY>
        <tr align="center">
          <th>用户当前积分</th>
        
        </TR>
	        <tr align="center">
				 <td><%= result[0][3]%></td>
	        </tr>
  
 
        </TBODY>
	    </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp;
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
   </DIV>
</DIV>
</FORM>
</BODY></HTML>
