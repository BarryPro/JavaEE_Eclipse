
<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: liangyl 2017/01/10 ������������°泬�Ϳ���������й����Ͷ���չʾ�����ⷴ��
   * ����: liangyl
   * ��Ȩ: si-tech
  */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");

		String offerId = request.getParameter("offerId");//ÿ���ύ��Ϊһ������ˮ hejwa and haoyy 2015��6��10��10:32:09
		String queryXspStr="select offer_id,offer_name from product_offer_relation a,product_offer b where a.relation_type_id in('4','6')  and a.offer_z_id =b.offer_id and a.optional_offer in('Y','T') and offer_a_id='"+offerId+"'";
		
		String retCode11 = "";
		String retMsg11 = "";
try{		
%>
	<wtc:pubselect name="sPubSelect" retcode="retCodeXsp" retmsg="retMsgXsp" outnum="2">
		<wtc:sql><%=queryXspStr%>
		</wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retarrXsp" scope="end" />
		var infoArray = new Array();

<%
			retCode11 = retCodeXsp;
			retMsg11 = retMsgXsp;
			if(retarrXsp.length>0){
				for(int i=0;i<retarrXsp.length;i++){
%>
					infoArray[<%=i%>]=new Array();
<%
					for(int j=0;j<retarrXsp[i].length;j++){
%>
						infoArray[<%=i%>][<%=j%>] = "<%=retarrXsp[i][j]%>";
<%
					}
				}
			}
			else{
				retCode11="111111";
				retMsg11="�޷�������";
			}
		
		}catch(Exception e){
			e.printStackTrace();
			retCode11 = "444444";
			retMsg11 = "����δ����������������ϵ����Ա��";
			%>
var infoArray = new Array();
<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCodeXsp","<%=retCode11 %>");
response.data.add("retMsgXsp","<%=retMsg11 %>");
response.data.add("retArray",infoArray);
core.ajax.receivePacket(response);
