<%
   /*
   * ����: ����������������
�� * �汾: v1.0
�� * ����: 2007/06/20
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opName = "����ƷĿ¼��";
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));               //��½����
		
	String ProdType=WtcUtil.repNull(request.getParameter("ProdType"));//��Ʒ����
	String sm_code=WtcUtil.repNull(request.getParameter("sm_code"));//Ʒ��
	String prod_direct="";//ҵ������
	String biz_code="";//ҵ�����
	System.out.println("ProdType=="+ ProdType);
	System.out.println("sm_code=="+ sm_code);
	System.out.println("prod_direct=="+ prod_direct);
	System.out.println("biz_code=="+ biz_code);
	
	String grouptype = request.getParameter("grouptype")==null?"frm":request.getParameter("grouptype"); 
	
	String dataJsp = "bizModeXml.jsp?isRoot=true&ProdType="+ProdType+"&sm_code="+sm_code+"&prod_direct="+prod_direct+"&biz_code="+biz_code;
	String workNo = loginNo;	
	String workName = loginName;
	String op_name = "����ƷĿ¼��";
  
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #003399 }
font { font-family: ����; font-size: 13px; }
</style>
<script language="JavaScript"> 
//-----������֯�ڵ�-------	
function saveTo(product_code,product_name,catalog_item_id)
{
	window.opener.frm.motive_code.value=product_code;     //����Ϣ���ص����õ�ҳ��ȥ
	window.opener.frm.motive_name.value=product_name;
	window.opener.frm.motive_info.value=product_code+"-"+product_name;
	window.opener.frm.motive_code.readOnly=true;     //����Ϣ���ص����õ�ҳ��ȥ
	window.opener.frm.catalog_item_id.value = catalog_item_id;
    window.opener.oporSubProd(product_code); 
  
        /*
		var packet = new AJAXPacket("newGrpTreeSave.jsp","���Ժ�...");
		packet.data.add("offer_id" ,product_code);
		packet.data.add("offer_name" ,product_name);
		packet.data.add("parent_offer_id" ,catalog_item_id);
		core.ajax.sendPacket(packet,doSaveTo,true);
		packet =null;
		*/
}
//-----������֯�ڵ�-------
function doSaveTo(packet)
{
	  var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg"); 
	  var product_code = packet.data.findValueByName("offer_id");
	  var product_name = packet.data.findValueByName("offer_name");
	  var biz_code = packet.data.findValueByName("biz_code");
	  var biz_name = packet.data.findValueByName("biz_name");
	  var catalog_item_id = packet.data.findValueByName("catalog_item_id");
	  
	 if(retCode=="000000"){
		if(typeof(window.parent.window.document.all.prodprc_id) != 'undefined'){
	 			window.parent.window.document.all.prodprc_id.value = product_code;  // ������ʱ���
	 			window.parent.window.document.all.prodprc_name.value = product_name;  // ������ʱ���
	 			window.parent.window.document.all.biz_code.value = biz_code;                    // ������ʱ���
	 			window.parent.window.document.all.biz_name.value = biz_name;                    // ������ʱ���
	 			
	 			window.parent.window.document.all("callthefunc").click();                          // ������ʱ���
		 }else {
	 			window.opener.frm.F00017.value=product_code+"|"+product_name;
				window.opener.frm.bizCode.value=biz_code;
				window.opener.frm.biz_code.value=biz_code;
				window.opener.frm.F00018.value=biz_name;
				window.opener.frm.catalog_item_id.value=catalog_item_id;
				window.opener.frm.product_code.value=product_code+"|"+product_name;     //����Ϣ���ص����õ�ҳ��ȥ  
				window.opener.frm.product_name.value=product_name;                      //����Ϣ���ص����õ�ҳ��ȥ  
				<% if(sm_code.equals("AD") || sm_code.equals("ML") || sm_code.equals("MA")){ %>
				 window.opener.getBillingType(biz_code);
				<%}%>
	 		}
	 			
				
				window.close();
	 }else{
	 	 rdShowMessageDialog("����"+retMsg);
	} 
}

</SCRIPT>
</head>
<body>
<form name="frm" method="post" action="">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">����ƷĿ¼��</div>
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
</div>
</form>
</body>
</html>