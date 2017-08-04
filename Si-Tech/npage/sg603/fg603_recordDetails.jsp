<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
		
		String opName     = "网站开户外呼号码详细信息";
		String regionCode = (String)session.getAttribute("regCode");
		String opCode 		= WtcUtil.repNull((String)request.getParameter("opCode"));
		String phoneNo 		= WtcUtil.repNull((String)request.getParameter("phoneNo"));
		
		String vOrderId			 = "";
		String vSendCode		 = "";
		String vSendName		 = "";
		String vOrderTime		 = "";
		String vCustName		 = "";
		String vIdName			 = "";
		String vIdIccid			 = "";
		String vProCode			 = "";
		String vDisCode			 = "";
		String vMailPerson	 = "";
		String vMailPhone		 = "";
		String vFixPhoneNo	 = "";
		String vMailAddress	 = "";
		String vMailPro			 = "";
		String vMailDis			 = "";
		String vMailTown		 = "";
		String vPostCode		 = "";
		String vDispatchType = "";
		String vOfferName		 = "";
		String vPrepayFee		 = "";
		String vPayAccept		 = "";
		String vPayTime			 = "";
		String vPayBank			 = "";
		String vPayPhone		 = "";
		String vPhoneNo			 = "";
		String vSaleFlag		 = "";
		String vIdAddr			 = "";
		String vOfferId			 = "";
		
		String paraAray[] = new String[10];

		paraAray[0] = "";                                       //流水
		paraAray[1] = "01";                                     //渠道代码
		paraAray[2] = opCode;                                   //操作代码
		paraAray[3] = (String)session.getAttribute("workNo");   //工号
		paraAray[4] = (String)session.getAttribute("password"); //工号密码
		paraAray[5] = phoneNo;                                  //用户号码
		paraAray[6] = "";                                       //用户密码
		paraAray[7] = "";
		paraAray[8] = "3";
		paraAray[9] = "";
		
		String retCode = "";
		String retMsg  = "";
try{
%>
 	<wtc:service name="sg530Qry" outnum="28" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
 		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
 		<wtc:param value="<%=paraAray[8]%>" />	
 		<wtc:param value="<%=paraAray[9]%>" />				
 	</wtc:service>
 	<wtc:array id="sg530QryResult" scope="end"/>
<%		
	if("000000".equals(code)&&sg530QryResult.length>0){
			vOrderId		  = sg530QryResult[0][0];   //集团订单号   
			vSendCode		  = sg530QryResult[0][1];   //发起请求方标识
			vSendName		  = sg530QryResult[0][2];   //发起请求方名称
			vOrderTime	  = sg530QryResult[0][3];   //订购时间      
			vCustName		  = sg530QryResult[0][4];   //客户名称      
			vIdName			  = sg530QryResult[0][5];   //证件类型      
			vIdIccid		  = sg530QryResult[0][6];   //证件号码      
			vProCode		  = sg530QryResult[0][7];   //卡号归属省    
			vDisCode		  = sg530QryResult[0][8];   //卡号归属地市  
			vMailPerson	  = sg530QryResult[0][9];   //收货人姓名名称
			vMailPhone	  = sg530QryResult[0][10];   //联系电话      
			vFixPhoneNo	  = sg530QryResult[0][11];   //固定电话      
			vMailAddress  = sg530QryResult[0][12];   //送货地址      
			vMailPro		  = sg530QryResult[0][13];   //收货人省份名称
			vMailDis		  = sg530QryResult[0][14];   //收货人地市名称
			vMailTown		  = sg530QryResult[0][15];   //收货人区县名称
			vPostCode		  = sg530QryResult[0][16];   //邮政编码      
			vDispatchType = sg530QryResult[0][17];   //配送时间要求  
			vOfferId 	    = sg530QryResult[0][18];   //套餐编码      
			vOfferName		= sg530QryResult[0][19];   //套餐名称      
			vPrepayFee		= sg530QryResult[0][20];   //预存款        
			vPayAccept		= sg530QryResult[0][21];   //支付流水      
			vPayTime			= sg530QryResult[0][22];   //支付时间      
			vPayBank		  = sg530QryResult[0][23];   //支付银行      
			vPayPhone			= sg530QryResult[0][24];   //手机支付号码  
			vPhoneNo		  = sg530QryResult[0][25];   //开户号码      
			vSaleFlag		  = sg530QryResult[0][26];   //订单状态      
			vIdAddr				= sg530QryResult[0][27];   //证件地址      
	}
	 retCode = code;
	 retMsg  = msg;
}catch(Exception e){
	 e.printStackTrace();
	 retCode = "40404";
	 retMsg  = "调用服务系统错误，请联系管理员";
}		
%>
<HEAD>
<TITLE>黑龙江移动BOSS</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
	
$(document).ready(function (){
	if("000000"!="<%=retCode%>"){
		rdShowMessageDialog("查询错误，<%=retCode%>：<%=retMsg%>");
		window.close();
	}
});
</script>
</HEAD>
<BODY>
	<form method=post name="getsimno">
	<%@ include file="/npage/include/header_pop.jsp" %>
	
	<div class="title">
		<div id="title_zi">详细信息展示</div>
	</div>
			    
	<table cellspacing="0" >
	  <tr>
	    <td class="blue" width="15%">集团订单号</td>
	    <td width="35%"><%=vOrderId%></td>
	    <td class="blue" width="15%">订购时间</td>
	    <td width="35%"><%=vOrderTime%></td>
		</tr>
		
		<tr>
	    
	    <td  class="blue">客户名称</td>
	    <td><%=vCustName%></td>
	    <td class="blue" >收货人姓名名称</td>
	    <td><%=vMailPerson%></td>
		</tr>
		
		<tr>
			<td  class="blue">证件类型</td>
	    <td><%=vIdName%></td>
	    <td class="blue" >证件号码</td>
	    <td><%=vIdIccid%></td>
		</tr>
		
		<tr>
	    <td  class="blue">联系电话</td>
	    <td><%=vMailPhone%></td>
	    <td  class="blue">平台定单号</td>
	    <td><%=vFixPhoneNo%></td>
		</tr>
		
		
		<tr>
			<td  class="blue">开户号码</td>
	    <td><%=vPhoneNo%></td>
	    <td  class="blue">邮政编码</td>
	    <td><%=vPostCode%></td>
		</tr>
		
		<tr>
	    <td class="blue" >套餐编码</td>
	    <td><%=vOfferId%></td>
	    <td  class="blue">套餐名称</td>
	    <td><%=vOfferName%></td>
		</tr>
		

		<tr>
			<td  class="blue">预存款</td>
	    <td><%=vPrepayFee%></td>		
	    <td  class="blue">订单状态</td>
	    <td><%if ("5".equals(vSaleFlag)){
	    				out.write("未外呼");
	    		} else if ("8".equals(vSaleFlag)){
	    				out.write("已预占");
	    		} else if ("0".equals(vSaleFlag)){
	    				out.write("外呼成功未写卡");
	    		}else if ("1".equals(vSaleFlag)){
	    				out.write("已写卡未邮寄");
	    		}else if ("2".equals(vSaleFlag)){
	    				out.write("已邮寄未反馈结果");
	    		}else if ("3".equals(vSaleFlag)){
	    				out.write("配送成功");
	    		}else if ("4".equals(vSaleFlag)){
	    				out.write("配送失败");
	    		}else if ("5".equals(vSaleFlag)){
	    				out.write("未外呼");
	    		}else if ("6".equals(vSaleFlag)){
	    				out.write("外呼失败");
	    		}else if ("7".equals(vSaleFlag)){
	    				out.write("用户拒收");
	    		} %></td>
		</tr>
		
	 <tr>
			<td  class="blue">配送时间要求</td>
	    	<td colspan="3">
	    	<%if ("1".equals(vDispatchType)){
	    				out.write("只工作日送货（双休日、假日不送货）");
	    		} else if ("2".equals(vDispatchType)){
	    				out.write("双休日、假日送货（工作日不送货）");
	    		} else if ("3".equals(vDispatchType)){
	    				out.write("工作日、双休日与假日均可送货");
	    		} %>
	    	</td>
	  </tr>
		<tr>
	    <td class="blue" >送货地址</td>
	    <td colspan="3"><%=vMailAddress%></td>
		</tr>
	</table>
  
  <table cellSpacing="0">
    <tr>
      <TD align="center" id="footer" >
        <input class="b_text" name=back onClick="window.close()" type="button" value="关闭">&nbsp;
      </TD>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</BODY>
</HTML>
