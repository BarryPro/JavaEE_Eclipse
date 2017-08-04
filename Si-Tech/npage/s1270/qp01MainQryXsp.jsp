
<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: liangyl 2017/01/10 齐齐哈尔关于新版超和卡办理过程中工单和短信展示的问题反馈
   * 作者: liangyl
   * 版权: si-tech
  */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");

		String offerId = request.getParameter("offerId");//每次提交都为一个新流水 hejwa and haoyy 2015年6月10日10:32:09
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
				retMsg11="无返回数据";
			}
		
		}catch(Exception e){
			e.printStackTrace();
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
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
