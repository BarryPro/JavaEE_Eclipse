<%
  /*
   * ����: ������ѯ
   * �汾: 3.0
   * ����: 2008/06/25
   * ����: zhanghonga
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

/*

FTP::bossweb\/bossweb/applications/sxdomain/DefaultWebApp/npage/PersonChange/sk330/fk330.jsp


7363 setlist
*/

	String opCode = "k330";
	String opName = "������ѯ";
	String currentTime=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String currentMinute = new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
  String currentDay = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String beginTime = currentDay + " 00:00:00";
  String endTime = currentDay + " 23:59:59";
%>
<html>
<head>
<title>������ѯ</title>

<script language=javascript>

	//������ɺ�ִ�еĲ���
	onload=function(){
		document.form1.queryCustId.focus();		
	}
	
	//���Ĳ�ѯ��ʽʱ�������¼�
	function changeQueryType(){
		if(document.form1.queryType.value=="1"){
			document.getElementById("signWnContent").style.display="block";
			document.getElementById("wntd").style.display="block";
			document.getElementById("signCustContent").style.display="none";
			document.getElementById("custtd").style.display="none";
			document.getElementById("titleDiv").innerHTML="�������ֻ���";
			hiddenTip(document.form1.queryCustId);
			document.form1.queryPhoneNo.focus();
			document.form1.queryPhoneNo.select();
		}else{
			document.getElementById("signWnContent").style.display="none";
			document.getElementById("wntd").style.display="none";
			document.getElementById("signCustContent").style.display="block";
			document.getElementById("custtd").style.display="block";
			document.getElementById("titleDiv").innerHTML="�����붩����ʶ";
			hiddenTip(document.form1.queryPhoneNo);
			document.form1.queryCustId.focus();
			document.form1.queryCustId.select();	
		}	
	}
	
	
	//�ύ����
	function doQuery(){
		with(document.form1){
			if(queryType.value=="0"){
				if(queryCustId.value.trim().len()==0){
					showTip(queryCustId,"������ʶ����Ϊ��!");
					return false;
				}
				if(!forInt(queryCustId)){return false;}
			}else{
				if(!forNumChar(queryPhoneNo)){return false;}
				if(queryPhoneNo.value.trim().len()!=11){
					showTip(queryPhoneNo,"�ֻ��ű�����11λ!");
					return false;
				}	
			}		
		}
		
		document.getElementById("sQryCnttOnlyDiv").style.display="block";
		document.getElementById("sQryCnttOnlyTable").style.display="block";
		
		form1.target="iframe1";
		form1.submit();
	}

	//�������
	function doClear(){
		with(document.form1){
			reset();
			changeQueryType();
			hiddenAllTip();
		}	
	}
	
	
	//����������ʾ��
	function hiddenAllTip(){
		with(document.form1){
			hiddenTip(queryCustId);
			hiddenTip(queryPhoneNo);
		}
	}
		
	//��ʾ�����ص�һ����Ϣ��
	function doShowOnlyInfo1(){
		if(document.getElementById("sQryCnttOnlyTable").style.display=="block"){
			document.getElementById("sQryCnttOnlyTable").style.display="none";
		}else{
			document.getElementById("sQryCnttOnlyTable").style.display="block";	
		}
	}
	
	
	//��ʾ�����صڶ�����Ϣ��
	function doShowInfo2(){
		if(document.getElementById("sQryCnttInfoTable").style.display=="block"){
			document.getElementById("sQryCnttInfoTable").style.display="none";
		}else{
			document.getElementById("sQryCnttInfoTable").style.display="block";	
		}
	}
</script>
</head>
<body>
<form name="form1" method="POST" action="fk330_info.jsp">
	<%@ include file="/npage/include/header.jsp" %>	
	<div class="title" id="titleDiv">�����붩����ʶ</div>
	  <table cellspacing="0">
	  	<tr>
	  		<td class="blue">��ѯ��ʽ</td>
	  		<td>
	  			<select name="queryType" onchange="changeQueryType()">
	  				<option value="0">��������ʶ��ѯ</option>
	  				<option value="1">���ֻ��Ų�ѯ</option>	
	  			</select>	
	  		</td>
	  		<td class="blue" id="signCustContent">������ʶ</td>	
	  		<td id="custtd">
	  			<input type="text" name="queryCustId" value="" style="ime-mode:disabled" 
	  			onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13)doQuery()" maxlength="16">	
	  		</td>
	  		<td class="blue" id="signWnContent" style="display:none">�ֻ���</td>

	  		<td id="wntd" style="display:none">
	  			<input type="text" name="queryPhoneNo" value="" style="ime-mode:disabled" 
	  			 onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13)doQuery()" maxlength="11" >		
	  		</td>
	  	</tr>
	    <tr>
	      <td colspan="5" id="footer">
	        <div align="center">
	          <input class="b_foot" type="button" name="qryPage" value="��ѯ" style="cursor:hand" onClick="doQuery()">
	          <input class="b_foot" type="button" name="back" value="����" style="cursor:hand" onClick="doClear()">
						<input class="b_foot" type="button" name="qryPage" value="�ر�" style="cursor:hand" onClick="parent.removeTab('<%=opCode%>')">
	        </div>
	      </td>
	    </tr>
	    
	  </table>
  </div>
  
	<div id="Operation_Table"> 
  <div class="title" onclick="doShowOnlyInfo1()" id="sQryCnttOnlyDiv" style="display:none;cursor:hand">��ѯ���</div>
	  <table id="sQryCnttOnlyTable" style="display:none">
	  	<tr>
	  		<td>
	  			<iframe id="iframe1" name="iframe1" frameborder="0" width="100%" height="240px" 
	  				marginwidth="0" marginheight="0" scrolling="auto" 
	  				src=""></iframe>	
	  				<!--
	  				http://10.204.127.5:7001/npage/PersonChange/sk330/fk330_info.jsp
	  				-->
	  		</td>
	  	</tr>
		</table>
	</div>
  
	<div id="Operation_Table">
	<div class="title" onclick="doShowInfo2()" id="sQryCnttInfoDiv" style="display:none;cursor:hand">��ѯ���</div>
		<table id="sQryCnttInfoTable" style="display:none">
			<tr>
				<td>
					<iframe id="iframe2" name="iframe2" frameborder="0" width="100%" height="200px" 
						marginwidth="0" marginheight="0" scrolling="auto"
						src=""></iframe>	
				</td>	
			</tr>	
		</table>
  <%@ include file="/npage/include/footer.jsp" %>
  </form>
</body>
</html>