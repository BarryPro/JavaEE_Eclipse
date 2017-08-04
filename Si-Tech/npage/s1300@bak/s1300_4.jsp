<%
/********************
 version v2.0
开发商: si-tech
*
*update:liutong@2008-8-18
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
		String opCode = "1302";
		String opName = "普通缴费";
		String workno = (String)session.getAttribute("workNo");
		String org_code = (String)session.getAttribute("orgCode");
		String workname = (String)session.getAttribute("workName");
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<HTML>
<HEAD>


<script language="JavaScript">
<!--	
 
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

function docheck()
{
    if(document.frm.serviceno.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.serviceno.focus();
     return false;
  }

  
   document.frm.action="s1300Cfm.jsp";
   document.frm.query.disabled=true;
   document.frm.return1.disabled=true;
   document.frm.reprint.disabled=true;
	 document.frm.nopay.disabled=true; 
   document.frm.return2.disabled=true;
   document.frm.submit();
} 

 function sel1()
 {
            window.location.href='s1300.jsp';
 }
 function sel2()
 {
           window.location.href='s1300_2.jsp';
  }
 function sel3()
 {
           window.location.href='s1300_3.jsp';
 }

 function sel4() {
           window.location.href='s1300_4.jsp';
 }
 function sel5() {
           window.location.href='s1300_5.jsp';
 }
 function doclear()
{
 			frm.reset();
 }

function querylast()
{
			var opcode = document.all.op_code.value;
		  var returnValue="-1";
			if(document.frm.phoneNo.value.length<11  )
			{
			     rdShowMessageDialog("请输入正确的服务号码！");
			     document.frm.phoneNo.focus();
			     return "-1";
	    }
 		    returnValue = window.showModalDialog('getCount.jsp?phoneNo='+document.frm.phoneNo.value,"",prop);
	  
			if(returnValue==null)
			 {
					rdShowMessageDialog("没有找到对应的帐号！");
					document.frm.phoneNo.focus();
					return "-1";
			  }
			  if(returnValue=="")
			 {
					rdShowMessageDialog("你没有选择帐号！");
					document.frm.phoneNo.focus();
					return "-1";
			  }
		    document.frm.contractno.value = returnValue;   
		  	returnValue=window.showModalDialog('getlast.jsp?phoneNo='+document.frm.phoneNo.value+'&contractno='+document.frm.contractno.value+'&yearmonth='+document.frm.yearmonth.value+'&op_code='+document.frm.op_code.value,"",prop);
	  
 			if( returnValue==null )
	     {
					 
						rdShowMessageDialog("查询失败，该号码今天未做业务！");

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
			window.showModalDialog('s1352_print.jsp?phoneNo='+document.all.serviceno.value+'&contractno='+document.all.contractno.value+'&totaldate='+document.frm.totaldate.value+'&login_accept='+document.frm.water_number.value+'&opname='+opname,"",prop);			
			document.all.phoneNo.value="";
			document.all.contractno.value="";	
}

 
function donopay()
{

      var ret= querylast();
			if(ret=="-1")
				return false;
 
 			 document.frm.action="s1310_2.jsp";
		   document.frm.query.disabled=true;
		   document.frm.return1.disabled=true;
		   document.frm.reprint.disabled=true;
		   document.frm.nopay.disabled=true; 
		   document.frm.return2.disabled=true;

 			frm.submit();		
 
}


-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY onLoad="" >
<form action="" method="post" name="frm"  >
<input type="hidden" name="busy_type"  value="4">
<input type="hidden" name="op_code"  value="1302">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
<input type="hidden" name="contractno" value="">
 

		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请选择缴费方式</div>
		</div>

      
              <table  cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue"  width=15%>缴费方式</td>
                  <td colspan="3"> 
                  	<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel1()" value="1"  >
                    服务号码 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  >
                    帐户号码 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType5" type="radio" onClick="sel5()" value="5"  >
                    托收用户交费
                    </q>
                    <q vType="setNg35Attr">
										<input name="busyType3" type="radio" onClick="sel3()" value="3"  >
                    托收单
                  </q>
                    <!--<input name="busyType4" type="radio" onClick="sel4()" value="4" checked>付费号码-->
									</td>
                 </tr>   
                </tbody> 
              </table>
            
              <table cellspacing="0">
                <tr> 
                  <td nowrap  class="blue" width=15%>付费号码</td>
                  <td> 
                    <input class="button" type="text" value="" name="serviceno" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) docheck();"  >
                  </td>
                  <td  class="blue" >服务类型</td>
                  <td> 
                    <select size="1" name="servicetype" >
                      <option class=button value="ap">APN业务</option>
										  <option class=button value="id">IDC业务</option>
										  <option class=button value="va">BOSSVPMN</option>
										</select>
				 				 	</td>
                </tr>
              </table>
          
        <TABLE cellSpacing="0">
          <TR > 
            <td id="footer"> 
                 <input type="button" name="query"  class="b_foot" value="查询" onclick="docheck()" index="9">
                &nbsp;
                <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" index="10">
                &nbsp;
                <input type="button" name="reprint"  class="b_foot" value="重打发票"   onclick="doreprint()"  >
                &nbsp;
                <input type="button" name="nopay" class="b_foot_long" value="上笔缴费冲正" onclick="donopay()" index="12">
                &nbsp;
                <input type="button" name="return2" class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>')" index="13">
             </TD>
          </TR>
        </TABLE>
      
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
 </BODY>
</HTML>