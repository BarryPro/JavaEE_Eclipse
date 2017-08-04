<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 管理系数配置 fb901
   * 版本: 1.0
   * 日期: 2010/11/30
   * 作者: wanglm
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%
	String opCode="b901";
	String opName="管理系数配置";
	String work_no = (String)session.getAttribute("workNo");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>管理系数配置</TITLE>
</HEAD>
<script language="javascript" >
	function selectGroup(){
    	window.open("grouptree.jsp",'_blank','height=600,width=300,scrollbars=yes');
	}
	function doSubmit(){
		if($("#groupId").val() == ""){
			rdShowMessageDialog("请选择组织节点!");
			return;
		}
		if($("#serviceNo").val() == ""){
		  	rdShowMessageDialog("报告号码不能为空!");
			return;
		}else{
			var serviceNoVal = $("#serviceNo").val();
			if(serviceNoVal.substring(serviceNoVal.length-1) != "|"){
			   	$("#serviceNo").val(serviceNoVal+"|");
			}
		}
		if($("#administratorNo").val() == ""){
		  	rdShowMessageDialog("管理员号码不能为空!");
			return;
		}else{
			var administratorNoVal = $("#administratorNo").val();
			if(administratorNoVal.substring(administratorNoVal.length-1) != "|"){
			   	$("#administratorNo").val(administratorNoVal+"|");
			}
		}
	   	form1.action = "fb901_sub.jsp?opCode=<%=opCode%>";
	   	form1.submit();
	}
</script>
<body>
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">管理系数配置</div>
    </div>
    <table cellSpacing="0">
    	<tr>
    		<td class="blue">组织节点</td>
    		<td>
    			<input type="hidden" name="groupId" id="groupId">
    			<input type="text" name="groupName" id="groupName" class="InputGrey" readonly />
    			<font color="orange">*</font>
    			<input type="button" name="selectBtn" class="b_text" value="选择" onclick="selectGroup()" />
    		</td>
    		<td class="blue">较忙指数 </td>
    	    <td>
    	    	<select name="busy" id="busy" style="width:100px">
    	    		<option value="1" />1
    	    		<option value="2" />2
    	    		<option value="3" />3
    	    		<option value="4" />4
    	    		<option value="5" />5
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
    	    <td class="blue">很忙指数 </td>
    	    <td>
    	    	<select name="varyBusy" id="varyBusy" style="width:100px">
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
    	    <td class="blue">等待人数 </td>
    	    <td>
    	    	<select name="waitPeoples" id="waitPeoples" style="width:100px">
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
    	    <td class="blue">等待时间 </td>
    	    <td colspan="3">
    	    	<select name="waitTime" id="waitTime" style="width:100px">
    	    		<option value="10" />10分钟
    	    		<option value="20" />20分钟
    	    		<option value="30" />30分钟
    	    		<option value="40" />40分钟
    	    		<option value="50" />50分钟
    	    		<option value="60" />60分钟
    	    		<option value="70" />70分钟
    	    		<option value="80" />80分钟
    	    		<option value="90" />90分钟
    	    	</select>
    	    	<font color="orange" >*</font>
    	    </td>
        </tr>
        <tr>
           <td class="blue" >营业厅管理人员手机号</td>	
           <td colspan="5">
              <input type="text" name="serviceNo" id="serviceNo" size="60" />
              <font color="orange" >*多个号码请用“|”分隔。</font>	
           </td>
        </tr>	
        <tr>
           <td class="blue" >县市分公司管理人员手机号</td>	
           <td colspan="5">
              <input type="text" name="administratorNo" id="administratorNo" size="60" />
              <font color="orange" >*多个号码请用“|”分隔。</font>	
           </td>
        </tr>
    	<tr>
			<td colspan="6" align="center" id="footer">
			<input class="b_foot" name="submits" type="button" onclick="doSubmit()" value="确认" />
			<input class="b_foot" name="reee"    type="button" onClick="form1.reset()" value="清除"/>
			<input class="b_foot" name="re"    type="button" onClick="javascript:history.go(-1);" value="返回"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="关闭"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
 <font color="#0256b8" >
        &nbsp;&nbsp;配置说明：
        <br/>
        <br/>
        &nbsp;&nbsp;1.配置繁忙程度系数<br/>
        &nbsp&nbsp;营业厅繁忙程度分为不忙、较忙、很忙三级,可配置等候人数与营业厅台席数的整倍数关系来调整:<br/>
        &nbsp;&nbsp;营业厅台席数=N 等候人数=Y   <br/>
        &nbsp;&nbsp;不忙   (较忙指数)×N＞Y≥  0  ×N<br/>
        &nbsp;&nbsp;较忙   (很忙指数)×N＞Y≥(较忙指数)×N<br/>
        &nbsp;&nbsp;很忙    +∞ ×N＞Y≥(很忙指数)×N<br/>
       &nbsp;&nbsp; 当营业厅繁忙状态为较忙或很忙时发送告警短信到县市分公司\营销部服务管理人员手机中:<br/>
        &nbsp;&nbsp;**营业厅， *时*分状态为很忙。<br/>
        <br/>
       &nbsp;&nbsp; 2.配置短信发送系数<br/>
        &nbsp;&nbsp;配置营业厅内等候人数阀值，当营业厅等候人数超过设定系数时自动发送告警短信到营业厅管理人员手机中:<br/>
        &nbsp;&nbsp;**营业厅， *时*分等候人数为**人。<br/>
        <br/>
        &nbsp;&nbsp;3.配置平均等候时间阀值<br/>
       &nbsp;&nbsp; 配置营业厅内等候时间阀值，当客户在营业厅的等候时间超过设定的阀值时发送告警短信到营业厅管理人员手机中:<br/>
       &nbsp;&nbsp; **营业厅， *时*分*客户等候时间超过*分钟。<br/>
	  
        </font>
</body>
</html>
    		
    			