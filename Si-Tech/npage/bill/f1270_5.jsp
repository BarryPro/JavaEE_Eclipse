<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%/*
*��ҳ�����ڶ�RPC�������÷��񣬲����ؽ����
*/%>
<%
	String subi20 = request.getParameter("subi20");
	String sm = request.getParameter("sm");
	System.out.println("sm==========="+sm);
	//String sqlStr ="select MODE_TYPE,MODE_TYPE||'-->'||TYPE_NAME from sBillModeType where REGION_CODE = '"+subi20+"' and sm_code = '"+sm+"' and MODE_FLAG='0'";
	String sqlStr = "SELECT distinct a.offer_attr_type, a.offer_attr_type || '-->' || NAME FROM product_offer a, offer_category b, band c WHERE a.offer_attr_type = b.offer_attr_type and a.band_id = c.band_id and c.sm_code ='"+sm+"'";
%>
		<wtc:pubselect name="sPubSelect" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="tri_metaData" scope="end" />
<%
		int xDimension = tri_metaData.length;
		String tri_metaDataStr = "var js_tri_metaDataStr = new Array(";
        int flag = 1;
        for(int i = 0; i < xDimension; i++)
        {
            if(flag == 1)
            {
                tri_metaDataStr = tri_metaDataStr + "new Array()";
                flag = 0;
                continue;
            }
            if(flag == 0)
            {
                tri_metaDataStr = tri_metaDataStr + ",new Array()";
            }
        }

        tri_metaDataStr = tri_metaDataStr + ");";
%>
<%=tri_metaDataStr%>
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {
%>
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
%>
var response = new AJAXPacket();
response.data.add("rpc_page","chg_city");
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);



