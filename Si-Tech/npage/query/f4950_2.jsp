<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: SIM卡信息查询1505
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s2600.wrapper.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%
 System.out.println("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");        
	String opCode = "4950";
	String opName = "空卡信息查询";
	String regionCode = (String)session.getAttribute("regCode");
    String cardNo = request.getParameter("cardNo");//查询条件 
  
    System.out.println("aaaaaaaaaaaaaaaaaaa");                                      
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>SIM卡信息查询</TITLE>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires", 0);
%>
	<wtc:service name="s4950Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="8" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=cardNo%>"/>
		
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%       System.out.println("aaaaaaaaaaaaaaaaaaa");     
	String ret_code 	= retCode;
	String retMessage 	= retMsg;
       
	String ret_Region_name  = "";
	String ret_Status_name 	= "";
	String ret_type_name 	= "";
	String ret_Sim_no = "";
	String ret_card_no = "";
System.out.println("ret_coderet_coderet_coderet_code="+ret_code);
	if(ret_code.equals("000000"))
	{
		ret_Region_name  = result[0][2];
		ret_card_no = result[0][3];
		ret_Sim_no 	= result[0][4];
		ret_type_name 	= result[0][5];
		ret_Status_name = result[0][6];
		
				
	}

%>
</HEAD>

<body>
<FORM method=post name="frm1505">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="1505">
<table cellspacing="0">
	<TR> 
		<TD class="blue">空卡序列号：</TD>
		<TD>
			
			<input type="text" class="button" name="cardNo" value="<%=ret_card_no%>"size="20" maxlength="20">
			
		</TD>
		<TD class="blue">对应的SIM卡号码</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="simNo" value="<%=ret_Sim_no%>" size="20" >
		</TD>
	</TR>
	<TR> 
		<TD class="blue">空卡类型</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="cardType" value="<%=ret_type_name%>" size="20" >
		</TD>
		<TD class="blue">空卡状态</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="cardStatus" value="<%=ret_Status_name%>" size="20" >
		</TD>
	</TR>
	
	<TR> 
		<TD class="blue">归属地</TD>
		<TD colspan="3">
			<input type="text" readonly class="InputGrey" name="regionCode" value="<%=ret_Region_name%>" size="60" >
		</TD>
		
	</TR>  
	
	<tr> 
		<td align="center" id="footer" colspan="4">
		&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
		&nbsp; 
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

<script type="text/javascript">
	//alert("ssssssssssssssssssss");
    var ser_ret_code;
    var ser_retMessage;

    ser_ret_code = "<%= ret_code %>";
    //alert(ser_ret_code);
    ser_retMessage = "<%= retMessage %>";

    if (ser_ret_code != "000000")
    {
        rdShowMessageDialog('错误 '+ ser_ret_code + '[' + ser_retMessage + ']',0);
        history.go(-1);
    }
    

</script>


