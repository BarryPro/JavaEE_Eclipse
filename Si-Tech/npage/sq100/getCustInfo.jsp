<%
/********************
    version v2.0
    ������: si-tech
    zhouby
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);

    String opCode = "1104";
    String opName = "��ͨ����";

    String pageTitle = "�ͻ���Ϣ��ѯ";
    String fieldNum = "";
    
    String password = (String)session.getAttribute("password");	
	  String work_no = (String)session.getAttribute("workNo");
	  String ipAddr = (String)session.getAttribute("ipAddr");
	  
	  String id_iccid = (String)request.getParameter("idIccid");
%>

<HTML><HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
  <%@ include file="/npage/include/header_pop.jsp" %>  
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>

  <wtc:service name="sCustTypeQryC" outnum="6" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="1100"/>
      <wtc:param value="<%=work_no%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=id_iccid%>"/>
  </wtc:service>
  
	<wtc:array id="result" scope="end" start="0"/>
 <%
      		int recordNum = result.length;
      		int runCodeJ=0; //Ԥ��
      		int runCodeI=0;//Ԥ��
      		int i=0;
      		if (recordNum > 0 ) {
          		for(i=0; i < recordNum; i++) {
          		    if(result[i][5].trim().equals("Ԥ��")) {
          		        runCodeJ++;
          		    }
          		    if(result[i][5].trim().equals("Ԥ��")) {
          		        runCodeI++;
          		    }
          		}
      		}
    		  out.print("<table cellspacing='0'><TR>");
    		       out.print("<TD >");
    		           out.print("<div>�ܼ�������:");
    		           out.print(recordNum);
    		           out.print("</div>");
    		       out.print("</TD>");
    		       out.print("<TD >");
    		           out.print("<div>Ԥ����:");
    		           out.print(runCodeJ);
    		           out.print("</div>");
    		       out.print("</TD>");
    		       out.print("<TD >");
    		           out.print("<div>Ԥ����:");
    		           out.print(runCodeI);
    		           out.print("</div>");
    		       out.print("</TD>");
    		    out.print("</TR></table>");
    		    
      		 
%>
       <table cellspacing='0'>
          <TR align='center'>
            <th>�������</th>
            <th>����ʱ��</th>
            <th>֤������</th>
            <th>֤������</th>
            <th>������</th>
            <th>״̬</th>
          </TR>
<%   

        if (recordNum > 0 ) {
           for(int j = 0; j < recordNum; j++) {
%>
             <tr>
               <td><%=result[j][0]%></td>
               <td><%=result[j][1]%></td>
               <td><%=result[j][2]%></td>
               <td><%=result[j][3]%></td>
               <td><%=result[j][4]%></td>
               <td><%=result[j][5]%></td>
             </tr>
<%
           }
       }
%> 
    </table>
    
    <TABLE cellspacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>

  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    
