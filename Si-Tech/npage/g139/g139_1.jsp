<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
 <%
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");	
	String orgCode = (String)session.getAttribute("orgCode");
    String opCode = "g139";   
    String opName = "集团客户陈账查询";
    
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[6] ;

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }        
                                              
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>集团客户交费查询</TITLE>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function doCheck2()
{
    if (document.frm1527.unit_id.value=="") {	
		 rdShowMessageDialog("请输入集团编码！");
		 document.frm1527.unit_id.select();
		 return false;
	} 
   
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
	var str = window.showModalDialog('getCount.jsp?unit_id='+document.frm1527.unit_id.value,"",prop);
	
	if(str == null ){
	   rdShowMessageDialog("此号码没有找到对应的帐号！");
       document.frm1527.unit_id.value="";
	   return false;
	} 
	
	if(str.length == 0) {
		rdShowMessageDialog("您没有选择对应的帐号！" );
        document.frm1527.unit_id.value=""; 
		return false;
	 }
	 document.all.fwhm2.style.display="block";
	 document.all.contract_no.value=str[0];
	 document.all.userType.value = str[1]; 
     document.all.userno.value = str[2];
	 document.all.idno.value = str[3];
	 return true;
}
 

function doCheck()
{	
	  
    if( document.frm1527.contract_no.value=="") 
    {	
	   rdShowMessageDialog("请输入集团产品帐号！");
	   document.frm1527.contract_no.select();
	   return false;
    }
	document.frm1527.action="g139_2.jsp"; 
	frm1527.submit();
	return true;
}

function query()
{
	 if(!doCheck())
		 return false;

	 return true;
}

function changsearchtype() {
   var otherFlag = document.frm1527.otherFlag[document.frm1527.otherFlag.selectedIndex].value;
   //alert(otherFlag);
   if(otherFlag == 0)
   {
	   document.all.fwhm1.style.display="none"; 
	   document.all.fwhm2.style.display="block"; 
   }
   else
   {
	   document.all.fwhm1.style.display="block"; 
	   document.all.fwhm2.style.display="none"; 
   }
    
}
</SCRIPT>

<FORM method=post name="frm1527" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团客户交费查询</div>
</div>
<input type="hidden" name="opCode"  value="g141">
<input type="hidden" name="userType"  value="0"> 
<input type="hidden" name="userno"  value="0">
<TABLE cellSpacing=0>
    <TR> 
        <TD class=blue>查询方式</TD>
        <TD colspan=3>
            <select size="1" name="otherFlag" onchange="changsearchtype()">
                <option class=button value=1>集团编码</option>
				<!--
                <option class=button value=0>产品帐号</option>
				-->
            </select>
        </TD>
        
    </TR>
    <tr id="fwhm1"  style="display:block">
		<TD class=blue >集团编码</TD>
        <TD  colspan=3>
            <input type="text" name="unit_id" size="20" maxlength="11"   onKeyPress="return isKeyNumberdot(0)"  >
            <input type="button" class="b_text" name="Button1" value="查询帐号" onclick="doCheck2()">
        </TD>
		 
	</tr>
	<tr id="fwhm2"  style="display:none">
		<TD class=blue >集团产品帐号</TD>
        <TD  >
            <input type="text" name="contract_no" size="20" maxlength="11" onKeyDown="if(event.keyCode==13){ return query() }"   onKeyPress="return isKeyNumberdot(0)" readonly >
            
        </TD>
		<TD class=blue >集团产品id</TD>
        <TD  >
            <input type="text" name="idno" size="20"  onKeyPress="return isKeyNumberdot(0)" readonly >
            
        </TD>
	</tr>
     
    
    <tr id="footer" > 
        <td colspan=4>
            <input class="b_foot" name=Button2  type="button" onClick="query()" value="  查 询  ">
            <input class="b_foot" name=reset  type=reset onClick="" value="  清 除  ">
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  关 闭  ">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->

