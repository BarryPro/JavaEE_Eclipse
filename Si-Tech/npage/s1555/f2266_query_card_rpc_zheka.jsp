<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.lang.*"%>

<%	
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>

<%!
Logger logger = Logger.getLogger("f2266_query_card_rpc.jsp");
%>
<%
	String res_group_id = (String)session.getAttribute("groupId");
	
	String begin_no = request.getParameter("begin_no");
	String end_no = request.getParameter("end_no");
	long cha = 0;
	String chasqls="select Trim("+end_no.trim()+")-Trim("+begin_no.trim()+") from dual";	
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=chasqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="alsss" scope="end"/> 
<%
cha =Long.parseLong(alsss[0][0]);

	String card_num = request.getParameter("card_num");
	String card_type = request.getParameter("card_type");
	String rpc_page = request.getParameter("rpc_page");
	logger.error("rpc_page = "+rpc_page);
	boolean query_result = false;
	String card_type_name = "";
	String card_value = "";
	String errorMsg = "";
	
	//comImpl com1=new comImpl();
	//List list = null;

	StringBuffer sqlbuf = new StringBuffer();
		sqlbuf.append(" select DISTINCT in_table from dchnfilerec where ")
			  .append(" LENGTH(BEGIN_NO) = LENGTH('")
			  .append(begin_no)
			  .append("') ")
			  .append(" AND ((TO_NUMBER(BEGIN_NO) <= TO_NUMBER('")
			  .append(begin_no)
			  .append("') and ")
			  .append(" TO_NUMBER(END_NO) >= TO_NUMBER('")
			  .append(end_no)
			  .append("')) or ")
			  .append(" (TO_NUMBER(BEGIN_NO) <= TO_NUMBER('")
			  .append(end_no)
			  .append("') and ")
			  .append(" TO_NUMBER(END_NO) >= TO_NUMBER('")
			  .append(begin_no)
			  .append("')))");
	/*sqlbuf.append(" select in_table from dchnfilerec where ")
			.append(" begin_no <= to_number('")
			.append(begin_no)
			.append("') ")
			.append("and end_no >= to_number('")
			.append(end_no)
			.append("')");*/
	System.out.println("sql === "+sqlbuf.toString());
	
	//comImpl com=new comImpl();
	//List al = null;
	String tab_name="";
	
	try
	{
		//al = com.spubqry32("1",sqlbuf.toString());
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlbuf%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="al" scope="end"/> 

<%
		logger.error("list size= "+al.length);
		if(al != null && al.length == 1 )
		{
			tab_name = al[0][0];
		}
		else
		{
			tab_name = "";
		}
	}
	catch(Exception e)
	{
		logger.fatal("Calling comImpl.spubqry32_1 Failed!");
		e.printStackTrace();
		tab_name = "";
	}
	
	
	if(!"".equals(tab_name))
	{
		//继续查询卡状态
		logger.fatal("tab name = "+tab_name);
		logger.error("card_type===="+card_type);
		
		String sqls = new StringBuffer("select count(*) from ").append(tab_name)
				.append( " where card_no>='" )
				.append( begin_no ).append( "' " ).append( " and card_no<='" )
				.append( end_no ).append( "' " ).append( " and length('" ).append( begin_no )
				.append( "') " ).append( "= length('" ).append( end_no ).append( "') " )
				.append( " and card_status='1' and group_id = '" ).append( res_group_id ).append( "'" )
				.append( " and isactive='1' ").toString();
		
		logger.error("sql = "+sqls);
		try
		{
			//list = com1.spubqry32("1",sqls);
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="list" scope="end"/> 
<%			
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~list[0][0]="+list[0][0]);
			if(list != null && list.length != 0)
			{
			    if((cha+1) != Integer.parseInt(list[0][0])){
			       query_result = false;
			       errorMsg="充值卡数目、状态或类型不正确!";
			    }else{
				logger.error("count = ["+list[0][0]+"]");
				logger.error("qry count = ["+card_num+"]");
				if(list[0][0].equals(card_num))
				{
					query_result = true;
					sqls = new StringBuffer("select res_name, b.PAR_VALUE from ")
								.append("dChnCardRes a,sChnResCode b where card_no = '")
								.append(begin_no)
								.append("' and a.res_code = b.res_code").toString();
					
					//List list1 = com1.spubqry32("2",sqls);
%>
			    <wtc:pubselect name="sPubSelect" outnum="2">
				<wtc:sql><%=sqls%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="list1" scope="end"/> 
<%					
					if(list1 != null && list1.length != 0)
					{
							card_type_name = list1[0][0];
							card_value = list1[0][1];
					}
					else
					{
						logger.fatal("查询卡资源类型失败!");
						
					}
				}
				else
				{
					errorMsg="充值卡数目或类型不正确";
				}
			}
			}
			else
			{
				errorMsg="查询充值卡错误！";
			}
			
			
		}
		catch(Exception e)
		{
			logger.fatal("Calling comImpl.spubqry32_2 Failed!");
			e.printStackTrace();
		}
	}
	else
	{
		errorMsg="查询充值卡错误！";
	}
	
	logger.error("card check result ="+query_result);
	logger.error("card type ="+card_type_name);
	logger.error("card value ="+card_value);
%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page","<%=rpc_page%>");
response.data.add("result","<%=query_result%>");
response.data.add("card_type","<%=card_type_name%>");
response.data.add("card_value","<%=card_value%>");
response.data.add("error_msg","<%=errorMsg%>");
response.data.add("begin_no","<%=begin_no%>");
core.ajax.receivePacket(response);
