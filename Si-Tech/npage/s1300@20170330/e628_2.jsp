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
		String opCode = "e628";
		String opName = "手机支付缴费查询";
		boolean flag = false;
		
		String phoneNo = request.getParameter("phoneNo");
		
		if(phoneNo == null)
		{
		    phoneNo = "";
		    flag = false;
		}
	  else
	  {
	      flag = true;
	  }	
/*
  Calendar calendar = new GregorianCalendar();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH);
  int day = 1;
        
  Date date = new Date();
	String todayyearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);

	date.setYear(year - 1900);
	date.setMonth(month+1);
	date.setDate(day-1);
		
	String yearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);
*/
  Calendar c = Calendar.getInstance();//获得一个日历的实例            
  c.add(Calendar.MONTH,-5);
  String year_month = new java.text.SimpleDateFormat("yyyyMM").format(c.getTime());
  String begin_date = year_month+"01";
  String end_date = new java.text.SimpleDateFormat("yyyyMMdd").format(new Date());      
%>
<HTML>
<HEAD>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">

function commit(){

   if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("请输入订单号!");
     document.frm.phoneNo.focus();
     return false;
  }
  

    	 
 	 document.frm.submit();
	        
}

 

function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneNo.focus();
     return false;
  }
  

 if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	       
			var phone_no = document.all.phoneNo.value;
		  var busy_type = "1";  
			var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("phone_no",phone_no);
			checkPwd_Packet.data.add("busy_type",busy_type);
			core.ajax.sendPacket(checkPwd_Packet);
			
			checkPwd_Packet=null;
 
}


 function doProcess(packet){
	var retResult   = packet.data.findValueByName("retResult");
	var SzxFlag     = packet.data.findValueByName("SzxFlag");
	var IsMarketing = packet.data.findValueByName("IsMarketing");
	var returnCode = packet.data.findValueByName("returnCode");
	
	if(returnCode=="999999"){
		rdShowMessageDialog("没有此用户的相关资料!");
		return;
	}
 
  commit();
}
function sel1() {
 		window.location.href='e628.jsp';
 }

 function sel2(){
    window.location.href='e628_2.jsp';
 }


 function doclear() {
 		frm.reset();
 }
 </script> 
 
<title>黑龙江BOSS-手机支付缴费信息查询</title>
</head>
<BODY>
<form action="e628_2.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">手机支付缴费信息查询/订单号</div>
		</div>

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">选择方式</td>
        <td colspan="4"> 
          <input name="busyType1" type="radio" onClick="sel1()" value="1" >手机号码
          <input name="busyType2" type="radio" onClick="sel2()" value="2" checked> 订单号        
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">订单号</td>
      <td> 
        <input class="button"type="text" name="phoneNo" value="<%=phoneNo%>" size="35" maxlength="32"  >
        <font class="orange"> *</font>
        <input type="button" name="Button1" class="b_text" value="查询" onclick="commit()">
      </td>  
    </tr>
  </table>


  <br>
      

		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>缴费时间</th>
        <th>缴费金额</th>
        <th>缴费号码</th>
        <th>被缴号码</th>
        <th>渠道标识</th>
      </tr>
<%
   if(flag){
 
     String sqlStr = "select to_char(optdate,'YYYYMMDD HH24:MI:SS'),to_char(payed/100),phoneno,payedmobile,decode(cnltyp,'CAS','手机支付客户端','WAP','WAP一、二级门户','100863','省10086短信营业厅','100864','省10086语音IVR营业厅','') from oneboss.wobphonepay where seq = :login_accept AND reversalflag='0'";
    
//     String sqlStr = "select to_char(optdate,'YYYYMMDD HH24:MI:SS'),payed,phoneno,payedmobile,decode(cnltyp,'CAS','手机支付客户端','WAP','WAP一、二级门户','100863','省10086短信营业厅','100864','省10086语音IVR营业厅','') from oneboss.wobphonepay where total_date between :begin_time and :end_time and seq = :login_accept ";
     String[] inParas1 = new String[2];
     String return_code="";
	   String ret_msg="";
     inParas1[0]=sqlStr;
//     inParas1[1]="begin_time="+begin_date+",end_time="+end_date+",login_accept="+phoneNo;
     inParas1[1]="login_accept="+phoneNo;
%>
   <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="5">
		    <wtc:param value="<%=inParas1[0]%>"/>
		    <wtc:param value="<%=inParas1[1]%>"/>
		</wtc:service>
		<wtc:array id="tempArr" scope="end" />	
	
<%	
    
    return_code = retCode2;
    ret_msg = retMsg2;
   if(tempArr.length != 0 && return_code.equals("000000"))
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
        
      </tr>
<%}}}%>  
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

