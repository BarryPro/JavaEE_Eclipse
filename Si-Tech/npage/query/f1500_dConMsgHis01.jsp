<%
/********************
 version v2.0
������: si-tech
����:�ۺ���Ϣ��ѯ֮�ʻ���ʷ��Ϣ
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//������� �û�ID���ֻ����롢�������š�����Ա����ɫ������
	 String opCode = "1500";
	 String opName = "�ۺ���Ϣ��ѯ֮�ʻ���ʷ��Ϣ";
	
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
   

   
	//xl add for zlc
	String pwdcheck = request.getParameter("pwdcheck");
	//pwdcheck="N";
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAA 1500 pwdcheck is "+pwdcheck+" and bankCust is "+bank_cust);
	
	String inLoginAccept="0";
	String inChnSource="01";
	String inOpCode="1500";
	String inLoginNo=work_no;
	String inLoginPwd = (String)session.getAttribute("password"); 
	String inPhoneNo = "";
	String inUserPwd="";
	
 
	String inOpNote="�ʺ�"+contract_no+"����1500���ʻ���ʷ��Ϣ��ѯ";
	String s_flag="3";
%>

<wtc:service name="sCustTypeQryJ" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=inLoginAccept%>"/>
	<wtc:param value="<%=inChnSource%>"/>	
	<wtc:param value="<%=inOpCode%>"/>
	<wtc:param value="<%=inLoginNo%>"/>
	<wtc:param value="<%=inLoginPwd%>"/>
	<wtc:param value="<%=inPhoneNo%>"/>
	<wtc:param value="<%=inUserPwd%>"/>
	
	<wtc:param value="<%=contract_no%>"/>
	<wtc:param value="<%=s_flag%>"/>
	<wtc:param value="<%=inOpNote%>"/>
	</wtc:service>
<wtc:array id="result" scope="end" />
		
<%	
	if(!retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>");
			history.go(-1);
		</script>
<%
		return;
	}


	if (result==null||result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("û�з�������������!");
	history.go(-1);
</script>
<%	}
%>
<HTML><HEAD><TITLE>�ʻ���ʷ��Ϣ</TITLE>
<script laguage="javascript">
	function sendPost(postUrl,bt)
	{
		$("#postForm").empty();
		$("#postForm").attr("action",postUrl);
		if(postUrl == "f1500_dConMsgHis02.jsp"){
			$("#postForm").append("<input type='hidden' name='contract_no' value='<%=contract_no%>' />").append("<input type='hidden' name='pwdcheck' value='<%=pwdcheck%>' />").append("<input type='hidden' name='work_no' value='<%=work_no%>'/>"); 
		}
		//alert($("#postForm").attr);
		$("#postForm").submit();

		 
	}
</script>
</HEAD>
<body>
<FORM method=post name="f1500_dConMsgHis01">
      	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�ʻ���ʷ��Ϣ</div>
			</div>
            <TABLE  cellSpacing="0">
              <TBODY>
                <tr align="center">
                  <th>�ʻ�����</th>
                  <th>����ģ��</th>
                  <th>����ʱ��</th>
                  <th>��������</th>
                  <th>������ˮ</th>
				  <th>����</th>
                </TR>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	 				<tr align="center">
<%    	        
					 
		%>
					  <%
						if(pwdcheck=="Y" ||pwdcheck.equals("Y"))
						{
							%>
							<td class="<%=tbClass%>"><%= result[y][0]%></td>
							<%
						}
						else
						{
							%>
							<td class="<%=tbClass%>"><%=result[y][0].substring(0,1)%>XX  </td>
							<%
						}
					  %>
					  
					  <td class="<%=tbClass%>"><%= result[y][1]%></td>
					  <td class="<%=tbClass%>"><%= result[y][2]%></td>
					  <td class="<%=tbClass%>"><%= result[y][3]%></td>
					  <td class="<%=tbClass%>"><%= result[y][4]%></td>
					  <td class="<%=tbClass%>"><input type="button" class="b_foot" value="��ѯ" onclick="sendPost('f1500_dConMsgHis02.jsp')"></td>
		<%	         
%>
	        </tr>
<%	      }
%>
              </TBODY>
	    </TABLE>
       
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
<form id="postForm" method="post">
  	
</form>
</BODY></HTML>
