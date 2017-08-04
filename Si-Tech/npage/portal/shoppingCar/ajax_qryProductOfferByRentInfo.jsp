<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String sale_mode = WtcUtil.repNull(request.getParameter("sale_mode"));//Ä£°åID
    String login_no =(String) session.getAttribute("workNo");//¹¤ºÅ
  String sql = "select b.OFFER_CODE,b.OFFER_NAME,b.OFFER_COMMENTS,d.BAND_name,b.EXP_DATE_OFFSET,b.EXP_DATE_OFFSET_UNIT,b.OFFER_TYPE from sChnResSaleBillMode a,PRODUCT_OFFER b, REGION c,band d where b.band_id = d.band_id and a.mode_code = RPAD(to_char(b.OFFER_ID), 8, ' ') and a.sale_mode = '"+sale_mode+"' and c.RIGHT_LIMIT >= (select a.power_right from dloginmsg a, sregioncode b where a.login_no = '"+login_no+"' and b.region_code = substr(a.org_code, 1, 2)) and b.OFFER_TYPE != 40 and b.OFFER_ID = c.OFFER_ID and c.GROUP_ID in (select a.parent_group_id from dChnGroupinfo a, dloginmsg b where a.group_id = b.group_id and b.login_no = '"+login_no+"')";
  String strArray="var retResult; ";  //must
  String[][] offerInfoShow=null;
%>

	<wtc:pubselect  name="sPubSelect"  outnum="7">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="rows" scope="end"/>
<%
	 if(retCode.equals("000000"))
	{
		strArray = WtcUtil.createArray("retResult",rows.length);	
		%>
		<%=strArray%>
		<%
		 for(int i=0;i<rows.length;i++)
		 {
		 		for(int j=0;j<rows[i].length;j++){
			    String temp = rows[i][j];
			    System.out.println("######################################rows["+i+"]["+j+"]=="+temp);
						if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}
					%>
					retResult[<%=i%>][<%=j%>] = "<%=temp.trim()%>";			
	<%		
			}
		}	
	}else{
		%>
		retResult=null;
		<%
		}
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);