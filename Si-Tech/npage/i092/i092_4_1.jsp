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
	  String opName = "ǿ��Ԥ��";
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  
	  String op_accept=request.getParameter("op_accept");

	  //��ҳ
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 200;
	   
	  //��ʼ ���� 


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
			System.out.println("CCCCCCCCCCCCCCCCxxxxxxxxxxxxxxxxxxxxxxCCCCCCCCC �ɹ�"+result1.length);
			allPage = (Integer.parseInt(mainInfo2[0][0])- 1) / iPageSize + 1 ;//ҳ���� ����ҲҪ��
			%>
				 
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>��ѯ���</TITLE>
				</HEAD>
				<body onload="inits()">


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">��ѯ���</div>
				</div>

					  <table cellspacing="0" id = "PrintA">
								<tr> 
									<th>��ˮ</th>
									<th>�ֻ�����</th>
									<th>��ǰ״̬</th>

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
		
							  <input class="b_foot" name=back onClick="window.location = 'i092_4.jsp' " type=button value=����>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
							</td>
						  </tr>
						  
					  </table>
					 
					<!--��ҳ-->
					<div align="center">
						<table align="center">
						<tr>
							<td align="center">
								�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=mainInfo2[0][0]%></font>&nbsp;&nbsp;
								��ҳ����<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
								��ǰҳ��<font name="currentPage" id="currentPage"><%=mainInfo2[0][1]%></font>&nbsp;&nbsp;
								ÿҳ������<%=iPageSize%>
								<!--
								<a href="javascript:setPage('1');">[��һҳ]</a>&nbsp;&nbsp;
								<a href="javascript:setPage('-1');">[��һҳ]</a>&nbsp;&nbsp;
								<a href="i092_2_qry_next.jsp?pageNumber=">[��һҳ]</a>&nbsp;&nbsp;
								 

								<a href="javascript:setPage('<%=allPage%>');">[���һҳ]</a>&nbsp;&nbsp;
								-->
								&nbsp;&nbsp;��ת��
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value,'<%=mainInfo2[0][0]%>');">
									<%
									for (int i = 0; i <= allPage; i ++) {
										if(i==0)
										{
											%>
												<option value="<%=i%>">--��ѡ��</option>
											<%
										}
										else
										{
											%>
												<option value="<%=i%>">��<%=i%>ҳ</option>
											<%
										}
									
									}
									%>
								</select>
								ҳ
							</td>
						</tr>
						</table>
					</div>
					<!--end ��ҳ-->	
							
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
 


