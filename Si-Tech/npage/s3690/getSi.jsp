<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-04-17
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s3690/pub.js"></script>
<%
    //�õ��������
    ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
 	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
 	String opName = "si��ѯ";
%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
    
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String pay_si= request.getParameter("pay_si"); 
    System.out.println("----pay_si---"+pay_si);
    String sqlStr = "select nvl(count(*),0) num from  dpartermsg where PARTER_ID='"+pay_si+"'";
	String sqlStr1 = "select PARTER_ID,PARTER_NAME  from dpartermsg where PARTER_ID = '"+pay_si+"'";
	System.out.println("---------"+sqlStr1);
    //retArray = callView.sPubSelect("2",sqlStr1);	
    try{
    %>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="32">
    	<wtc:sql><%=sqlStr1%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr1" scope="end" />
    <%
    if (retCode1.equals("000000") && retArr1.length>0){
        result = retArr1;
    }
    
    //result = (String[][])retArray.get(0);	
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-���ſͻ���ѯ</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">si��ѯ</div>
</div>
<!------------------------------------------------------>
  <TABLE cellSpacing=0>
             <TR align="center">
                 <Th>si����</Th>
	             <Th>si����</Th>
              </tr>  
               <TR align="center">
                 <TD><%=result[0][0]%></TD>
	             <TD><%=result[0][1]%></TD>
              </tr>         
              
        <TR id="footer"> 
            <TD colspan='3'>
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=ȷ��>       
            </TD>
            
        </TR>
   <TABLE>

  <!------------------------>  
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
<%
}catch(Exception ee){
    ee.printStackTrace();
%>
    <script>
        rdShowMessageDialog("����SI���벻��ȷ!",0);  
        window.close();
    </script>
<%   
}
%>
