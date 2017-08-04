<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%
/*
返回参数：
    错误代码
    错误消息
    担保数量
    最大担保数量
    担保人姓名
    担保人电话
    担保人地址

*/

        //得到输入参数
        
        ArrayList retArray = new ArrayList();
        String return_code,return_message;
        String[][] result = new String[][]{};
		int[] colNums=new int[3];
		colNums[0]=2;
		colNums[1]=2;
		colNums[2]=2;
		comImpl co=new comImpl();
	    //--------------------------
	    String retType = request.getParameter("retType"); 
	    String sm_code = request.getParameter("sm_code"); 
	    String pack_code = request.getParameter("pack_code"); 
	    String region_code = request.getParameter("region_code");
	    
	    //返回值定义
        String retCode = "";
        String retMessage = "";

		String pack_backcode=pack_code;
        String pack_prefee = "";
		String pack_addifeeCode = ""; 
		String pack_addifeeName = "";
        String pack_mainfeeCode = "";
		String pack_mainfeeName = "";        

		//查询语句
		String sq1="select count(*) from sPackCode where region_code='"+region_code+"' and mach_code='"+pack_code+"'";

        StringBuffer sq2buf=new StringBuffer("select Mach_code,Prepay_fee from sPackCode where MACH_CODE='"+pack_code+"'and Region_code='"+region_code+"';");

		sq2buf.append("select mode_code,mode_name from sBillPackCode where Mach_code='"+pack_code+"' and Region_code='"+region_code+"' and Mode_flag='2' and sm_code='gn';"); 

		sq2buf.append("select mode_code,mode_name from sBillPackCode where Mach_code='"+pack_code+"' and Region_code='"+region_code+"' and Mode_flag='0' and sm_code='gn';");

		String sq2=sq2buf.toString();
		System.out.println("1104:"+sq2);
         try
        {
            retArray = co.spubqry32("1",sq1,"region",region_code);

            result = (String[][])retArray.get(0);            

			if(result[0][0].trim().equals("0"))
			{
              retCode="000001";
			  retMessage="无营销包信息！";
			}
            else
			{
              retCode="000000";
			  retMessage="成功取得营销包信息！";
 			  retArray = co.multiSql(colNums,sq2,"region",region_code);
 			  result = (String[][])retArray.get(0);
			  if(result.length==1)
			  {
			    pack_backcode = Pub_lxd.repStr(result[0][0].trim(),"000");
			    pack_prefee = Pub_lxd.repStr(result[0][1].trim(),"0.00");
 			  }
			  result = (String[][])retArray.get(1);
              if(result.length>0)
			  {
                for(int k=0;k<result.length;k++)
				{
			      pack_addifeeCode += Pub_lxd.repStr(result[k][0].trim(),"")+"~";
				  pack_addifeeName += "["+Pub_lxd.repStr(result[k][1].trim(),"")+"]";
				}
				pack_addifeeCode=pack_addifeeCode.substring(0,pack_addifeeCode.length()-1);
				//pack_addifeeName=pack_addifeeName.substring(0,pack_addifeeName.length()-1);
			  }
			  result = (String[][])retArray.get(2);
			  if(result.length==1)
			  { 			  			 
                pack_mainfeeCode = Pub_lxd.repStr(result[0][0].trim(),"");
                pack_mainfeeName = Pub_lxd.repStr(result[0][1].trim(),"");             
			  }
 			}			                       
        }catch(Exception e){
			retCode="000002";
			retMessage="查询营销包信息错误！";
        }
		
%>
var response = new RPCPacket();
var retType = "";
var retCode = "";
var retMessage = "";

var pack_backcode = "";
var pack_prefee = "";
var pack_addifeeCode = "";
var pack_addfeeName = "";
var pack_mainfeeCode = "";
var pack_mainfeeName = "";
 
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";

pack_backcode = "<%=pack_backcode%>";
pack_prefee = "<%=pack_prefee%>";
pack_addifeeCode = "<%=pack_addifeeCode%>";
pack_addifeeName = "<%=pack_addifeeName%>";
pack_mainfeeCode = "<%=pack_mainfeeCode%>";
pack_mainfeeName = "<%=pack_mainfeeName%>";
 
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);

response.data.add("pack_backcode",pack_backcode);
response.data.add("pack_prefee",pack_prefee);
response.data.add("pack_addifeeCode",pack_addifeeCode);
response.data.add("pack_addifeeName",pack_addifeeName);
response.data.add("pack_mainfeeCode",pack_mainfeeCode);
response.data.add("pack_mainfeeName",pack_mainfeeName);
core.rpc.receivePacket(response);