<%@ page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String phone_no = request.getParameter("phone_no");
	String workNo = (String) session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String retCode ="";
	String retMsg  ="";
	System.out.println("test~~~~~~~~~~~~~~~~~$$$$$$$$$$$$" +phone_no+"====="+workNo );
%>

<wtc:service name="sActiveQry" routerKey="region" routerValue="<%=regionCode%>" retcode="code" retmsg="msg" outnum="3">
	  <wtc:param value="<%=workNo%>"/>
	  <wtc:param value="<%=phone_no%>"/>	
	  <wtc:param value="01"/>	
</wtc:service>
<wtc:array id="retActiveQry" scope="end"/>
	
<%
System.out.println("test~~~~~~~~~~~~~~~~~$$$$$$$$$$$$" + retActiveQry.length );
if(code.equals("000000")||code.equals("0")){
	if(retActiveQry.length>0)
	{
%>
<!--ҵ���Ƽ���Ϣ��ʼ-->
<div id="Operation_Table">
	<div class="title">
	   <div id="title_zi">ҵ���Ƽ���Ϣ</div>
	</div>
          <div class="list">
              <table cellspacing="0" id="nominateOperList">
                  <tr>
                      <th>�ͻ�����</th>
                      <th>�����</th>
                      <th>����</th>
                  </tr>
                  <%
                  for(int i=0;i<retActiveQry.length;i++)
									{ 
                  %>
                  <tr>
                      <td><%=retActiveQry[i][0]%></td> 
                      <td><%=retActiveQry[i][1]%></td>
                      <td><input type="button" class="b_text" value="�Ƽ�" onclick="nominateOper('<%=phone_no%>','<%=retActiveQry[i][0]%>','<%=retActiveQry[i][2]%>');"/></td>
                  </tr>  
                  <%
                  }
                  %>                    
              </table>
          </div>  			
</div>		
<!--ҵ���Ƽ���Ϣ����-->
<%
 }
}
%>	