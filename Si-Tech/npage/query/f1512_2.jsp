<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>过户历史资料查询</TITLE>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
    String opCode = "1512";
    String opName = "过户历史资料查询";
%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String regionCode = Department.substring(0,2);
 String password = (String)session.getAttribute("password"); 
		
	String phoneNo = request.getParameter("phoneNo");//查询条件

%>
					<wtc:service name="sCustTypeQryJ"  routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="7" >
						<wtc:param value="0" />
						<wtc:param value="01" />	
						<wtc:param value="1512" />	
						<wtc:param value="<%=workNo%>" />
						<wtc:param value="<%=password%>" />
						<wtc:param value="<%=phoneNo%>" />
						<wtc:param value="" />
						<wtc:param value="" />
						<wtc:param value="0" />
			</wtc:service>
			<wtc:array id="result"  scope="end"/>
				

<%
	
	System.out.println("------------55555575555555555-------------");
	//String [][] result = new String[][]{};
	//result = (String[][])arlist.get(0);
	if (result.length==0) {
%>
        <script language="JavaScript">
        	rdShowMessageDialog("没有查询到相关数据！");
        	history.go(-1);
        </script>
<%
	}
	else
	{
	    System.out.println(result[0][1]);
%>	

</HEAD>

<body>

<FORM method=post name="frm1512">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
<input type="hidden" name="opCode"  value="1512">

<table cellspacing="0" id=contentList>
    <TR> 
        <TD class=blue>服务号码</TD>
        <TD colspan=6>
            <input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value=<%=phoneNo%>>
        </TD>
    </TR>
    
    
    
    <tr>
        <th>过户操作时间</th>
        <th>操作工号</th>
        <th>客户姓名</th>
        <th>证件类型</th>
        <th>证件号码</th>  
        <th>联系人姓名</th>  
        <th>联系电话</th>
    </tr>
    
<%
    for(int y=0;y<result.length;y++){
%>
    <tr>
<%
        for(int j=0;j<result[0].length;j++){
%>
    
            <td>
                <%=result[y][j]%>
            </td>
<%
        }
%>
    </tr>
<%
    }
%>
    <tr id="footer" > 
        <td colspan=7>
            <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->
<%
}
%>

                                    
