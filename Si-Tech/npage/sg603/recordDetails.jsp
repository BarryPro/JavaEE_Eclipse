<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
		String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
		String opName = WtcUtil.repNull((String)request.getParameter("opName"));
		
		String vOrderId	= WtcUtil.repNull((String)request.getParameter("vOrderId"));
		String vSendCode	= WtcUtil.repNull((String)request.getParameter("vSendCode"));
		String vSendName	= WtcUtil.repNull((String)request.getParameter("vSendName"));
		String vOrderTime	= WtcUtil.repNull((String)request.getParameter("vOrderTime"));
		String vCustName	= WtcUtil.repNull((String)request.getParameter("vCustName"));
		String vIdName	= WtcUtil.repNull((String)request.getParameter("vIdName"));
		String vIdIccid	= WtcUtil.repNull((String)request.getParameter("vIdIccid"));
		String vProCode	= WtcUtil.repNull((String)request.getParameter("vProCode"));
		String vDisCode	= WtcUtil.repNull((String)request.getParameter("vDisCode"));
		String vMailPerson	= WtcUtil.repNull((String)request.getParameter("vMailPerson"));
		String vMailPhone	= WtcUtil.repNull((String)request.getParameter("vMailPhone"));
		String vFixPhoneNo	= WtcUtil.repNull((String)request.getParameter("vFixPhoneNo"));
		String vMailAddress	= WtcUtil.repNull((String)request.getParameter("vMailAddress"));
		String vMailPro= WtcUtil.repNull((String)request.getParameter("vMailPro"));
		String vMailDis	= WtcUtil.repNull((String)request.getParameter("vMailDis"));
		String vMailTown	= WtcUtil.repNull((String)request.getParameter("vMailTown"));
		String vPostCode	= WtcUtil.repNull((String)request.getParameter("vPostCode"));
		String vDispatchType	= WtcUtil.repNull((String)request.getParameter("vDispatchType"));
		String vOfferName	= WtcUtil.repNull((String)request.getParameter("vOfferName"));
		String vPrepayFee	= WtcUtil.repNull((String)request.getParameter("vPrepayFee"));
		String vPayAccept	= WtcUtil.repNull((String)request.getParameter("vPayAccept"));
		String vPayTime	= WtcUtil.repNull((String)request.getParameter("vPayTime"));
		String vPayBank	= WtcUtil.repNull((String)request.getParameter("vPayBank"));
		String vPayPhone	= WtcUtil.repNull((String)request.getParameter("vPayPhone"));
		String vPhoneNo	= WtcUtil.repNull((String)request.getParameter("vPhoneNo"));
		String vSaleFlag	= WtcUtil.repNull((String)request.getParameter("vSaleFlag"));
		String vIdAddr	= WtcUtil.repNull((String)request.getParameter("vIdAddr"));
		String vOfferId	= WtcUtil.repNull((String)request.getParameter("vOfferId"));
		
%>
<HEAD>
	<TITLE>黑龙江移动BOSS</TITLE>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>

	<script type=text/javascript>
		
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
	    <td><%=vOrderId%></td>
	    <td width="15%" class="blue">发起请求方标识</td>
	    <td><%=vSendCode%></td>
	    <td width="15%" class="blue">发起请求方名称</td>
	    <td><%=vSendName%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">订购时间</td>
	    <td><%=vOrderTime%></td>
	    <td width="15%" class="blue">客户名称</td>
	    <td><%=vCustName%></td>
	    <td width="15%" class="blue">证件类型</td>
	    <td><%=vIdName%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">证件号码</td>
	    <td><%=vIdIccid%></td>
	    <td width="15%" class="blue">卡号归属省</td>
	    <td><%=vProCode%></td>
	    <td width="15%" class="blue">卡号归属地市</td>
	    <td><%=vDisCode%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">收货人姓名名称</td>
	    <td><%=vMailPerson%></td>
	    <td width="15%" class="blue">联系电话</td>
	    <td><%=vMailPhone%></td>
	    <td width="15%" class="blue">固定电话</td>
	    <td><%=vFixPhoneNo%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">送货地址</td>
	    <td><%=vMailAddress%></td>
	    <td width="15%" class="blue">收货人省份名称</td>
	    <td><%=vMailPro%></td>
	    <td width="15%" class="blue">收货人地市名称</td>
	    <td><%=vMailDis%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">收货人区县名称</td>
	    <td><%=vMailTown%></td>
	    <td width="15%" class="blue">邮政编码</td>
	    <td><%=vPostCode%></td>
	    <td width="15%" class="blue">配送时间要求</td>
	    <td>
	    	<%if ("1".equals(vDispatchType)){
	    				out.write("只工作日送货（双休日、假日不送货）");
	    		} else if ("2".equals(vDispatchType)){
	    				out.write("双休日、假日送货（工作日不送货）");
	    		} else if ("3".equals(vDispatchType)){
	    				out.write("工作日、双休日与假日均可送货");
	    		} %></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">套餐编码</td>
	    <td><%=vOfferId%></td>
	    <td width="15%" class="blue">套餐名称</td>
	    <td><%=vOfferName%></td>
	    <td width="15%" class="blue">预存款</td>
	    <td><%=vPrepayFee%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">支付流水</td>
	    <td><%=vPayAccept%></td>
	    <td width="15%" class="blue">支付时间</td>
	    <td><%=vPayTime%></td>
	    <td width="15%" class="blue">支付银行</td>
	    <td><%=vPayBank%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">手机支付号码</td>
	    <td><%=vPayPhone%></td>
	    <td width="15%" class="blue">开户号码</td>
	    <td><%=vPhoneNo%></td>
	    <td width="15%" class="blue">订单状态</td>
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
	    <td class="blue">证件地址</td>
	    <td cospan="5"><%=vIdAddr%></td>
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
