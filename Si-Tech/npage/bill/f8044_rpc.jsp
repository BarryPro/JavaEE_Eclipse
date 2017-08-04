<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-09
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%
	String errorMsg = "";
	String errorCode = "0000";
	String regionCode = request.getParameter("regionCode");
	String typecode = request.getParameter("typecode");
	String saleCode=request.getParameter("saleCode");
	String brandCode=request.getParameter("brandCode");
	String typeCode=request.getParameter("typeCode");
	String townCodeStrs[]=null;
	String townNameStrs[]=null;
	String townMsgStrs[]=null;
	String modeMsgStrs[]=null;
	String sql = "";
	String [] paraIn = new String[2];
	//comImpl co=new comImpl();	
	if(typecode == null || "".equals(typecode))
	{
		errorCode = "1000";
		errorMsg = "获取类型代码为空！";
		
	}
	else if(regionCode == null || "".equals(regionCode))
	{
		errorCode = "2000";
		errorMsg = "区域代码为空！";
		
	}
	else
	{
		if( "getSaleCode".equals(typecode) )
		{
			System.out.println("1------brandCode="+brandCode+"2------typeCode="+typeCode+"3-------------regionCode="+regionCode+"4--------saleCode"+saleCode);
			sql = "select unique a.sale_code,trim(a.sale_name) from sPhoneSalCfg a where a.region_code=:regionCode "+
			" and a.sale_type='11' and valid_flag='Y' and a.spec_type like 'P%' and brand_code=:brandCode and type_code=:typeCode";
			System.out.println("ssssssssssssssss="+sql);
			
			paraIn[0] = sql;    
            paraIn[1]="regionCode="+regionCode+",brandCode="+brandCode+",typeCode="+typeCode;

			
			//List al = null;
			//al = co.spubqry32("2",sql);
			%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="townCodeData" scope="end"/>
            <%
			
			if(townCodeData.length>0 && retCode.equals("000000"))
			{
				//String townCodeData[][] = (String[][])al.get(0);
				townCodeStrs = new String[townCodeData.length];
				townNameStrs = new String[townCodeData.length];                                
				for(int i=0; i< townCodeData.length; i++)
				{
					townCodeStrs[i] = townCodeData[i][0];
					townNameStrs[i] = townCodeData[i][1];
				}
			}       
			else
			{
				errorCode = "4000";
				errorMsg = "数据错误！";
			}
		}
		else if( "getSaleDet".equals(typecode) )
		{
			if(saleCode == null || "".equals(saleCode))
			{
				errorCode = "5000";
				errorMsg = "营销案代码为空！";
			}
			else
			{
				sql = "select prepay_gift,base_fee,CONSUME_TERM,MON_BASE_FEE,sale_price,sale_code,case when base_fee = -1 then to_char(sale_price-prepay_gift) else to_char(sale_price-prepay_gift-base_fee) end,market_price "+
				   " from sPhoneSalCfg  where region_code=:regionCode and sale_type='11' and valid_flag='Y' and spec_type like 'P%' and sale_code=:saleCode";
				
				
				paraIn[0] = sql;    
                paraIn[1]="regionCode="+regionCode+",saleCode="+saleCode;
            
				//List all = null;
				//all = co.spubqry32("8",sql);
				//System.out.println("mylog:"+sql);
								//System.out.println("mylog:"+paraIn[1]);

				%>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="8" >
                	<wtc:param value="<%=paraIn[0]%>"/>
                	<wtc:param value="<%=paraIn[1]%>"/> 
                </wtc:service>
                <wtc:array id="townCodeMsg" scope="end"/>
                <%
				if(townCodeMsg.length>0 && retCode2.equals("000000"))
				{
					//String townCodeMsg[][] = (String[][])all.get(0);
					if(townCodeMsg.length == 1)
					{
						townMsgStrs = new String[townCodeMsg[0].length];
						for(int i=0; i< townCodeMsg[0].length; i++)
						{
							townMsgStrs[i] = townCodeMsg[0][i];
						}
					}
					else
					{
						errorCode = "4002";
						errorMsg = "无法获取代码详细数据！";
					}	
				}
				else
				{
					errorCode = "4001";
					errorMsg = "数据错误！";
				}
				/**************************/
			//sql="select a.mode_code from dChnResSalePlanModeRel a , sPhoneSalCfg b,sbillmodecode c where a.sale_code=b.sale_code and b.region_code=:regionCode and b.sale_type='11'  and valid_flag='Y' and spec_type like 'P%' and b.region_code=c.region_code and a.mode_code=c.mode_code and a.sale_code=:saleCode";
				sql="select a.mode_code from dChnResSalePlanModeRel a , sPhoneSalCfg b,product_offer c where a.sale_code=b.sale_code and b.region_code=:regionCode and b.sale_type='11'  and valid_flag='Y' and spec_type like 'P%'  and a.mode_code=to_char(c.offer_id) and a.sale_code=:saleCode";
				
				paraIn[0] = sql;    
                paraIn[1]="regionCode="+regionCode+",saleCode="+saleCode;
				
				//List allmode = null;
				//allmode = co.spubqry32("1",sql);
				System.out.println("mylog sql:"+sql);
				System.out.println("mylog canshu: "+paraIn[0]);
				System.out.println("mylog canshu: "+paraIn[1]);
				%>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="1" >
                	<wtc:param value="<%=paraIn[0]%>"/>
                	<wtc:param value="<%=paraIn[1]%>"/> 
                </wtc:service>
                <wtc:array id="modeCodeMsg" scope="end"/>
                <%
				
				if(modeCodeMsg.length>0 && retCode3.equals("000000"))
				{
					//String modeCodeMsg[][] = (String[][])allmode.get(0);
					System.out.println("modeCodeMsg.length="+modeCodeMsg.length);
					if(modeCodeMsg.length >0)
					{
						modeMsgStrs = new String[modeCodeMsg.length];
						for(int i=0; i< modeCodeMsg.length; i++)
						{
							modeMsgStrs[i] = modeCodeMsg[i][0];
						}
					}
					else
					{
						errorCode = "4003";
						errorMsg = "无法获取代码详细数据！";
					}	
				}
				else
				{
					errorCode = "400100";
					errorMsg = "数据错误！";
				}
			}
		}
	}
%>

var response = new AJAXPacket();

response.data.add("errorMsg","<%=errorMsg%>");
response.data.add("errorCode","<%=errorCode%>");
response.data.add("retType","<%=typecode%>");
<%
if("0000".equals(errorCode))
{
	if( "getSaleCode".equals(typecode) )
	{
%>
		var values = Array();
		var names = Array();
<%
		for(int i=0; i< townCodeStrs.length ;i++)
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
	else if( "getSaleDet".equals(typecode) )
	{
%>
		var values = Array();
<%		
		for(int i=0; i< townMsgStrs.length; i++)
		{
		
		  //System.out.println("mylog "+i+"   "+townMsgStrs[i]);
		  
%>
			values[<%=i%>] = "<%=townMsgStrs[i]%>";
<%
		}
%>
		var modevalues = Array();
<%		
		for(int i=0; i< modeMsgStrs.length; i++)
		{
%>
			modevalues[<%=i%>] = "<%=modeMsgStrs[i]%>";
<%
		}
%>
		response.data.add("values",values);
		response.data.add("modevalues",modevalues);
<%
	}
}	
%>
core.ajax.receivePacket(response);

