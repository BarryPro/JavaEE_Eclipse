<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
    String opCode = "zgag";
    String opName = "营销案赠送充值卡充值";
	String phone_no = request.getParameter("phone_no"); 
	String card_no = request.getParameter("card_no");
%>
<body onload = "inits()">
<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>   
	 
 
<script language = "javascript">
	 function inits()
	 {
		 document.all.doCfm.disabled=false;
		 document.all.doCfm2.disabled=true;
	 }
	 function checkCard2()
	 {
		var myPacket = new AJAXPacket("zgag_check.jsp","正在查询充值卡信息，请稍候......");
		myPacket.data.add("phoneNo",document.all.phone_no.value );//手机号码
		myPacket.data.add("card_no",document.all.card_no.value ); //卡号
		core.ajax.sendPacket(myPacket,doPosSubInfo1);
		myPacket=null;
	 }
	 function doPosSubInfo1(packet)
	 {
		//alert("123"); 返回已赠送金额 充值卡面值
		var s_flag =  packet.data.findValueByName("s_flag");
		var s_ycz =  packet.data.findValueByName("s_ycz");
		var s_mz =  packet.data.findValueByName("s_mz");
	//	alert("s_flag is "+s_flag+" and s_ycz is "+s_ycz+" and s_mz is "+s_mz);
		if(s_flag=="1")
		{
			rdShowMessageDialog("充值卡记录不存在!");
			history.go("-1");
		}
		else
		{
			document.all.doCfm2.disabled=false;
			 
			document.all.yzsje.value=s_ycz;
			document.all.czkmz.value=s_mz;
			document.all.czkmm.focus();
		}
	 }
	 function doCfmP()
	 {
		 var czkmm = document.all.czkmm.value;
		 if(czkmm=="")
		 {
			rdShowMessageDialog("请输入充值卡密码!");
			document.all.czkmm.focus();
			return false;
		 } 	
		 
		 //判断 kczje 够不够
		 var finalNew= "";
	
		 finalNew = (document.all.kzsje.value)-(document.all.yzsje.value)-(document.all.czkmz.value);
	//	 alert("1 finalNew is "+finalNew);
		 /*
		 if(finalNew<0)
		 {
			rdShowMessageDialog("可充值金额超过赠送总金额,不允许再进行充值!");
			history.go("-1");
		 }*/
		 var	prtFlag = rdShowConfirmDialog("充值卡面值"+document.all.czkmz.value+"元,是否确定充值？");
		 if (prtFlag==1)
		 {
			document.frm1508_2.action="zgag_3.jsp?phoneNo="+document.all.phone_no.value+"&kzsje="+document.all.kzsje.value+"&kmz="+document.all.czkmz.value+"&yczje="+document.all.kzsje.value+"&card_no="+document.all.card_no.value+"&km="+document.all.czkmm.value+"&o_login_accept="+document.all.o_login_accept.value;
			//alert(document.all.action);
			document.frm1508_2.submit();
		 }
		 else
		 {
			return false;
		 }
	 }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>营销案赠送充值卡充值</TITLE>
</HEAD>

<wtc:service name="se257QryAct" routerKey="phone" routerValue="<%=phone_no%>"  retcode="errCodeNew" retmsg="errMsgNew" outnum="2">
		    <wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=card_no%>"/>
</wtc:service>
<wtc:array id="results" scope="end" />
<%
	String return_code="";
	String return_msg="";
	String s_zje="";
	String s_login_accept="";
	String[][] result1  = null ;
	result1=results;
	if(result1!=null)
	{
		return_code=errCodeNew;
		return_msg=errMsgNew;
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaffffffffffffffffffffffff return_code is  "+return_code);
		if(return_code=="000000" ||return_code.equals("000000"))
		{
			s_login_accept=results[0][0];
			s_zje=results[0][1];
			%>
			<input type="hidden" name="o_login_accept" value="<%=s_login_accept%>">
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>
					
					  <table cellspacing="0" >
								<tr> 
									<td class="blue" >用户手机号码</td>
									<td> 
										<input type="text"  name="phone_no" value="<%=phone_no%>" readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >充值卡卡号</td>
									<td> 
										<input type="text"  name="card_no" value="<%=card_no%>" readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >可赠送金额</td>
									<td> 
										<input type="text"  name="kzsje" value="<%=s_zje%>"  readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >已赠送金额</td>
									<td> 
										<input type="text"  name="yzsje"   readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >充值卡面值</td>
									<td> 
										<input type="text"  name="czkmz" readonly class="InputGrey" >
									</td>
								  
								</tr>
								<tr> 
									<td class="blue" >充值卡密码</td>
									<td> 
										<input type="password" name="czkmm" >
									</td>
								  
								</tr>
				 

						 
						  <tr align="center" id="footer">
							<td colspan="8">
								
								<input class="b_foot" name=doCfm  type=button index="8" value="个人校验" onclick="checkCard2()">
							 
							 
								<input class="b_foot" name=doCfm2 type=button  value="为个人充值" onclick="doCfmP()">
							</td>
						</tr>
						  
					  </table>
					  <tr id="footer"> 
						   
						  </tr>
					
						
							
						

				<%@ include file="/npage/include/footer.jsp" %>
				
			<%
		}
		else
		{
			%>
				<script language="JavaScript">
						rdShowMessageDialog("服务查询报错,错误代码:"+"<%=return_code%>"+",错误原因:"+"<%=return_msg%>");
						history.go("-1");
				 </script>
			<%
		}
	}
%>
</FORM>
				</BODY>
</HTML>

