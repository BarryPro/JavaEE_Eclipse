<%
  /*
   * 功能: m219·集团客户购充值卡冲正
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
  String groupId=WtcUtil.repNull((String)session.getAttribute("groupId"));
  
  String loginAccept = "";
  String cardName = "";
  String resCode = "";
  String cardNum = "0"; //卡数
  String salePrice = "0.00"; //应收金额
  String real_salePrice = "0.00"; //实收金额
  String cardParValue = "0.00"; //面值
  String op_time = ""; //操作时间
  
  //获取系统时间
	Date currentTime = new Date(); 
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd");
	String currentTimeString = formatter.format(currentTime);
  
  String  inParams [] = new String[2];
	inParams[0] = "SELECT C.RES_NAME, to_char(B.RES_CODE), to_char(A.CARD_NUM), A.SALE_MONEY, to_char(A.LOGIN_ACCEPT),"
								+"      A.OUT_MONEY, C.PAR_VALUE, to_char(a.op_time,'yyyymmdd')"
								+" FROM WCHNCARDOUTSUM A, WCHNCARDOUTDET B, SCHNRESCODE C"
								+" WHERE C.RES_CODE = B.RES_CODE"
								+"  AND A.LOGIN_ACCEPT = B.LOGIN_ACCEPT"
								+"  AND A.GROUP_ID =:groupId "
								+"  AND LOGIN_NO =:loginNo "
								+"  AND A.LAST_SALE_FLAG = 'Y'"
								+"  AND OP_TYPE = '0'"
								+"  AND TO_CHAR(A.OP_TIME, 'yyyy/mm/dd') =:currentTimeString " //--当前时间的年月日 
								+"  AND A.OP_CODE IN ('m218') "//--集团销售的OP_CODE 
								+"  AND OP_TIME = (SELECT MAX(OP_TIME) "
								+"    FROM WCHNCARDOUTSUM A, WCHNCARDOUTDET B"
								+"  WHERE A.LOGIN_ACCEPT = B.LOGIN_ACCEPT"
								+"  AND A.GROUP_ID =:groupId "
								+"  AND LOGIN_NO =:loginNo "
								+"  AND OP_TYPE = '0'"
								+"  AND A.OP_CODE IN ('m218')"//--集团销售的OP_CODE 
								+"  AND B.BEGIN_NO =:cardBeginNo "
								+"  AND B.END_NO =:cardEndNo )"
								+"  AND B.BEGIN_NO =:cardBeginNo "
								+"  AND B.END_NO =:cardEndNo ";
	inParams[1] = "groupId="+groupId+",loginNo="+loginNo+",currentTimeString="+currentTimeString+",groupId="+groupId+",loginNo="+loginNo+",cardBeginNo="+cardBeginNo+",cardEndNo="+cardEndNo+",cardBeginNo="+cardBeginNo+",cardEndNo="+cardEndNo;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="8"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    	if(ret.length>0){
    		cardName = ret[0][0];
    		resCode = ret[0][1];
    		cardNum = ret[0][2];
    		salePrice = ret[0][3];     
    		loginAccept = ret[0][4];   
    		real_salePrice = ret[0][5];
    		cardParValue = ret[0][6];
    		op_time = ret[0][7];  
%>
<div id="Main">
	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>
		<table cellspacing="0" name="t1" id="t1">
			<TR>
        <TD width="18%" class="blue">操作流水</TD>
        <TD width="32%">
          <input type="text" name="login_accept"  id="login_accept" size="20" v_type="string" v_must=1 value="<%=loginAccept%>" class="InputGrey" readonly />
        </TD>
        <TD width="18%" class="blue">操作时间</TD>
        <TD width="32%">
          <input type="text" name="op_time"  id="op_time" size="20" v_type="string" v_must=1 value="<%=op_time%>" class="InputGrey" readonly />
        </TD>
      </TR>
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
        <TD width="18%" class="blue">卡数量</TD>
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
          <input type="text" name="real_salePrice"  id="real_salePrice" size="20" v_must="1" value="<%=real_salePrice%>" class="InputGrey" readonly />
        </TD>
      </TR>
     	<TR>
      	<TD id="footer" colspan="4"> &nbsp;
			  	<input name="subStn" id="subStn"  type="button" class="b_foot" value="确认" onclick="subInfo(this)" />
      		&nbsp; 
          <input  name="closeBtn"  class="b_foot" onClick="removeCurrentTab()" type="button" value="关闭" />
        </TD>
      </TR>	
   	</table>
	</div>
</div>
		<%}else{%>
				<SCRIPT type=text/javascript>	
					rdShowMessageDialog("当前查询条件，无当天购买记录！请确认！",1);
				</SCRIPT>	
		<%}%>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />