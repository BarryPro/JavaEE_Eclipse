<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglma @ 20110419
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	System.out.println("=====================进入了selMealName.jsp===============");
    String regionCode = (String)session.getAttribute("regCode");
    String phonNoArr = request.getParameter("phonNoArr");
    String unitId = request.getParameter("unitId");
	String updateNoType = request.getParameter("updateNoType");
    String cust_id = request.getParameter("cust_id");
	String params_="";
	String outNum ="";
	String sql1 = "";
	String sql2 = "";
	if(updateNoType == "0"){
       	//当月套餐
       	  sql1 = " SELECT  c.offer_name ,e.name                                                                     "+
                " FROM dcustmsgadd a, suserfieldcode b, product_offer c, dcustmsg d ,dgrpmembermsg e ,region f,sregioncode h                                      "+
                "  WHERE a.field_code = '80003'                                                                           "+
                "  AND a.field_code = b.field_code                                                                        "+
                "  AND a.busi_type = b.busi_type                                                                          "+
                "  AND c.offer_id = a.field_value                                                            "+
                "  AND d.ID_NO = a.id_no                                                                                  "+    
                "  and a.id_no = e.id_no "+
                "  AND substr(d.BELONG_CODE, 1, 2) = h.region_code  and c.offer_id=f.offer_id and f.group_id=h.group_id                                                      "+
                "  and a.id_no = (select id_no from dgrpmembermsg where unit_id = "+unitId+" AND  short_phoneno = '"+phonNoArr+"')";
           sql2 = " SELECT  c.offer_name   ,e.name                                                                   "+
                " FROM dcustmsgadd a, suserfieldcode b, product_offer c, dcustmsg d  ,dgrpmembermsg e ,region f,sregioncode h                                    "+
                "  WHERE a.field_code = '80004'                                                                           "+
                "  AND a.field_code = b.field_code                                                                        "+
                "  AND a.busi_type = b.busi_type                                                                          "+
                "  AND c.offer_id = a.field_value                                                             "+
                "  AND d.ID_NO = a.id_no                                                                                  "+    
                "  and a.id_no = e.id_no "+
                "  AND substr(d.BELONG_CODE, 1, 2) = h.region_code    and c.offer_id=f.offer_id and f.group_id=h.group_id  "+
                "  and a.id_no = (select id_no from dgrpmembermsg where unit_id = "+unitId+" AND  short_phoneno = '"+phonNoArr+"')";
       }else{
          	sql1 = " SELECT  c.offer_name     ,e.name                                                                 "+
                " FROM dcustmsgadd a, suserfieldcode b, svpmnpkgcode c, dcustmsg d ,dgrpmembermsg e ,region f,sregioncode h                                      "+
                "  WHERE a.field_code = '80003'                                                                           "+
                "  AND a.field_code = b.field_code                                                                        "+
                "  AND a.busi_type = b.busi_type                                                                          "+
                "  AND c.offer_id = a.field_value                                                 "+
                "  AND d.ID_NO = a.id_no                                                                                  "+    
                "  and a.id_no = e.id_no "+
                "  AND substr(d.BELONG_CODE, 1, 2) = h.region_code   and c.offer_id=f.offer_id and f.group_id=h.group_id                  "+
                "  and d.phone_no = '"+phonNoArr+"'";
           sql2 = " SELECT  c.offer_name     ,e.name                                                                 "+
                " FROM dcustmsgadd a, suserfieldcode b, product_offer c, dcustmsg d  ,dgrpmembermsg e ,region f,sregioncode h                                     "+
                "  WHERE a.field_code = '80004'                                                                           "+
                "  AND a.field_code = b.field_code                                                                        "+
                "  AND a.busi_type = b.busi_type                                                                          "+
                "  AND c.offer_id = a.field_value                                                             "+
                "  AND d.ID_NO = a.id_no                                                                                  "+    
                "  and a.id_no = e.id_no "+
                "  AND substr(d.BELONG_CODE, 1, 2) = h.region_code   and c.offer_id=f.offer_id and f.group_id=h.group_id     "+
                "  and d.phone_no = '"+phonNoArr+"'";
       }
	   
    String sql3 = "  select c.feeindex_name from dgrpusermsg a,dgrpusermsgadd b,svpmnfeeindex c "+
                  "  where a.cust_id = '"+cust_id+"' "+
                  "   and a.sm_code = 'vp'          "+
                  "   and a.id_no = b.id_no         "+
                  "   and b.field_code = '10317'     "+
                  "   and b.field_value = c.feeindex "+
                  "   and c.region_code = '"+regionCode+"' ";
    System.out.println("======================gejing===============================    "+sql1);
	System.out.println("======================gejing===============================    "+sql2);
    String returnCode = "";
    String returnMsg = "";
    String flag = "";
    try{
        %>
         <wtc:pubselect name="sPubSelect"  retcode="retCode1" retmsg="retMsg1" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
  	       <wtc:sql><%=sql1%></wtc:sql>
         </wtc:pubselect>
        <wtc:array id="result1" scope="end" />
        	
        <wtc:pubselect name="sPubSelect"  retcode="retCode2" retmsg="retMsg2" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
  	       <wtc:sql><%=sql2%></wtc:sql>
         </wtc:pubselect>
        <wtc:array id="result2" scope="end" />
        	
        <wtc:pubselect name="sPubSelect"  retcode="retCode3" retmsg="retMsg3" routerKey="region" routerValue="<%=regionCode%>" outnum="1" >
  	    	 <wtc:sql><%=sql3%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="result3" scope="end" />
        <%
        returnCode = retCode2;
        returnMsg = retMsg2;
        if(result1.length > 0 && result2.length > 0){
           if("初始值".equals(result1[0][0])){
              if("初始值".equals(result2[0][0])){
                 flag = result3[0][0] +","+ result3[0][0] + "," +result1[0][1];
              }else{
              	 flag = result3[0][0] +","+ result2[0][0] + "," +result1[0][1];
              }
           }else{
           	  if("初始值".equals(result2[0][0])){
                 flag = result1[0][0] +","+ result3[0][0] + "," +result1[0][1];
              }else{
              	 flag = result1[0][0] +","+ result2[0][0] + "," +result1[0][1];
              }
           }
        }
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnCode = "+returnCode);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnMsg  = "+returnMsg);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> flag  = "+flag);
    }catch(Exception e){
        returnCode = "999999";
        returnMsg = "调用服务sCheckPhoneNo失败！";
        e.printStackTrace();
    }

%>
var response = new AJAXPacket();
var result1 = "<%=flag%>";
var returnCode = "<%=returnCode%>";
var returnMessage = "<%=returnMsg%>";

response.data.add("result",result1);
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMessage);
core.ajax.receivePacket(response);
