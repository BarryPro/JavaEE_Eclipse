<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String opCode ="g634"; //"d223";
	String opName = "��������";//"�˷�ͳ��";
	String regionCode= (String)session.getAttribute("regCode"); 
	String phone_no = request.getParameter("phone_no");	
	String cust_name="";
	String cust_level="";
	String s_hours="";
	String[] inParas0 = new String[2];
	inParas0[0]="select to_char(b.phone_No),trim(a.cust_name),to_char(b.ilevel),to_char(d.hours) from dcustdoc a,dCustLevel b,dcustmsg c,cUrgent_offon d where a.cust_id = c.cust_id and b.id_no=c.id_no and c.phone_No=:phone_no and b.ilevel = d.ilevel ";
	inParas0[1]="phone_no="+phone_no;
	String s_idNo="";

	//xl add �ȼ��ж�
	String[] inParas_check = new String[1];
	inParas_check[0]="select to_char(ILEVEL),to_char(hours),op_note from cUrgent_offon";
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="3" >
			<wtc:param value="<%=inParas_check[0]%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
	<%
		if(result0==null||result0.length==0){
		System.out.println("888888888888888888888888weikong");
		 
		%>
		<script language="javascript">
			 
			rdShowMessageDialog("����δ�ܳɹ�,������Ϣ����ѯ������ϢΪ��!");
			//history.go(-1); 
		</script>
	<%}
 
	%>
<script language="javascript">
	//����ȫ�ֱ���
  var project_code = new Array();
  var transin_fee = new Array();//where���� �� projectCode Ҫ��ѯ��ʾ���� fee
  var op_notes=new Array();
	 
<%
	System.out.println("qweqwe1888888888888888888888888888881111111111111");
	if(result0.length >0){
		for(int m=0;m<result0.length;m++)
		  {
			out.println("project_code["+m+"]='"+result0[m][0]+"';\n");
			out.println("transin_fee["+m+" ]='"+result0[m][1]+"';\n");
			out.println("op_notes["+m+" ]='"+result0[m][2]+"';\n");
		  }
	}
	else{
	System.out.println("qweqwe9888800000000000000000111");
	}
%>
	 
	function doCfms()
	{
		var prtFlag=0;
		var ilevel = document.getElementById("i_level").value;
		var hours = document.getElementById("dqsj").value;
		prtFlag = window.confirm("�Ƿ�ȷ�ϰ����������?");

		var actions = "g634_3.jsp?phone_no=<%=phone_no%>"+"&iLevel="+ilevel+"&hours="+hours;

		if (prtFlag==1)
		{
			document.all.frm1507_2.action=actions;
			document.all.frm1507_2.submit();
		}
		else
		{
			return false;
		}
		
	}
</script>
		

<!--xl add for zhaorh sEmergencyInit-->
<wtc:service name="sEmergencyInit" retcode="s_code" retmsg="s_msg"  outnum="6" >
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="g634"/>
			<wtc:param value="01"/>
</wtc:service>
<wtc:array id="s_eme_id" scope="end" />

	<%
		if(s_eme_id!=null &&s_eme_id.length>0 )
		{
			cust_name=s_eme_id[0][4];
			cust_level=s_eme_id[0][0];
			s_hours=s_eme_id[0][1];
				%><HEAD><TITLE>��������</TITLE>
			</HEAD>

			<body>
			<!--
			<DIV><img class='hideEl' src='jia.gif'   style='cursor:hand' width='15' height='15' onclick="show()">&nbsp;&nbsp;<img class='hideEl' src='jian.gif'   style='cursor:hand' width='15' height='15' onclick="hide()"></DIV>
			-->
			<FORM method=post name="frm1507_2">
				<%@ include file="/npage/include/header.jsp" %>
				<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi">��������</div>
				</div>
				<table cellspacing="0" id="tabList">
				<%
					//for(int i =0;i<sid_arr.length;i++)
					{
						%>
							<tr>
								<td>�ֻ�����</td><td><%=phone_no%></td>
								<td>����</td><td><%=cust_name%></td>
							</tr>
							<tr>
								<td>�ͻ��ȼ�</td><td><%=s_eme_id[0][5]%></td>
								<input type="hidden" id="i_level" value="<%=cust_level%>">
								<td>��������ʱ����Сʱ��</td>
								<td><input type="text" name="dqsj" onKeyPress="return isKeyNumberdot(0)"  ><font color="red">(�<%=s_eme_id[0][1]%>Сʱ)</font></td>
								<input type="hidden" id="i_hour" value="<%=s_eme_id[0][1]%>">
							</tr>
							<tr>
								<td>�Ѱ������</td><td><%=s_eme_id[0][2]%></td>
								<td>ÿ������������</td><td><%=s_eme_id[0][3]%></td>
							</tr>
						<%
					}
				%>
				
				 
				 
					<td align="center" id="footer" colspan="9">
					&nbsp; <input class="b_foot" name=doCfm onClick="doCfms()" type="button" value="ȷ��">	 
					&nbsp; <input class="b_foot" name=back onClick="window.location='g634_1.jsp'" type="button" value="����">
					&nbsp;  
					</td>
				</tr>
			</table>
				<%@ include file="/npage/include/footer.jsp" %>
			</form>
			</body>
			</html><%
			
		}
		else
		{
			if(s_eme_id==null || s_eme_id.length==0)
			{
				%>
					<script language="javascript">
						rdShowMessageDialog("���񱨴�!�������"+"<%=s_code%>"+",������Ϣ"+"<%=s_msg%>");
						history.go(-1);
					</script>
				<%
			}			
				
		}
	

 %>

 