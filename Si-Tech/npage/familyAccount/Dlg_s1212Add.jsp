<%
/********************
 version v2.0
开发商: si-tech
hejwa 2013-4-28 10:46:05
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode     = request.getParameter("opCode");
	String opName     = request.getParameter("opName");
  String regionCode = (String)session.getAttribute("regCode");
%>
<HTML>
<HEAD>
<TITLE>中国移动客户关系管理系统</TITLE>
<%
  request.setCharacterEncoding("GBK");
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%

    String Fees=WtcUtil.repNull(request.getParameter("Fees"));
	//-----------获得服务器端费用信息数组-------------
	String sq1="select trim(fee_code),trim(detail_code),trim(detail_name) from sFeecodedetail order by fee_code,detail_code";
%>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=regionCode%>" outnum="3">
	<wtc:sql><%=sq1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="feeStr" scope="end"/>
<script>

//判断是否为整数
function isInt(objNumber){
	if(!isNaN(objNumber)){
		if(Math.round(objNumber)==objNumber){
			return ture;
		}else{
			return false;
		}
	}else{
		return false;
	}
}
 function initLine(seri)
 {
    var len=document.all.ch.length;
    if(typeof(len)=="undefined")
    {
      if(document.all.ch.checked)
	  {   
 		  document.all.fee_per.value="1";
	  }
	  else
	  {
      document.all.fee_per.value="";
	  }
	}
	else
	{ 
	  if(document.all.ch[seri].checked)
	  {
		document.all.fee_per[seri].value="1";
	  }
	  else
	  {
		document.all.fee_per[seri].value="";
	  }
	}
	
 }

 function ret()
 {
   var chkFlag=false;
   var len=document.all.ch.length;
   var tem1="";
   var temSeri="";
   
   if(typeof len =="undefined")
   {
     if(document.all.ch.checked)
	 {    	   
	 	window.returnValue=document.all.fee_code.value+"#"+document.all.detail_code.value+"#"+document.all.fee_name.value+"#"+document.all.bill_order.value+"#"+document.all.fee_per.value;
	 }
   }
   else
   {
     for(var i=0;i<len;i++)
	 {
       if(document.all.ch[i].checked)
	   {
        tem1+=document.all.bill_order[i].value+document.all.fee_code[i].value+"#";
			  temSeri+=i+"#";
			  chkFlag=true;
	   }
	 }
	 if(!chkFlag)
	 {
       rdShowMessageDialog("请至少选择一项，再按确定按钮！");
       return;
	 }
 	 var tem2=orderOtherStr(tem1,temSeri,"#");
 	 var len2=getTokNums(tem2,"#");
      var orderArr=new Array(len2);

 	 for(var j=0;j<len2;j++)
	 {     
 	   orderArr[j]=oneTok(tem2,"#",j+1);	  
	 }
   
     var lxd="";
     
	 for(var i=0;i<orderArr.length;i++)
	 { 
 		 if(forNonNegInt(document.all.bill_order[orderArr[i]])==false) return false;
		 if(forNotNegReal(document.all.fee_per[orderArr[i]])==false) return false;
	 
		 if(parseFloat(document.all.fee_per[orderArr[i]].value)>1)
	     {
           rdShowMessageDialog("费用比率不能大于1！");
			   document.all.fee_per[orderArr[i]].value="";
			   document.all.fee_per[orderArr[i]].focus();
           return false;
	     }
		tem3=document.all.fee_code[orderArr[i]].value+"#"+document.all.detail_code[orderArr[i]].value+"#"+document.all.fee_name[orderArr[i]].value+"#"+document.all.bill_order[orderArr[i]].value+"#"+document.all.fee_per[orderArr[i]].value;
		lxd+=tem3+"|";
	 }
 	 window.returnValue=lxd;
   }
   window.close();   
 }
 
$(document).bind("keydown",function(){
	//alt +5 取焦点
	 var oEvent = window.event;
	 //alert("oEvent.keyCode|"+oEvent.keyCode);
   if (oEvent.keyCode == 13) {
   		ret();
   }
});
</script>
<BODY>
<FORM action="" method=post name="frm">
<%@ include file="/npage/include/header_pop.jsp" %>
<table cellspacing="0">
    <TBODY> 
    	<TR> 
      	<th nowrap> 
        	选择
      	</th>
      	<th nowrap> 
        	一级账目项
      	</th>
      	<th nowrap> 
        	二级账目项
      	</th>
				<th nowrap> 
       		三级账目项
      	</th>
      	<th nowrap>  
        	费用名称
      	</th>
      	<th nowrap> 
        	费用比率
      	</th>
    </TR>
<%
   for(int i=0;i<feeStr.length;i++)
  {
%>
     <TR> 
        <TD> 
            <input type="checkbox" name="ch" value="checkbox" <% if(Fees.indexOf(feeStr[i][0])!=-1){%> disabled <%}%> onclick="initLine('<%=i%>')">
        </TD>
        <TD> 
          <%
            String levelOneAccount = "";
            String levelTwoAccount = "";
            if(feeStr[i][0]!=null){
              levelOneAccount = feeStr[i][0].substring(0,feeStr[i][0].length()-1);
            }
          %>
          <%=levelOneAccount%>
          <input type=hidden name="fee_code" value="<%=feeStr[i][0]%>" Class="InputGrey" readOnly>
        </TD>
        <TD> 
				  <%
				    if(feeStr[i][0]!=null){
              levelTwoAccount = feeStr[i][0].substring(feeStr[i][0].length()-1,feeStr[i][0].length());
            }
				  %>
				   <%=levelTwoAccount%>
        </TD>
				<TD> 
				   <%=feeStr[i][1]%>
			     <input type=hidden name="detail_code" value="<%=feeStr[i][1]%>" Class="InputGrey" readOnly>
        </TD>
			  <TD> <%out.println(feeStr[i][2].trim());%>
			     <input type=hidden name="fee_name" value="<%=feeStr[i][2]%>" Class="InputGrey" readOnly>
        </TD>            
           <input type="hidden" name="bill_order" id="bill_order<%=i%>" size="5"   maxlength="3" v_must=1  value="0" />
        <TD> 
           <input type="text" name="fee_per" size="7" maxlength="7"  v_must=1 v_maxlength=7>
        </TD>
      </TR>
<%
  }
 %>
<TR >
<TD COLSPAN=6>
<DIV ALIGN="CENTER">
<INPUT class="b_foot" TYPE="BUTTON"  value="确定" onClick="ret()">
</DIV>
</TD>
</TR>
   </TBODY> 
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
 </BODY></HTML>
