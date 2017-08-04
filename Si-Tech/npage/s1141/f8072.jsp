 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-16 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<head>
		<title>大兴安岭签约赠礼</title>
<%
	String opCode = "8072";	
	String opName = "大兴安岭签约赠礼";	//header.jsp需要的参数  	
	String regionCode = (String)session.getAttribute("regCode");

%>
<%
  /*comImpl co=new comImpl(); 
  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  System.out.println("sql====="+sql);
  ArrayList agentCodeArr = co.spubqry32("2",sql);
  String[][] agentCodeStr = (String[][])agentCodeArr.get(0);*/
%>

  </script>
	<!--<script type="text/javascript" src="/npage/s3000/njs/S3000.js"></script>-->
	<script language=javascript>
	  onload=function()
	  {
	    document.all.srv_no.focus();
	  }
	
	//----------------验证及提交函数-----------------
	function doCfm(subButton)
	{
	  controlButt(subButton);//延时控制按钮的可用性
	 // if(!checkElement(document.frm)) return false; 
	  var radio1 = document.getElementsByName("opFlag");
	  for(var i=0;i<radio1.length;i++)
	  {
	    if(radio1[i].checked)
		{
		  var opFlag = radio1[i].value;
		  if(opFlag=="one")
		  {
		  
		    	frm.action="f8072_1.jsp";
		    	document.all.opcode.value="8072";
		    	
		  }else if(opFlag=="two")
		  {
		    if(document.all.backaccept.value==""){
		    	alert("请输入业务流水！");
		    	return;
		    }
		   
		    	frm.action="f8072_1.jsp";
		    	document.all.opcode.value="8073";
		    	
		  }
		}
	  }
	 
	  frm.submit();	
	  return true;
	}
	function opchange(){		
	
		 if(document.all.opFlag[0].checked==true) {
		  	
		  	document.all.backaccept_id.style.display = "none";
		  }else {
		  	document.all.backaccept_id.style.display = "";
		  	
		  }
	
	}
	</script>
</head>
<body>	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">大兴安岭签约赠礼</div>
		</div>		
      <input type="hidden" name="opcode" >      
      <table cellspacing="0" >        
	  <TR> 
	      <TD width="16%" class="blue">操作类型</TD>
              <TD>
		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
		<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
	      </TD>    
         </TR>    
         <tr> 
            <td width="16%"  nowrap class="blue"> 手机号码</td>
            <td nowrap  width="34%"> 
                <input type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  value =<%=activePhone%>  readonly class="InputGrey"  maxlength="11" index="0">
                <font class="orange">*</font>
            </td>  
         </tr>
         <TR  style="display:none" id="backaccept_id"> 
	          <TD width="16%" class="blue">业务流水</TD>
              	  <TD>
			<input type="text" name="backaccept" v_must=1 >
			<font class="orange">*</font>
	          </TD>	          
         </TR>    
      </table>
      
      <table cellspacing="0" >      
         <tr> 
            <td id="footer" >              
              <input type=button name="confirm" class="b_foot"  value="确认" onClick="doCfm(this)" index="2">    
              <input type=button name=back class="b_foot" value="清除" onClick="frm.reset()">
	      <input type=button name=qryP class="b_foot" value="关闭" onClick="removeCurrentTab();">
           </td>
        </tr>
      </table>
      <%@ include file="/npage/include/footer_simple.jsp" %>    
   </form>
</body>
</html>