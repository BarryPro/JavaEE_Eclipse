<%
  /*
   * ����: �Ӵ���Ϣ��ѯ
   * �汾: 3.0
   * ����: 2008/06/25
   * ����: zhanghonga
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "k320";
	String opName = "���������ѯ";
	String currentTime=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String currentMinute = new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
  String currentDay = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  
  //Calendar cal = Calendar.getInstance();
  //cal.add(Calendar.MONTH,-1);
  //String beginTime = new java.text.SimpleDateFormat("yyyyMMdd").format(cal.getTime()) + " " +currentMinute; 
	String beginTime = currentDay + " 00:00:00";
  String endTime = currentDay + " 23:59:59";
%>
<html>
<head>
<title>���������ѯ</title>

<script language=javascript>

	//������ɺ�ִ�еĲ���
	onload=function(){
		document.form1.queryCustId.focus();		
	}
	
	//��鿪ʼʱ��
	function checkBeginTime(){
		with(document.form1){
			if(queryBeginTime.value.trim().len()==8){
				queryBeginTime.value=queryBeginTime.value+" 00:00:00";
			}
			
			var beginTime = queryBeginTime.value.trim();
			var endTime = queryEndTime.value.trim();
			var currentTime = "<%=currentTime%>";
 
			if(!forDate(queryBeginTime)){return false;}
			
			beginTime = beginTime.substring(0,8) + beginTime.substring(9,11) + beginTime.substring(12,14) +beginTime.substring(15,17);
			endTime = endTime.substring(0,8) + endTime.substring(9,11) + endTime.substring(12,14) +endTime.substring(15,17);	
			currentTime = currentTime.substring(0,8) + currentTime.substring(9,11) + currentTime.substring(12,14) +currentTime.substring(15,17);
			
			/***if(beginTime>currentTime){
				showTip(queryEndTime,"��ʼʱ�䲻�ܴ��ڵ�ǰʱ��!");
				return false;
			}***/
			
			if(beginTime>endTime){
				showTip(queryBeginTime,"��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
				return false;
			}
			
			hiddenTip(queryBeginTime);
		}
	}
	
	//������ʱ��
	function checkEndTime(){
		with(document.form1){
			if(queryEndTime.value.trim().len()==8){
				queryEndTime.value=queryEndTime.value+" "+"<%=currentMinute%>";
			}
			
			var beginTime = queryBeginTime.value.trim();
			var endTime = queryEndTime.value.trim();
			var currentTime = "<%=currentTime%>";
			
			if(!forDate(queryEndTime)){return false;}
			
			beginTime = beginTime.substring(0,8) + beginTime.substring(9,11) + beginTime.substring(12,14) +beginTime.substring(15,17);
			endTime = endTime.substring(0,8) + endTime.substring(9,11) + endTime.substring(12,14) +endTime.substring(15,17);
			currentTime = currentTime.substring(0,8) + currentTime.substring(9,11) + currentTime.substring(12,14) +currentTime.substring(15,17);
			
			/**if(endTime>currentTime){
				showTip(queryEndTime,"����ʱ�䲻�ܴ��ڵ�ǰʱ��!");
				return false;
			}**/
			
			if(endTime<beginTime){
				showTip(queryEndTime,"����ʱ�䲻��С�ڿ�ʼʱ��!");
				return false;
			}
			
			hiddenTip(queryEndTime);
		}	
	}
	
	
	//�ύ����
	function doQuery(){
		with(document.form1){
				if(queryCustId.value.trim().len()!=0){
					if(!forInt(queryCustId)){return false;}
				}
				
				if(accept_no.value!="" && accept_no.value.trim().len()!=14){
					showTip(queryWorkNo,"���������ʶ������ʮ��λ!");
					return false;
				}	
			}
			
			if(checkBeginTime()==false){
				return false;	
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
			hiddenAllTip();
		}	
	}
	
	
	//����������ʾ��
	function hiddenAllTip(){
		with(document.form1){
			hiddenTip(queryCustId);
			hiddenTip(queryWorkNo);
			hiddenTip(queryBeginTime);
			hiddenTip(queryEndTime);
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
<form name="form1" method="POST" action="k320_qry.jsp">
	<%@ include file="/npage/include/header.jsp" %>	
	<div class="title" id="titleDiv">������ͻ�ID</div>
	  <table cellspacing="0">
			<tr>
				<td class="blue">���������ʶ</td>
				<td>
					<input type="text" name="accept_no" value="" maxlength="14" style="ime-mode:disabled">
				</td>
				<td class="blue" id="signCustContent">�ͻ���ʶ</td>	
		  		<td id="custtd">
		  			<input type="text" name="queryCustId" value=""  maxlength="11">	
		  		</td>
			</tr>
			<tr>
				<td class="blue">��ʼʱ��</td>
				<td>
					<input type="text" name="queryBeginTime" value="<%=beginTime%>" maxlength="17" onblur="checkBeginTime()" style="ime-mode:disabled"  v_format="yyyyMMdd HH:mm:ss">	
				</td>
				<td class="blue">����ʱ��</td>
				<td>
					<input type="text" name="queryEndTime" value="<%=endTime%>" maxlength="17" onblur="checkEndTime()" style="ime-mode:disabled"  v_format="yyyyMMdd HH:mm:ss">
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
	  			<iframe id="iframe1" name="iframe1" frameborder="0" width="100%" height="240px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>	
	  		</td>
	  	</tr>
		</table>
	</div>
  
	<div id="Operation_Table">
	<div class="title" onclick="doShowInfo2()" id="sQryCnttInfoDiv" style="display:none;cursor:hand">��ѯ���</div>
		<table id="sQryCnttInfoTable" style="display:none">
			<tr>
				<td>
					<iframe id="iframe2" name="iframe2" frameborder="0" width="100%" height="200px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>
				</td>	
			</tr>	
		</table>
  <%@ include file="/npage/include/footer.jsp" %>
  </form>
</body>
</html>