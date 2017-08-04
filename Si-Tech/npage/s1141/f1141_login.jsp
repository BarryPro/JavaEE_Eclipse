<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.04
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>

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
}
catch(EOFException e){
System.out.println("End of stream");
}

%>
<html>
<head>
<title>预存话费优惠购机</title>
<%
  String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

   // ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	//String[][] baseInfoSession = (String[][])arrSession.get(0);
    //String work_no = baseInfoSession[0][2];
   // String loginName = baseInfoSession[0][3];
   // String org_Code = baseInfoSession[0][16];
        String opCode = request.getParameter("opCode");
		String opName = "预存话费优惠购机";
		activePhone = request.getParameter("activePhone");
  	    String work_no =(String)session.getAttribute("workNo");
        String loginName =(String)session.getAttribute("workName");
        String powerRight =(String)session.getAttribute("powerRight");
        String orgCode =(String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
%>
<%
  //comImpl co=new comImpl();
 
  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  System.out.println("sql====="+sql);
  //ArrayList agentCodeArr = co.spubqry32("2",sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end" />
<%
 // String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
 
 
  if(retCode.equals("0")||retCode.equals("000000")){
          System.out.println("调用服务sPubSelect in f1141_login.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	
 	     	}else{
 			System.out.println("调用服务sPubSelect in f1141_login.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

 
 
%>

  </script>

<script language=javascript>
  onload=function()
  {
    document.all.srv_no.focus();
    document.all.backaccept_id.style.display = "";
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
 
 var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f1141_1.jsp";
	    	document.all.opcode.value="1141";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("请输入业务流水！");
	    	return;
	    }
	   
	    	frm.action="f1142_1.jsp";
	    	document.all.opcode.value="1142";
	    	
	  }
	}
  }
  frm.submit();	
  return true;
}
function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange(){
	


}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">预存话费优惠购机</div>
		</div>
	
	
 <input type="hidden" name="opcode" >


      <table cellspacing="0">
		<TR> 
		  <TD width="16%" class="blue">操作类型</TD>
		  <TD width="84%" colspan="3">
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正
		  </TD>
		</TR>    
		<tr> 
			<td width="16%" nowrap class="blue"> 
			  <div align="left">手机号码</div>
			</td>
			<td nowrap  width="34%" colspan="3"> 
				<div align="left"> 
					<input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0"  Class="InputGrey" readOnly  value ="<%=activePhone%>">
				</div>
			</td>
		</tr>
         <TR  style="display:none" id="backaccept_id"> 
	          <TD width="16%" class="blue">业务流水</TD>
              <TD width="34%"  colspan="3">
			<input class="button" type="text" name="backaccept" v_must=1 onblur="checkElement(this);">
			<font class="orange">*</font>
	          </TD>
	        
         </TR>    
           <td class=Lable  nowrap colspan="4">&nbsp;</td>
         </tr>
         <tr> 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>');">
              </div>
           </td>
        </tr>
      </table>
    <input type="hidden" name="opCode" value="<%=opCode%>">
	<%@ include file="/npage/include/footer_simple.jsp"%>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
   </form>
</body>
</html>
