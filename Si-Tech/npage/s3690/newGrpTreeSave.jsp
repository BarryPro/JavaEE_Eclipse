<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

var retarr=new Array();
<%
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String offer_id = request.getParameter("offer_id");
    String offer_name = request.getParameter("offer_name");
    String parent_offer_id = request.getParameter("parent_offer_id");
    String biz_code="";
    String biz_name="";
    String catalog_item_id=parent_offer_id;
    
    String sqlStr ="SELECT catalog_item_id,catalog_item_type,catalog_item_name,catalog_item_desc,band_id,parent_catalog_item_id,leaf_flag "+
                   " FROM catalog_item b WHERE catalog_item_type='W'  START WITH b.catalog_item_id=:parent_offer_id  CONNECT BY PRIOR parent_catalog_item_id=catalog_item_id"; 
    String paraIn = "parent_offer_id="+parent_offer_id;



	  %>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeX" retmsg="retMsgX" outnum="7" >
				<wtc:param value="<%=sqlStr%>"/>
				<wtc:param value="<%=paraIn%>"/> 
			</wtc:service>
			<wtc:array id="retarr" scope="end"/>
	  <%
        if(retarr.length>0 && retCodeX.equals("000000")){                
              for(int i=0;i<7;i++){
                 System.out.println("====|owner_type|===="+retarr[0][i]);
              }
              //catalog_item_id=retarr[0][0];
              biz_code=retarr[0][3];
              biz_name=retarr[0][2];
          }

%>

var response = new AJAXPacket();
retCode = "<%=retCodeX%>";
retMessage = "<%=retMsgX%>";
offer_id ="<%=offer_id%>";
offer_name = "<%=offer_name%>";
biz_code="<%=biz_code%>";
biz_name="<%=biz_name%>";
catalog_item_id="<%=catalog_item_id%>";
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("offer_id",offer_id);
response.data.add("offer_name",offer_name);
response.data.add("biz_code",biz_code);
response.data.add("biz_name",biz_name);
response.data.add("catalog_item_id",catalog_item_id);
core.ajax.receivePacket(response);







