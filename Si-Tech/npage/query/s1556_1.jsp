<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat" %>
 <%
 	String opCode="1556";
	String opName="��ϸ�ʵ���ѯ";
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String belongName = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
    
	String in_query_type = request.getParameter("query_type");
	String in_phoneno = request.getParameter("phone_no");
	String in_contract_no = request.getParameter("contract_no");
    String in_begin_time = request.getParameter("begin_time");
    String in_end_time = request.getParameter("end_time");
	String in_bill_type = request.getParameter("bill_type");
    System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC in_begin_time is "+in_begin_time+" and in_end_time is "+in_end_time); 
	Date date = new Date();
	String todayyearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);

	if (in_query_type == null) {
	    in_query_type = "2";
	}

	if (in_begin_time == null) {
	    in_begin_time = todayyearmonth.substring(0,6) + "01";
	    in_end_time = todayyearmonth;
	}
	
	String bill_typename = "";
	if (in_bill_type.equals("1")) {
	    bill_typename = "�ʵ���ϸ";
	} else {
	    bill_typename = "δ������ϸ";
	}

	String[] inParas1 = new String[3];
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
	//CallRemoteResultValue callRemoteResultValue = null;

	inParas1[0] = "select to_char(id_no) from dcustmsg where phone_no = :in_phoneno";
	inParas1[1] = "select to_char(user_passwd) from dcustmsg where phone_no  = :in_phoneno";
	inParas1[2] = "in_phoneno="+in_phoneno;

	
    //callRemoteResultValue = viewBean.callService("0", null, "TlsPubSelBoss", "1", inParas1);
    //result = callRemoteResultValue.getData();
%>    
		<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=in_phoneno%>"   retmsg="errMsg3" outnum="1">
			<wtc:param value = "<%=inParas1[0]%>"/>
			<wtc:param value = "<%=inParas1[2]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>   
<%			
	String inParas[] = new String[8];
  inParas[0] = in_query_type;
	inParas[1] = in_phoneno;
	inParas[2] = in_begin_time;
	inParas[3] = in_end_time;
	inParas[4] = in_bill_type;
	inParas[5] = in_contract_no;
	inParas[6] = workno;
	inParas[7] = opCode;

	int [] lens ={2,6,3,6,6};
	
	double should_pay2 =0;
	double favour_fee2 = 0;
	double should_pay4 =0.00;
	double favour_fee4 = 0.00;
	
 	//CallRemoteResultValue value = viewBean.callService("2",in_phoneno,"s1524_Qry","23",lens,inParas);
 	//ArrayList list  = value.getList();
%>


   <!-- =================================ȡ�û������Լ��������� add by zhangyta at 20120501 Begin============================================ -->  
		<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=in_phoneno%>"  retcode="errCode" retmsg="errMsg1" outnum="1">
		<wtc:param value = "<%=inParas1[1]%>"/>
		<wtc:param value = "<%=inParas1[2]%>"/>
		</wtc:service>
		<wtc:array id="result7" scope="end"/> 
    <%
    String user_pass = "";
    if (retCode.equals("000000")) {
        if (result7 != null) {
            if (result7.length > 0) {
                user_pass = result7[0][0];
            }
        }
    }%>

<!-- =================================ȡ�û������Լ��������� add by zhangyta at 20120501 End============================================ -->


<wtc:service name="s1524_Qry" routerKey="phone" routerValue="<%=in_phoneno%>"  retcode="errCode" retmsg="errMsg"  outnum="24" >
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=inParas[3]%>"/>
			<wtc:param value="<%=inParas[4]%>"/>
			<wtc:param value="<%=inParas[5]%>"/>
			<wtc:param value="<%=inParas[6]%>"/>
			<wtc:param value="<%=inParas[7]%>"/>				
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result6" start="2" length="6" scope="end" />
	<wtc:array id="result3" start="8" length="3" scope="end" />
	<wtc:array id="result2" start="11" length="6" scope="end" />
	<wtc:array id="result4" start="17" length="6" scope="end" />
	<wtc:array id="result5" start="23" length="1" scope="end" />
<%  
  String record_num = result1[0][0];
	String return_code = result1[0][1];
 	String error_msg = return_code;
	DecimalFormat df = new DecimalFormat("0.00");   
%>
 

<!--xl add ���˴��� begin-->
<wtc:service name="s1500AgtPayQry" routerKey="phone" routerValue="<%=in_phoneno%>" retcode="retCode2" retmsg="retMsg2" outnum="6" >
	<wtc:param value="<%=in_phoneno%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=in_begin_time%>"/>
	<wtc:param value="<%=in_end_time%>"/>
</wtc:service>
<wtc:array id="result_agt" scope="end"/>
<%
	String return_code_agt=retCode2;
	String return_msg_agt=retMsg2;
	String agt_type="";
	String agt_phone="";
	String agt_begin="";
	String agt_end="";
	System.out.println("XCXXXXXXXXXXXXXXXXXXXXXXXXXXXXCCCCCCCCCCCCCC s1500AgtPayQry return_code_agt is "+return_code_agt+" and return_msg_agt is "+return_msg_agt+" and result_agt.length is "+result_agt.length+"and in_phoneno is "+in_phoneno);
	if(!return_code_agt.equals("000000"))
	{
		System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCC ��ѯ�����Ƿ�չʾ?");
		agt_type="��";
		agt_phone="��";
		agt_begin="��";
		agt_end="��";
		
	}
	else
	{
		//agt_type=result_agt[0][0];
		//agt_phone=result_agt[0][1];
		//agt_begin=result_agt[0][2];
		//agt_end=result_agt[0][3];
	}
%>
<!--xl add ���˴��� end-->

<% if (!return_code.equals("000000")) {%>
  <script language="JavaScript">
    rdShowMessageDialog("��ϸ�ʵ���ѯʧ��! ");
    window.location="s1556.jsp?activePhone=<%=in_phoneno%>";
  </script>
<% } else { %>

<HEAD>
<TITLE>������BOSS-��ϸ�ʵ���ѯ</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM action="s1321_3print.jsp" method=post name=form>
	 <%@ include file="/npage/include/header.jsp" %>
	 	<div class="title">
			<div id="title_zi">�ʵ�����  <%=bill_typename%> </div>
		</div>  
				     <table cellspacing="0">
                      <tr > 
                        <th> 
                          <div align="center"> <b>�ʵ�����</b></div>
                        </th>
						<!--<td nowrap bgcolor="#99ccff"> 
                          <div align="center"> <b>����</b></div>
                        </td>-->
						<th> 
                          <div align="center"> <b>��������</b></div>
                        </th>
						<th> 
                          <div align="center"> <b>Ӧ��</b></div>
                        </th>
						<th> 
                          <div align="center"> <b>�Ż�</b></div>
                        </th>
						<th> 
                          <div align="center"> <b>�ʵ���Ŀ��</b></div>
                        </th>
					  </tr>

                      <% 
					      for (int i = 0;i < result2.length; i++) {
					     	  should_pay2 += Double.parseDouble(result2[i][3]);
					   	      favour_fee2 += Double.parseDouble(result2[i][4]);
					  %>
                        <tr> 
                          <td nowrap><%=result2[i][0]%>
                          </td>
						<!--  <td width="22%" nowrap><%=result2[i][1]%>
                          </td> -->
						  <td nowrap><%=result2[i][2]%>
                          </td>
						  <td nowrap><%=result2[i][3]%>
                          </td>
						  <td nowrap><%=result2[i][4]%>
                          </td>
						  <td nowrap><%=result2[i][5]%>
                          </td>
					  </tr>
					  <% } %>

					   <tr> 
                        <td  colspan="2" nowrap>��Ӧ�գ�<%=df.format(should_pay2)%>
                        </td>
					    <td  colspan="2" nowrap>���Żݣ�<%=df.format(favour_fee2)%>
                        </td>
					    <td colspan="2" nowrap>�ܷ��ã�<%=df.format(should_pay2-favour_fee2)%>
                        </td>
                      </tr>
					   
                    </table>
               <% if ( result4.length > 0 ) { %>     
				     <table cellspacing="0">
                      <tr> 
                        <th nowrap> 
                          <div align="center"> <b>�ʵ�����</b></div>
                        </th>
						<!--<td nowrap bgcolor="#99ccff"> 
                          <div align="center"> <b>����</b></div>
                        </td>-->
						<th nowrap> 
                          <div align="center"> <b>��������</b></div>
                        </th>
						<th nowrap> 
                          <div align="center"> <b>Ӧ��</b></div>
                        </th>
						<th nowrap> 
                          <div align="center"> <b>�Ż�</b></div>
                        </th>
						<th nowrap> 
                          <div align="center"> <b>�ʵ���Ŀ��</b></div>
                        </th>
					  </tr>

                      <% 
					      for (int i = 0;i < result4.length; i++) {
							  should_pay4 += Double.parseDouble(result4[i][3]);
					   	  favour_fee4 += Double.parseDouble(result4[i][4]);
					  %>
                        <tr> 
                          <td nowrap><%=result4[i][0]%>
                          </td>
						 <!-- <td width="22%" nowrap><%=result4[i][1]%>
                          </td>-->
						  <td nowrap><%=result4[i][2]%>
                          </td>
						  <td nowrap><%=result4[i][3]%>
                          </td>
						  <td nowrap><%=result4[i][4]%>
                          </td>
						  <td nowrap><%=result4[i][5]%>
                          </td>
					  </tr>
					  <% } %>
					  <tr> 
                        <td colspan="2" nowrap>��Ӧ�գ�<%=df.format(should_pay4)%>
                        </td>
					    <td colspan="2" nowrap>���Żݣ�<%=df.format(favour_fee4)%>
                        </td>
					    <td colspan="2" nowrap>�ܷ��ã�<%=df.format(should_pay4-favour_fee4)%>
                        </td>
                      </tr>
                    </table>
                    <%}%>

					<table cellspacing="0">
                      <div class="title">
							<div id="title_zi">������Ϣ</div>
					  </div>
					   <tr align="center"> 
							<th>��������</th>
							<th>��������</th>            
							<th>��ʼʱ��</th>
							<th>����ʱ��</th>
							<th>��������</th>
							<th>�������</th>
							</tr>
							<%
								for(int i=0;i<result_agt.length;i++)
								{
									%>
										<tr>
											<td><%=result_agt[i][0]%></td>
											<td><%=result_agt[i][1]%></td>
											<td><%=result_agt[i][2]%></td>
											<td><%=result_agt[i][3]%></td>
											<td><%=result_agt[i][4]%></td>
											<td><%=result_agt[i][5]%></td>
										</tr>
									<%
								}
							%>
					</table>
        <table>
        	<tr>
        		<td id="footer">
        <input class="b_foot" name=reset type=reset value=���� onclick="JavaScript:history.go(-1)">
        &nbsp;
        <input class="b_foot" name=sure type=button value=�ر� onclick="removeCurrentTab();">
		&nbsp;
		<%
			if(result.length > 0){%>
			
			<a href="f1500_sPubCustBillDet1.jsp?idNo=<%=result[0][0]%>&opFlag=1556">��ϸ�ʷ���Ϣ��ѯ</a>
		<%
			}
		%>
		
        	</td>		
        </tr>
		<table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</FORM>
</BODY>
</HTML>
<% } %>
