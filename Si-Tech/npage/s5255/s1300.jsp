<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-21
********************/
%>
<%
  String opCode = "5255";
  String opName = "空中充值帐户缴费";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.util.*"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>

<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
     
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
       							<%String ph_no=request.getParameter("ph_no");
                  	System.out.println("------------------ph_no---------------"+ph_no);
                  	%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doProcess(packet){
 var retResult = packet.data.findValueByName("retResult");
 if (retResult == "false") {
 rdShowMessageDialog("客户密码过于简单,请修改密码！",0);
             	
    }
  docheck();
}

function check_HidPwd()
{
      if(document.frm.phoneNo.value=="")
	            {
	                 rdShowMessageDialog("请输入服务号码!",0);
	 	             document.frm.phoneNo.focus();
	 	             return false;
	            }
	            
 		  
              if( document.frm.phoneNo.value.length != 11 )
	            {
	                  rdShowMessageDialog("服务号码只能是11位!",0);
	 	             document.frm.phoneNo.value = "";
	 	             document.frm.phoneNo.focus();
	 	             return false;
	            }
	var phone_no = document.all.phoneNo.value;
  var busy_type = "1";
	var checkPwd_Packet = new AJAXPacket("/npage/s1300/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("phone_no",phone_no);
	checkPwd_Packet.data.add("busy_type",busy_type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;

}

 
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

function docheck()
{
	if(document.frm.phoneNo.value=="")
	            {
	                 rdShowMessageDialog("请输入服务号码!",0);
	 	             document.frm.phoneNo.focus();
	 	             return false;
	            }
	            
 		  
              if( document.frm.phoneNo.value.length != 11 )
	            {
	                  rdShowMessageDialog("服务号码只能是11位!",0);
	 	             document.frm.phoneNo.value = "";
	 	             document.frm.phoneNo.focus();
	 	             return false;
	            }
               document.frm.action="s1300Cfm.jsp";
               document.frm.query.disabled=true;
 			   document.frm.return1.disabled=true;
			   document.frm.reprint.disabled=true;
  		//	   document.frm.nopay.disabled=true; 
			   document.frm.return2.disabled=true;
 		      document.frm.submit();
} 

function querylast()
{
			var opcode = document.all.op_code.value;
		    var returnValue="-1";
			if(frm.phoneNo.value.length<11  )
			{
			     rdShowMessageDialog("请输入正确的服务号码！",0);
			     document.frm.phoneNo.focus();
			     return "-1";
	        }
 		    returnValue = window.showModalDialog('getCount.jsp?phoneNo='+document.frm.phoneNo.value,"",prop);
	  
			if(returnValue==null)
			 {
					rdShowMessageDialog("没有找到对应的帐号！",0);
					document.frm.phoneNo.focus();
					return "-1";
			  }
			  if(returnValue=="")
			 {
					rdShowMessageDialog("你没有选择帐号！",0);
					document.frm.phoneNo.focus();
					return "-1";
			  }
		    document.frm.contractno.value = returnValue;   
 


		  	 returnValue=window.showModalDialog('getlast.jsp?phoneNo='+document.frm.phoneNo.value+'&contractno='+document.frm.contractno.value+'&yearmonth='+document.frm.yearmonth.value+'&op_code='+document.frm.op_code.value,"",prop);
	  
 			if( returnValue==null )
	        {
					 
						rdShowMessageDialog("查询失败，该号码本月未做业务！",0);

						document.all.contractno.value="";
						document.frm.phoneNo.focus();
						return "-1";
		    }
 			
			document.frm.water_number.value=returnValue;

			return "1";

 

}

function doreprint()
{

	  var opname="号码缴费";
    var returnValue= querylast();
		if(returnValue=="-1")
		return false;
		var totalDate = document.frm.totaldate.value.substring(0,4) +document.frm.totaldate.value.substring(5,7)+document.frm.totaldate.value.substring(8,10);
		document.frm.action='s1352_print.jsp?contractno='+document.all.contractno.value+'&payAccept='+document.frm.water_number.value+'&total_date='+totalDate+'&workno=<%=workno%>'+'&returnPage='+codeChg("s1300.jsp?ph_no=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>");   
		document.frm.submit();
}


-->
 </script> 
 
<title>黑龙江BOSS-空中充值代理商帐户充值</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>

<input type="hidden" name="busy_type"  value="1">
<input type="hidden" name="op_code"  value="5255">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
 
	<div class="title">
		<div id="title_zi">空中充值代理商帐户充值</div>
	</div>

              <table  cellspacing="0">
                <tr> 
                  <td class="blue">服务号码</td>
                  <td> 
       
                  	
                    <input type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();"  value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
                  </td>
                  <td class="blue">帐户号码</td>
                  <td> 
                    <input type="text"  name="contractno" size="20" maxlength="20"  readOnly  Class="InputGrey" >
                  </td>
                </tr>
              </table>

        <TABLE cellSpacing="0">
          <TR > 
            <TD   align="center" id="footer">  
                 <input type="button" name="query"   value="查询" onclick="check_HidPwd()" class="b_foot">
                <input type="button" name="return1" style="display:none" value="清除" onclick="doclear()" class="b_foot">
                &nbsp;
                <input type="button" name="reprint"   value="重打收据"   onclick="doreprint()" class="b_foot" >
                &nbsp;
     <%
		//		<input type="button" name="nopay"  value="上笔缴费冲正" onclick="donopay()" index="12">
          //      &nbsp;
       %>
				<input type="button" name="return2"  value="关闭" onClick="removeCurrentTab()"  class="b_foot" >
             </TD>
          </TR>
        </TABLE>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
 </BODY>
</HTML>