<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1717";
	String opName = "����ԭ��ά��";
%>
<html>
<head>
<title>����ԭ��ά��</title>

<script language=javascript>

function addttt(){
myFrame.window.addtest();
//alert("wwwwww");
//window.opener.document.getElementById("call_cause_id").value=document.form1.treeValue.value;
//window.close();
}
function delttt(){
myFrame.window.deltest();
	}



</script>
</head>
<body>
<%@ include file="/npage/include/header.jsp" %>	
<form name="form1" method="POST" action="">	
<div id="Operation_Table"> 
  <div class="title"  id="testName" >����ԭ������</div>
  	<table  cellspacing="0">
	  	<tr>
	  		<td>	  		 
       <input name="add" type="button"  id="add" value="����" onClick="addttt();return false;">	
       <input name="modify" type="button"  id="modify" value="�޸�" onClick="modify();return false;">
			 <input name="delete" type="button"  id="delete" value="ɾ��" onClick="delttt();return false;">
       <input name="close" type="button"  id="close" value="�ر�">
	  		</td>
	  	</tr>
		</table>
	  <table id="sQryCnttOnlyTable" >
	  	<tr>
	  		<td>
	  			<iframe name="myFrame" src="k172_callCauseManageTree.jsp" frameborder="0" width="100%" height="300px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>	
	  		</td>
	  	</tr>
		</table>
	</div>
	<div id="Operation_Table">
<table>
		<tr>
				<td colspan="2" class="blue">				
					<div  id="nodeName" align="top">��ǰά���ڵ�:</div>
				</td>		
			</tr>	
			<tr>
				<td width="20%" class="blue">				
					�ֶ�
				</td>	
				<td width="80%" class="blue">
					�ֶ���ֵ
				</td>	
			</tr>	
			<tr>
				<td width="20%" class="blue">
        ��������
				</td>	
				<td width="80%" class="blue">
					<div  id="node_city" align="top">3333</div>
				</td>	
			</tr>	
			<tr>
				<td width="20%" class="blue">
          �������
				</td>	
				<td width="80%" class="blue">
					<div  id="tele_code" align="top">3333</div>
				</td>	
			</tr>				<tr>
				<td width="20%" class="blue">
				  �ڵ����
				</td>	
				<td width="80%" class="blue">
					<div  id="node_code" align="top">3333</div>
				</td>	
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					�ϼ��ڵ�
				</td>	
				<td width="80%" class="blue" >
					<div  id="super_id" align="top">3333</div>
				</td>	
			</tr>	
					<tr class="grey" >
				<td width="20%" class="blue" >
					�ڵ�����
				</td>	
				<td width="80%" class="blue" >
					<div  id="node_bak" align="top">3333</div>
				</td>	
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					��������
				</td>	
				<td width="80%" class="blue" >
					<div  id="call_type" align="top">3333</div>
				</td>	
			</tr>	
						<tr class="grey" >
				<td width="20%" class="blue" >
					ȫ·��
				</td>	
				<td width="80%" class="blue" >
					<div  id="full_name" align="top">3333</div>
				</td>	
			</tr>	
								<tr class="grey" >
				<td width="20%" class="blue" >
					�Ƿ���ʾ
				</td>	
				<td width="80%" class="blue" >
					<div  id="flag" align="top">3333</div>
				</td>	
			</tr>	
		</table>

  </form>
    <%@ include file="/npage/include/footer.jsp" %>
</body>
</html>