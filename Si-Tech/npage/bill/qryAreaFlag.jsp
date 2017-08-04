<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String errCode = "";
    String errMsg = "";  
    String sqlStr = "";
    String area_flag = "0";
  
	String orgCode = request.getParameter("orgCode");
	String modeCode = request.getParameter("modeCode");

    String sqlStr2 = "select count(*) from product_offer_attr where offer_attr_seq='60001' and offer_id=to_number('"+modeCode+"')";
    String [] paraIn = new String[2];
    paraIn[0] = sqlStr2;    
    paraIn[1]="region_code="+orgCode.substring(0,2)+",mode_code="+modeCode;
%>
    <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=orgCode.substring(0,2)%>" retcode="retCode" retmsg="retMsg" outnum="1" >
    	<wtc:param value="<%=sqlStr2%>"/>
    </wtc:service>
    <wtc:array id="modeTypeArr" scope="end"/>
<%
  System.out.println(sqlStr2);
  errCode = retCode;
  errMsg = retMsg;

    if(modeTypeArr!=null && modeTypeArr.length>0 && errCode.equals("000000"))
    {
        if(!modeTypeArr[0][0].equals("0"))
        {
            area_flag="1";
        }
    }
	
	String rpcPage = "qryAreaFlag";
	
%>

var rpcPage="<%=rpcPage%>";
var area_flag="<%=area_flag%>";

var response = new AJAXPacket();


response.data.add("rpc_page",rpcPage); 
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 
response.data.add("area_flag",area_flag);
core.ajax.receivePacket(response);

