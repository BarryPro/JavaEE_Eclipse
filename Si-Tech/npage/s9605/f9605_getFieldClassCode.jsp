<%
   /*
   * ����: ע�����������-��ѯ����
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
		
		String iClassCode = WtcUtil.repNull(request.getParameter("iClassCode"));
		String iClassName = WtcUtil.repNull(request.getParameter("iClassName"));
		String getRegionSql = "select class_code,class_name from sClass where class_code in (10431, 10442,10702) ";
		if(!"".equals(iClassCode)){
			getRegionSql += " and class_code like '%"+iClassCode.trim()+"%'";
		}
		
		if(!"".equals(iClassName)){
			getRegionSql += " and class_name like '%"+iClassName.trim()+"%'";	
		}
		System.out.println("getRegionSql add =="+getRegionSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="2"> 
		<wtc:sql><%=getRegionSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function doChange(){
				var regionRadios = document.getElementsByName("regionRadio");	
				for(var i=0;i<regionRadios.length;i++){
					if(regionRadios[i].checked){
						var impValue = regionRadios[i].value;
						parent.document.all.iClassCode.value=impValue.substring(0,impValue.indexOf("|"));
						parent.document.all.iClassName.value=impValue.substring(impValue.indexOf("|")+1,impValue.length);
						
						if(parent.document.all.iClassCode.value=="10442"||parent.document.all.iClassCode.value=="10702")
						{
							parent.document.all.sFunctionCode2.value="ALL";
							parent.document.all.sFunctionCode2.readOnly = true;
							parent.document.getElementById("clearBtn").disabled=true;
							parent.document.all.sFunctionName2.disabled = true;
						}else
						{
								parent.document.all.sFunctionCode2.value="";
								parent.document.all.sFunctionCode2.readOnly = false;
								parent.document.getElementById("clearBtn").disabled=false;
								parent.document.all.sFunctionName2.disabled = false;
						}
						
						if(parent.document.all.iClassCode.value=="10431")//�ط�����
						{
							parent.document.all.iClassSeq.value="1";
						}else if(parent.document.all.iClassCode.value=="10442")//�ʷѴ���
						{
							parent.document.all.iClassSeq.value="2";
						}else if(parent.document.all.iClassCode.value=="10702")//С������
						{
							parent.document.all.iClassSeq.value="3";
						}
						
						/**
							*���ӡ��޸�ģ���޸�
							*1.�ֶεģ�ѡС������ʱ����ӡѡ��ֻ�С���ӡ������ʾ����ֻ�С��ʷ�˵����
							*2.��������ֻ��һ��ֵ�ģ�ֱ���óɻ�ɫ������ѡ��
						**/
						if(parent.document.all.iClassCode.value=="10702"){
								parent.document.all.sIsPrint2.value = "2";
								parent.document.all.sIsPrint2.disabled = true;
						}else{
								parent.document.all.sIsPrint2.disabled = false;
						}
						
						parent.doChangeIsPrint2Select(parent.document.getElementById("sIsPrint2"));	
					}
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th width="15%" nowrap>ѡ��</td>
				<th width="35%" nowrap>����</td>
				<th nowrap>�ֶ�������</td> 
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
				tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="radio" name="regionRadio" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 	</div>
</body>
</html>    

