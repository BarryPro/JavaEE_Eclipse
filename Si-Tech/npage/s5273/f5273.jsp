<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.25
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");    
    
	String regionCode = (String)session.getAttribute("regCode");
	
	ArrayList retList = new ArrayList();  
	String sqlStr="";

    sqlStr ="select region_code,region_name from sRegionCode where region_code='"+regionCode+"' Order By region_code";
	String[] inParams = new String[2];
	inParams[0] = "select region_code,region_name from sRegionCode where region_code=:regionCode Order By region_code";
	inParams[1] = "regionCode="+regionCode;
	
  	//retList = impl.sPubSelect("2",sqlStr,"region",regionCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="retListString"  scope="end"/>
<%
  	//String[][] retListString = (String[][])retList.get(0);
  	if(retListString.length==0){
  		retListString = new String[1][1];
  		retListString[0][0] = "";
  	}

	//----------------------查找出所属地市的佣金比例配置---------------------------
	ArrayList retList1 = new ArrayList();
  	String sqlStr1 = "select trim(to_char(reward_rate,90.999)),trim(to_char(awake_fee,99999990.99)),trim(to_char(min_prepay,99999990.99)) from sAgtReward where region_code = '"+  retListString[0][0] +"'";
	inParams[0] = "select trim(to_char(reward_rate,90.999)),trim(to_char(awake_fee,99999990.99)),trim(to_char(min_prepay,99999990.99)) from sAgtReward where region_code =:regCode";
	inParams[1] = "regCode="+retListString[0][0];
	
  	//retList1 = impl.sPubSelect("3",sqlStr1,"region",regionCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="retListString1"  scope="end"/>
<%
  	//String[][] retListString1 = (String[][])retList1.get(0);
	String reward_rate = "";
	String awake_fee = "";
	String min_prepay = "";

	if(retListString1.length != 0){
		reward_rate = retListString1[0][0];
		awake_fee = retListString1[0][1];
		min_prepay = retListString1[0][2];
	}
%>


<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>佣金比例配置</title>
<%//-----------------------------------js区域-------------------------------------%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language=javascript>

	//--------------------------------提交表单------------------------------------
	function commit(){
		getAfterPrompt();
		var new_reward=document.form1.reward_rate.value;
		if(new_reward>=1||new_reward<0.01){
			rdShowMessageDialog("佣金比例输入不正确，请输入0到1之间的两位有效值小数!");
			return false;
		}
		if(checkcommit()){
			form1.action="f5273_Cfm.jsp";
			form1.submit();
			return true;
		}
	}
	
	//---------------------------------清空表单---------------------------------------
	function resetJSP(){
		for(i=0;i<document.form1.elements.length;i++){
			if (document.form1.elements[i].type=="text"){
				document.form1.elements[i].value = "";
			}
		}
	}

	//------------------------------------验证------------------------------------------
	function checkcommit(){
		
		if(!checkElement(document.form1.reward_rate)){
			return false;
		}else if(!checkElement(document.form1.sales_region)){
			return false;
		}else{
			return true;
		}
	}
	//------------------------------------备注------------------------------------------
	function ratechg(){
		document.form1.reason.value = "新佣金比例:"+document.form1.reward_rate.value;
	}
	
</script>
</head>
<%//--------------------------------------页面区域--------------------------------------------%>
<body>

<form name="form1" method="post">
  <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		
        <table cellspacing="0">
          
          <tr> 
            <td class="blue">地市</td>
            <td> 
			<select name="sales_region" v_type="string" v_must="1">
			<%
				for(int i=0;i < retListString.length;i ++){
			%>
              <option value='<%=retListString[i][0]%>'><%=retListString[i][1]%></option>
			<%
				}
			%>
            </select>
		    <font color="orange">*</font>            
			</td>
          </tr>
          <tr> 
            <td class="blue">佣金比例</td>
            <td> 
              <input name="reward_rate" type="text" id="reward_rate" maxlength="14" v_type="float" v_must="1" value='<%=reward_rate%>' onChange="ratechg()">
		   	  <font color="orange">*</font>            
			</td>
          </tr>
          <tr> 
            <td class="blue">修改原因</td>
            <td> 
          		<input name="reason" type="text" id="reason" maxlength="60" size="60"  v_type="string" >
            </td>
          </tr>
          <tr> 
          	  <input name="awake_fee" type="hidden" id="awake_fee" maxlength="14"  v_type="money" v_must="1" value='<%=awake_fee%>'>
              <input name="min_prepay" type="hidden" id="min_prepay" maxlength="14"  v_type="money" v_must="1" value='<%=min_prepay%>'>
          </tr>
          <tr> 
            <td colspan="4" id="footer"> 
              <div align="center"> 
                <input name="submit1" type="button" class="b_foot" value="确认" onClick="commit()">
                &nbsp; 
                <input name="reset" type="button" class="b_foot" value="清除" onClick="resetJSP()">
                &nbsp; 
                <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="返回">
                &nbsp; </div>
            </td>
          </tr>
        </table>

   <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
