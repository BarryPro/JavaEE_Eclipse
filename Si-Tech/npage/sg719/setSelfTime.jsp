<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.text.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<%
	String currentTime = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); //��ǰʱ��
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String expType = request.getParameter("expType");
	String expNum = request.getParameter("expNum");	
%>
<html>
	<script type=text/javascript>

		function saveTo(){
			if(!checksubmit(gropFm)) return false ;
			var begTime = document.gropFm.effTime;
			var endTime = document.gropFm.expTime;
			if(begTime.value.trim()!="" && endTime.value.trim() ){
				if(parseInt(begTime.value.trim()) > parseInt(endTime.value.trim())){
					rdShowMessageDialog("��Чʱ�䲻�ܴ���ʧЧʱ��");
					return false;
				}
			}
			if(begTime.value.trim()!="" && endTime.value.trim()){
				if(parseInt(begTime.value.trim()) < parseInt("<%=currentTime%>")){
					rdShowMessageDialog("��Чʱ�䲻��С�ڵ�ǰʱ��");
					return false;
				}
			}

			if(begTime.value.trim().substring(6,8)!="01"){
				rdShowMessageDialog("������Ч������ֻ����ÿ��1��");
				var tempTime = begTime.value.trim().substring(0,4)+"/"+begTime.value.trim().substring(4,6)+"/"+begTime.value.trim().substring(6,8);
				var parseTime = new Date(tempTime);
				var year = parseTime.getYear();
				var month = parseTime.getMonth()+2;
				if(month<10){ 
						month = "0"+month;
				}else
				{
					month = ""+month;
				}
				if(month=="13")
				{
					month="01";
					year++;
				}
				var day = "01";
				document.gropFm.effTime.value = ""+year+month+day;
				var expTypeTemp="";
				if("<%=expType%>"=="��")
				{
					expTypeTemp="MM";
				}else if("<%=expType%>"=="��")
				{
					expTypeTemp="yyyy";
				}	
				$("#expTime").val(setDateMove(document.gropFm.effTime.value+"000000",expTypeTemp,'<%=expNum%>','yyyyMMddkkmmss')+"");
			}
      
			var retValue = "";
			if(begTime.value.trim()!="" && endTime.value.trim()!=""){
					retValue = begTime.value.trim()+"000000"+"~"+endTime.value.trim();
			}
			window.returnValue = retValue;
			window.close();
			}
	</script>
	<body>
	<div id="operation">
	<FORM name="gropFm" action="" method=post>
	<%@ include file="/npage/include/header.jsp" %>	
	<div id="operation_table">
		<DIV class="title"><div class="text">������ʧЧʱ��</div></DIV>	
		<div class="input" id="attrInfo" >
			<table>
				<input type="hidden" id="sysTime" value = "<%=currentTime%>" v_format="yyyyMMdd">
				<tr id="effId">
				<th>��Чʱ�䣺</th>
				<td><input type="text" name="effTime" id="effTime" value="<%=startTime.substring(0,8)%>" class="required yyyyMMdd" v_format="yyyyMMdd" ></td>
				</tr>
				<tr id="expId">
				<th>ʧЧʱ�䣺</th>
				<td><input type="text" name="expTime" id="expTime" value="<%=endTime.substring(0,8)%>" class="required yyyyMMdd" v_format="yyyyMMdd"  readOnly></td>
				</tr>

			</table>
		</div>
	</div>
	<div id="operation_button">
	<input class="b_foot" name=query  type=button onClick="saveTo()" value="ȷ��">
	&nbsp; 
	<input class="b_foot" name=back onClick="window.close()" type=button value="����">
	&nbsp; 
</div>
	<%@ include file="/npage/include/footer.jsp"%>
	</FORM>
	</div>
	</body>
</html>