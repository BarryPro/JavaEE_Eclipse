<%
  /*
   * 功能:订单审核,通过查询条件调用对应服务返回结果到主页面
　 * 版本:  v1.0
　 * 日期: 2009-01-15 10:00
　 * 作者: wanglj
　 * 版权: sitech
　*/
%> 
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%	
	String strArray="var arrMsg;";	
	String retType = request.getParameter("ret_type");
	String pageSize = request.getParameter("pageSize");		
  	String fieldName = request.getParameter("filed_name");
  	String selType = request.getParameter("selType");
  	String retQuence = request.getParameter("retQuence");
	String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage") ;
	int iStartPos = (Integer.parseInt(currentPage)-1)*Integer.parseInt(pageSize);
	int iEndPos = Integer.parseInt(currentPage)*Integer.parseInt(pageSize);
	String[] nameList = fieldName.split("\\|");
	int colNum = nameList.length;	
	int num = 0;
	int totalPage = 0;
	
	String workNo = (String)session.getAttribute("workNo");
  	String workName = (String)session.getAttribute("workName");
  	//String siteId  = (String)session.getAttribute("siteId");
  	String siteId  = (String)session.getAttribute("groupId");
  	String type=request.getParameter("type");
  	String order_val=request.getParameter("order_val");
	System.out.println(order_val+"@@@@@@@@@@@@@@@@@@@@@@@@@"+siteId+"@@@@@"+type);
 	UType u = null;
 	int totalRec = 0;
%>
 
<%
	if(type.equals("0"))//所有
	{
	%>
		<wtc:utype name="sOrdeArrayAll" id="retVal" scope="end" >
		     <wtc:uparam value="<%=siteId%>" type="STRING"/> 
		</wtc:utype>
	<%
		u = retVal;
	}
	else if(type.equals("1"))//员工号
	{
	%>
		<wtc:utype name="sOrdeArrayLogin" id="retVal" scope="end" >
		     <wtc:uparam value="<%=order_val%>" type="STRING"/>
		     <wtc:uparam value="<%=siteId%>" type="STRING"/>
		</wtc:utype>	
	<%
		u = retVal;
	}
	else if(type.equals("2"))//订单号
	{
	%>
		<wtc:utype name="sGetOrderArray" id="retVal" scope="end" >
		     <wtc:uparam value="<%=order_val%>" type="STRING"/>
		     <wtc:uparam value="<%=siteId%>" type="STRING"/>
		</wtc:utype>	
	<%
		u = retVal;
	}
	else if(type.equals("3"))//订单子项
	{
		UType arrayUtype = new UType();
		arrayUtype.setUe("STRING",order_val);
	%>
		<wtc:utype name="sOrdeArrayInfo" id="retVal" scope="end" >
     	<wtc:uparam value="<%=siteId%>" type="STRING"/>
     	<wtc:uparam value="<%=arrayUtype%>" type="UTYPE"/>  
		</wtc:utype>
	<%
		u = retVal;
	}
%>
     
<%
			StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(u,1,"2",logBuffer);		
	System.out.println(logBuffer.toString());
     String returnCode=u.getValue(0); 
     String returnMsg=u.getValue(1);
     System.out.println(returnCode+"............."+returnMsg);
     if(returnCode.equals("0")){							
%>
<%							
							if(type.equals("3")){
							 	if (u.getSize(2)!= 0){
							 		String service_no3 = u.getValue("2.0.17");
							 		int service_num3 =  Integer.parseInt(u.getValue("2.0.7"));
							 		for(int i = 1; i< u.getSize(2); i++){
							 			System.out.println(":::::::::::::::::");
							 			service_no3 += "<br>"+u.getValue("2."+ i +".17");
							 			service_num3 = service_num3 + Integer.parseInt(u.getValue("2."+ i +".7"));
							 		}
									num = 1;
									totalPage = 1;
									strArray = CreatePlanerArray.createArray("arrMsg",1);
%>
									<%=strArray%>
									arrMsg[0][0] = "<%= u.getValue("2.0.0")%>";
									arrMsg[0][1] = "<%= u.getValue("2.0.2")%>";
									arrMsg[0][2] = "<%= service_no3%>";
									arrMsg[0][3] = "<%= u.getValue("2.0.3")%>";
									arrMsg[0][4] = "<%= service_num3%>";
									arrMsg[0][5] = "<%= u.getValue("2.0.9")%>";
									arrMsg[0][6] = "<%= u.getValue("2.0.11")%>";
									arrMsg[0][7] = "<%= u.getValue("2.0.13")%>";
									arrMsg[0][8] = "<%= u.getValue("2.0.14")%>";
									arrMsg[0][9] = "<%= u.getValue("2.0.16")%>";	
								
<%															
							}else{
%>
								var arrMsg=null;
<%								
							}
						}else{
							UType total = (UType)u.getUtype(2);
							if(total != null){
									String strArray1="var arrMsg1;";	
									num = total.getSize();
									Map arrayMap = new HashMap();
									List arrayList  = new ArrayList();
									Map servNoMap = new HashMap();
									Map servNumMap = new HashMap();
									int m =0;
									strArray1 = CreatePlanerArray.createArray("arrMsg1",num);
									%>
										<%=strArray1%>
									<%
									for(int i = 0; i<num; i++){
										String  array_order_no =  total.getValue(i+".0");
										String  service_no  = total.getValue(i+".17");
										String  service_num  =  total.getValue(i+".7");
										StringBuffer sb = new StringBuffer();
										if(arrayList.indexOf(array_order_no) != -1)	{
											m--;
											service_no = (String)servNoMap.get(array_order_no)+"<br>"+ total.getValue(i+".17");
											service_num = String.valueOf(Integer.parseInt((String)servNumMap.get(array_order_no)) + Integer.parseInt(total.getValue(i+".7")));
											sb.append("arrMsg1["+m+"][0]='"+array_order_no+"';");
											sb.append("arrMsg1["+m+"][1]='"+total.getValue(i+".2")+"';");
											sb.append("arrMsg1["+m+"][2]='"+ service_no +"';");
											sb.append("arrMsg1["+m+"][3]='"+total.getValue(i+".3")+"';");
											sb.append("arrMsg1["+m+"][4]='"+service_num+"';");
											sb.append("arrMsg1["+m+"][5]='"+total.getValue(i+".9")+"';");
											sb.append("arrMsg1["+m+"][6]='"+total.getValue(i+".11")+"';");
											sb.append("arrMsg1["+m+"][7]='"+total.getValue(i+".13")+"';");
											sb.append("arrMsg1["+m+"][8]='"+total.getValue(i+".14")+"';");
											sb.append("arrMsg1["+m+"][9]='"+total.getValue(i+".16")+"';");
											arrayMap.put(array_order_no,sb.toString());
											servNoMap.put(array_order_no,service_no);
											servNumMap.put(array_order_no,service_num);
										}else{
											sb.append("arrMsg1["+m+"][0]='"+array_order_no+"';");
											sb.append("arrMsg1["+m+"][1]='"+total.getValue(i+".2")+"';");
											sb.append("arrMsg1["+m+"][2]='"+ service_no +"';");
											sb.append("arrMsg1["+m+"][3]='"+total.getValue(i+".3")+"';");
											sb.append("arrMsg1["+m+"][4]='"+ service_num +"';");
											sb.append("arrMsg1["+m+"][5]='"+total.getValue(i+".9")+"';");
											sb.append("arrMsg1["+m+"][6]='"+total.getValue(i+".11")+"';");
											sb.append("arrMsg1["+m+"][7]='"+total.getValue(i+".13")+"';");
											sb.append("arrMsg1["+m+"][8]='"+total.getValue(i+".14")+"';");
											sb.append("arrMsg1["+m+"][9]='"+total.getValue(i+".16")+"';");
											arrayList.add(array_order_no);
											arrayMap.put(array_order_no,sb.toString());
											servNoMap.put(array_order_no,service_no);
											servNumMap.put(array_order_no,service_num);
										}
										m++;	
									 out.println(sb);
									}
									num = arrayList.size();
									totalRec = num;
									int retNum = (iEndPos >= num) ?  num - iStartPos : Integer.parseInt(pageSize) ;
									strArray = CreatePlanerArray.createArray("arrMsg",retNum);
%>
													<%=strArray%>
<%   									
									int m1 = 0;
									for(int i = iStartPos; (i<iEndPos) && (i <num) ; i++){  
%>
										arrMsg[<%=m1%>][<%=0%>] = arrMsg1[<%=i%>][<%=0%>] ;
										arrMsg[<%=m1%>][<%=1%>] = arrMsg1[<%=i%>][<%=1%>] ;
										arrMsg[<%=m1%>][<%=2%>] = arrMsg1[<%=i%>][<%=2%>] ;
										arrMsg[<%=m1%>][<%=3%>] = arrMsg1[<%=i%>][<%=3%>] ;
										arrMsg[<%=m1%>][<%=4%>] = arrMsg1[<%=i%>][<%=4%>] ;
										arrMsg[<%=m1%>][<%=5%>] = arrMsg1[<%=i%>][<%=5%>] ;
										arrMsg[<%=m1%>][<%=6%>] = arrMsg1[<%=i%>][<%=6%>] ;
										arrMsg[<%=m1%>][<%=7%>] = arrMsg1[<%=i%>][<%=7%>] ;
										arrMsg[<%=m1%>][<%=8%>] = arrMsg1[<%=i%>][<%=8%>] ;
										arrMsg[<%=m1%>][<%=9%>] = arrMsg1[<%=i%>][<%=9%>] ;
<%   								
										m1++;
								}
							totalPage = totalRec % Integer.parseInt(pageSize) == 0 ? totalRec/Integer.parseInt(pageSize) : totalRec/Integer.parseInt(pageSize) + 1;
						}else{
%>
								var arrMsg=null;
<%								
							}	
					 }
         }else {
%>
						var arrMsg=null;
						
<%}
System.out.println("---wanglj------------"+retType+","+returnCode+","+currentPage+","+totalPage+","+totalRec);
%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("errorCode","<%= returnCode %>");
response.data.add("arrMsg",arrMsg); 
response.data.add("currentPage","<%=currentPage%>"); 
response.data.add("totalPage","<%=totalPage == 0 ? 1 : totalPage%>");
response.data.add("totalRec","<%=totalRec%>");
core.ajax.receivePacket(response);

     
