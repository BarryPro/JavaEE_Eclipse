<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.26
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	    String retType = request.getParameter("retType"); 
	    String simNo = request.getParameter("simNo"); 
 	    String region_code = request.getParameter("region_code");
	    
	    //返回值定义
        //String retCode = "";
        //String retMessage = "";
		String sim_type = "";
        String sim_typename = "";	

		//查询语句
		String sq1="select a.sim_type,b.res_name from dsimres a,sResCode b where a.sim_no='"+simNo+"' and a.sim_type=b.res_code";     

       
       /** try
        {
            retArray = co.spubqry32("2",sq1,"region",region_code);
            result = (String[][])retArray.get(0);            

			if(result==null)
			{
              retCode="000001";
			  retMessage="SIM卡类型不存在！"; 			  
			}
			else
			{
              retCode="000000";
			  retMessage="SIM卡类型查询成功！";
			  sim_type=result[0][0];
			  sim_typename=result[0][1];
			}
                      
        }catch(Exception e){
			retCode="000002";
			retMessage="查询SIM卡类型失败！";
            logger.error("Call comImpl is Failed!");
        }
        **/
%>
<wtc:pubselect name="spubqry32" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMessage" outnum="4">
<wtc:sql><%=sq1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
System.out.println(retCode+"   retCode  in pubGetSimType.jsp");
System.out.println(retType+"   retType  in pubGetSimType.jsp");
if(retCode.equals("0")){

 			   retCode="000000";
 			   sim_type=result[0][1];
			  sim_typename=result[0][2];
 			
 			}
		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var sim_type="";
var sim_typename="";
  
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
sim_type="<%=sim_type%>";
sim_typename="<%=sim_typename%>";
  
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sim_type",sim_type);
response.data.add("sim_typename",sim_typename);
core.ajax.receivePacket(response);