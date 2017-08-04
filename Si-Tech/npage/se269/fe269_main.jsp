<%
    /*************************************
    * 功  能: 4A总开关 e269
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-9-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 4A总开关 </title>
<%
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
    String regionCode=(String)session.getAttribute("regCode");
    String retCode = "";
    String retMsg = "";
    String butResult =  "";	
    String[][] buttonResult = new String[][]{};
    String sqlStr = "select flag_switch from ssystemParameter "
    	+"  where login_no = 'switch' and op_code='"+opCode+"' ";
    
    try
    {
    	System.out.println("--------------e269  查询开关状态    begin----------------------");
%>

<wtc:pubselect name="sPubSelect" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
        <wtc:sql><%=sqlStr%></wtc:sql>         
    </wtc:pubselect>
    <wtc:array id="buttonResult1" scope="end"/> 
   	<%
   	  buttonResult = buttonResult1;
      retCode = retCode2;
      retMsg = retMsg2;
      butResult = buttonResult[0][0];	
       	System.out.println("--------e269------butResult="+butResult);
       	}catch(Exception e){
       	   System.out.println("--------e269------error--------------");
       	}
       	  int leng =  buttonResult.length;
       	  System.out.println("----------e269----retCode=  "+retCode + "|" + retMsg);
       	  System.out.println("--------------e269  查询开关状态    end------------------------");
   	%>
  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
    function doCfm(subButton)
    {
         var buttonFlag = "";
        controlButt(subButton);			//延时控制按钮的可用性
        if($("input[name='opFlag']:checked").val() == "open"){
		    buttonFlag = "1";
    	}else{
    		buttonFlag = "0";
    	}
       
		document.frm.action="fe269_ajax_subInfo.jsp?buttonFlag="+buttonFlag;
		document.frm.submit();
    }
    
    function controlButt(subButton){
        subButt2 = subButton;
        subButt2.disabled = true;
        setTimeout("subButt2.disabled = false",3000);
    }

</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" value="<%=opCode%>">
 	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
	<table cellspacing="0">
<%
	if(!retCode.equals("000000"))
	{
	  %>
	   <script language="javascript">
	      rdShowMessageDialog("错误信息：<%=retMsg%><br>错误代码：<%=retCode%>", 0);
      	  removeCurrentTab();
	   </script>
	  <%
	}
	String open_check="";
	String close_check="";
	if("1".equals(butResult)){  //1：按钮为开启状态
		open_check="checked";
	}else{                      
		close_check="checked";  //0：按钮为关闭状态  
	}
	
%>
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="open"  <%out.print(open_check);%>/>开&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="close" <%out.print(close_check);%> />关
		</td>
	</tr>
			
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2" />    
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();" />
		</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>