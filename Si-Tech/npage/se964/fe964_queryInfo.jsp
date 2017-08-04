<%
    /*************************************
    * 功  能: 领取网上选号SIM卡 e964
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String work_name = WtcUtil.repNull((String)session.getAttribute("workName"));
	String password = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName = WtcUtil.repNull((String)request.getParameter("opName"));
	String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	String userCardNo = WtcUtil.repNull((String)request.getParameter("idIccid"));
	String v_saleFlag="";
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
  
	<wtc:service name="sE964init"  routerKey="region" routerValue="<%=regionCode%>"   retcode="errcode" retmsg="errmsg" outnum="23">
	<wtc:param value="<%=printAccept%>" />
	<wtc:param value="01" />
	<wtc:param value="<%=opCode%>" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="<%=password%>" />
	<wtc:param value="<%=phoneNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	</wtc:service>
	<wtc:array id="retList" scope="end"/>

<%
	System.out.println("retList.length: "+retList.length);
	System.out.println("errcode: "+errcode);
	System.out.println("errmsg: "+errmsg);
%>
<HEAD>
  <TITLE>领取网上选号SIM卡查询</TITLE>
</HEAD>
<% if (!"000000".equals(errcode)) {%>
    <script language="javascript">
    	rdShowMessageDialog("错误代码：<%=errcode%><br>错误信息：<%=errmsg%>",0);
    	window.location.href="fe964_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </script>
<%}else{%>
<body>
<FORM method="post" name="frm">
<%@ include file="/npage/include/header.jsp" %>
 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
<div id="Operation_Table">
  <div class="title">
  	<div id="title_zi">领取网上选号SIM卡查询</div>
  </div>
  <table cellspacing="0">
    <tr>
      <th>服务号码</th>
      <th>订单状态</th>
      <th>用户编码</th>
      <th>sim卡号</th>
      <th>客户姓名</th>
      <th>证件类型</th>
      <th>证件号码</th>
      <th>sim卡类型</th>
    </tr>
    
  <%
  if(retList.length==0){
		out.println("<tr height='25' align='center'><td colspan='8'>");
		out.println("没有任何记录！");
		out.println("</td></tr>");
	}else if(retList.length>0){
  	for(int y=0;y<retList.length;y++){
      String tdClass = "";
      if (y%2==0){
          tdClass = "Grey";
      }
      System.out.println("-------e964--------retList[0].length="+retList[0].length);
      System.out.println("-------e964--------retList[y][0]="+retList[y][0]);
      System.out.println("-------e964--------retList[y][1]="+retList[y][1]);
      System.out.println("-------e964--------retList[y][2]="+retList[y][2]);
      System.out.println("-------e964--------retList[y][3]="+retList[y][3]);
      System.out.println("-------e964--------retList[y][4]="+retList[y][4]);
      System.out.println("-------e964--------retList[y][5]="+retList[y][5]);
      System.out.println("-------e964--------retList[y][6]="+retList[y][6]);
      System.out.println("-------e964--------retList[y][7]="+retList[y][7]);
      System.out.println("-------e964--------retList[y][8]="+retList[y][8]);
      System.out.println("-------e964--------retList[y][9]="+retList[y][9]);
      System.out.println("-------e964--------retList[y][10]="+retList[y][10]);
      System.out.println("-------e964--------retList[y][11]="+retList[y][11]);
      System.out.println("-------e964--------retList[y][12]="+retList[y][12]);
      System.out.println("-------e964--------retList[y][13]="+retList[y][13]);
      System.out.println("-------e964--------retList[y][14]="+retList[y][14]);
      System.out.println("-------e964--------retList[y][15]="+retList[y][15]);
      System.out.println("-------e964--------retList[y][16]="+retList[y][16]);
      System.out.println("-------e964--------retList[y][17]="+retList[y][17]);
      System.out.println("-------e964--------retList[y][18]="+retList[y][18]);
      System.out.println("-------e964--------retList[y][19]="+retList[y][19]);
      System.out.println("-------e964--------retList[y][20]="+retList[y][20]);
      System.out.println("-------e964--------retList[y][20]="+retList[y][22]);
      System.out.println("-------e964--------retList[y][20]="+retList[y][22]);
      
      if("1".equals(retList[y][1])){
        v_saleFlag = "尚未支付";
      }else if("2".equals(retList[y][1])){
        v_saleFlag = "已完成支付";
      }else if("3".equals(retList[y][1])){
        v_saleFlag = "支付失败";
      }else if("4".equals(retList[y][1])){
        v_saleFlag = "支付成功，未取卡";
      }else if("5".equals(retList[y][1])){
        v_saleFlag = "支付成功，已取卡";
      }else if("6".equals(retList[y][1])){
        v_saleFlag = "取卡超时已销户";
      }else{
        v_saleFlag = "";
      }
    %>
  	  <tr>
  	    <td class="<%=tdClass%>">
  	      <a class="orange" href="fe964_showInfoAndWriteCad.jsp?opCode=<%=opCode%>&opName=<%=opName%>&userCardNo=<%=userCardNo%>&phoneNo=<%=phoneNo%>&custName=<%=retList[y][6]%>&qryPhoneNo=<%=retList[y][0]%>&brandName=<%=retList[y][10]%>&idName=<%=retList[y][11]%>&custIccid=<%=retList[y][8]%>&simCaidName=<%=retList[y][12]%>&custAddr=<%=retList[y][7]%>&idNo=<%=retList[y][2]%>&simType=<%=retList[y][5]%>&saleFlag=<%=v_saleFlag%>&hlrCodeName=<%=retList[y][13]%>&simNo=<%=retList[y][3]%>&prePayFee=<%=retList[y][21]%>&simPayFee=<%=retList[y][22]%>&offerIdStr=<%=retList[y][15]%>&offerNameStr=<%=retList[y][16]%>&offerComStr=<%=retList[y][17]%>&spelServIdStr=<%=retList[y][18]%>&spelServNameStr=<%=retList[y][19]%>" title="写卡" target="_self" ><%=retList[y][0].equals("")?"&nbsp;":retList[y][0]%></a>
  	    </td>
  	    <td class="<%=tdClass%>"><%=v_saleFlag.equals("")?"&nbsp;":v_saleFlag%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][2].equals("")?"&nbsp;":retList[y][2]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][3].equals("")?"&nbsp;":retList[y][3]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][6].equals("")?"&nbsp;":retList[y][6]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][11].equals("")?"&nbsp;":retList[y][11]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][8].equals("")?"&nbsp;":retList[y][8]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][5].equals("")?"&nbsp;":retList[y][5]%></td>
  	   </tr>
    <%
      }
    }
  %>
  </table>
  <table cellspacing=0>
    <tr id="footer"> 
      <td>
        <input class="b_foot" name="back" onClick="goBack()" type="button" value="返回" />
        <input class="b_foot" name="back" onClick="removeCurrentTab()" type="button" value="关闭" />
      </td>
    </tr>
  </table>
</div>
<input type="hidden" name="simType" id="simType" value="" />
<input type="hidden" name="custName" id="custName" value="" />
<input type="hidden" name="custAddr" id="custAddr"  value="" />
<input type="hidden" name="iccNo" id="iccNo" value="" />
<input type="hidden" name="smName" id="smName"  value="" />

<input type="hidden" name="cardtype_bz"  value="s" />
<input name=simType id="simType" type=hidden value="" />
<input name=simCode id="simCode" type=hidden value="" />
<input name=phoneNo id="phoneNo" type=hidden value="" />
<input type="hidden" name="simCodeCfm" id="simCodeCfm"   />
<input type="hidden" name="cardstatus" id="cardstatus"   />
<input type="hidden" name="cardNo" id="cardNo" value=""  />
<input name=writecardbz type=hidden value="" />
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="javascript">
	function goBack(){
	  window.location.href="fe964_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
</BODY>
</HTML>
<%}%>