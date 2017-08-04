<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%
	String errorMsg = "";
	String errorCode = "0000";
	String regionCode = request.getParameter("regionCode");
	String opType = request.getParameter("opType"); 
	String typecode = request.getParameter("typecode");
	String sql = "";
	String townCodeStrs[]=null;
	String townNameStrs[]=null;
	String townMsgStrs[]=null;
	int dataCount = 0;
	int pageCount = 0;
	int pageSize = 900;
	List al = null;
	List pageList = null;
	int startRow,endRow;
	int i,j,k;
	if(opType == null || "".equals(opType))
	{
		errorCode = "1000";
		errorMsg = "获取操作类型代码错误！";
	}
	else if(!"a".equals(opType) && !"m".equals(opType) && !"d".equals(opType) )
	{
		errorCode = "1001";
		errorMsg = "获取操作类型代码错误["+opType+"]！";
	}
	else if(regionCode == null || "".equals(regionCode))
	{
		errorCode = "2000";
		errorMsg = "获取区域代码错误！";	
	}
	if(typecode == null || "".equals(typecode))
	{
		errorCode = "3000";
		errorMsg = "获取标志类型代码错误！";
	}
	else
	{
	
		System.out.println("-------------------opType-------------------"+opType);
	
		if( "a".equals(opType) )
		{
			sql = "select count(1) from product_offer a,  band c, region d, sregioncode e where offer_type = '10' and a.band_id = c.band_id and a.offer_id = d.offer_id and d.group_id = e.group_id and e.region_code = '"+regionCode+"'  and c.sm_code in  ('gn','zn','dn')    and not exists(select 1 from sfav1860cfgdisable b where a.offer_id  = to_number(b.mode_code) and  b.region_code = '"+regionCode+"'  )     and not exists(select 1 from sfav1860cfg b where a.offer_id  = to_number(b.mode_code) and b.region_code = '"+regionCode+"')";
 			System.out.println(sql);
		%>
		
	 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t4" scope="end"/>					
		<%
			if(result_t4 != null)
			{
				String dataCountStrs[][] = result_t4;
				dataCount = Integer.parseInt(dataCountStrs[0][0]);
				pageCount = dataCount / pageSize;
			}
			else
			{
				throw new Exception("调用查询服务失败");
			}
			//al初始化
			al = new ArrayList();
			for(i=0; i<= pageCount; i++)
			{ 
				startRow = i * pageSize;
				endRow = (i+1) * pageSize;
    		sql = "select mode_code, mode_name from ( "+
							" select rownum rowno, a.offer_id mode_code, a.offer_id ||'-->'|| a.offer_name mode_name from product_offer a, band c, region d, sregioncode e where offer_type = '10' and a.band_id = c.band_id and c.sm_code in  ('gn','zn','dn') "+
    					" and a.offer_id = d.offer_id and d.group_id = e.group_id and e.region_code = '"+regionCode+"' "+
    					" and not exists(select 1 from sfav1860cfgdisable b where a.offer_id  = to_number(b.mode_code) and  b.region_code = e.region_code  ) "+
							" and not exists(select 1 from sfav1860cfg b where a.offer_id  = to_number(b.mode_code) and b.region_code = e.region_code)            "+
    					" order by a.offer_id) "+
    					" where  rowno >="+startRow+" and rowno < "+endRow; 
				pageList = null;
				%>
	 	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t3" scope="end"/>				
				<%
				if(result_t3!= null)
				{
					String pageData[][] = result_t3;
					for(k=0; k< pageData.length; k++)
					{
						String tmp[] = new String[2];
						tmp[0]=pageData[k][0];
						tmp[1]=pageData[k][1];
						al.add(tmp);
					}
				}
			}  
			townCodeStrs = new String[al.size()];
			townNameStrs = new String[al.size()];
			for(i = 0; i < al.size(); i++)
			{
				String tmp[] = (String [])al.get(i);
				townCodeStrs[i] = tmp[0];
				townNameStrs[i] = tmp[1];
			}
		}
		else
		{
		 
			sql ="select count(1) from sfav1860cfg a, product_offer c, band d"+
					 " where  to_number(a.mode_code)= c.offer_id and c.offer_type = '10' and c.band_id = d.band_id and d.sm_code in ('gn','zn','dn') "+
					 " and a.region_code =  '"+regionCode+"'"+
					 " and not exists(select 1 from sfav1860cfgdisable b where a.mode_code = b.mode_code and a.region_code = b.region_code)";
					 
			System.out.println(sql);		 
			%>
			
 		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t1" scope="end"/>					
			<%
			if(result_t1 != null)
			{
				String dataCountStrs[][] = result_t1;
				dataCount = Integer.parseInt(dataCountStrs[0][0]);
				pageCount = dataCount / pageSize;
			}
			else
			{
				throw new Exception("调用查询服务失败");
			}
			//al初始化
			al = new ArrayList();
			for(i=0; i<= pageCount; i++)
			{
				startRow = i * pageSize;
				endRow = (i+1) * pageSize;
				sql = "select mode_code,mode_name from (select rownum rowno,a.mode_code mode_code,a.mode_code||'-->'||c.offer_name mode_name from sfav1860cfg a,product_offer c, band d where c.offer_type = '10' "+
							"and c.band_id = d.band_id and  d.sm_code in ('gn','zn','dn') and to_number(a.mode_code) = c.offer_id and a.region_code='"+regionCode+"' "+
							"and not exists(select 1 from sfav1860cfgdisable b where a.mode_code = b.mode_code and a.region_code = b.region_code) "+
							"order by a.mode_code) where rowno >="+startRow+" and rowno < "+endRow;		 
				System.out.println(sql);		
				%>
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t" scope="end"/>				
				<%
				if(result_t!= null)
				{
					String pageData[][] = result_t;
					for(k=0; k< pageData.length; k++)
					{
						String tmp[] = new String[2];
						tmp[0]=pageData[k][0];
						tmp[1]=pageData[k][1];
						al.add(tmp);
					}
				}
			}  
			townCodeStrs = new String[al.size()];
			townNameStrs = new String[al.size()];
			for(i = 0; i < al.size(); i++)
			{
				String tmp[] = (String [])al.get(i);
				townCodeStrs[i] = tmp[0];
				townNameStrs[i] = tmp[1];
			}
		}
	}
%>
var response = new AJAXPacket();
response.data.add("errorMsg","<%=errorMsg%>");
response.data.add("errorCode","<%=errorCode%>");
response.data.add("typecode","<%=typecode%>");
<%
if("0000".equals(errorCode))
{
	if( "getModeList".equals(typecode) )
	{
%>
		var values = Array();
		var names = Array();
<%
		for(i=0; i< townCodeStrs.length ;i++)
		{
%>
			values[<%=i%>] = "<%=townCodeStrs[i]%>";
			names[<%=i%>] = "<%=townNameStrs[i]%>";
<%
		}
%>
		response.data.add("values",values);
		response.data.add("names",names);
<%
	}
	else if( "getTownMsg".equals(typecode) )
	{
%>
		var values = Array();
<%		
		for(i=0; i< townMsgStrs.length; i++)
		{
%>
			values[<%=i%>] = "<%=townMsgStrs[i]%>";
<%
		}
%>
		response.data.add("values",values);
<%
	}
}	
%>
core.ajax.receivePacket(response);

