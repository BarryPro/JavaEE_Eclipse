<%
   /*
   * ����: ע�����������-��ѯ���д���
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
 		String opCode = "9605";
 		String opName = "ע�����������";

		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		
		String getRegionSql = "select group_id,group_name from dChnGroupMsg where  ROOT_DISTANCE = 2";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=getRegionSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%		
		int totalNum = sVerifyTypeArr.length;
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
			<tr align="center">
				<th width="15%" nowrap>ѡ��</td>
				<th width="35%" nowrap>���б��</td>
				<th nowrap>��������</td> 
			</tr> 
	<%
			if(totalNum==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(totalNum>0){
				String tbclass = "";
				for(int i=0;i<totalNum;i++){
					tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="checkbox" name="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	       <input type="button" name="allchoose"  class="b_text" value="ȫ��ѡ��" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       <input type="button" name="cancelAll" class="b_text" value="ȡ��ȫѡ" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;
	    </td>
	  </tr>
 </table>
 </div>
</body>
</html>    
