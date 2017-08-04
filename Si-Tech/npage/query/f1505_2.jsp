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
	String opCode = "1505";
	String opName = "SIM卡信息查询";
	String regionCode = (String)session.getAttribute("regCode");
  String simNo = request.getParameter("simNo");//查询条件
	String iLoginNo  = (String)session.getAttribute("workNo");
	String iPhoneNo = request.getParameter("phoneNo");    
  String querytype=request.getParameter("querytype");                                              
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>SIM卡信息查询</TITLE>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires", 0);
        String iLoginAccept = "0";
        String iChnSource = "01";
%>
	<wtc:service name="s1505Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="26" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>	
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=simNo%>"/>
		<wtc:param value="<%=querytype%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%            
	String ret_code 	= retCode;
	String retMessage 	= retMsg;
       
  String ret_Region_code = "";     
	String ret_Region_name  = "";
	String ret_District_code = "";
	String ret_District_name= "";
	String ret_Town_code = "";
	String ret_Town_name 	= "";
	String ret_Sim_status = "";
	String ret_Status_name 	= "";
	String ret_Sm_code = "";
	String ret_Sm_Name 	= "";
	String ret_Sim_type = "";
	String ret_type_name 	= "";
	String ret_Phone_head 	= "";
	String ret_Hlr_code = "";
	String ret_Hlr_name 	= "";
	String ret_Sim_fee 	= "";
	String ret_Double_Flag 	= "";
	String ret_Ip_Flag 	= "";
	String ret_Puk1 	= "";
	String ret_Puk2 	= "";
	String ret_Phone_no 	= "";
	String ret_Imsi_no 	= "";
	String ret_card_no = "";
	String ret_Sim_no = "";

	if(ret_code.equals("000000"))
	{
	  ret_Region_code = result[0][0];
		ret_Region_name  = result[0][1];
		ret_District_code = result[0][2]; 
		ret_District_name = result[0][3];
		ret_Town_code = result[0][4]; 
		ret_Town_name 	= result[0][5];	
		ret_Sim_status = result[0][6];
		ret_Status_name 	= result[0][7];	
		ret_Sm_code = result[0][8];		
		ret_Sm_Name 	= result[0][9];
		ret_Sim_type = result[0][10]; 
		ret_type_name 	= result[0][11];
		ret_Phone_head 	= result[0][12];
		ret_Hlr_code = result[0][13];
		ret_Hlr_name 	= result[0][14];
		ret_Sim_fee 	= result[0][15];
		ret_Double_Flag 	= result[0][16];
		ret_Ip_Flag 	= result[0][17];
		ret_Puk1 	= result[0][18];
		ret_Puk2 	= result[0][19];
		ret_Phone_no 	= result[0][20];
		ret_Imsi_no 	= result[0][21];
		ret_Sim_no = result[0][22];
		ret_card_no = result[0][25];
	}
			
%>
</HEAD>

<body>
<FORM method=post name="frm1505">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="1505">
<table cellspacing="0">
	<TR> 
		<TD class="blue">SIM卡号</TD>
		<TD>
			<input type="text" class="InputGrey" readOnly name="simNo" size="20" value="<%= ret_Sim_no %>"  maxlength="20">
		</TD>
		<TD class="blue">对应的服务号码</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="phoneNo" value="<%= ret_Phone_no %>"  size="20" maxlength="11">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">IMSI号</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="imsiNo" value="<%= ret_Imsi_no %>" size="20" maxlength="15">
		</TD>
		<TD class="blue">号段头</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="phoneNoHead" value="<%= ret_Phone_head %>" size="20" maxlength="7">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">HLR代码</TD>
		<TD>
			<input type="text" readonly class="InputGrey"  value="<%= ret_Hlr_code %>--><%= ret_Hlr_name %>" name="hlrCode" size="20" maxlength="20">
		</TD>
		<TD class="blue">业务类型</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Sm_code %>--><%= ret_Sm_Name%>" name="sm_code" size="20" maxlength="60">
		</TD>
	</TR>      
	<TR> 
		<TD class="blue">归属地市</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Region_code%>--><%= ret_Region_name %>" name="regionCode" size="20" maxlength="20">
		</TD>
		<TD class="blue">归属区县</TD>
		<TD>
			<input type="text" readonly class="InputGrey"  value="<%= ret_District_code%>--><%= ret_District_name %>" name="disCode" size="20" maxlength="30">
		</TD>
	</TR>  
	<TR> 
		<TD class="blue">归属网点</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Town_code%>--><%= ret_Town_name %>" name="townCode" size="20" maxlength="30">
		</TD>
		<TD class="blue">SIM卡状态</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Sim_status%>--><%= ret_Status_name %>"  name="simStatus" size="20" maxlength="8">
		</TD>
	</TR>   
	<TR> 
		<TD class="blue">SIM卡类型</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Sim_type%>--><%= ret_type_name %>"  name="simType" size="20" maxlength="30">
		</TD>
		<TD class="blue">SIM卡卡费</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Sim_fee %>"  name="simFee" size="20" maxlength="8">
		</TD>
	</TR>     
	<TR> 
		<TD class="blue">PUK1</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Puk1 %>"  name="PUK1" size="20" maxlength="30">
		</TD>
		<TD class="blue">PUK2</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Puk2 %>" name="PUK2" size="20" maxlength="8">
		</TD>
	</TR>  
	<TR> 
		<TD class="blue">是否双号卡</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Double_Flag %>"  name="doubleFlag" size="20" maxlength="30">
		</TD>
		<TD class="blue">是否商务IP</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_Ip_Flag %>"  name="Ip_Flag" size="20" maxlength="30">
		</TD>
	</TR>  
	<TR> 
		<TD class="blue">空卡序列号:</TD>
		<TD>
			<input type="text" readonly class="InputGrey" value="<%= ret_card_no %>"  name="card_no" size="20" maxlength="30">
		</TD>
		<TD class="blue">&nbsp;</TD>
		<TD>
			&nbsp;
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
    var ser_ret_code;
    var ser_retMessage;

    ser_ret_code = "<%= ret_code %>";
    ser_retMessage = "<%= retMessage %>";

    if (ser_ret_code != "000000")
    {
        rdShowMessageDialog('错误 '+ ser_ret_code + '[' + ser_retMessage + ']',0);
    }
    

</script>


