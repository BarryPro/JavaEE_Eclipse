<%
    /********************
     * @ OpCode    :  6991
     * @ OpName    :  SIM卡变更历史和详细信息查询
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-01-26
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "5432";
    String opName = "短信举报";
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String selectSql = "select length(trim(msg)) + 1,msg ,msg_code from SSHORTMSGMODEL where op_code='5432'";
%>
	<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1">
		<wtc:sql><%=selectSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing=0>
<tr>
    <td class="blue">受理号码</td>
    <td >
        <input type="text" id="phoneNo" name="phoneNo" value="<%=activePhone%>" size="11" v_must="1"  readOnly class="InputGrey"/><font class="orange">*</font> 
    </td>
    
    <td class="blue">被举报号码</td>
    <td >
        <input type="text" id="phoneNoja"  name="phoneNoja"   maxlength="12" v_type="mobphone" v_must="1"  /><font class="orange">*</font> 
    </td>
</tr>
<tr>
	<td class="blue">举报类型</td>
	<td colspan="3">
		<!-- 下拉框数值，与文字长度有关。如果修改文字请修改对应的值 -->
		<select name="report" id="report" onchange="changeReport()" style="width:380px;">
			<option value="0">--请选择--</option>
			<%
				if(result1 != null && result1.length > 0){
					for(int i = 0; i < result1.length; i++){
			%>
						<option  reportTypeVal = "<%=result1[i][2]%>"  value="<%=result1[i][0]%>"><%=result1[i][1]%></option>
			<%
					}
				}
			%>
		</select>
		<input type="hidden" name="reportVal" id="reportVal" />
		<input type="hidden" name="reportTypeVal" id="reportTypeVal" />
	</td>
</tr>
<tr>
    <td class="blue">短信内容</td>
    <td colspan="3">
        <input type="text" id="smsDeti" name="smsDeti" value="" size="140" maxlength="140" v_maxlength="140" v_type="string" v_must="1" /><font class="orange">*</font> 
    </td>
  
</tr>

<tr id="footer">
    <td colspan="4">
    	  <input type="reset" id="bClear" name="bClear" value="确定" onclick="submitf()" class="b_foot" />
        <input type="reset" id="bClear" name="bClear" value="清除" class="b_foot" />
        <input type="button" id="bClose" name="bClose" value="关闭" class="b_foot" onClick="removeCurrentTab()" />
    </td>
</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>

<script type=text/javascript>
 
    
    function submitf(){
     		
     		if(!($("#phoneNoja").val() == "9")){
	        if(!forPhone(document.all.phoneNoja)) return false;
	      }else{
	      	var s1 = document.getElementById("report");
					for(i = 0;i<s1.length;i++){
						if(s1.options[i].text == '淫秽、色情、赌博、暴力、凶杀、恐怖信息'){
							s1.options[i].selected = true;
							changeReport();
						}
					}
	      }
        var phoneNoj = $("#phoneNoja").val();
        if(phoneNoj == ""){
            rdShowMessageDialog("请输入手机号码！",0);
            $("#phoneNoj").focus();
            return false;
        }
        
        var smsDeti = $("#smsDeti").val();
        if(!checkElement(document.getElementById("smsDeti"))){
        	rdShowMessageDialog("短信内容长度不允许超过140个字符或70个汉字！", 1);
            $("#smsDeti").focus();
            return;
        }
        
      frm.action="f5432_2.jsp";
    	frm.submit();
    }
    
    function changeReport(){
    	
    	    	
    	//document.getElementById("reportTypeVal").value=
		
    	
    	var reportObj = $("#report");
    	
    	var reportTypeVal =  reportObj.find("option:selected").attr("reportTypeVal");
			document.getElementById("reportTypeVal").value = reportTypeVal;
    	var selectValue = reportObj.val();
    	var selectText = reportObj.find("option:selected").text();
    	var reportVal = $("#reportVal").val();
			$("#reportTypeVal").val(  $("#reportVal").reportTypeVal );
    	if("0" != selectValue){
    		$("#smsDeti").val(selectText + ":" + $("#smsDeti").val().substr(reportVal));
    	}else{
    		$("#smsDeti").val($("#smsDeti").val().substr(reportVal));
    	}
 	
    	$("#smsDeti")[0].focus();
    }
    
</script>

</body>
</html>