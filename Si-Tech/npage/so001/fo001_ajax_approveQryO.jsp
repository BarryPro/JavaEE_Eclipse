<%
   /*
   * ����: ��ֵ˰��˰��������Ϣ�б�
�� * �汾: v1.0
�� * ����: 2013-08-30
�� * ����: wangjxc	
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:  	
   * �޸���:
   * �޸�Ŀ��:
 ��*/
%>
 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String  CustId	     = (String)request.getParameter("CustId");
		String  TaxpayerId   = (String)request.getParameter("TaxpayerId");
		String  auditState   = (String)request.getParameter("auditState");
		String  LoginNo   = (String)request.getParameter("LoginNo");
		String  model   = (String)request.getParameter("model");
		String workNo = (String)session.getAttribute("workNo");
		String passWord = (String)session.getAttribute("passWord");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode=(String)session.getAttribute("regCode");
		int page_num=Integer.parseInt((String)request.getParameter("PAGE_NUM"));//ҳ��
		String page_num_string=page_num+"";
%>

<wtc:service name="so001AppQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  <wtc:param value="<%=CustId%>"/>
	  <wtc:param value="<%=TaxpayerId%>"/>
	  <wtc:param value="<%=auditState%>"/>
	  <wtc:param value="<%=LoginNo%>"/>
	  <wtc:param value="<%=model%>"/>
	  <wtc:param value="<%=page_num_string%>"/>
	  <wtc:param value="10"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>
	<%
	String[][] AllPageNum   = new String[][]{};
	AllPageNum   = retList;
	String data_num="";
	int anum = 0;
	if(retList.length>0)
	{
		data_num = AllPageNum[0][0];
		anum = Integer.parseInt(data_num);
	}	
	%>	


<div class="list">
		<table id="tbSort">
	<tr>
		<th>�ͻ���ʶ</th>
		<th>��˰��ʶ���</th>
		<th>�ϼ�������������</th>
		<th>�ϼ���������ʱ��</th>
    	<th>�ϼ������������</th>
		<th>������Ա��������</th>
		<th>������Ա����ʱ��</th>
		<th>������Ա�������</th>
		<th>����״̬</th>
		<th>��������</th>
	</tr>

	<% 
	if("000000".equals(retCode)){
			int nowPage = 1;
			int allPage = 0;
			int pre_page = 0;
			int next_page = 0;
			
			if(retList.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(retList.length>0){
				for(int i=0;i<retList.length;i++){
				
				
	%>
   <tr>
		<td><%=retList[i][1]%></td>
		<td>
		   <a href="javascript:viewTaxPayerInfoO('<%=retList[i][1]%>','<%=auditState %>','<%=retList[i][3]%>','<%=retList[i][6]%>')"><%=retList[i][2]%></a>
		</td>
		<td><%=retList[i][3]%></td>
		<td><%=retList[i][4]%></td>
		<td><%=retList[i][5]%></td>
		<td><%=retList[i][6]%></td>
		<td><%=retList[i][7]%></td>
		<td><%=retList[i][8]%></td>
		<td><%=retList[i][9]%></td>
		<td><%=retList[i][10]%></td>
   </tr>
   <%
		
	}
   %>
</table>
</div>
	

	<%
	allPage = anum/ 10 + 1 ;	
	pre_page = (page_num>1)?(page_num-1):page_num;		
	next_page = ((page_num+1)<allPage)?(page_num+1):allPage;

	 %>	
	
	
	<div align="center">
				<table align="center">
					<tr>
						<td align="center">
						�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=retList[0][0]%></font>&nbsp;&nbsp;
						��ҳ����<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
						ÿҳ������10
						<a href="javascript:doQueryApproveListO('1');">[��һҳ]</a>&nbsp;&nbsp;
						<a href="javascript:doQueryApproveListO('<%=pre_page+""%>');">[��һҳ]</a>&nbsp;&nbsp;
						<a href="javascript:doQueryApproveListO('<%=next_page+""%>');">[��һҳ]</a>&nbsp;&nbsp;
						<a href="javascript:doQueryApproveListO('<%=allPage%>');">[���һҳ]</a>&nbsp;&nbsp;
						<span class="pages">ת���� 
			<input type="text" class="W_30px" name="jump" value="" onkeyup="if(event.keyCode===13){doQueryApproveListO(this.value,'<%=allPage+""%>');}" /> ҳ</span>
			<span class="pages">��<%=page_num+""%>/<%=allPage+""%>ҳ</span>
			
						</td>
					</tr>
				</table>
				</div>
				<input type="hidden" id="nowPage" />
  				<input type="hidden" id="allPage" value="<%= allPage %>" />
	
	
<%	}}else{

		return;
	}
	%>
	<input type="hidden" name="retCode" id="retCode" value="<%=retCode%>" />
	<input type="hidden" name="retMsg" id="retMsg" value="<%=retMsg%>" />
	
