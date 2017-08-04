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
      String opCode = "i092";
	  String opName = "强制预拆";
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  
	  String op_accept=request.getParameter("op_accept");

	  //分页
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 200;
	   
	  //开始 结束 


	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[5];

	  inParas2[0]=workno;
	  inParas2[1]=op_accept;
	  inParas2[2]= "" + iPageNumber;
	  inParas2[3]="" + iPageSize;
 
%>
<wtc:service name="bi092_chk" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="13">
		  <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="3" scope="end"/>
<wtc:array id="mainInfo2"  start="5" length="2" scope="end"/>
<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo1; 
		int nowPage = 1;
		int allPage = 0;
		
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
			System.out.println("CCCCCCCCCCCCCCCCxxxxxxxxxxxxxxxxxxxxxxCCCCCCCCC 成功"+result1.length);
			allPage = (Integer.parseInt(mainInfo2[0][0])- 1) / iPageSize + 1 ;//页数的 这里也要改
			%>
				 
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>查询结果</TITLE>
				</HEAD>
				<body onload="inits()">


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>

					  <table cellspacing="0" id = "PrintA">
								<tr> 
									<th>流水</th>
									<th>手机号码</th>
									<th>当前状态</th>

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

						 
						
						  <tr id="footer"> 
							<td colspan="9">
		
							  <input class="b_foot" name=back onClick="window.location = 'i092_4.jsp' " type=button value=返回>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
							</td>
						  </tr>
						  
					  </table>
					 
					<!--分页-->
					<div align="center">
						<table align="center">
						<tr>
							<td align="center">
								总记录数：<font name="totalPertain" id="totalPertain"><%=mainInfo2[0][0]%></font>&nbsp;&nbsp;
								总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
								当前页：<font name="currentPage" id="currentPage"><%=mainInfo2[0][1]%></font>&nbsp;&nbsp;
								每页行数：<%=iPageSize%>
								<!--
								<a href="javascript:setPage('1');">[第一页]</a>&nbsp;&nbsp;
								<a href="javascript:setPage('-1');">[上一页]</a>&nbsp;&nbsp;
								<a href="i092_2_qry_next.jsp?pageNumber=">[下一页]</a>&nbsp;&nbsp;
								 

								<a href="javascript:setPage('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
								-->
								&nbsp;&nbsp;跳转到
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value,'<%=mainInfo2[0][0]%>');">
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
					rdShowMessageDialog(retMsg2);
					window.location.href="i092_4.jsp";
				</script>
			<%
		}
%>	 
<script language="javascript">
	
	function inits()
	{
		document.getElementById("toPage").disabled=false;
	}

	

	function gotos(page,total_1)
	{
		document.getElementById("toPage").disabled=true;
		window.location.href="i092_4_1.jsp?pageNumber="+page+"&op_accept="+<%=op_accept%> ; 
	}
	
	function getId(id_no)
	{
		alert(id_no);
	}
</script> 
 


