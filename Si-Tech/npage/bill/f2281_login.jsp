<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>



<head>
<title>签约赠礼品</title>
<%
	String opCode = (String)request.getParameter("opCode");
	String opName="签约赠礼品";

	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	
	
	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	if(WtcUtil.haveStr(favStr,"a272"))
		pwrf=true;


    /*String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_Code = baseInfoSession[0][16];

	String[][] temfavStr=(String[][])arrSession.get(3);
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;*/
%>

<script language=javascript>
  onload=function()
  {
    //document.all.srv_no.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
 //if(!check(frm)) return false; 
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f2281_1.jsp";
	    	document.all.opcode.value="2281";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	//alert("请输入业务流水！");
	    	rdShowMessageDialog("请输入业务流水！");
	    	return;
	    }
	   
	    	frm.action="f2282_1.jsp";
	    	document.all.opcode.value="2282";
	    	
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
		<div id="title_zi">签约赠礼品</div>
	</div>
	<table cellspacing="0">
	<TR > 
	      <TD class="blue">操作类型</TD>
	        <TD colspan="3">
	<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
	<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
	      </TD>
	    <input type="hidden" name="opcode" >
	   </TR>    
	   <tr> 
	      <td class="blue"> 
	        <div align="left">手机号码</div>
	      </td>
	      <td colspan="3"> 
	      <div align="left"> 
	          <input class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"  v_name="服务号码" maxlength="11" index="0" value="<%=activePhone%>">
	      </td>
			</div>
	   </tr>
	   <TR  style="display:none" id="backaccept_id"> 
	      <TD class="blue">业务流水</TD>
	        <TD colspan="3">
	<input class="button" type="text" name="backaccept" v_must=1 >
	<font class="orange">*</font>
	      </TD>
	   </TR>    
	     <td class=Lable  nowrap colspan="4">&nbsp;</td>
	   </tr>
	   <tr > 
	      <td colspan="4" id="footer"> 
	        <div align="center"> 
	        <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
	        <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
	    		<input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>');">
	        </div>
	     </td>
	  </tr>
	</table>
	
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>