<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
    String opCode = "9105";
    String opName = "�Զ�У������ѯ";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");	
	String op_name = "�Զ�У������ѯ";
	String regionCode = (String)session.getAttribute("regCode");
    	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    	//String[][] baseInfoSession = (String[][])arrSession.get(0);
    	//String[][] otherInfoSession = (String[][])arrSession.get(2);
	String orgCode = (String)session.getAttribute("rogCode");
	    //String[][] pass = (String[][])arrSession.get(4);
	String password  = (String)session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
function conf()
{		  
    if(!check(document.frm)){
        	return false;			
        }
  if(document.frm.verifyType.value==0){
	frm.action="f9105_2.jsp";
  frm.submit();
  }
 if(document.frm.verifyType.value==1){
	frm.action="f9105_2.jsp";
  frm.submit();
  }
}
</script>
</head>
<body>
<form name="frm" method="POST" action="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
<%@ include	file="/npage/include/header.jsp"%>
	<div class="title">
    	<div id="title_zi">�Զ�У������ѯ</div>
    </div>
<table cellSpacing="0">        
          <tr> 
            <td nowrap class=blue>��ѯ��ʽ</td>
            <td colspan="4"> 
              <div align="left"> 
               <select size=1 name=verifyType>                
                 <option value="0">���ܴ���</option>
                 <option value="1">У������</option>
               </select>
              </div>
            </td>
          </tr>
          <tr>
            <td class=blue nowrap>��ѯ����</td>
            <td colspan="4">
            	<input name="message" type="text" maxlength="30" id="message" value="" v_type="string">
            </td>
          </tr>
          <tr>
          	<td colspan="5" id="footer">
          		 <div align="center">
	          	   <input name="sumbit" class="b_foot" type="button"  value="��ѯ" onClick="conf()">
	          		 <input type="button" name="close" value="�ر�" class="b_foot" onclick="removeCurrentTab()"/>
               </div>
             </td>
          </tr>
</table>          	
<%@ include file="/npage/include/footer.jsp"%>	
</form>	 	
</body>
</html>
