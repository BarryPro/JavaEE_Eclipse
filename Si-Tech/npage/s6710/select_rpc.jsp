<% 
  /*
   * 功能: 彩铃卡产品
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 功能：根据传入的SQL查询 
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
   * update:liutong@20080917
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>


<%@ page import="com.sitech.boss.pub.util.*" %>



<%!
  public static String createArray(String aimArrayName, int xDimension) {
    String stringArray = "var " + aimArrayName + " = new Array(";

    int flag = 1;
    for (int i = 0; i < xDimension; i++) {
      if (flag == 1) {
        stringArray += "new Array()";
        flag = 0;
      }
      else if (flag == 0) {
        stringArray += ",new Array()";
      }
    }
    stringArray += ");";
    return stringArray;
  }
%>

<%
    String retType = request.getParameter("retType");
	  String sqlStr = request.getParameter("sqlStr");
	  System.out.println("111111111111111111111111====="+sqlStr);
	String orgCode = (String)session.getAttribute("orgCode");
   String regionCode = orgCode.substring(0,2);
		//SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
		//ArrayList retArray1 = new ArrayList();
		//String[][] result1 = new String[][]{};
	  int recordNum1=0;
		//retArray1 = callView1.sPubSelect("2",sqlStr);
		//result1 = (String[][])retArray1.get(0);
		
		%>
		    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
		<%
		
		 
		  if(retCode1.equals("0")||retCode1.equals("000000")){
          System.out.println("调用服务sPubSelect in .jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
          recordNum1 = result1.length;
           String tri_metaDataStr = createArray("js_tri_metaDataStr",result1.length);
						%>
							
							<%=tri_metaDataStr%>
									
						<%
 	        	if(recordNum1==0){
 	        		for(int i=0;i<recordNum1;i++)
							{
						%>
							 js_tri_metaDataStr[<%=i%>][0]="<%=result1[i][0]%>";
							 js_tri_metaDataStr[<%=i%>][1]="<%=result1[i][1]%>";		
						<%
						  System.out.println("result1[i][0]=" + result1[i][0] + "result1[i][0]="+result1[i][1] );
						  }
 	            }else{
 	            	
							for(int i=0;i<recordNum1;i++)
							{
						%>
							 js_tri_metaDataStr[<%=i%>][0]="<%=result1[i][0]%>";
							 js_tri_metaDataStr[<%=i%>][1]="<%=result1[i][1]%>";		
						<%
						  System.out.println("result1[i][0]=" + result1[i][0] + "result1[i][0]="+result1[i][1] );
						  }
					  
 	        	   
 	        	}
 	        	
 	     	}else{
 	         	System.out.println(retCode1+"    retCode1");
 	     		System.out.println(retMsg1+"    retMsg1");
 			   System.out.println("调用服务sPubSelect in pubSysAccept.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}
%>
		

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);
