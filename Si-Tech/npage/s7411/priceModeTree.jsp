<%
   /*
   * 功能: 服务类型属性树。
　 * 版本: v1.0
　 * 日期: 2009/10/23
　 * 作者: chendx
　 * 版权: sitech
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));               //登陆密码
		
	String catalog_item_id=WtcUtil.repNull(request.getParameter("catalog_item_id"));
	String sm_code=WtcUtil.repNull(request.getParameter("sm_code"));
	String motive_type=WtcUtil.repNull(request.getParameter("motive_type"));
	
	String grouptype = request.getParameter("grouptype")==null?"frm":request.getParameter("grouptype"); 
	
	String dataJsp = "priceModeXml.jsp?isRoot=true&catalog_item_id="+catalog_item_id+"&sm_code="+sm_code+"&motive_type="+motive_type;
	String workNo = loginNo;	
	String workName = loginName;
	String op_name = "产品业务包资费树";
    String opName = op_name;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #003399 }
font { font-family: 宋体; font-size: 13px; }
</style>
<script language="JavaScript"> 
//-----返回组织节点-------	
function saveTo(offer_id,offer_name,eff_date,exp_date)
{	
		/*var packet = new AJAXPacket("f7411_getMotiveCode.jsp","请稍后...");
		packet.data.add("element_id" ,product_code);
		core.ajax.sendPacket(packet,doSaveTo,true);
		packet =null;*/
		window.opener.frm.offer_id.value=offer_id;		//将信息返回到调用的页面去
		window.opener.frm.offer_name.value=offer_name;
		window.opener.frm.eff_date.value=eff_date;
		window.opener.frm.exp_date.value=exp_date;
		window.opener.frm.sure.disabled=false;
		window.opener.frm.btnQry.disabled=true;
		var return_value = "";
		window.close();    
		
}
</SCRIPT>
</head>
<body>
<form name="fPubSimpSel" method="post" action="">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">产品业务包资费树</div>
</div>    
<table cellspacing="0" >
    <tr>
        <td height="600" valign="top" nowrap>
            <script>loader();</script>
            <div id="xtree"  XmlSrc="<%=dataJsp%>"></div>
            <script language="JavaScript">
                <!--
                    document.all.xtree.className="xtree";
                //-->
            </script>
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</div>
</body>
</html>