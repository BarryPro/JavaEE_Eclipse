   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "��Ʒ����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String[][] retListString1 = new String[][]{};
	 
String regionCode = (String)session.getAttribute("regCode");	
	String region_code = request.getParameter("region_code");
	String mode_code = request.getParameter("nextModeCode");
	
	String sqlStr1="";
	sqlStr1 ="select a.mode_code,a.mode_name, decode(a.mode_flag,'0','����Ʒ','1','��ѡ��Ʒ','2','���Ӳ�Ʒ',a.mode_flag),b.sm_code||'->'||b.sm_name from sBillModeCode a, sSmCode b where a.region_code = b.region_code and a.sm_code = b.sm_code and a.region_code='"+region_code+"' and mode_code like '%" + mode_code + "%' and rownum < 100 " +
	" and a.mode_flag='0' and a.mode_code not in (select mode_code from sBillModeRelease where mode_code like '%" + mode_code + "' and group_id = '" + region_code + "') order by a.mode_code";
	//retList1 = impl.sPubSelect("4",sqlStr1,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%	
	if(result_t.length>0&&code.equals("000000"))
	retListString1 = result_t;
	System.out.println("--------OK--------------");
%>

<html>
<head>
<title>�����ʷ��б�</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table  id="tab1"  cellspacing="0">
	<tr bgColor="#eeeeee">
		<th height="26" align="center">
			ѡ��
		</th>
		<th  align="center">
			��Ʒ����
		</th>
		<th align="center">
			��Ʒ����
		</th>
		<th align="center">
			��Ʒ���
		</th>
		<th align="center">
			ҵ��Ʒ��
		</th>
	</tr>
</table>
<table  cellspacing="0">
	<tr>
		<td>
				<div align="center" id="footer">
			      <input type="button" name="commit" onClick="doCommit();" value=" ȷ�� " class="b_foot">
			      &nbsp;
			      <input type="button" name="back" onClick="doClose();" value=" �ر� " class="b_foot">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="nextModeCode" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="nextModeCodeName" value="<%=retListString1[i][1]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		  newrow.insertCell(4).innerHTML = '<%=retListString1[i][3]%>';
		<%}%>

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("��û��ѡ���κβ�Ʒ���룡");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//ֵΪһ��ʱ����Ҫ������
				if(document.all.num.checked){
					window.opener.form1.nextModeCode.value=document.all.nextModeCode.value;
					window.opener.form1.nextModeCodeName.value=document.all.nextModeCodeName.value;
					window.close();
				}
				else{
					rdShowMessageDialog("��û��ѡ���κβ�Ʒ���룡");
					return false;
				}
			}
			else{//ֵΪ����ʱ��Ҫ������
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.form1.nextModeCode.value=document.all.nextModeCode[a].value;
					window.opener.form1.nextModeCodeName.value=document.all.nextModeCodeName[a].value;
					window.close();
				}
				else{
					rdShowMessageDialog("��û��ѡ���κβ�Ʒ���룡");
					return false;
				}
			}
		}
	
	function doClose(){
		window.close();
	}
</script>