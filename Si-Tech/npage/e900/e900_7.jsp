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
		String opCode = "e900";
		String opName = "铁通发票信息";
		String login_no = (String)session.getAttribute("workNo");
		String invoice_code = request.getParameter("invoice_code");
		String invoice_number = request.getParameter("invoice_number");
		
		String fanwei = request.getParameter("fanwei");
		String [] inParas = new String[2];
		String [] inParas1 = new String[2];
		String [] inParas2 = new String[2];
		String return_code="";
		String return_code1="";
		String return_code2="";
	    String ret_msg="";
	    String return_page = "e900_7.jsp";
	    
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
	   
%>
 	


<HTML>
<HEAD>
<script language="JavaScript">
 
function commit(){
  
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
/*  
  if(document.frm.fanwei.value =="")  {
     rdShowMessageDialog("请选择查询范围!");
     document.frm.fanwei.value = "";
     document.frm.fanwei.focus();
     return false;
  }
*/

	document.frm.submit();
	            
}

 function sel1() {
 		 
		window.location.href='e900.jsp';
 }

 function sel2(){
 
	window.location.href='e900_2.jsp';
 }
 
 function sel3(){
    window.location.href='e900_3.jsp';
 }
function sel4(){
    window.location.href='e900_4.jsp';
 }
function sel5(){
    window.location.href='e900_5.jsp';
 }
  function sel6(){
    window.location.href='e900_6.jsp';
 }
 
function sel7(){
    window.location.href='e900_7.jsp';
 }
 
 function doclear() {
 		frm.reset();
 }
 
 </script> 
 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY>
<form action="e900_7.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">铁通发票信息</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1">地市、区县领票 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">营业厅领票
          <input name="busyType2" type="radio" onClick="sel2()" value="1">发票使用情况查询 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">领用存情况表 
          <input name="busyType2" type="radio" onClick="sel4()" value="1">上期领用存情况表          
          <input name="busyType2" type="radio" onClick="sel6()" value="1">查询与删除
          <input name="busyType2" type="radio" onClick="sel7()" value="1" checked>查询
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="right" class="blue" width="15%">发票代码&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_code" value="" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>  
      <td align="right" class="blue" width="15%">发票号码&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_number" value="" size="20" maxlength="8"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
    </tr>  
<!--    
     <tr>
    	<td align="right" class="blue" width="15%">范围选择;&nbsp;&nbsp;</td>
      <td> 
        <select name="fanwei" >
          	<option value="">--请选择--</option>      
          	<option value="0">地市</option>  
          	<option value="1">区县</option>  
          	<option value="2">营业厅</option>               
        </select>
      </td>  
      <td align="right" class="blue" width="15%">&nbsp;&nbsp;&nbsp;</td>
      <td> 
        &nbsp;&nbsp;&nbsp;
      </td>
    </tr>
-->
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
        <th>区县</th>
        <th>营业厅id</th>
        <th>营业厅</th>
        <th>录入工号</th>    
        <th>姓名</th> 
        <th>录入时间</th>               
      </tr>
<%
   if(flag)
   {

	inParas[0]="SELECT a.invoice_code,a.s_invoice_number,a.e_invoice_number,b.region_name,'','','',a.login_no,c.login_name,to_char(a.op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.tt_wcityinvoice a,sregioncode b,dloginmsg c WHERE a.login_no=c.login_no AND a.region_code = b.group_id AND  a.invoice_code=:invoice_code AND a.s_invoice_number<=to_number(:invoice_number) AND a.e_invoice_number>=to_number(:invoice_number1)";
    inParas[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number+",invoice_number1="+invoice_number;

	inParas1[0]="SELECT a.invoice_code,a.s_invoice_number,a.e_invoice_number,b.region_name,d.district_name,'','',a.login_no,c.login_name,to_char(a.op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.tt_wdisinvoice a,sregioncode b,dloginmsg c,sdiscode d WHERE a.login_no=c.login_no AND a.region_code=b.group_id AND a.district_code=d.group_id AND a.invoice_code=:invoice_code AND a.s_invoice_number<=to_number(:invoice_number) AND a.e_invoice_number>=to_number(:invoice_number1)";
  	inParas1[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number+",invoice_number1="+invoice_number;

	inParas2[0]="SELECT a.invoice_code,a.s_invoice_number,a.e_invoice_number,b.region_name,d.district_name,a.group_id,e.group_name,a.login_no,c.login_name,to_char(a.op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.tt_wgroupinvoice a,sregioncode b,dloginmsg c,sdiscode d,dchngroupmsg e WHERE a.login_no=c.login_no AND a.region_code=b.group_id AND a.district_code=d.group_id AND a.group_id=e.group_id AND a.invoice_code=:invoice_code AND a.s_invoice_number<=to_number(:invoice_number) AND a.e_invoice_number>=to_number(:invoice_number1)";
    inParas2[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number+",invoice_number1="+invoice_number;

/*              
      if(fanwei.equals("0") )
      {
        inParas[0]="SELECT a.invoice_code,a.s_invoice_number,a.e_invoice_number,b.region_name,'','',c.login_name,to_char(a.op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.wcityinvoice a,sregioncode b,dloginmsg c WHERE a.login_no=c.login_no AND a.region_code = b.region_code AND  a.invoice_code=:invoice_code AND a.invoice_number=to_number(:invoice_number)";
      	inParas[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number;
      }
      else if(fanwei.equals("1"))
  	  {
  	    inParas[0]="SELECT a.invoice_code,a.s_invoice_number,a.e_invoice_number,b.region_name,d.district_name,'',c.login_name,to_char(a.op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.wdisinvoice a,sregioncode b,dloginmsg c,sdiscode d WHERE a.login_no=c.login_no AND a.region_code=b.region_code AND a.district_code=d.district_code AND a.region_code=d.region_code AND a.invoice_code=:invoice_code AND a.invoice_number=to_number(:invoice_number)";
  	    inParas[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number;
  	  }
      else
      {
        inParas[0]="SELECT a.invoice_code,a.s_invoice_number,a.e_invoice_number,b.region_name,d.district_name,e.group_name,c.login_name,to_char(a.op_time, 'YYYY-MM-DD HH24:MI:SS') FROM dbcustadm.wgroupinvoice a,sregioncode b,dloginmsg c,sdiscode d,dchngroupmsg e WHERE a.login_no=c.login_no AND a.region_code=b.region_code AND a.district_code=d.district_code AND a.region_code=d.region_code AND a.group_id=e.group_id AND a.invoice_code=:invoice_code AND a.invoice_number=to_number(:invoice_number)";
        inParas[1]="invoice_code="+invoice_code+",invoice_number="+invoice_number;
      }
*/      
   
%>

<wtc:service name="TlsPubSelBoss"   retcode="retCode" retmsg="retMsg" outnum="10">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>	
	</wtc:service>
<wtc:array id="tempArr" scope="end"/>

<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="10">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>	
	</wtc:service>
<wtc:array id="tempArr1" scope="end"/>

<wtc:service name="TlsPubSelBoss"   retcode="retCode2" retmsg="retMsg2" outnum="10">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
<wtc:array id="tempArr2" scope="end"/>
<%	

   return_code = retCode;
   return_code1 = retCode1;
   return_code2 = retCode2;
   ret_msg = retMsg;
   if(return_code.equals("000000") && return_code1.equals("000000") && return_code2.equals("000000"))
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
        <td><%=tempArr[i][9]%></td>
      </tr>
<%   }

	 for(int i=0; i<tempArr1.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr1[i][0]%></td>
        <td><%=tempArr1[i][1]%></td>
        <td><%=tempArr1[i][2]%></td>
        <td><%=tempArr1[i][3]%></td>
        <td><%=tempArr1[i][4]%></td>
        <td><%=tempArr1[i][5]%></td>
        <td><%=tempArr1[i][6]%></td>
        <td><%=tempArr1[i][7]%></td>
        <td><%=tempArr1[i][8]%></td>
        <td><%=tempArr1[i][9]%></td>
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
        <td><%=tempArr2[i][9]%></td>
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

