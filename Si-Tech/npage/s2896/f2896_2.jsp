<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��ѯ���������
�� * �汾: v1.0
�� * ����: 2009��03��04��
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%@ page import="java.text.*"%>
<%
	String opCode = "2896";	
	String opName = "��ѯ���������";	//header.jsp��Ҫ�Ĳ���   
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
		String loginNo=(String)session.getAttribute("workNo"); 
	String workName = (String)session.getAttribute("workName");
	String workPwd = (String)session.getAttribute("password");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");

	String queryInfo = request.getParameter("parterId");
	String iTypeCode = request.getParameter("oTypeCode");
	

	System.out.println("queryInfo="+queryInfo);
	
	String regionCode = orgCode.substring(0,2);

	
	String  currentYear= (String)session.getAttribute("currentYear");
	
	System.out.println("22222222222="+currentYear);
	
	 String[][] result = new String[][]{};
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>

<div id="productList" >
<div class="title"><div id="title_zi">�����������Ϣ�б�</div></div>

<table cellspacing="0" id="productTab" >
    <tr align="center">
        <th nowrap>���������</th>
        <th nowrap>���� </th>
        <th nowrap>״̬</th>   
        
    </tr>
    <wtc:service name="se539Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="<%=opCode%>"/>
              <wtc:param value="<%=loginNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=queryInfo%>"/>
              <wtc:param value="<%=iTypeCode%>"/>
              <wtc:param value=""/>
   </wtc:service>
   <wtc:array id="rows"  scope="end" />
	<%
  		    if (retCode.equals("000000")){
  		        result = rows;
  		    }else{
  		        %>
  		            <script type=text/javascript>
  		                rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
  		                window.close();
  		            </script>
  		        <%
  		    }  	

       for(int i=0;i<result.length;i++){

       System.out.println(result[i][0]);
       System.out.println(result[i][1]);
       System.out.println(result[i][2]);
    %>
    <tr align="center">

        <td nowrap class="blue" >
        	
        	<%=result[i][0]%>
        </td>
        <%
        if("01".equals(result[i][1].trim())){
        %>
        <td nowrap class="blue">����</td>
        <%
        }
        else if("02".equals(result[i][1].trim())){
        %>        
        <td nowrap class="blue">����</td>
        <%
        }
        else{
        %>        
        <td nowrap class="blue">WAPPush</td>
        <%
        }       
        
        
         if("1".equals(result[i][2].trim()))
        {
%>
        <td nowrap class="blue">����</td>   
<%      }
   			else  if("3".equals(result[i][2].trim())){
%>
				<td nowrap class="blue">��ͣ</td>
<%      }  
%>   
        	
        	
        
    </tr>
    <%
       }
    %>
</table>
</div>

<table cellSpacing=0> 
  <tr>
    <td align="center" id="footer" colspan="4">
      <input class="b_foot" name=reset type=button value="�ر�" onClick="window.close();">
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>