<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ����Ԥ���������Ա��ѯ
�� * �汾: 
�� * ����: 20100603
�� * ����: sunaj
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**��Ҫ�������.�������ҳ��,��ɾ��**/
response.setHeader("Pragma","No-Cache"); 
response.setHeader("Cache-Control","No-Cache");
response.setDateHeader("Expires", 0); 

    String[][] result = new String[][]{};
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = orgCode.substring(0,2);
	String opFlag = request.getParameter("opflag");
	String memCode="";
	String[] inParas = new String[2];
	
	if(opFlag.equals("one"))
	{
		memCode="8376";	     //��һ����Ա	  
	}else
	{
		memCode="8378";      //�ڶ�����Ա
	}
	inParas[0] = "select a.login_no,a.login_name  from dloginmsg a,shighlogin b    "+
		    	  "where a.login_no=b.login_no and b.op_code=:memcode ";	
	inParas[1] = "memcode="+memCode;
	
%>				  	
<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="Retmsg2" retcode="Retcode2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
</wtc:service>
<wtc:array id="memresult" scope="end"/>	
<%
	String[][] memarr= new String[][]{};
	if(Retcode2.equals("0") || Retcode2.equals("000000"))
	{
		memarr = memresult;
 	}
%>		  
<html>
<head>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<script language="javascript">

function f8375Init(obj)
{
 	parent.document.all.work_men.value = obj.vLoginNo;
 	parent.document.all.work_menname.value = obj.vLoginName;
}

</script>
</head>
<body>
<form name="frm" method="POST" >
	<div id="Operation_Table">
	
		<table cellspacing="0" id="tabList" width="50%">
			<tr align="center">
				<th class="blue" nowrap>��ѡ��</th>
				<th nowrap>�����˹���</th>
				<th nowrap>����������</th>
			</tr> 
	<%
			if(memarr.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
				
			}else if(memarr.length>0)
			{
				String tbclass = "";
				for(int i=0;i<memarr.length;i++)
				{
					tbclass = (i%2==0)?"Grey":"";
	%>
				<tr align="center">

				<td class="Grey" align=center>
				<input type="radio" name="radio" vLoginNo="<%=memarr[i][0]%>" vLoginName="<%=memarr[i][1]%>" onclick="f8375Init(this)">
				</td>		
						<td class="<%=tbclass%>"><%=memarr[i][0]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=memarr[i][1]%>&nbsp;</td>
				</tr>
<%				
				}
			}
%>
 	</table>
</div>
  	
</body>
</html>    
