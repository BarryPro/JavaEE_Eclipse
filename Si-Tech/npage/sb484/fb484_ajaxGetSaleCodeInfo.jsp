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
	String brandCode = WtcUtil.repStr(request.getParameter("brandCode"), "");
	String phoneType = WtcUtil.repStr(request.getParameter("phoneType"), "");
	
	System.out.println("===========wanghfa========= regionCode = " + regionCode);
	System.out.println("===========wanghfa========= saleType = " + saleType);
	System.out.println("===========wanghfa========= brandCode = " + brandCode);
	System.out.println("===========wanghfa========= phoneType = " + phoneType);
	
	//Ӫ������
	String sqlsaleType = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code='" + regionCode + "' and a.sale_type='" + saleType + "' and a.valid_flag='Y'";
	String[] inParamC = new String[2];
	inParamC[0] = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code=:region_code and a.sale_type='" + saleType + "' and a.valid_flag='Y'";
	inParamC[1] = "region_code=" + regionCode;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeSc" retmsg="retMsgSc" outnum="4">
	<wtc:param value="<%=inParamC[0]%>"/>
	<wtc:param value="<%=inParamC[1]%>"/>
	</wtc:service>
	<wtc:array id="resultSc"  scope="end"/>
<%
	System.out.println("===========wanghfa========= retCodeSc = " + retCodeSc);
	System.out.println("===========wanghfa========= retMsgSc = " + retMsgSc);
	if ("000000".equals(retCodeSc) && resultSc.length != 0) {
%>
		<option value = "0">--��ѡ��--</option>
<%
		for (int i = 0; i < resultSc.length; i ++) {
			System.out.println("===========wanghfa========= saleCode saleCode = " + resultSc[i][0]);
			System.out.println("===========wanghfa========= saleCode saleName = " + resultSc[i][1]);
			System.out.println("===========wanghfa========= saleCode phoneBrand = " + resultSc[i][2]);
			System.out.println("===========wanghfa========= saleCode phoneType = " + resultSc[i][3]);
			if (brandCode.equals(resultSc[i][2]) && phoneType.equals(resultSc[i][3])) {
%>
				<option value="<%=resultSc[i][0]%>" brandCode="<%=resultSc[i][2]%> phoneType="<%=resultSc[i][3]%>"><%=resultSc[i][1]%></option>
<%
			}
		}
	} else if ("000000".equals(retCodeSc) && resultSc.length == 0) {
		System.out.println("===========wanghfa========= resultSc ������");
%>
		<option value = "0">��ѯTD�̻�Ӫ����ϸ������</option>
		<script language="javascript">
			rdShowMessageDialog("��ѯTD�̻�Ӫ����ϸ������");
		</script>
<%
	} else {
%>
		<option value = "0">��ѯTD�̻��ͺ���Ϣ����</option>
		<script language="javascript">
			rdShowMessageDialog("��ѯӪ��������Ϣ����retCode=<%=retCodeSc%>��retMsg=<%=retMsgSc%>");
		</script>
<%
	}
%>

