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
	
	System.out.println("===========wanghfa========= regionCode = " + regionCode);
	System.out.println("===========wanghfa========= saleType = " + saleType);
	System.out.println("===========wanghfa========= brandCode = " + brandCode);
	
	//�ֻ�����
	String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='" + saleType + "' and a.valid_flag='Y'";
	String[] inParamPt = new String[2];
	inParamPt[0] = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='" + saleType + "'and a.valid_flag='Y'";
	inParamPt[1] = "region_code=" + regionCode;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodePt" retmsg="retMsgPt" outnum="3">
	<wtc:param value="<%=inParamPt[0]%>"/>
	<wtc:param value="<%=inParamPt[1]%>"/>
	</wtc:service>
	<wtc:array id="resultPt"  scope="end"/>
<%
	System.out.println("===========wanghfa========= retCodePt = " + retCodePt);
	System.out.println("===========wanghfa========= retMsgPt = " + retMsgPt);
	if ("000000".equals(retCodePt) && resultPt.length != 0) {
%>
		<option value = "0">--��ѡ��--</option>
<%
		for (int i = 0; i < resultPt.length; i ++) {
			System.out.println("===========wanghfa========= phoneType phoneType = " + resultPt[i][0]);
			System.out.println("===========wanghfa========= phoneType phoneName = " + resultPt[i][1]);
			System.out.println("===========wanghfa========= phoneType phoneCode = " + resultPt[i][2]);
			if (brandCode.equals(resultPt[i][2])) {
%>
				<option value = "<%=resultPt[i][0]%>"><%=resultPt[i][1]%></option>
<%
			}
		}
	} else if ("000000".equals(retCodePt) && resultPt.length == 0) {
		System.out.println("===========wanghfa========= phoneType ������");
%>
		<option value = "0">��ѯTD�̻��ͺ�������</option>
		<script language="javascript">
			rdShowMessageDialog("��ѯTD�̻��ͺ�������");
		</script>
<%
	} else {
%>
		<option value = "0">��ѯTD�̻��ͺ���Ϣ����</option>
		<script language="javascript">
			rdShowMessageDialog("��ѯTD�̻��ͺ���Ϣ����retCode=<%=retCodePt%>��retMsg=<%=retMsgPt%>");
		</script>
<%
	}
%>

