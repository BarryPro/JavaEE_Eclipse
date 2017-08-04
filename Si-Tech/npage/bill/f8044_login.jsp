<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-09
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.nio.*%>
<%@ page import="java.nio.MappedByteBuffer%>
<%
 	request.setCharacterEncoding("GBK");  
  	try{
		DataOutputStream out2 = 
		new DataOutputStream(
		new BufferedOutputStream(
		new FileOutputStream("data.txt")));
		out2.writeChars("\naaa\n");
		out2.close();
	}catch(EOFException e){
		System.out.println("End of stream");
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>欢乐新农村神州行手机营销</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;   	
	        	
   	String work_no = (String)session.getAttribute("workNo");    //工号  
   	String loginName = (String)session.getAttribute("workName");//工号名称  
    String org_Code = (String)session.getAttribute("orgCode");  //归属代码	
	String regionCode = org_Code.substring(0,2);	//地市	
%>

<script language=javascript>
   onload=function(){
   	if("<%=opCode%>" == "8045"){
        
    }else{

    }
    opchange();
  }

//----------------验证及提交函数-----------------
	function doCfm(subButton){
	  controlButt(subButton);//延时控制按钮的可用性
	  //if(!check(frm)) return false; 
	  var radio1 = document.getElementsByName("opFlag");
	  for(var i=0;i<radio1.length;i++){
	    if(radio1[i].checked){
		  var opFlag = radio1[i].value;
		  if(opFlag=="one"){	  	
		    	frm.action="f8044_1.jsp";
		    	document.all.opcode.value="8044";
		    	
		  }else if(opFlag=="two"){
		    if(document.all.backaccept.value==""){
		    	alert("请输入业务流水！");
		    	return;
		    }
		    frm.action="f8045_1.jsp";
		    document.all.opcode.value="8045";	    	
		  }
		}
	  }  
	  frm.submit();	
	  return true;
	}
	function opchange(){
		  document.all.backaccept_id.style.display = "";	
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
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi"><%=opName%></div>
</div>	
<input type="hidden" name="opcode" >
<table cellspacing="0">          
    <tr> 
        <TD width="16%" class="blue">操作类型</TD>
        <TD width="84%"  colspan="3">
            
            <input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正
        </TD>  
    </tr>    
    <tr> 
        <td width="16%" class="blue" nowrap> 
            手机号码
        </td>
        <td  width="34%" nowrap colspan="3">             
            <input class="InputGrey" readonly value="<%=activePhone%>"  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  v_name="服务号码" maxlength="11" index="0">                            
        </td>            
    </tr>
    
    <tr style="display:none" id="backaccept_id"> 
        <TD  width="16%" class="blue" >业务流水</TD>
        <TD width="34%" colspan="3">
            <input class="button" type="text" name="backaccept" v_must=1  onblur="checkElement(this);">			
            <font class="orange">*</font>
        </TD>	     
    </tr>   
    <tr> 
        <td colspan="4"  id="footer">              
            <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
            <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">              
        </td>
    </tr>
</table>         	
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
