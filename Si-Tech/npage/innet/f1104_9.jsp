<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.02
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>

<%@ include file="/npage/include/public_title_name.jsp" %>

<% request.setCharacterEncoding("gb2312");%>


<%
	String eInfo = request.getParameter("eInfo");
	//System.out.println(eInfo);
	String[] eInfo1 = eInfo.split("~");
	//System.out.println("444444444444444444"+eInfo1[0]);
	//System.out.println(eInfo1[1]);
	//System.out.println(eInfo1[2]);
	//System.out.println(eInfo1[3]);
	//System.out.println(eInfo1[4]);
	//System.out.println(eInfo1[5]);
	
	String editValue = "";
	int chPos = -1;
%>

<HTML><HEAD><TITLE>������BOSS-��e����ϸ��Ϣ</TITLE>
<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="viewRes">  
         <%@ include file="/npage/include/header_pop.jsp" %>
  	
		<div class="title">
			<div id="title_zi">��e����ϸ��Ϣ</div>
		</div>
  
        <table cellspacing="0">
          <!-------
 ƾ֤״̬����
      ����ʡ��������
      ƾ֤���
      �ۿ���  
      ��Ч��  
      ��������        
--------->
          <TR> 
            <TD width=15% nowrap> 
              <div align="right">ƾ֤״̬</div></TD>
     	    <TD width=25% nowrap> 
              <div align="left"><%=eInfo1[0]%></div></TD>
      	    <TD width=15% nowrap> 
              <div align="right">����ʡ����</div></TD>
     	    <TD width=45% nowrap> 
              <div align="left"><%=eInfo1[1]%></div></TD>
     </TR>

          <TR> 
            <TD width=15% nowrap> 
              <div align="right">ƾ֤���</div></TD>
     	    <TD width=25% nowrap> 
              <div align="left"><%=eInfo1[2]%></div></TD>
     	    <TD width=15% nowrap> 
              <div align="right">�ۿ���</div></TD>
      	    <TD width=45% nowrap> 
              <div align="left"><%=eInfo1[3]%></div></TD>
     </TR> 
          <TR> 
            <TD width=15% nowrap> 
              <div align="right">��Ч��</div></TD>
     	    <TD width=25% nowrap> 
              <div align="left"><%=eInfo1[4]%></div></TD>
     	    <TD width=15% nowrap> 
              <div align="right">��������</div></TD>
      	    <TD width=45% nowrap> 
              <div align="left">��</div></TD>
     </TR>  
   </table>


        <TABLE cellSpacing="0">
          <TBODY> 
          <TR> 
            <TD align=center id="footer">                          
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value="  ����  ">&nbsp;            
            </TD>
        </TR>
    </TBODY>
    </TABLE>
  <%@ include file="/npage/include/footer_pop.jsp" %>   
</FORM>
</BODY></HTML>    
