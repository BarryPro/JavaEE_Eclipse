<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*
********************/
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
	String opName = "�ۺ���Ϣ��ѯ֮�ͻ�-�ʻ���Ӧ��ϵ";
  
	String orgCode = (String)session.getAttribute("orgCode");
	String region_code = orgCode.substring(0,2);
	String cust_id=request.getParameter("custId");
	String cust_name=request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String recodeIDd=request.getParameter("recodeIDd");
	String work_name=request.getParameter("workName");
	String pwdcheck = request.getParameter("pwdcheck");
	String nopass = (String)session.getAttribute("password");
	/*
	if(pwdcheck=="Y" ||pwdcheck.equals("Y"))
	{
		System.out.println("֤��ͨ��������У�飬���߹������ܣ�չʾȫ����Ϣ");
	}
	if(pwdcheck=="N" ||pwdcheck.equals("N"))
	{
		System.out.println("֤��δͨ��������У�飬չʾ������Ϣ");
	}*/
 
	//ArrayList custConMsg = co.spubqry32("5",qrySql); 
%>

<!--xl add for �滻ԭ��ѯ sCustTypeQryE -->
<wtc:service name="sCustTypeQryE" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="1500"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=cust_id%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

	 
<%	
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("��ѯ���Ϊ��,�ͻ�-�ʻ���Ӧ��ϵ������!");
	</script>
<%
		return;
	}
%>

<HTML>
	<HEAD>
		<TITLE>�ͻ�-�ʻ���Ӧ��ϵ</TITLE>
		<script language="javascript">
	$(document).ready(function(){
		try{
			parent.parent.oprInfoRecode('','','','',"<%=recodeIDd%>");
		}catch(e){
		}
	});
</script>		
	</HEAD>
<body>

<FORM method=post name="f1500_custuser">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�ͻ�-�ʻ���Ӧ��ϵ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			</div>
		</div>
  <TABLE id="mainTable" cellspacing="0">
    <TBODY>
      <TR align="center"> 

        <th>�ͻ�ID</th>
        <th>�ʻ�ID</th>
        <th>��ʼʱ��</th>
        <th>����ʱ��</th>
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
			  //xl add ����У��
 	
			  
			  for(int j=1;j<result[0].length;j++){
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%	        
				}
%>
	        </tr>
<%	      
		}
%>
    </TBODY>
  </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
