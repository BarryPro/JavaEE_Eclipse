<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ϵ������ fb901
   * �汾: 1.0
   * ����: 2010/11/30
   * ����: wanglm
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%
	String opCode="b901";
	String opName="����ϵ������";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	String varyBusy = request.getParameter("varyBusy");
	String busy = request.getParameter("busy");
	String waitePeoples = request.getParameter("waitePeoples");
	String waiteTime = request.getParameter("waiteTime");
	String serviceNo = request.getParameter("serviceNo");
	String administratorNo = request.getParameter("administratorNo");
	String groupId = request.getParameter("groupId");
    String groupName = request.getParameter("groupName");
	   System.out.println("======================= + varyBusy" + varyBusy);
	   System.out.println("======================= + busy" + busy);
	   System.out.println("======================= + waitePeoples" + waitePeoples);
	   System.out.println("======================= + waiteTime" + waiteTime);
	   System.out.println("======================= + serviceNo" + serviceNo);
	   System.out.println("======================= + administratorNo" + administratorNo);
	   System.out.println("======================= + groupId" + groupId);
	   System.out.println("======================= + groupName" + groupName);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>����ϵ������</TITLE>
</HEAD>
<script language="javascript" >
	function selectGroup(){
    	window.open("grouptree.jsp",'_blank','height=600,width=300,scrollbars=yes');
	}
	function doSubmit(){
		if($("#groupId").val() == ""){
			rdShowMessageDialog("��ѡ����֯�ڵ�!");
			return;
		}
		if($("#serviceNo").val() == ""){
		  	rdShowMessageDialog("������벻��Ϊ��!");
			return;
		}else{
			var serviceNoVal = $("#serviceNo").val();
			if(serviceNoVal.substring(serviceNoVal.length-1) != "|"){
			   	$("#serviceNo").val(serviceNoVal+"|");
			}
		}
		if($("#administratorNo").val() == ""){
		  	rdShowMessageDialog("����Ա���벻��Ϊ��!");
			return;
		}else{
			var administratorNoVal = $("#administratorNo").val();
			if(administratorNoVal.substring(administratorNoVal.length-1) != "|"){
			   	$("#administratorNo").val(administratorNoVal+"|");
			}
		}
		updateState();
	   	form1.action = "fb901_sub.jsp?opCode=<%=opCode%>";
	   	form1.submit();
	}
	function updateState(){
		$("#reee").attr("disabled",false);
	   	$("#busy").attr("disabled",false);
	   	$("#selectBtn").attr("disabled",false);
	   	$("#varyBusy").attr("disabled",false);
	   	$("#waitPeoples").attr("disabled",false);
	   	$("#waitTime").attr("disabled",false);
	   	$("#serviceNo").attr("disabled",false);
	   	$("#administratorNo").attr("disabled",false);
	}
	function sel(){
		 $("#groupId").val("<%=groupId%>");
		 $("#groupName").val("<%=groupName%>");
	   	 $("#busy").val("<%=busy%>");
	   	 $("#varyBusy").val("<%=varyBusy%>");
	   	 $("#waitPeoples").val("<%=waitePeoples%>");
	   	 $("#waitTime").val("<%=waiteTime%>");
	}
	function clearText(){
		$("#busy").val("1");
	   	$("#varyBusy").val("1");
	    $("#waitPeoples").val("10");
	   	$("#waitTime").val("1");
	    $("#serviceNo").val("");
	    $("#administratorNo").val("");
	}
	function goBack(){
	   window.location="fb901.jsp";	
	}
</script>
<body onload="sel()">
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">����ϵ������</div>
    </div>
    <table cellSpacing="0">
    	<tr>
    		<td class="blue">��֯�ڵ�</td>
    		<td>
    			<input type="hidden" name="groupId" id="groupId">
    			<input type="text" name="groupName" id="groupName" class="InputGrey"  readonly />
    			<font color="orange">*</font>
    			<input type="button" name="selectBtn" id="selectBtn" class="b_text" value="ѡ��" onclick="selectGroup()"  disabled />
    		</td>
    		<td class="blue">��æָ�� </td>
    	    <td>
    	    	<select name="busy" id="busy" style="width:100px" value="<%=busy%>" disabled >
    	    		<option value="1" />1
    	    		<option value="2" />2
    	    		<option value="3" />3
    	    		<option value="4" />4
    	    		<option value="5" />5
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
    	    <td class="blue">��æָ�� </td>
    	    <td>
    	    	<select name="varyBusy" id="varyBusy" style="width:100px"  disabled >
    	    		<option value="1" />1
    	    		<option value="2" />2
    	    		<option value="3" />3
    	    		<option value="4" />4
    	    		<option value="5" />5
    	    		<option value="6" />6
    	    		<option value="7" />7
    	    		<option value="8" />8
    	    		<option value="9" />9
    	    		<option value="10" />10
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
    	</tr>
    	<tr>
    	    <td class="blue">�ȴ����� </td>
    	    <td>
    	    	<select name="waitPeoples" id="waitPeoples" style="width:100px" disabled >
    	    		<option value="10" />10
    	    		<option value="20" />20
    	    		<option value="30" />30
    	    		<option value="40" />40
    	    		<option value="50" />50
    	    		<option value="60" />60
    	    		<option value="70" />70
    	    		<option value="80" />80
    	    		<option value="90" />90
    	    		<option value="100" />100
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
    	    <td class="blue">�ȴ�ʱ�� </td>
    	    <td colspan="3">
    	    	<select name="waitTime" id="waitTime" style="width:100px" disabled >
    	    		<option value="10" />10����
    	    		<option value="20" />20����
    	    		<option value="30" />30����
    	    		<option value="40" />40����
    	    		<option value="50" />50����
    	    		<option value="60" />60����
    	    		<option value="70" />70����
    	    		<option value="80" />80����
    	    		<option value="90" />90����
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
        </tr>
        <tr>
           <td class="blue" >Ӫҵ��������Ա�ֻ���</td>	
           <td colspan="5">
              <input type="text" name="serviceNo" id="serviceNo" size="60" value="<%=serviceNo%>" disabled />
              <font color="orange" >*����������á�|���ָ���</font>	
           </td>
        </tr>	
        <tr>
           <td class="blue" >���зֹ�˾������Ա�ֻ���</td>	
           <td colspan="5">
              <input type="text" name="administratorNo" id="administratorNo" size="60" value="<%=administratorNo%>" disabled />
              <font color="orange" >*����������á�|���ָ���</font>	
           </td>
        </tr>
         <tr>
           <td colspan="6" ><font color="orange" >*����޸İ�ť�ɶ���Ϣ�����޸ġ�</font>	</td>
        </tr>
    	<tr>
			<td colspan="6" align="center" id="footer">
			<input class="b_foot" name="submits" type="button" onclick="doSubmit()" value="ȷ��" />
			<input class="b_foot" name="update" type="button" onclick="updateState()" value="�޸�" />
			<input class="b_foot" name="reee" id="reee"    type="button" onmouseup="clearText()"  value="���" disabled />
			<input class="b_foot" name="re"    type="button" onClick="goBack()" value="����"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
    		
    			