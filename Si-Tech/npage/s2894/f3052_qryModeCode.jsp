 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	
	String impRegion= (String)session.getAttribute("regCode");
	String opCode = "3052";		
	String opName = "ҵ��������Ա�ʷѹ�ϵά��";	//header.jsp��Ҫ�Ĳ��� 	
	
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
	
	String prodCode = request.getParameter("prodCode");
	String mode_type = request.getParameter("mode_type");
	sqlStr1="select a.mode_code,trim(a.mode_name),trim(a.note) "
		+"from sBillModeCode a "
		+"where a.mode_type='"+mode_type+"' and a.start_time<=sysdate and a.stop_time>=sysdate "
		+"and a.region_code='"+impRegion+"'"
		+"order by a.mode_code";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=impRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retListString1" scope="end" />	
<%	
	
	//retList1 = impl.sPubSelect("3",sqlStr1,"region",impRegion);
	//String[][] retListString1 = (String[][])retList1.get(0);
	//int errCode=impl.getErrCode();
	//String errMsg=impl.getErrMsg();
		
	String op_name = "�ʷ��б�";

%>

<html>
<head>
<title><%=op_name%></title>
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
	window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
	<form name="frm" method="POST" >
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�ʷ��б�</div>
		</div>	
		<table id="tab1" border="0"  cellspacing="0">
		  <tr>
		    <th>ѡ��</th>
		    <th>�ʷѴ���</th>
		    <th>�ʷ�����</th>
		    <th>�ʷ�����</th>
		  </tr>
		</table>
		<table cellspacing="0">
		  <tr>
		    <td id="footer">		      
		        <input type="button" name="commit" class="b_foot" onClick="doCommit();" value=" ȷ�� ">
		        &nbsp;
		        <input type="button" name="back" class="b_foot" onClick="doClose();" value=" �ر� ">		     
		    </td>
		  </tr>
		</table>
		 <%@ include file="/npage/include/footer.jsp" %>  	
</form>
</body>
</html>
<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="prodCode" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="prodName" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="prodNote" value="<%=retListString1[i][2]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		<%}%>
	
	function doCommit()
	{
		if("<%=retListString1.length%>"=="0")
		{
			rdShowMessageDialog("��ѡ��һ����¼��");
			return false;
		}
		else if("<%=retListString1.length%>"=="1")
		{//ֵΪһ��ʱ����Ҫ������
			if(document.all.num.checked)
			{
				window.opener.form1.prodCode.value=document.all.prodCode.value;
				window.opener.form1.prodName.value=document.all.prodName.value;
				window.opener.form1.prodNote.value=document.all.prodNote.value;
				//window.close();
			}
			else
			{
				rdShowMessageDialog("��ѡ��һ����¼��");
				return false;
			}
		}
		else
		{//ֵΪ����ʱ��Ҫ������
			var a=-1;
			for(i=0;i<document.all.num.length;i++)
			{
				if(document.all.num[i].checked)
				{
					a=i;
					break;
				}
			}
			if(a!=-1)
			{
				window.opener.form1.prodCode.value=document.all.prodCode[a].value;
				window.opener.form1.prodName.value=document.all.prodName[a].value;
				window.opener.form1.prodNote.value=document.all.prodNote[a].value;
				//window.close();
			}
			else
			{
				rdShowMessageDialog("��ѡ��һ����¼��");
				return false;
			}
		}
		window.close();
	}
	
	function doClose(){		
		window.close();
	}
</script>

