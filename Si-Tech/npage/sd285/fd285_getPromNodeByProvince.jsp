 <%
   /*
   * ����: ���Ѷ�������-��ѯ���ش���
�� * �汾: v3.0
�� * ����: 2011-3-28
�� * ����: ningtn
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
 		String opName = "���Ѷ�������";
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--		
			/**��ѡ��ȫ��ѡ��**/
			function doSelectAllNodes(){
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=true;
				}
				doChange();	
			}
			
			/**ȡ����ѡ��ȫ��ѡ��**/
			function doCancelChooseAll(){
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=false;
				}
				doChange();				
			}
			
			/**��ѡ��ѡ�л���ȡ������Ҫ�¼�**/
			function doChange(){
				var regionChecks = document.getElementsByName("regionCheck");	
				var impCodeStr = "";
				var impNameStr = "";
				var regionLength = 0;
				for(var i=0;i<regionChecks.length;i++){
					if(regionChecks[i].checked){
						var impValue = regionChecks[i].value;
						var impArr = impValue.split("|");
						if(regionLength==0){
							impCodeStr = impArr[0];
							impNameStr = impArr[0]+" "+impArr[1];
						}else{
							impCodeStr += (","+impArr[0]);
							impNameStr += (","+impArr[0]+" "+impArr[1]);	
						}
						regionLength++;
					}
				}
				
				impNameStr += (" -->"+"һ��ѡ��"+regionLength+"������");
						
				parent.document.all.sGroupInfo.value = impNameStr;
				parent.document.all.sGroupId.value = impCodeStr;
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr height=25 align="center">
				<th width="15%" nowrap>ѡ��</td>
				<th nowrap>ʡ�����</td>
				<th nowrap>ʡ������</td> 
			</tr> 
			<tr align="center">
				<td>
					<input type="checkbox" name="regionCheck" value="10014|������" onclick="doChange()">	
				</td>
				<td>10014&nbsp;</td>
				<td>������&nbsp;</td>
			</tr>
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	       <input type="button" name="allchoose" class="b_text" value="ȫ��ѡ��" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       <input type="button" name="cancelAll" class="b_text" value="ȡ��ȫѡ" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;
	    </td>
	  </tr>
 </table> 
</div> 
</body>
</html>    

