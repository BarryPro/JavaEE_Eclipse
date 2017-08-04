<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String catalog_item_id = WtcUtil.repNull(request.getParameter("catalog_item_id"));//目标节点标识
	String login_no = (String) session.getAttribute("workNo");//工号
	String flag="N";//是否省级工号
	String channelSegment=WtcUtil.repNull(request.getParameter("channelSegment"));//渠道类型标识
	String strArray="var arrMsg;";  

System.out.println("---------------------------login_no---------------------------"+login_no);
System.out.println("---------------------------flag-------------------------------"+flag);
System.out.println("---------------------------catalog_item_id--------------------"+catalog_item_id);
System.out.println("---------------------------channelSegment---------------------"+channelSegment);
%>
<%String regionCode_sGOfferByCat = (String)session.getAttribute("regCode");%>
<wtc:utype name="sGOfferByCat" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode_sGOfferByCat%>">
	<wtc:uparams name="TOptrMsg" iMaxOccurs="1">
		<wtc:uparam value="<%=login_no%>" type="STRING"/>   
		<wtc:uparam value="<%=flag%>" type="STRING"/>   
		<wtc:uparam value="<%=catalog_item_id%>" type="LONG"/>   
		<wtc:uparam value="<%=channelSegment%>" type="STRING"/>   
	</wtc:uparams>
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
	 System.out.println("# return from sGOfferByCat -> "+retCode+ " | " +retMsg);
	 String location = "";
	  if(retCode.equals("0"))
	{

		 int retValNum = retVal.getUtype("2").getSize();
		 System.out.println("retValNum="+retValNum); 
	   strArray = WtcUtil.createArray("arrMsg",retValNum);
		%>
		<%=strArray%>
		<%
		 for(int i=0;i<retValNum;i++)
		 {
			location = "2."+i;
			int n = 0;
			for(int j=0;j<32;j++)
			{
			  String temp1 = retVal.getUtype(location).getValue(j);
				temp1=temp1.replaceAll(",","；");
				System.out.println("temp1======"+temp1);
				if(j==0||j==2||j==3||j==16||j==17||j==20||j==31)
				{
					String temp = retVal.getUtype(location).getValue(j);
					temp=temp.replaceAll(",","；");
					//System.out.println("temp======"+temp);
					if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}

	%>
	        
					arrMsg[<%=i%>][<%=n%>] = "<%=temp.trim().replaceAll("\\n"," ")%>";
	<%
					n++;
				}
			}
	%>			
	<%		
		}	
	}else{
		%>
		arrMsg=null;
		<%
		retMsg = "操作失败，请联系管理员";
		}
%>


var response = new AJAXPacket();
response.data.add("catalog_item_id","<%= catalog_item_id %>");
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%= retMsg %>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);
