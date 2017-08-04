<%
  /*
   * 功能: m218·集团客户购充值卡
   * 版本: 1.0
   * 日期: 2015/1/8 
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String cardBeginNo = WtcUtil.repStr(request.getParameter("cardBeginNo"), ""); //开始卡号
	String cardEndNo = WtcUtil.repStr(request.getParameter("cardEndNo"), ""); //结束卡号
	String loginNo= (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String cardNum = "0"; //卡数
  String cardName = ""; //卡类型名称
  String cardParValue = "0.00"; //面值
  String resCode = ""; //卡类型代码
  String salePrice = "0.00"; //应收金额
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
	<wtc:service name="sm218Qry" routerKey="region" routerValue="<%=regionCode%>"	retcode="retCode" retmsg="retMsg" outnum="4">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=cardBeginNo%>"/>
		<wtc:param value="<%=cardEndNo%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    	if(ret.length>0){
    		cardNum = ret[0][0];
    		cardName = ret[0][1];
    		cardParValue = ret[0][2];
    		resCode = ret[0][3];
    		double v_salePrice =  Double.parseDouble(cardParValue) * Double.parseDouble(cardNum);
    		v_salePrice = (double) Math.round(v_salePrice*100)/100;  //四舍五入
		    if(v_salePrice == Math.floor(v_salePrice)){ //23 或 23.0
					salePrice = Double.toString(v_salePrice) + "0";
				}else{
					if(v_salePrice*10 == Math.floor(v_salePrice*10)){ //23.4
						salePrice = Double.toString(v_salePrice) + "0";
					}else{ //23.1234
						salePrice = Double.toString(v_salePrice);
					}
				}
    	}
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<TR>
					<TD width="18%" class="blue">卡类型代码</TD>
	        <TD width="32%">
	         	<input type="text" name="res_code" id="res_code" v_must="1" value="<%=resCode%>" class="InputGrey" readonly />
	        </TD>
	        <TD width="18%" class="blue">卡类型名称</TD>
	        <TD width="32%">
	          <input type="text" name="card_name"  id="card_name" style="width:150px;" v_must="1" value="<%=cardName%>"  class="InputGrey" readonly  />
	        </TD>
	      </TR>
				<TR>
	        <TD width="18%" class="blue">卡数</TD>
	        <TD width="32%">
	          <input type="text" name="card_num"  id="card_num" size="20" v_must="1" value="<%=cardNum%>" class="InputGrey" readonly />
	        </TD>
	        <TD width="18%" class="blue">卡面值</TD>
	        <TD width="32%">
	         	<input type="text" name="card_parValue" id="card_parValue" size="20" v_must="1" value="<%=cardParValue%>" class="InputGrey" readonly />
	        </TD>
	      </TR>
	      <TR>
	        <TD width="18%" class="blue">应收金额</TD>
	        <TD>
	          <input type="text" name="sale_price"  id="sale_price" size="20" v_must="1" value="<%=salePrice%>" class="InputGrey" readonly />
	        </TD>
	        <TD width="18%" class="blue">实收金额</TD>
	        <TD >
	          <input type="text" name="real_salePrice"  id="real_salePrice" size="20" v_must="1" value="<%=salePrice%>" class="InputGrey" readonly />
	        </TD>
	      </TR>
       	<TR>
	      	<TD id="footer" colspan="4"> &nbsp;
				  	<input name="next" id="next"  type="button" class="b_foot" value="确认" onclick="subInfo(this)" />
	      		&nbsp; 
	          <input  name="closeBtn"  class="b_foot" onClick="removeCurrentTab()" type="button" value="关闭" />
	        </TD>
	      </TR>	
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />