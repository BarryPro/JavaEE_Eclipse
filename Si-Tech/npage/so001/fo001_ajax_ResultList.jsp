<%
   /*
   * 功能: 增值税纳税人资质信息列表
　 * 版本: v1.0
　 * 日期: 2013-08-30
　 * 作者: wangjxc	
　 * 版权: sitech
   * 修改历史
   * 修改日期:  	
   * 修改人:
   * 修改目的:
 　*/
%>
 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String  CustId	     = (String)request.getParameter("CustId");
		String  TaxpayerId   = (String)request.getParameter("TaxpayerId");
		String workNo = (String)session.getAttribute("workNo");
		String passWord = (String)session.getAttribute("passWord");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode=(String)session.getAttribute("regCode");
		int page_num=Integer.parseInt((String)request.getParameter("PAGE_NUM"));//页码
		String page_num_string=page_num+"";
%>

<wtc:service name="so001Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  <wtc:param value="<%=CustId%>"/>
	  <wtc:param value="<%=TaxpayerId%>"/>
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
		<th>客户标识</th>
		<th>纳税人识别号</th>
		<th>单位名称</th>
		<th>纳税人资质类型</th>
    	<th>发票类型</th>
		<th>联系电话</th>
		<th>地址信息</th>
		<th>开户银行</th>
		<th>银行帐户</th>
		<th>生效时间</th>
		<th>失效时间</th>
	</tr>

	<% 
	if("000000".equals(retCode)){
			int nowPage = 1;
			int allPage = 0;
			int pre_page = 0;
			int next_page = 0;
			
			if(retList.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(retList.length>0){
				for(int i=0;i<retList.length;i++){
				
				
	%>
   <tr>
		<td><%=retList[i][1]%></td>
		<td><%=retList[i][2]%></td>
		<td><%=retList[i][5]%></td>
		<td><%=retList[i][3]%></td>
		<td><%=retList[i][4]%></td>
		<td><%=retList[i][7]%></td>
		<td><%=retList[i][6]%></td>
		<td><%=retList[i][8]%></td>
		<td><%=retList[i][9]%></td>
		<td><%=retList[i][10]%></td>
		<td><%=retList[i][11]%></td>	
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
						总记录数：<font name="totalPertain" id="totalPertain"><%=retList[0][0]%></font>&nbsp;&nbsp;
						总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
						每页行数：10
						<a href="javascript:doQueryTaxpayList('1');">[第一页]</a>&nbsp;&nbsp;
						<a href="javascript:doQueryTaxpayList('<%=pre_page+""%>');">[上一页]</a>&nbsp;&nbsp;
						<a href="javascript:doQueryTaxpayList('<%=next_page+""%>');">[下一页]</a>&nbsp;&nbsp;
						<a href="javascript:doQueryTaxpayList('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
						<span class="pages">转到第 
			<input type="text" class="W_30px" name="jump" value="" onkeyup="if(event.keyCode===13){doQueryTaxpayList(this.value,'<%=allPage+""%>');}" /> 页</span>
			<span class="pages">第<%=page_num+""%>/<%=allPage+""%>页</span>
			
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
	
