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
      String opCode = "i282";
	  String opName = "�������ѹ��ܲ�ѯ";
	  String phone_no=request.getParameter("phone_no"); 
	  //phone_no="01";
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  
	 
	  
	   
	  //��ʼ ���� 
	  	


	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[6];
	 
	  inParas2[0]="";
	  inParas2[1]="";
	  inParas2[2]="";
	  inParas2[3]= ""  ;
	  inParas2[4]="";
	  inParas2[5]=workno;
 
%>
<wtc:service name="bi282Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="5">
		    <wtc:param value="<%=phone_no%>"/>
		 
</wtc:service>
<wtc:array id="mainInfo0"  start="0" length="2" scope="end"/>
<wtc:array id="mainInfo1"  start="2" length="3" scope="end"/> 
<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo1; 
	 
		retCode2="000000";
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
		 
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
				<!--
//����Ԫ�ذ�������ʼʱ�䡢����ʱ�䡢����ƣ������Ϊһ���������ȹ̶�ֻչʾ�����ײ˻������
-->
<script language="javascript">
	function kt(rule_id)
	{
		//alert("kt "+rule_id);//�ѹر�״̬ �ſ�ͨ
 
		var s_flag='A';
		var url="i282_3.jsp?s_flag="+s_flag+"&s_rule_id="+rule_id;
		var url_new =url;//URLencode(url);
		document.frm1508_2.action=url;
		//alert(url);
		document.frm1508_2.submit();  
	}
	function gb(rule_id)
	{
		//alert("gb "+rule_id);
		var s_flag='D';
		var url="i282_3.jsp?s_flag="+s_flag+"&s_rule_id="+rule_id;
		var url_new =url;//URLencode(url);
		document.frm1508_2.action=url;
		//alert(url);
		document.frm1508_2.submit();  
	}
	function yjgb(rule_id)
	{
		//alert("yjgb "+rule_id);
		var s_flag='E';
		var url="i282_3.jsp?s_flag="+s_flag+"&s_rule_id="+rule_id;
		var url_new =url;//URLencode(url);
		document.frm1508_2.action=url;
		//alert(url);
		document.frm1508_2.submit();  
	}
	function goBack()
	{
		window.location.href="i282_1.jsp?activePhone=<%=phone_no%>";
	}	
</script>
					  <table cellspacing="0" id = "PrintA">
								<tr>
									<td>�ֻ�����</td>
									<td><%=phone_no%></td>
								</tr>
								
								<tr> 
									<th>����ҵ�����</th>
									<th>����ҵ������</th>
									<th>�û���ǰ״̬</th> 
									<th>����</th> 
									
								</tr>
								
								
								<%
									for(int i =0;i<result1.length;i++)
									{
										%>
											<%
												if(result1[i][0]!="100025" &&(!(result1[i][0].equals("100025"))))
												{
													%>
													<tr>
														<td>
															<%=result1[i][0]%>
														</td>
														<td>
															<%=result1[i][1]%>
														</td>
														<%
															if(result1[i][2]=="1" ||result1[i][2].equals("1"))
															{
																%>
																	<td>�ѹر�</td>
																	<td>
																	<input type="button"  class="b_foot" id=<%=i%> value="��ͨ" onclick="kt('<%=result1[i][0]%>')">&nbsp;&nbsp;
																	<input type="button"  class="b_foot"  value="�ر�" disabled >
																	</td>
																<%
															}
															else
															{
																%>
																	<td>�ѿ�ͨ</td>
																	<td>
																	
																	<input type="button"  class="b_foot"  value="��ͨ" disabled >
																	&nbsp;&nbsp;
																	<input type="button"  class="b_foot" id=<%=i%> value="�ر�" onclick="gb('<%=result1[i][0]%>')">
																	</td>
																<%
															}	
														%>
														 
														 
													</tr>
													<%
												}
												else
												{
													%>
														<tr>
															<td>
																<%=result1[i][0]%>
															</td>
															<td>
																<%=result1[i][1]%>
															</td>
															<%
																if(result1[i][2]=="1" ||result1[i][2].equals("1"))
																{
																	%>
																		<td>�ѹر�</td>
																		<td>
																		<input type="button"  class="b_foot" id=<%=i%> value="��ͨ" onclick="kt('<%=result1[i][0]%>')">&nbsp;&nbsp;
																		<input type="button"  class="b_foot"  value="�ر�" disabled >
																		</td>
																	<%
																}
																else
																{
																	%>
																		<td>�ѿ�ͨ</td>
																		<td>
																		
																		<input type="button"  class="b_foot"  value="��ͨ" disabled >
																		&nbsp;&nbsp;
																		<input type="button"  class="b_foot" id=<%=i%> value="���¹ر�" onclick="gb('<%=result1[i][0]%>')">
																		&nbsp;&nbsp;
																		<input type="button"  class="b_foot" id=<%=i%> value="���ùر�" onclick="yjgb('<%=result1[i][0]%>')">
																		</td>
																	<%
																}	
															%>
															 
															 
														</tr>
													<%  	
												}	
											%>
											
										<%	
									}
									
								%>
								
								 
						<input type="hidden" name="phone_no" value="<%=phone_no%>">		 

					 </table>
		 			 
					 <table cellSpacing="0">
						<tr> 
						  <td id="footer"> 
								 <input type="button" name="query" class="b_foot" value="����" onclick="goBack()" >
						   
							  &nbsp;
					   
							  &nbsp;
								  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
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
					window.location.href="i282_1.jsp?activePhone=<%=phone_no%>";
				</script>
			<%
		}
%>	 
 
 


