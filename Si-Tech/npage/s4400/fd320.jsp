<%
  /*
   * ����: ȫ��ͨVIP�򳵷������ d320
   * �汾: 2.0
   * ����: 2011/3/24
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
  String opCode =  "d320";
	String opName =  "ȫ��ͨVIP�򳵷������";
	String workNo =  (String)session.getAttribute("workNo");
	String workName =  (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String workpw = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");

	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo")) ;
	String passwd = WtcUtil.repNull(request.getParameter("passwd")) ;
	String ret_code = "";
	String ret_meg = "";
	String result[][] = null;
	int recNum1=0;
	int recNum = 0 ;
	String disPlay = request.getParameter("disPlay") ;

	if("yes".equals(disPlay)){////���Ƶ�һ�β���ʾ
		System.out.println("--------------111111111111111111111-------------------------");
	%>

		<wtc:service name="sD320Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
			<wtc:param value=" " />
			<wtc:param value=" " />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=workpw%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="<%=passwd%>" />
		</wtc:service>
  	<wtc:array id="r0" start="0" length="2" scope="end" />
		<wtc:array id="r1" start="2" length="6" scope="end" />

<%
		ret_code = retCode;
		ret_meg = retMsg;
		result = r1;
	}
	if(!ret_code.equals("000000")&&!ret_code.equals(""))
	{%>
	 <script language='jscript'>
		rdShowMessageDialog('������Ϣ��<%=ret_meg%>' + '������룺' + '<%=ret_code%>' + '��',0);
		window.location.href = "fd320.jsp?phoneNo=<%=phoneNo%>&passwd=<%=passwd%>&disPlay=no";
	</script>
	<%}	else{
	if(result!=null)
	{
		recNum1=result.length;
		if(recNum1<1)
		{
%>
	<script language='jscript'>
		window.location.href = "fd320.jsp?phoneNo=<%=phoneNo%>&passwd=<%=passwd%>&disPlay=no";
	</script>

<%
}}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<!--
	function qry(){
	    if(!check(document.form)){
        	return false;
        }

	    if((document.form.phoneNo.value).trim()==""){
    	    	  	rdShowMessageDialog("�������ֻ�����!");
					      document.form.phoneNo.focus();
						  	return false;
    	}

	    if((document.form.passwd.value).trim()==""){
    	    	  	rdShowMessageDialog("����������!");
					      document.form.passwd.focus();
						  	return false;
    	}
    document.form.queryBut.disabled=true;
		document.form.submit();
	}

	function comjsp()
	{
		getAfterPrompt();

		var tab=document.getElementById("ShowId");
		var trs=tab.rows;
		if(trs.length<3)
		{
			 rdShowMessageDialog("�˺���û�в�����¼,���ܰ����������!");
			 return false;
		}

    if((document.form.phoneNo.value).trim()==""){
  	    	  	rdShowMessageDialog("�������ֻ�����!");
				      document.form.phoneNo.focus();
					  	return false;
  	}

    if((document.form.passwd.value).trim()==""){
  	    	  	rdShowMessageDialog("����������!");
				      document.form.passwd.focus();
					  	return false;
  	}

		var flag="N";
		var radios=document.getElementsByName("oprRadio");
		var changdu = radios.length;
    for(var i=0;i<changdu;i++)
		{
			var radio=radios[i];
			if(radio.checked==true)
			{
				var td=document.getElementById("loginAccept"+(i+1));
				var old_loginAccept=td.innerHTML;
				document.form.old_loginAccept.value=old_loginAccept;
				flag="Y";
			}
		}
		if(flag=="N")
		{
			 rdShowMessageDialog("��ѡ��һ����Ҫɾ���ļ�¼!");
			 return false;
		}
		form.action="fd320Cfm.jsp";
		form.submit();
	  return true;
	}

	function combegin()
	{
		document.form.phoneNo.value="";
		document.form.passwd.value="";
	}
-->
</script>
</head>
<body>
<FORM action="fd320.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp"%>
<div class="title">
	<div id="title_zi">���հ���ȫ��ͨVIP�򳵷���ҵ���ѯ</div>
</div>
  <input type="hidden" name="disPlay"  value="yes">
<table cellSpacing="0">
		<tr>
			<td class="blue">�û�����</td>
			<td>
				<input type="text" name="phoneNo" value="<%=phoneNo%>"  v_must=1 v_type="phone" size=20 onblur="checkElement(this)"/>
			</td>
			<td class="blue">����</td>
			<td>
				<input type="password" name="passwd"  value="<%=passwd%>" v_must=1  onblur="checkElement(this)"/>
			</td>
		</tr>

		 <tr id="footer">
	      <td colspan="4" align="center"><input class="b_foot" name="queryBut" type="button" value="��ѯ" style="cursor:hand;" onclick="qry()"></td>
	    </tr>
	  </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>
      <table cellSpacing="0" id="ShowId">
	          <tr id="ShowTotalId">
	          	<th><div align="center">ѡ��</div></th>
	            <th><div align="center">����ˮ��</div></th>
	            <th><div align="center">�û�����</div></th>
	            <th><div align="center">�û�����</div></th>
	            <th><div align="center">���ѻ���</div></th>
	            <th><div align="center">��Ѵ���</div></th>
	            <th><div align="center">������Ա����</div></th>
              </tr>
              <%
              	if(result!= null){
			    			recNum = result.length ;
							}
			 				%>
			  <%if(recNum<1){%>
		  	<tr><td colspan="12" align = "center"><b><font class="orange">�˺���û�в�����¼</font></td></tr>
		      <%}else{%>
	          <%
          		for(int i=0;i<recNum;i++){
          		String tdClass = "";
         if (i%2==0){
             tdClass = "Grey";
         }
		  	  %>
				<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';;this.style.cursor='hand'">
			      <td class="<%=tdClass%>"><div align="center"><input type="radio" name="oprRadio"></div></td>
			      <td class="<%=tdClass%>"><div align="center"  id="loginAccept<%=i+1%>"><%=result[i][0]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][1]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][2]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][5]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][4]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][3]%></div></td>
	  	  </tr>
			  <%}}%>

			  <tr id="footer">
        	<td colspan="11" align="right">
        				 <div align="center">
			              <input class="b_foot" type="button" id="confirm" name="confirm" value="ȷ��" index="2" onClick="comjsp()">
			              <input class="b_foot" type="button" name=back value="���" onClick="combegin();">
					          <input class="b_foot" type="button" name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
			            </div>
        	</td>
        </tr>
		</table>
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
		<input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
		<input type="hidden" name="old_loginAccept" id="old_loginAccept"/>

   <%@ include file="/npage/include/footer.jsp"%>
</FORM>
</BODY>
</HTML>
<%}%>

