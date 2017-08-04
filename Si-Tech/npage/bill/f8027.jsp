<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-13
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  request.setCharacterEncoding("GBK");
%>
<%
  String opCode = "8027";
  String opName = "买手机、送话费";
%>

<html>
<head>
<title>买手机、送话费</title>
<%
  String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
		//System.out.println("--------workNoFromSession---------------hjw--------"+workNoFromSession);
    String work_no = (String)session.getAttribute("workNo");
    //System.out.println("--------work_no---------------hjw--------"+work_no);
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");


%>


  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    document.all.srv_no.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
   //alert(check(frm));
  //if(!check(frm)) return false; 
  //alert();
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  		
	    	frm.action="f8027_1.jsp";
	    	document.all.opcode.value="8027";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("请输入业务流水！");
	    	return;
	    }
	   
	    	frm.action="f8028_1.jsp";
	    	document.all.opcode.value="8028";
	    	
	  }
	}
  }
	    
	
 
  frm.submit();	
  return true;
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true) 
	{
	  	
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
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">

	  <TR> 
	          <td class="blue">操作类型</TD>
              <TD>
		<input type="hidden" name="opFlag" value="one" onclick="opchange()"  >
		<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正
	
				      
	          </TD>
	<input type="hidden" name="opcode" >

         </TR>    
         <tr> 
            <td class="blue"> 
              <div align="left">手机号码</div>
            </td>
            <td> 
            <div align="left"> 
                <input   type="text"  name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" value =<%=activePhone%>  Class="InputGrey" readOnly > 
                <font class="orange">*</font>
            </td>
            
         </tr>
         <TR  id="backaccept_id"> 
	          <td class="blue">业务流水</TD>
              <TD>
			<input  type="text" name="backaccept" v_must=1 >
			<font class="orange">*</font>
		</td>
         </TR>    

         <tr> 
            <td colspan="5" > 
              <div align="center"> 
              <input  type=button name="confirm" value="确认" onClick="doCfm(this)" index="2" class="b_foot">    
              <input  type=button name=back value="清除" onClick="frm.reset()" class="b_foot" >
		          <input  type=button name=qryP value="关闭" onClick="removeCurrentTab()" class="b_foot" >
              </div>
           </td>
        </tr>
      </table>

    <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>
