<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ȫ��ͨ��������1121
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
<%
	String contractno = request.getParameter("contractno");
    int [] lens ={2,3};
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regionCode");			//��������
	String[] inParas = new String[1];
	inParas[0] = contractno;
	
//	ScallSvrViewBean viewBean = new ScallSvrViewBean();
//	CallRemoteResultValue  value  = viewBean.callService("1", orgcode.substring(0,2) ,  "s1362Query", "5"  ,  lens , inParas) ;
%>  
	<wtc:service name="s1362Query" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	<wtc:array id="result2" start="1" length="1" scope="end"/>
<% 
 	String[][] result  = null ;
	String[][] result2  =null;
 
//    ArrayList list  = value.getList();
//	result = (String[][])list.get(0);

	String return_code = result[0][0];
 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
    
%>

<%if (return_code.equals("000000")) {%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>������BOSS-Ԥ����ϸ��ѯ</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</head>
<BODY>
<table colspan="0">
    <tr> 
      <th align="center">��Ŀ����</th>
      <th align="center">Ԥ����</th>
      <th align="center">�Ƿ����</th>
    </tr>
    <% for(int i=0; i < result.length  ; i++)
	{
		%>
			<tr> 
			  <td> 
				<div align="center"><%=result2[i][0]%></div>
			  </td>
			  <td> 
				<div align="center"><%=result2[i][1]%></div>
			  </td>
			   <td> 
				<div align="center"><%=result2[i][2]%></div>
			  </td>
			</tr>
    <%}%>
 
    <tr> 
      <td colspan="6"> 
        <div align="center"> 
          <input class="b_foot" type="button" name="return" value="�� ��" onClick="removeCurrentTab()">
        </div>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
</body>
</html>
<%} else {%>
   <SCRIPT LANGUAGE="JavaScript">
      window.returnValue="��ѯ���� ������룺'<%=return_code%>'��������Ϣ��'<%=error_msg%>'��";
	  window.close();     
   </SCRIPT>
<%}%>