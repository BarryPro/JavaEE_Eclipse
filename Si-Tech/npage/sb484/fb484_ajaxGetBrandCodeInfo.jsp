<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-9-6 TD�̻����¹���
     *
     ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = WtcUtil.repStr(request.getParameter("regionCode"), "");
	String saleType = WtcUtil.repStr(request.getParameter("saleType"), "");
	
	System.out.println("===========wanghfa========= regionCode = " + regionCode);
	System.out.println("===========wanghfa========= saleType = " + saleType);
	
	String sqlBrandCode = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='" + saleType + "' and a.brand_code=b.brand_code and a.valid_flag='Y'";
	String[] inParamBc = new String[2];
	inParamBc[0] = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code=:region_code and a.sale_type='" + saleType + "' and a.brand_code=b.brand_code and a.valid_flag='Y'";
	inParamBc[1] = "region_code="+regionCode;
	System.out.println("===========wanghfa=========== inParamBc = " + sqlBrandCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeBc" retmsg="retMsgBc" outnum="2">
		<wtc:param value="<%=inParamBc[0]%>"/>
	<wtc:param value="<%=inParamBc[1]%>"/>
	</wtc:service>
	<wtc:array id="resultBc"  scope="end"/>
<%
	System.out.println("===========wanghfa========= retCodeBc = " + retCodeBc);
	System.out.println("===========wanghfa========= retMsgBc = " + retMsgBc);
	if ("000000".equals(retCodeBc) && resultBc.length != 0) {
%>
		<option value = "0">--��ѡ��--</option>
<%
		for (int i = 0; i < resultBc.length; i ++) {
			System.out.println("===========wanghfa========= resultBc brandCode = " + resultBc[i][0]);
			System.out.println("===========wanghfa========= resultBc brandName = " + resultBc[i][1]);
%>
			<option value = "<%=resultBc[i][0]%>"><%=resultBc[i][1]%></option>
<%
		}
	} else if ("000000".equals(retCodeBc) && resultBc.length == 0) {
		System.out.println("===========wanghfa========= resultBc ������");
%>
		<option value = "0">��ѯTD�̻�Ʒ��������</option>
		<script language="javascript">
			rdShowMessageDialog("��ѯTD�̻�Ʒ��������");
		</script>
<%
	} else {
%>
		<option value = "0">��ѯTD�̻�Ʒ����Ϣ����</option>
		<script language="javascript">
			rdShowMessageDialog("��ѯƷ����Ϣ����retCode=<%=retCodeBc%>��retMsg=<%=retMsgBc%>");
		</script>
<%
	}
%>

