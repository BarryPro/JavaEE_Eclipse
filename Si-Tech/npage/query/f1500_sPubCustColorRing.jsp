<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�ͻ�-�û���Ӧ��ϵ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String password = (String)session.getAttribute("password");

	String phoneNo = request.getParameter("phoneNo");
	
	String inParas[] = new String[4];
  inParas[0] = phoneNo;
  inParas[1] = workno;
  inParas[2] = password;
  inParas[3] = opCode;
	//list = viewBean.callFXService("s3066Query",inParas,"8","phone",inParas[0]);
%>
	<%--
		20100906 by lichaoa ������BOSS�������Ӳ��忪ͨ�͵���ʱ���ѯ���ܵ����� 
		����3���������
		begin
	--%>
	<wtc:service name="s3066Query" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
		<wtc:param value="0"/>
		<wtc:param value=""/>		
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="totalResult0" start="0" length="2" scope="end"/>
	<wtc:array id="totalResult"  start="2" length="9" scope="end"/>
	<wtc:array id="totalResult1"  start="7" length="1" scope="end"/>

<%
	System.out.println("1111111111111111111111111111111111111111a"+totalResult.length);
	System.out.println("1111111111111111111111111111111111111111a"+retCode1);
		int iretCode=Integer.parseInt(retCode1);
        String test[][] = totalResult;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");		
	if (iretCode != 0 && iretCode != 306602) {
%>
		  <script language="JavaScript">
		      rdShowMessageDialog("������Ϣ��ѯʧ��! ");
		      history.go(-1);
		  </script>
<% 
	}else{ 
	if( iretCode == 306602) 
	{
		totalResult = new String [1][8];
		totalResult[0][2] = "������Ϣ";
		totalResult[0][3] = "���û����ǲ����û�";
		totalResult[0][4] = "";
		totalResult[0][5] = "";
		totalResult[0][6] = "";
		totalResult[0][7] = "0";
		totalResult[0][8] = "";
		totalResult[0][9] = "";
		totalResult[0][10] = "";
	}
%>
<HTML>
<HEAD>
<TITLE>������Ϣ��ѯ</TITLE>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM method=post name=form>
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">������Ϣ</div>
		</div>
    <table cellspacing="0">
      <tr align="center"> 
        <th>��������</th>
				<th>�����ײ�</th>
				<th>��ǰ�Ƿ���Ч</th>
				<th>�����Ʒ��ʼʱ��</th>
				<th>�����Ʒ����ʱ��</th>
				<th>���忪ͨʱ��</th>
				<th>���嵽��ʱ��</th>
				<th>ҵ���ں��ʷ�</th>
			 </tr>
		<%--
		20100906 by lichaoa ������BOSS�������Ӳ��忪ͨ�͵���ʱ���ѯ���ܵ����� 
		���Ӳ��忪ͨ����ʱ��
		begin
		--%>
            <% 
            			
				for (int i=0;i<totalResult.length; i++) {
					if(totalResult[i][0]!=null){
			%>
        <tr>
			<td>
				<%=totalResult[i][0]%>
			</td>
			<td>
				<%=totalResult[i][1]%>
			</td>
			<td>
				<%
					if("Y".equals(totalResult[i][2]))
					{
						out.print("��ǰ��Ч");
					}
					else if("N".equals(totalResult[i][2]))
					{
					  	out.print("ԤԼ��Ч");
					}
				%>
			</td>
			<td>
				<%=totalResult[i][3]%>
			</td>
			<td>
				<%=totalResult[i][4]%>
			</td>
			<td>
				<%=totalResult[i][6]%>
			</td>
			<td>
				<%=totalResult[i][7]%>
			</td>
			<td>
				<%=totalResult[i][8]%>
			</td>
		</tr>  
       <%--lichaoa 20100906 ������BOSS�������Ӳ��忪ͨ�͵���ʱ���ѯ���ܵ�����
    	����3���ֶ�������ʾ������Ļ��Χ��������Ĵ����滻������Ĵ��롣 
                <tr> 
                  <td width="20%" nowrap><%=totalResult[i][0]%>&nbsp;</td>
		  						<td width="20%" nowrap><%=totalResult[i][1]%>&nbsp;</td>
		  						<td width="20%" nowrap>
					  <%
					  	  if("Y".equals(totalResult[i][2]))
					  	  {
					  	  	out.print("��ǰ��Ч");
					  	  }
					  	  else if("N".equals(totalResult[i][2]))
					  	  {
					  	  	out.print("ԤԼ��Ч");
					  	  }
					  %>
					  			&nbsp;
                 </td>
					  		 <td width="20%" nowrap><%=totalResult[i][3]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][4]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][6]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][7]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][8]%>&nbsp;</td>
					  		 
					  	</tr>
		20100906 by lichaoa ������BOSS�������Ӳ��忪ͨ�͵���ʱ���ѯ���ܵ����� 
		���Ӳ��忪ͨ����ʱ��
		end
		--%>
					  <% }} %>
					    <tr>
					    	<td>��������Ϣ</td>
					    	<td colspan="7" nowrap>
					  <%
					  	  if("0".equals(totalResult1[0][0])){
					  	  	out.print("���û����ǲ������û�");
					  	  }else if("1".equals(totalResult1[0][0])){
					  	  	out.print("���û��ǲ������û�");
					  	  }
					  %>
                &nbsp;
                </td>
					    </tr>
           </table>

        <table cellspacing="0">
	        <tbody> 
	          <tr> 
	      	    <td id="footer">
	    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
	    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=�ر�>
	    	    </td>
	          </tr>
	        </tbody> 
	      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
<% } %>

