   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
              
<%
  String opCode = "1414";
  String opName = "数据业务付奖";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  
    request.setCharacterEncoding("GBK");
%>

<html>

<head>
<title>数据业务付奖冲正</title>
<%
    String workNoFromSession=(String)session.getAttribute("workNo");
	  String userPhoneNo=activePhone;
 	  boolean workNoFlag=false;
 	  if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
	  
		String[][] temfavStr= (String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
     
    System.out.println("fasle"); 
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272")){
	  	pwrf=true;
	  	System.out.println("true");
	  }
   String printAccept="";
   printAccept = getMaxAccept();  
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  
  js_pwFlag="<%=pwrf%>";


 function sel_type1() {
            window.location.href='s1414.jsp?ph_no='+document.frm.phone_no.value;
 }

 function sel_type2(){
           window.location.href='s1414Del.jsp?ph_no='+document.frm.phone_no.value
 }

function query_phone_no()
{
 	if (document.frm.phone_no.value.length == 0) {
  	rdShowMessageDialog("手机号码不能为空，请重新输入 !!",0);
    document.frm.phone_no.focus();
    return false;
  } 

	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
  var  returnValue ;
  var	 pos;
  var  varLoginAccept = null;
  returnValue=window.showModalDialog('getphonedata.jsp?phone_no='+document.frm.phone_no.value,"",prop);

  if( returnValue == null )
	{
			rdShowMessageDialog("没有找到数据付奖信息！",0);
			return false;
	}
	 
	if(returnValue == "" )
	{
			rdShowMessageDialog("您没有选择数据业务付奖信息!",0);
			return false;
	}
	 
	pos =  returnValue.indexOf("|");
	document.frm.login_accept.value = returnValue.substr(0,pos);
	returnValue = returnValue.substring(pos+1);

	pos =  returnValue.indexOf("|");
	document.frm.cust_name.value = returnValue.substr(0,pos);
	returnValue = returnValue.substring(pos+1);

	pos =  returnValue.indexOf("|");
	document.frm.award_info.value = returnValue.substr(0,pos);
	returnValue = returnValue.substring(pos+1);
	
	pos =  returnValue.indexOf("|");
	document.frm.op_note.value = returnValue.substr(0,pos);
	returnValue = returnValue.substring(pos+1);

	pos =  returnValue.indexOf("|");
	document.frm.award_sum.value = returnValue.substr(0,pos);
	
	document.frm.confirm.disabled = false;

	return true;
 
 
} 
//----------------验证及提交函数-----------------
 

function doProcess(packet)
{
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
	var retResult = packet.data.findValueByName("retResult");
  var type = packet.data.findValueByName("type");
  var custName = packet.data.findValueByName("cust_name");
	var phone_no = packet.data.findValueByName("phone_no");
	var award_info = packet.data.findValueByName("award_info");
	var op_note = packet.data.findValueByName("op_note");

 	if(custName!=""){
			document.frm.cust_name.value = custName;
			document.frm.phone_no.value = phone_no;
			document.frm.award_info.value = award_info;
			document.frm.op_note.value = op_note;
			if(js_pwFlag!="false")
			{
				document.frm.confirm.disabled = false;
			}
		}else{
			document.frm.cust_name.value = "";
			document.frm.phone_no.value = "";
			document.frm.award_info.value = "";
			document.frm.op_note.value = "";
			rdShowMessageDialog("无此操作记录！",0);
			document.frm.srv_no.focus();
			return false;
		}
}
function printCommit()
{
	getAfterPrompt();          
	if (document.frm.login_accept.value.length == 0) {
      rdShowMessageDialog("操作流水不能为空，请重新输入 !!",0);
      return false;
     } 

	if(rdShowConfirmDialog('确认要提交信息吗？')==1)
  {
		frm.submit();
  }else{
  	return false;
  }
  
  return true;  	 
}
 

</script>
</head>
<body>
<form name="frm" method="POST" action="s1414DelCfm.jsp" >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">数据业务付奖冲正</div>
	</div>

<input type="hidden" name="iccid" value="">
<input type="hidden" name="custAddress" value="">
 
      <table cellspacing="0" >
      	<tr> 
        	<td   nowrap height=10 class="blue">操作类型</td>
            <td   nowrap colspan="3" height=10>
            <input name="spType1" type="radio" onClick="sel_type1()" value="1" > 
            录入 	
            <input name="spType2" type="radio" onClick="sel_type2()" value="2" checked> 
            冲正 	
          </td>
        </tr>
       	<tr> 
        	<td width="16%"  nowrap class="blue"> 
      			<div align="left">手机号码</div>
      		</td>
          <td nowrap  width="28%"> 
          	<div align="left"> 
          		<%
            	String ph_no=request.getParameter("ph_no");
            	System.out.println("--------------ph_no------------"+ph_no);
            	%>
            	<input   type="text"  name="phone_no" size="15" id="phone_no" v_minlength=1 v_maxlength=16 v_type="phone_no" v_must=1  maxlength="14" index="0" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >	
            	<font class="orange">*
							<input  type="button" name="infor" class="b_text" value="查询" onClick="query_phone_no()">
							</font>
						</div>
          </td>
          <td nowrap  width="16%" class="blue"> 
          	<div align="left">操作流水</div>
          </td>
          <td width="40%"  nowrap>
			     		<input type="text"  name="login_accept"  maxlength="8" readonly  Class="InputGrey" > 		    
					</td>
        </tr>
        <tr >
		    	<td nowrap  width="16%" class="blue"> 
          	<div align="left"  >用户名称</div>
          </td>
          <TD  width="34%">
			     <input type="text"  name="cust_name"  maxlength="8" readonly  Class="InputGrey" > 		    
		    	</TD>
			 		<td  nowrap   class="blue">付奖类型</td>
          <td class=Input nowrap  width="40%">
          	<input type="text"  name="award_info"  maxlength="8" readonly  Class="InputGrey" > 		    
					</TD>
               
            </td>
	
        </tr>
        
	<tr >
	<td nowrap  width="16%" class="blue"> 
    	<div align="left">付奖数量</div>
    </td>
    <TD  width="34%">
			<input type="text"  name="award_sum"  maxlength="8" readonly  Class="InputGrey" > 		    
		</TD>
		<td  nowrap  >&nbsp;</td>
			<td>&nbsp;
		       <div align="left"></div>
		    </td>
         </tr>         
       
		 		<tr> 
          <td   valign="top" class="blue"> 
              <div align="left">操作备注</div>
            </td>
            <td colspan="4" valign="top" bgcolor="eeeeee"> 
            <input type="text"  name="op_note" size="90" readonly   Class="InputGrey" maxlength=60> 
            </td>
  
		 
		   
         </tr>
         <tr > 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input  type=button name="confirm" class="b_foot" value="确认" onClick="printCommit()" index="2" >    
              <input  type=button name=back  class="b_foot" value="清除" onClick="frm.reset()">
		          <input  type=button name=qryP  class="b_foot" value="关闭" onClick="window.close();">
              </div>
           </td>
        </tr>
      </table>
 
   <%@ include file="/npage/common/pwd_comm.jsp" %>
   <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>