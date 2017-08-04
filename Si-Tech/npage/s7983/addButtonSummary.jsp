<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
	String loginNo=(String)session.getAttribute("workNo");    //工号 
	String loginName =(String)session.getAttribute("workName");//工号名称  	
	String orgCode = (String)session.getAttribute("orgCode");      
	String regionCode = (String)session.getAttribute("regCode");    
	String ip_Addr = request.getRemoteAddr();

    String [][] retStr = new String[][]{};
    String error_code = "";
    String error_msg="系统错误，请与系统管理员联系";
    int valid = 1;  //0:正确，1：系统错误，2：业务错误 

    double dTotalOwe=0.00;
    String sTotalOwe="";

    String login_no = request.getParameter("loginNo");  
    String phone_no = request.getParameter("phoneNo");
    String op_code  = request.getParameter("opCode");
    String org_code = request.getParameter("orgCode");
    String iRegion_Code = org_code.substring(0,2);
    
    
    String portalName = request.getParameter("portalName");    
    String portalPassword = request.getParameter("portalPassword");
    
    String shortNo = request.getParameter("shortNo");
    String realNo = request.getParameter("realNo");
    
    String opCode = "3210";	
	String opName = "用户信息";

try{
%>	    
     <wtc:service name="s2417Init" routerKey="region" routerValue=" <%=iRegion_Code%>" retcode="retCode2417" retmsg="retMsg2417" outnum="38">
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=op_code%>"/>	
		<wtc:param value="<%=org_code%>"/>			
     </wtc:service>
     <wtc:array id="retStrArray" scope="end" />
<%	  
     retStr = retStrArray;	              
     error_code = retCode2417;
     error_msg = retMsg2417;                 
         
     if(!error_code.equals("000000") || !retStr[0][5].equals("A")){
        error_msg="用户状态非正常";
%>
	     <wtc:service name="SoxLogCfm" outnum="2" retmsg="retMsg2" retcode="retCode2" routerKey="region" routerValue="<%=iRegion_Code%>">
    		<wtc:param value="grp"/>
    		<wtc:param value="1"/>
    		<wtc:param value="<%=login_no%>"/>	
    		<wtc:param value="<%=op_code%>"/>
    		<wtc:param value="<%=phone_no%>"/>
    		<wtc:param value=""/>
    		<wtc:param value="s2417Init"/>	
    		<wtc:param value="date"/>	
    		<wtc:param value="2"/>	
    		<wtc:param value="1"/>	
    		<wtc:param value="<%=error_msg%>"/>
    		<wtc:param value=""/>	
    		<wtc:param value=""/>		
	     </wtc:service>
	     <wtc:array id="retStrerr" scope="end" />	     
<%
     }
         
}catch(Exception e){
}
       
    if( retStr == null ){
       valid = 1;
    }else if (!error_code.equals("000000")) {
       valid = 2;
    }else{
       valid = 0;
       if (Double.parseDouble(retStr[0][18]) > Double.parseDouble(retStr[0][17])){
              sTotalOwe = "0.00";
       }else {
           dTotalOwe = Double.parseDouble(retStr[0][17])-Double.parseDouble(retStr[0][18]);
           String tmp1 = Double.toString(dTotalOwe*100+0.5);
           if (tmp1.indexOf(".")!=-1){
              String tmp2 = tmp1.substring(0,tmp1.indexOf("."));
              double tmp3 = Double.parseDouble(tmp2);
              sTotalOwe = Double.toString(tmp3/100);
           } 
       }
    }
%>
<html>
<head>
<%if(valid != 0){%>
<script language="JavaScript">
  function err_init(){
    rdShowMessageDialog("<br>错误代码:["+"<%=error_code %>]</br>"+"错误信息:["+"<%=error_msg %>"+"]",0);
    window.close();
  }
</script>
</head>
<body onLoad="err_init();">
<%}else{%>
<title><%=opName%></title>
<script language="JavaScript">
    function save_to(){
        /*var str="";
        str = document.frm.custName.value.trim() + "|" + document.frm.idIccid.value.trim() + "|" +
                document.frm.smCode.value + "|" + document.frm.totalOwe.value+ "|" + document.frm.run_code.value;
                */
        var obj = new Object();
        obj.smCode = $('input[name="smCode"]').val();
        obj.shortNo = $('#shortNo').val();
        obj.realNo = $('#realNo').val();
        obj.portalName = $('#portalName').val();
        obj.portalPassword = $('#portalPassword').val();
        obj.runCode = $('#runCode').val();
        obj.totalOwe = $('#totalOwe').val();
        
        window.returnValue = obj;
        window.close();
    }

    function quit(){
//            document.frm.smName.value = "<%=retStr[0][2]%>";
//            document.frm.custName.value = "<%=retStr[0][3]%>";
//            document.frm.idIccid.value = "<%=retStr[0][14]%>";
//            document.frm.cardname.value = "<%=retStr[0][15]%>";
//            document.frm.grpbigname.value = "<%=retStr[0][16]%>";
//            document.frm.totalOwe.value = "<%=sTotalOwe%>";
//            document.frm.run_code.value = "<%=retStr[0][5]%>";
        window.close();
    }
</script>
</head>
<body>
<form name="frm" method="post" action="">
  <%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
	
    <table cellspacing="0">
      <!--
      <tr>
        <td  class="blue">业务类型名称</td>
        <td><input name="smName" type="text" class="InputGrey" id="smName" readonly></td>
      </tr>
      <tr>
        <td  class="blue">客户名称</td>
        <td><input name="custName" type="text" class="InputGrey" id="custName" readonly></td>
      </tr>
      <tr>
        <td  class="blue">证件号码</td>
        <td ><input name="idIccid" type="text" class="InputGrey" id="idIccid" readonly></td>
      </tr>
      <tr>
        <td  class="blue">大客户名称</td>
        <td><input name="cardname" type="text" class="InputGrey" id="cardname" readonly></td>
      </tr>
      <tr>
        <td class="blue">集团客户名称</td>
        <td><input name="grpbigname" type="text" class="InputGrey" id="grpbigname" readonly></td>
      </tr>
      <tr>
        <td class="blue">当前欠费</td>
        <td><input name="totalOwe" type="text" class="InputGrey" id="totalOwe" readonly></td>
      </tr>
      <tr>
        <td class="blue">运行状态</td>
        <td><input name="run_code" type="text" class="InputGrey" id="run_code" readonly></td>
      </tr>
      -->
      <tr> 
        <td class="blue">短号</td>
        <td>
          <input type="text" class="InputGrey" id="shortNo" value="<%=shortNo%>" readonly/>
        </td>
      </tr>
      <tr>
        <td class="blue">成员用户号码</td>
        <td>
          <input type="text" class="InputGrey" id="realNo" value="<%=realNo%>" readonly/>
        </td>  
      </tr>
      
      <tr> 
        <td class="blue">Portal登录名</td>
        <td>
          <input type="text" class="InputGrey" id="portalName" value="<%=portalName%>" readonly/>
        </td>
      </tr>
      <tr>
        <td class="blue">Portal登录密码</td>
        <td>
          <input type="text" class="InputGrey" id="portalPassword" value="<%=portalPassword%>" readonly/>
        </td>  
      </tr>
    </table>
        
    <table cellspacing="0">
		<tr> 
			<td id="footer"> 
			  <input name="confirm" type="button" class="b_foot" id="confirm" value="确认" onClick="save_to()">			    		
			  <input name="return" type="button" class="b_foot" id="return" value="返回" onClick="quit()">			               
			</td>
		</tr>
  	</table>

    <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
    <input type="hidden" name="loginName" id="loginName" value="">
    <input type="hidden" name="opCode" id="opCode" value="">
    <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
    <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
    <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
    <input type="hidden" name="smCode"  value="<%=retStr[0][1]%>">
    <input type="hidden" name="runCode" id="runCode"  value="<%=retStr[0][5]%>">
    <input type="hidden" name="totalOwe" id="totalOwe"  value="<%=sTotalOwe%>">
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%}%>
</body>
</html>
