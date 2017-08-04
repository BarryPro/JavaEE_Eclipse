<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "g053";
		String opName = "渠道发票信息";
		String login_no = (String)session.getAttribute("workNo");
		String bank_code = request.getParameter("bank_code");
		String invoice_code = request.getParameter("invoice_code");
		String invoice_number = request.getParameter("invoice_number");
		
		String [] inParas = new String[2];
		String [] inParas1 = new String[2];
		String [] inParas2 = new String[2];
		String return_code1="";
		String return_code2="";
	    String ret_msg="";
	    String return_page = "e673_7.jsp";
	    
		boolean flag = false;
		if(invoice_code == null)
	   {
		    invoice_code = "";
		    flag = false;
	   }
	   else
	   {
	      flag = true;
	   }	
	   
	   String sqlStr = "select BANK_CODE,BANK_NAME from QD_BANKCODE order by BANK_CODE";	   
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg" retcode="return_code">
			<wtc:sql><%=sqlStr%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	
<%
   String bank_options = "<option value=>--请选择--</option>";
   for(int i=0;i<return_result.length;i++)
   {
     bank_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
%> 	


<HTML>
<HEAD>
<script language="JavaScript">
 
function commit(){
	
  if(document.frm.bank_code.value =="")  {
     rdShowMessageDialog("请选择银行名称!");
     document.frm.bank_code.value = "";
     document.frm.bank_code.focus();
     return false;
  }
  
  if(document.frm.invoice_code.value=="")  {
     rdShowMessageDialog("请输入发票代码!");
     document.frm.invoice_code.value = "";
     document.frm.invoice_code.focus();
     return false;
  }
  
  if(document.frm.invoice_code.value.length < 12)  {
     rdShowMessageDialog("发票代码长度不够!");
     document.frm.invoice_code.value = "";
     document.frm.invoice_code.focus();
     return false;
  }
  if(document.frm.invoice_number.value=="")  {
     rdShowMessageDialog("请输入发票号码!");
     document.frm.invoice_number.value = "";
     document.frm.invoice_number.focus();
     return false;
  }
  
  if(document.frm.invoice_number.value.length < 8)  {
     rdShowMessageDialog("发票号码长度不够!");
     document.frm.invoice_number.value = "";
     document.frm.invoice_number.focus();
     return false;
  }

	document.frm.submit();
	            
}

function sel1() { 		 
	window.location.href='g053.jsp';
}
function sel2(){ 
	window.location.href='g053_2.jsp';
}
function sel3(){
    window.location.href='g053_3.jsp';
}
function sel4(){
    window.location.href='g053_4.jsp';
}
function sel5(){
    window.location.href='g053_5.jsp';
}
function sel6(){
    window.location.href='g053_6.jsp';
} 
function sel7(){
    window.location.href='g053_7.jsp';
} 
function doclear() {
 	frm.reset();
}
 
 </script> 
 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY>
<form action="g053_7.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">发票统计信息和录入</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1">地市领票
          <input name="busyType2" type="radio" onClick="sel5()" value="1">营业厅领票
<!--          
          <input name="busyType2" type="radio" onClick="sel2()" value="1">发票使用情况查询 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">领用存情况表 
          <input name="busyType2" type="radio" onClick="sel4()" value="1">上期领用存情况表   
 -->                 
          <input name="busyType2" type="radio" onClick="sel6()" value="1">查询与删除
          <input name="busyType2" type="radio" onClick="sel7()" value="1" checked>查询
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
      <td align="left" class="blue" width="15%">银&nbsp;&nbsp;行&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;</td>
       <td> <select name="bank_code" >
          	<%=bank_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
    	<td align="right" class="blue" width="15%">发票代码&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_code" value="" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>  
      <td align="right" class="blue" width="15%">发票号码&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_number" value="" size="20" maxlength="8"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
    </tr>  
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="查询" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<br>
      

		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>发票代码</th>
        <th>发票起始号码</th>
        <th>发票结束号码</th>
        <th>地市</th>
        <th>银行</th>
        <th>营业厅id</th>
        <th>营业厅</th>
        <th>录入工号</th>    
        <th>录入时间</th>               
      </tr>
<%
   if(flag)
   {

	inParas[0]="SELECT a.invoice_code,a.s_invoice_number,a.e_invoice_number,b.region_name,C.BANK_NAME,'','',a.login_no,to_char(a.op_time, 'YYYY-MM-DD HH24:MI:SS') FROM qd_wcityinvoice a,sregioncode b,QD_BANKCODE c WHERE a.bank_code = c.bank_code AND a.region_code = b.region_code AND  a.invoice_code=:invoice_code AND a.s_invoice_number<=to_number(:invoice_number) AND a.e_invoice_number>=to_number(:invoice_number1) and A.BANK_CODE=:bank_code ";
    inParas[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number+",invoice_number1="+invoice_number+",bank_code="+bank_code;

	inParas2[0]="SELECT A.INVOICE_CODE,A.S_INVOICE_NUMBER,A.E_INVOICE_NUMBER,B.REGION_NAME,C.BANK_NAME,A.GROUP_ID,D.GROUP_NAME,A.LOGIN_NO,TO_CHAR(A.OP_TIME, 'YYYY-MM-DD HH24:MI:SS') FROM QD_WGROUPINVOICE A, SREGIONCODE B, QD_BANKCODE C,QD_DLOGINMSG D WHERE A.BANK_CODE = C.BANK_CODE AND A.GROUP_ID = D.GROUP_ID AND A.REGION_CODE = B.REGION_CODE  AND a.invoice_code=:invoice_code AND a.s_invoice_number<=to_number(:invoice_number) AND a.e_invoice_number>=to_number(:invoice_number1) AND A.BANK_CODE=:bank_code";
    inParas2[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number+",invoice_number1="+invoice_number+",bank_code="+bank_code;

%>

<wtc:service name="TlsPubSelBoss"   retcode="retCode" retmsg="retMsg" outnum="10">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>	
	</wtc:service>
<wtc:array id="tempArr" scope="end"/>

<wtc:service name="TlsPubSelBoss"   retcode="retCode2" retmsg="retMsg2" outnum="10">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
<wtc:array id="tempArr2" scope="end"/>
<%	

   return_code = retCode;
   return_code2 = retCode2;
   ret_msg = retMsg;
   if(return_code.equals("000000") && return_code2.equals("000000"))
   {
     for(int i=0; i<tempArr.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr[i][0]%></td>
        <td><%=tempArr[i][1]%></td>
        <td><%=tempArr[i][2]%></td>
        <td><%=tempArr[i][3]%></td>
        <td><%=tempArr[i][4]%></td>
        <td><%=tempArr[i][5]%></td>
        <td><%=tempArr[i][6]%></td>
        <td><%=tempArr[i][7]%></td>
        <td><%=tempArr[i][8]%></td>
      </tr>
<%   }

	 for(int i=0; i<tempArr2.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr2[i][0]%></td>
        <td><%=tempArr2[i][1]%></td>
        <td><%=tempArr2[i][2]%></td>
        <td><%=tempArr2[i][3]%></td>
        <td><%=tempArr2[i][4]%></td>
        <td><%=tempArr2[i][5]%></td>
        <td><%=tempArr2[i][6]%></td>
        <td><%=tempArr2[i][7]%></td>
        <td><%=tempArr2[i][8]%></td>
      </tr>
<%   }

  }

else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("信息查询出错!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%	}

}%>      
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

