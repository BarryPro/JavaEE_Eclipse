<%
/********************
 * version v2.0
 * 功能：获取用户信息 查询身份证号、办理地址、VIP级别、VIP卡号
 * 开发商: si-tech
 * update by huangrong @ 2011-3-31
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String errCode = "";
    String errMsg = "";  
    String errCode1 = "";
    String errMsg1 = "";     
    String id_iccid = "";
    String id_address = "";
    String card_name = "";
    String card_no = "";
    String cust_type="";
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
		String phoneNo = request.getParameter("phoneNo");
    String sqlStr2 = "select b.id_iccid,b.id_address,d.card_name,c.card_no from dcustmsg a, dcustdoc b,dbvipadm.dGrpBigUserMsg c, sBigCardCode d where a.cust_id=b.cust_id and a.phone_no=c.phone_no and substr(a.attr_code,3,2)=d.card_type and a.phone_no='"+phoneNo+"'";
%>
 	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="4" retcode="retCode" retmsg="retMsg">
   <wtc:sql><%=sqlStr2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultStr" scope="end"/>
	
<%
  System.out.println(sqlStr2);
  errCode = retCode;
  errMsg = retMsg;
  	System.out.println("===================================errCode============"+errCode);
  if(errCode.equals("000000"))
  { 	
  	if(resultStr!=null && resultStr.length>0)
  	{ 
  	  id_iccid=resultStr[0][0];
    	id_address=resultStr[0][1];
   	  card_name=resultStr[0][2];
    	card_no=resultStr[0][3];   	
    	cust_type="inner_vip";
  	}else
  		{
  		String sqlStr="select count(*) from dcustmsg where phone_no='"+phoneNo+"'";
%>  
  	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode1" retmsg="retMsg1">
   <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultStr1" scope="end"/>    		
<% 	
	  errCode1 = retCode1;
	  errMsg1 = retMsg1;
		if(errCode1.equals("000000"))
		{
			if(resultStr1!=null && resultStr1.length>0)
	  	{
	  	  if(resultStr1[0][0].equals("0"))
	  	  {
	  	    id_iccid="";
		    	id_address="";
		   	  card_name="";
		    	card_no=""; 
	  	  	cust_type="out";
	  	  }else
  	  	{
	  	    id_iccid="";
		    	id_address="";
		   	  card_name="";
		    	card_no="";   	  	
	  	  	cust_type="inner_notvip"  ;	  	
  	  	}
	  	}
		}

  		}
  }
%>

var id_iccid="<%=id_iccid%>";
var id_address="<%=id_address%>";
var card_name="<%=card_name%>";
var card_no="<%=card_no%>";
var cust_type="<%=cust_type%>";

var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 
response.data.add("id_iccid",id_iccid);
response.data.add("id_address",id_address);
response.data.add("card_name",card_name);
response.data.add("card_no",card_no);
response.data.add("cust_type",cust_type);
core.ajax.receivePacket(response);



