<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
      String opCode = "i086";
	  String opName = "ר���Ŀ���ѯ";
	 
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  //��ʼ ����
	  String s_new=request.getParameter("s_new"); //һ����Ŀ������
	  String s_level = request.getParameter("level"); //һ����Ŀ������
	  System.out.println("SSSSSSSSSSSSSSSSSSSSSSSS s_new is "+s_new+" and s_level is "+s_level);
	  
	  String ret_val[][];
	  String ret_val_new[][];
	 /* int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		int recordcount=0;
	*/
//ƴ��sql ʹ��stringBuffer where 1=1 and~~   sbuffer.append("");
/*
��ƣ� ����Ӧ����forѭ��,�ֱ�ȡ��ÿ���µķֱ�ļ�¼��Ȼ��չ��?
	   forѭ���������� YYYYMMȡ��������
	   for(k=vBeginTime;k<=vEndTime;)
	   int iBegin = Integer.parseInt(print_begin);
int iEnd = Integer.parseInt(print_end);
int vYear=0;
int vMonth = 0;
vYear = iBegin/100;
vMonth=iBegin%100;	
int k = 0;
*/
 
%>
<wtc:service name="bi086BillQry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="10">
		    <wtc:param value="<%=s_new%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=s_level%>"/>
</wtc:service>
<wtc:array id="mainInfo1" start="0" length="2" scope="end"/>
<wtc:array id="mainInfo2" start="2" length="1" scope="end"/>
<wtc:array id="mainInfo21" start="3" length="2" scope="end"/>
<wtc:array id="mainInfo3" start="5" length="1" scope="end"/> 
<wtc:array id="mainInfo4" start="6" length="2" scope="end"/>
<wtc:array id="mainInfo5" start="8" length="1" scope="end"/> 
<wtc:array id="mainInfo6" start="9" length="1" scope="end"/> 
<%
		String errCode = retCode5;
		String errMsg = retMsg5;
		String ret_code="";
		String[][] result1  = null ;
		String[][] result2  = null ;
		String[][] result3  = null ;
		String[][] result4  = null ;
		String[][] result5  = null ;
		String[][] result6  = null ;
		result1 = mainInfo1;
		result2 = mainInfo2;
		result3 = mainInfo3;
		result4 = mainInfo4;
		result5 = mainInfo5;
		result6 = mainInfo6;
		ret_code=result1[0][0];
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAA ret_code is "+ret_code);
		if(ret_code.equals("0")||ret_code.equals("000000"))
		{
			System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCC �ɹ�");
			%>
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>��ѯ���</TITLE>
				</HEAD>
				<body>


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">��ѯ���</div>
				</div>
				<table cellspacing="0">
				<%
					//һ��
					if(s_level=="1" ||s_level.equals("1"))
					{
						if(mainInfo2.length>0)
						{
							%>
								<tr > 
									<td rowspan=<%=mainInfo2.length+1%> align="center" width="20%" >һ����Ŀ���Ӧ�Ķ�����Ŀ��</td>
									<%
										for(int i =0;i<mainInfo2.length;i++)
										{
											%>
												<tr>
													<td align="center"><%=mainInfo2[i][0]%></td>
													<td align="center">��</td>
												</tr>
											<%
										}
					    }	
									%>
								</tr>
						
								<p>
								<tr > 
									<td rowspan=<%=mainInfo21.length+1%> align="center" width="20%">һ����Ŀ���Ӧ��������Ŀ��</td>
									<%
										if(mainInfo21.length>0)
										{
											for(int i =0;i<mainInfo21.length;i++)
											{
												%>
													<tr>
														<td align="center"><%=mainInfo21[i][0]%></td>
														<td align="center"><%=mainInfo21[i][1]%></td>
													</tr>
												<%
											}
										}
										
									%>
								</tr>
							<%
								
						
						
					}
					if(s_level=="2" ||s_level.equals("2"))
					{
						if(mainInfo3.length>0)
						{
							%>
								<tr > 
									<td rowspan=<%=mainInfo3.length+1%> align="center" width="20%">������Ŀ���Ӧ��һ����Ŀ��</td>
									<%
										for(int i =0;i<mainInfo3.length;i++)
										{
											%>
												<tr>
													<td align="center"><%=mainInfo3[i][0]%></td>
													<td align="center">��</td>
												</tr>
											<%
										}
									%>
								</tr>
								<p>
								<tr > 
									<td rowspan=<%=mainInfo4.length+1%> align="center" width="20%">������Ŀ���Ӧ��������Ŀ��</td>
									<%
										for(int j =0;j<mainInfo4.length;j++)
										{
											%>
												<tr>
													<td align="center"><%=mainInfo4[j][0]%></td>
													<td align="center"><%=mainInfo4[j][1]%></td> 
												</tr>
											<%
										}
									%>
								</tr>
							<%
								
						}
					 
					}
					if(s_level=="3" ||s_level.equals("3"))
					{
						%>
							<tr > 
								<td rowspan=<%=mainInfo5.length+1%> align="center" width="20%">������Ŀ���Ӧ��һ����Ŀ��</td>
								<%
									for(int j =0;j<mainInfo5.length;j++)
									{
										%>
											<tr>
												<td align="center"><%=mainInfo5[j][0]%></td>
												 
											</tr>
										<%
									}
								%>
							</tr>
							<p>
							<tr > 
								<td rowspan=<%=mainInfo6.length+1%> align="center" width="20%">������Ŀ���Ӧ�Ķ�����Ŀ��</td>
								<%
									for(int j =0;j<mainInfo6.length;j++)
									{
										%>
											<tr>
												<td align="center"><%=mainInfo6[j][0]%></td>
												 
											</tr>
										<%
									}
								%>
							</tr>
						<%
					}		
				%>

					  
								
						 	
						<tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot" name=back onClick="window.location = 'i086_1.jsp' " type=button value=����>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
							</td>
						</tr>
					</table>
				 
				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
				</BODY></HTML>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("��ѯ���Ϊ�գ�");
					window.location.href="i086_1.jsp";
				</script>
			<%
		}
%>	 
 


