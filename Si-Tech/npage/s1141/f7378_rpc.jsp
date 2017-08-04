 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-11 页面改造,修改样式
	********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.util.UnicodeUtil" %>

<%  
	//SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
	String errorMsg = "";
	String errorCode = "0000";
	String regionCode = request.getParameter("regionCode"); 
	String typecode = request.getParameter("retType");
	String optype=request.getParameter("optype");
	String phone_no=request.getParameter("phone_no");
	String listtype=request.getParameter("listtype");
	String townCodeStrs[]=null;
	String townNameStrs[]=null;
	String townMsgStrs[]=null;
	String sql = "";
	String[][] townCodeArray    = null;
	String[][] townNameArray= null;
	//comImpl co=new comImpl();	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	System.out.println("typecode="+typecode);
	if( "getopcode".equals(typecode) ){			
				sql = "select a.op_code,a.total_date  from sroleopcode a "+
					" where  a.op_type='3' and a.region_code=:region and not exists(select 1 from dBlakWhiteList x,dcustmsg c "+
					" where   list_type=:listtype and op_Type=:optype and x.id_no=c.id_no "+
					" and c.phone_no=:phone and a.op_code=x.op_code) ";
				System.out.println("sql="+sql);
				//组织输入参数
	    			String [] paraIn = new String[4];
	    			paraIn[0] = "region";
	    			paraIn[1] = regionCode;
	    			paraIn[2] = sql;
	    			paraIn[3] = "region="+regionCode+",listtype="+listtype+",optype="+optype+",phone="+phone_no;
    				//调用服务
    				//ArrayList al = callView1.callFXService("sPubSelectNew",paraIn,"2");
    			%>
    				<wtc:service name="sPubSelectNew" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
					<wtc:param value="<%=paraIn[0]%>"/>
					<wtc:param value="<%=paraIn[1]%>"/>
					<wtc:param value="<%=paraIn[2]%>"/>
					<wtc:param value="<%=paraIn[3]%>"/>					
				</wtc:service>
				<wtc:array id="townCodeArray1" start="0" length="1" scope="end"/>
				<wtc:array id="townNameArray2" start="1" length="1" scope="end"/>
    			
    			<% 				
				//if(callView1.getErrCode() == 0){
				if(retCode1.equals("000000")){
	    				System.out.println("pppppppppppppppppppp");
	    				//townCodeArray =(String[][])al.get(0);
	    				//townNameArray =(String[][])al.get(1);
	    				townCodeArray =townCodeArray1;
	    				townNameArray =townNameArray2;
	    				System.out.println("ownCodeArray.length="+townCodeArray.length);                            
				
    				}else{
					errorCode = "4000";
					errorMsg = "数据错误！";
					
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
	if( "getopcode".equals(typecode) )
	{
%>
		var values = Array();
		var names = Array();
<%
		/*for(int i=0; i< townCodeStrs.length ;i++)*/
		for(int i=0; townCodeArray != null && i<townCodeArray.length;i++)
		{
%>
			values[<%=i%>] = "<%=townCodeArray[i][0]%>";
			names[<%=i%>] = "<%=townNameArray[i][0]%>";
<%
		}
%>
		response.data.add("values",values);
		response.data.add("names",names);
<%
	}
	
}	
%>
core.ajax.receivePacket(response);

