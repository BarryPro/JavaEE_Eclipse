<%
/********************
 version v2.0
������: si-tech
����:�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "zg46";
	String opName = "Ԥ����Ʊ��ϸ��Ϣ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String loginaccept  = request.getParameter("loginaccept");
 
 
	
	 
	String[] inParas2 = new String[2];
    inParas2[0]="select to_char(op_time,'YYYYMMDD hh24:mi:ss'),to_char(invoice_money),to_char(unit_id),to_char(grp_phone_no),to_char(grp_contract_no) from grp_pre_invoice where login_accpet=:accepts and s_flag = 'p' ";
	inParas2[1]="accepts="+loginaccept;
	String[] inParas_detail = new String[2];
	//inParas_detail[0]="select cust_name,to_char(contract_no) from dcustdoc a,dcustmsg b where a.cust_id=b.cust_id and b.phone_no=:phone_No"; 
	inParas_detail[0]="select bank_cust from dconmsg where contract_no=:contract_no";

	
%>
<script language="javascript">
	function addTab(uid,invoice_money,loginaccept,phone_no)
	{
		//alert(uid+" and invoice_money is "+invoice_money+" and loginaccept is "+loginaccept);
		var s_flag="";
		//alert(phone_no);
		if(phone_no.substr(0,2)=="20")
        {
		//	alert("����");
			s_flag="1";
		}
		else if(phone_no=="0")
		{
			//alert("һ��֧��");
			s_flag="A";
		}
		else
		{
			//alert("����");
			s_flag="0";
		}
		if(s_flag=="0")
		{
			document.getElementById('light').style.display='block';
			document.getElementById('fade').style.display='block';
			 
			win=parent.addTab(true,'1300','�˺Žɷ�','../s1300/s1300_2.jsp?account_id=');
			parent.removeTab("1300");
			win=parent.addTab(true,'1300','�˺Žɷ�','../s1300/s1300_2.jsp?account_id='+uid+'&invoice_money='+invoice_money+"&loginaccept="+loginaccept+"&print_flag=Y");
			win.reload();
		}
		if(s_flag=="1")
		{
			document.getElementById('light').style.display='block';
			document.getElementById('fade').style.display='block';
			 
			win=parent.addTab(true,'d340','���Žɷ�','../s1300/s1300_group.jsp?account_id=');
			parent.removeTab("d340");
			win=parent.addTab(true,'d340','���Žɷ�','../s1300/s1300_group.jsp?account_id='+uid+'&invoice_money='+invoice_money+"&loginaccept="+loginaccept+"&print_flag=Y");
			win.reload();
		} 
		if(s_flag=="A")
		{
			//alert("һ��֧������"+loginaccept);
			document.getElementById('light').style.display='block';
			document.getElementById('fade').style.display='block';
			win=parent.addTab(true,'3172','һ��֧���ʻ��ɷ�','../s3172/f3172_1.jsp?account_id=');
			parent.removeTab("3172");
			win=parent.addTab(true,'3172','һ��֧���ʻ��ɷ�','../s3172/f3172_1.jsp?account_id='+uid+'&invoice_money='+invoice_money+"&loginaccept="+loginaccept+"&print_flag=Y");
			win.reload();
		}
		
	}
	function confirm()
	{
		window.location.reload();
	}
</script>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="5">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
	
	<%
		if(!retCode2.equals("000000")){
	%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,�������<%=retCode2%><br>������Ϣ<%=retMsg2%>!");
			history.go(-1);
		</script>
<%
		return;
	}


	if (result==null||result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("<br>û�з�������������",1);
	history.go(-1);
</script>
<%	}
	else
	{
		%>
		<HTML><HEAD><TITLE>Ԥ�������Ϣ</TITLE>
			<style> 
  .black_overlay{  display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.8;  opacity:.80;  filter: alpha(opacity=80);  }  .white_content {  display: none;  position: absolute;  top: 25%;  left: 25%;  width: 50%;  height: 50%;  padding: 16px;  border: 16px solid transparent;  background-color: transparent;  z-index:1002;  overflow: auto;  }  
</style>
</HEAD>
<body>
	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">Ԥ����Ʊ��ϸ��Ϣ</div>
			</div>
<FORM method=post name="f1500_dConMsgPre">
     
            <TABLE  cellSpacing="0">
              <TBODY>
                <TR align="center">
                  <th>��Ʊʱ��</th>
                  <th>��Ʊ���</th>
                  <th>���⼯�ź���</th> 
				  <th>��Ʒ����</th>
				  <th>��Ʒ�ʺ�</th>
				  <th>��Ʒ����</th>
				  <th>����</th>
				</TR>
		<tr align="center">
<%    	        
		    for(int y=0;y<result.length;y++)
			{
				 inParas_detail[1]="contract_no="+result[y][4];
				 %>
				 <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
					<wtc:param value="<%=inParas_detail[0]%>"/>
					<wtc:param value="<%=inParas_detail[1]%>"/>
				</wtc:service>
				<wtc:array id="result1" scope="end" />
				 <tr>
				 <%
				 for(int j=0;j<result[0].length;j++)
				 {
					 %>
						 <td><%=result[y][j]%></td>
						 
					 <%
				 }
				 %>
			 
				 <td><%=result1[0][0]%></td>
				 <td><input class="b_foot" type="button" value="�ɷ�" onclick="addTab('<%=result[y][4]%>','<%=result[y][1]%>','<%=loginaccept%>','<%=result[y][3]%>')"></td>
				 </tr>
				 <%	 
		    }
%>
	     </tr>
<%	    
%>	
<tr>
 <td colspan=7 align="center"><input class="b_foot" name=back onClick="window.location.href='zg46_1.jsp'" type=button value=����></td>
</tr>
	</TBODY>
	    </TABLE>
	<div id="light" class="white_content"> 
 
	<input class="b_foot" type="button" value="�ɷѳɹ�" onclick="confirm()">
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input class="b_foot" type="button" value="�ر�" onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
  
</div> 
<div id="fade" class="black_overlay">
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id=footer>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
		<%
	}
%>


