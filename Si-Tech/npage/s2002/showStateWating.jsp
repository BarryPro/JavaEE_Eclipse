<%
  /*
   * 功能: 查看与bboss交互的工单状态
　 * 版本: v1.0
　 * 日期: 2010-5-13 11:40:39
　 * 作者: wangzn
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="1111";
  String opName="工单状态";
  String sqlStr="";
  
  
  
  //端到端过来的预受理
  String sm_code = WtcUtil.repNull((String)request.getParameter("sm_code"));
  String in_GrpId = WtcUtil.repNull((String)request.getParameter("in_GrpId"));
  String in_ChanceId = WtcUtil.repNull((String)request.getParameter("in_ChanceId"));
  String IdNo = WtcUtil.repNull((String)request.getParameter("IdNo"));
  String WaNo = WtcUtil.repNull((String)request.getParameter("wa_no1"));
  String disDDH = "";
  String disDDMC = "";
  String disDDZT = "";
  String tmpRetCode = "";
  if(!"".equals(in_ChanceId)){
        //校验工单是否操作过了！
        %>
        <wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        <wtc:sql>SELECT chance_id,chance_name FROM dbsalesadm.dmktchance WHERE chance_id = '<%=in_ChanceId%>'</wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result" scope="end"/>
        <%
        if(result.length!=1){
        System.out.println(result[0][0]+"--"+result[0][1]);
        %>
             <script type="text/javascript">
					        rdShowMessageDialog("查询订单信息出错！");
					        parent.removeTab('<%=opCode%>');
			       </script>
        <%       
        }else{
             disDDH = result[0][0];
             disDDMC = result[0][1];
              
        }%>
        <wtc:service name="s9104ChkChance" retcode="retCode" retmsg="retMsg" outnum="0" routerKey="region" routerValue="<%=regionCode%>">
            <wtc:param value="<%=in_ChanceId%>"/>
        </wtc:service>
        <%
        disDDZT = retMsg;
        tmpRetCode = retCode;
        }
        %>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">		
	<script type="text/javascript" src="/njs/extend/jquery/portalet/interface_pack.js"></script>
</HEAD>
<BODY>
<FORM name="form1" method="post" action="subStateWating.jsp">
<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi">工单状态</div></div>
<table>
	<tr>
		 <td class="blue" width="15%">订单号</td>
		 <td><%=disDDH%></td>
  </tr>
  <tr>
		 <td class="blue" width="15%">订单名称</td>
		 <td><%=disDDMC%></td>
  </tr>
  <tr>
		 <td class="blue" width="15%">订单状态</td>
		 <td><%=disDDZT%></td>
  </tr>
</table>	
	
	
<table>
  <tr>
    <td align="center" id="footer" colspan="2">
     <!-- <input class="b_foot" name=next id=nextoper type=button value="下一步">-->
      <input class="b_foot" name=butClose type=button value="关闭" onClick="parent.removeTab('<%=opCode%>');">
    </td>
  </tr>
</table>
<input type="hidden" id="in_ChanceId" name="in_ChanceId" value="<%=in_ChanceId%>"/> <!--wangzn 2010-5-12 14:35:34-->
<input type="hidden" id="WaNo" name="WaNo" value="<%=WaNo%>"/>
<input type="hidden" id="sm_code" name="sm_code" value="<%=sm_code%>"/>
<input type="hidden" id="op_code" name="op_code" value="<%=opCode%>"/>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<script type="text/javascript">
   $(document).ready(function () {
	     if("000000"!=<%=tmpRetCode%>){
	     	   $("#nextoper").attr("disabled",true);
       }
       $('#nextoper').click(function(){
		        form1.submit();
       });
   });
</script>
