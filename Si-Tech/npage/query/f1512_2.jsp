<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������ʷ���ϲ�ѯ</TITLE>
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
    String opName = "������ʷ���ϲ�ѯ";
%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String regionCode = Department.substring(0,2);
 String password = (String)session.getAttribute("password"); 
		
	String phoneNo = request.getParameter("phoneNo");//��ѯ����

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
        	rdShowMessageDialog("û�в�ѯ��������ݣ�");
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
	<div id="title_zi">��ѯ���</div>
</div>
<input type="hidden" name="opCode"  value="1512">

<table cellspacing="0" id=contentList>
    <TR> 
        <TD class=blue>�������</TD>
        <TD colspan=6>
            <input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value=<%=phoneNo%>>
        </TD>
    </TR>
    
    
    
    <tr>
        <th>��������ʱ��</th>
        <th>��������</th>
        <th>�ͻ�����</th>
        <th>֤������</th>
        <th>֤������</th>  
        <th>��ϵ������</th>  
        <th>��ϵ�绰</th>
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
            <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
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

                                    
