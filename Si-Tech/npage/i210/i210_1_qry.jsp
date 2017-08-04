<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
      String opCode = "i210";
	  String opName = "赠费失败查询";
	  String begin_tm=request.getParameter("begin_tm");
	  String end_tm=request.getParameter("end_tm");
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  
	  String s_op_code="1311";//查询服务用的
	  //分页
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 20;
	   
	  //开始 结束 
	  	


	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[6];
	 
	  inParas2[0]=s_op_code;
	  inParas2[1]=begin_tm;
	  inParas2[2]=end_tm;
	  inParas2[3]= "" + iPageNumber;
	  inParas2[4]="" + iPageSize;
	  inParas2[5]=workno;
 
%>
<wtc:service name="bi210Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="8">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
			<wtc:param value="<%=inParas2[4]%>"/>
			<wtc:param value="<%=inParas2[5]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="4" scope="end"/>
<wtc:array id="mainInfo2"  start="6" length="2" scope="end"/>
<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo1; 
		int nowPage = 1;
		int allPage = 0;
		
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
			//System.out.println("CCCCCCCCCCCCCCCCxxxxxxxxxxxxxxxxxxxxxxCCCCCCCCC 成功"+result1.length+" and result1[i][0] is "+result1[0][0]);
			allPage = (Integer.parseInt(mainInfo2[0][0])- 1) / 20 + 1 ;
			%>
				 
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>查询结果</TITLE>
				</HEAD>
				<body>


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>
				<!--
//界面元素包括：开始时间、结束时间、活动名称（活动名称为一个下拉框，先固定只展示“砍白菜活动”），
-->

					  <table cellspacing="0" id = "PrintA">
								<tr> 
									<th>手机号码</th>
									<th>时间</th>
									<th>金额</th> 
									
							<%
								for(int i=0;i<result1.length;i++)
								{
									%>
										<tr>
											<td><%=result1[i][0]%></td>
											<td><%=result1[i][1]%></td>
											<td><%=result1[i][2]%></td>
										</tr>
									<%
								}
							%>

						 
						
						   
						  
					  </table>
					 
					<!--分页-->
					<div align="center">
						<table align="center">
						<tr>
							<td align="center">
								总记录数：<font name="totalPertain" id="totalPertain"><%=mainInfo2[0][0]%></font>&nbsp;&nbsp;
								总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
								当前页：<font name="currentPage" id="currentPage"><%=mainInfo2[0][1]%></font>&nbsp;&nbsp;
								每页行数：20
								<!--
								<a href="javascript:setPage('1');">[第一页]</a>&nbsp;&nbsp;
								<a href="javascript:setPage('-1');">[上一页]</a>&nbsp;&nbsp;
								<a href="i092_2_qry_next.jsp?pageNumber=">[下一页]</a>&nbsp;&nbsp;
								 

								<a href="javascript:setPage('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
								-->
								&nbsp;&nbsp;跳转到
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value);">
									<%
									for (int i = 0; i <= allPage; i ++) {
										if(i==0)
										{
											%>
												<option value="<%=i%>">--请选择</option>
											<%
										}
										else
										{
											%>
												<option value="<%=i%>">第<%=i%>页</option>
											<%
										}
									
									}
									%>
								</select>
								页
								<input type="button" class="b_foot" value="返回" onclick="window.location.href='i210_1.jsp'">
							</td>
						</tr>
						</table>
					</div>
					<!--end 分页-->	
							
				<input type="hidden" id="nowPage" />
				<input type="hidden" id="allPage" value="<%= allPage %>" />		

				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
				</BODY></HTML>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("查询结果为空！");
					window.location.href="i210_1.jsp";
				</script>
			<%
		}
%>	 
<script language="javascript">
	 
	 
	function gotos(page)
	{
		//var page_now = document.all.toPage[document.all.toPage.selectedIndex].value;
		window.location.href="i210_1_qry.jsp?pageNumber="+page+"&begin_tm=<%=begin_tm%>&end_tm=<%=end_tm%>";
	}
	function inits()
	{
		var page_now = document.all.toPage[document.all.toPage.selectedIndex].value;
		$("#currentPage").text(page);
	}
	
	
</script> 
 


