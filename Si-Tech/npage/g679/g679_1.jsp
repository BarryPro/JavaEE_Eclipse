<%
/********************
 version v2.0
开发商: si-tech
*
*update:liutong@2008-8-15
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>



<%
		/**ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String workno = baseInfo[0][2];
		String workname = baseInfo[0][3];
		String org_code = baseInfo[0][16];
		String belongName = baseInfo[0][16];
		String[][] password = (String[][])arr.get(4);//读取工号密码 
		String pass = password[0][0];
		String[][] info1 = (String[][])arr.get(1);
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		**/
		String opCode = "g679";
		String opName = "家庭未出帐查询";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		activePhone = request.getParameter("activePhone");
%>
<HTML><HEAD>

<script language="JavaScript">
<!--	
  
  function doProcess(packet)
  {
    var retResult=packet.data.findValueByName("retResult");
	var m_phone_no=packet.data.findValueByName("m_phone_no");
		var s_phone_no=packet.data.findValueByName("s_phone_no");
		var i_flag=packet.data.findValueByName("i_flag");
	//alert(i_flag+'m_phone_no is'+m_phone_no+'s_phone_no is'+s_phone_no); 
	if(retResult=="false")
	{
		//rdShowMessageDialog("请重新输入手机号码");
		return false;
	}	

	if(retResult=="true")
	{
		//docheck(); 
		document.frm.action="g679_2.jsp?i_flag="+i_flag+"&m_phone_no="+m_phone_no+"&s_phone_no="+s_phone_no;
	    
		document.frm.submit();
	 
	}
	
	//
  }
 
  function docheck()
  {
	  
  }
 function sel1()
 {
            window.location.href='s1300.jsp';
 }
 function sel2()
 {
           window.location.href='g659_1.jsp';
  }
 

 
 function sel5() {
           window.location.href='e034.jsp';
 }

 function init()
 {
    document.frm.contractno.focus();  
	//document.getElementById("div1").style.display="none";
 }
 function doclear() {
 		frm.reset();
 }

 function doQuery()
 {
	  if(document.frm.contractno.value=="")
      {
			rdShowMessageDialog("请输入家庭成员号码!");
			document.frm.contractno.focus();
			return false;
      }
	  //密码
	  /* 
	  if(document.frm.cus_pass.value=="")
      {
			rdShowMessageDialog("请输入密码!");
			return false;
      }
	  */ 
	  if(document.frm.ym.value=="")
      {
			rdShowMessageDialog("请输入查询年月!");
			document.frm.ym.focus();
			return false;
      }
	  //document.frm.custPass.value=document.frm.cus_pass.value;
		var myPacket = new AJAXPacket("getKdNo_new.jsp","正在查询客户，请稍候......");
		myPacket.data.add("contractNo",(document.all.contractno.value).trim());
		myPacket.data.add("return_page","g679_1.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;	
	  /*
	  document.frm.action="d568_2.jsp?check_code="+document.frm.check_code.value+"&check_no="+document.frm.check_no.value+"&loginno="+document.frm.loginno.value+"&phoneno="+document.frm.phoneno.value;
	  document.frm.query.disabled=true;
	  document.frm.submit();
	  */
 }
-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY  onLoad="init()" >
<FORM action="" method="post" name="frm"  >
<input type="hidden" name="busy_type"  value="2">
<input type="hidden" name="op_code"  value="g679">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
<input type="hidden" name="phoneNo" id = "pno"  value="" >
<input type="hidden" name="i_flag" >   
<input type="hidden" name="s_phone_no" > 
<input type="hidden" name="m_phone_no" > 
 <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请输入手机号码</div>
		</div>
              <table cellspacing="0">
                 
              </table>
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">家庭成员号码</td>
                  <td>
				  <input type="text" name="contractno" size="20" maxlength="25" style="ime-mode:disabled"   onKeyDown="if(event.keyCode==13) getpasswd();" index="5" value="<%=activePhone%>" readonly>
				  </td>
                   
 				</tr>
				<tr> 
                  <td  class="blue" width="15%">查询年月</td>
                  <td> 
                    <input type="text" name="ym" size="20" maxlength="6" value="<%=dateStr%>" >(YYYYMM)
					 
                  </td>
                   
 				</tr> 
				
				<!--
				<tr> 
				  <td class="blue"  width="15%">用户密码</td>
					  <td colspan=3>
						<jsp:include page="/npage/query/pwd_one.jsp">
							<jsp:param name="width1" value="16%"  />
							<jsp:param name="width2" value="34%"  />
							<jsp:param name="pname" value="cus_pass"  />
							<jsp:param name="pwd" value="12345"  />
							</jsp:include>
				   </td>
				 
				</tr>
				-->
              </table>
         <input type="hidden" name="phone_input">
         <input type="hidden" name="dbBand_Account">
		 <input type="hidden" name="custPass"  value="">
        <TABLE cellSpacing="0">
          <TR > 
            <TD noWrap colspan="6" id="footer"> 
              <div align="center"> 
                <input type="button" name="query"  class="b_foot" value="查询" onclick="doQuery()"  >
                &nbsp;
                <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
                &nbsp;
				<!--
				<input type="button" name="reprint"  class="b_foot" value="重打发票" onclick="doreprint()"  >
                &nbsp;
                <input type="button" name="nopay" class="b_foot_long" value="上笔缴费冲正" onclick="donopay()"  >
                &nbsp;
				<input type="button" name="query1"  class="b_foot" value="下一步" onclick="getpasswd1()"  > 
				-->
               
               <input type="button" name="return2" class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>');"  >
              </div>
            </TD>
          </TR>
        </TABLE>
      
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
  
</FORM>
 

</BODY>
</HTML>
