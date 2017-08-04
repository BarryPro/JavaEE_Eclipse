<%
   /*
   * 功能: 订单缓装查询(订单缓装)分页查询_2
　 * 版本: v1.0
　 * 日期: 2009/01/30
　 * 作者: jiangxl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>		

<%
System.out.println("-----------------------fq034_4.jsp----------------");
	String workNo = (String)session.getAttribute("workNo");
  int valid = 1;	//0:正确，1：系统错误，2：业务错误
  String errorCode="444444";
  String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
  String strArray="var arrMsg; ";  //must 
  String strArray2="var arrMsg2; ";  //must 
  String strArray3="var posArrMsg; ";  //must 

  String retType = request.getParameter("retType");
	String phoneNo = request.getParameter("phoneNo");
	String stateFlag = request.getParameter("stateFlag");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String strstartRow = request.getParameter("startRow");
	
	String password = (String)session.getAttribute("password");	
	String work_no = (String)session.getAttribute("workNo");
	String opCode = request.getParameter("opCode");
	
	String strendRow = request.getParameter("endRow");
	String strrecordPerPage = request.getParameter("recordPerPage");
	String sqlCondition =" and login_no='"+workNo+"'";
	if(!"".equals(phoneNo)) sqlCondition+=" and phone_no ='"+phoneNo+"'";
	if(!"".equals(stateFlag)) sqlCondition+=" and pre_flag ='"+stateFlag+"'";
	if(!"".equals(startTime)) sqlCondition+=" and  to_char(pre_time,'YYYYMMDD') >= '"+startTime+"'";
	// sqlCondition+=" and pre_time >= TO_DATE('"+startTime+"','yyyyMMdd')";
	if(!"".equals(endTime)) sqlCondition+=" and  to_char(pre_time,'YYYYMMDD')  <= '"+endTime+"'";
	//sqlCondition+=" and  pre_time<=TO_DATE('"+endTime+"','yyyyMMdd')";
	String insql="";

	if(strstartRow==null||strstartRow.trim().equals("")) strstartRow="0";
	if(strendRow==null||strendRow.trim().equals("")) strendRow="10";
	if(strrecordPerPage==null||strrecordPerPage.trim().equals("")) strrecordPerPage="10";			
	
	int startRow=Integer.parseInt(strstartRow);
	int endRow=Integer.parseInt(strendRow);
	int recordPerPage=Integer.parseInt(strrecordPerPage);
	if(startRow<0) startRow=0;
	if(endRow<=0) endRow=10;
	if(recordPerPage<0) recordPerPage=10;

	insql ="select phone_no,id_no,cust_name,pre_time,group_id,pre_flag,login_no,myrow from "
	+"( select dCustMsgPre.*,rownum as myrow from dCustMsgPre where rownum <"
	+endRow +sqlCondition+"order by pre_time desc  ) where myrow>="+startRow;
	
    int retInfo = 0;
    String[][] result = null;

	String quetype=request.getParameter("quetype");
	/*lijy add@20110823*/
	String quetypes= WtcUtil.repNull(request.getParameter("quetypes"));
	/*lijy add@20110823 end */
	String quevalue=request.getParameter("quevalue");
	String orderSelectId=request.getParameter("orderSelectId");
	String opcodestr=request.getParameter("opcodestr");
	String quetype2=request.getParameter("quetype2");
	String optName = request.getParameter("optName");
	String custname="";
	String operater="";
	String orderstat="";
	String orderSelect="";
	/*
	lijy 注释@20110823
	if(quetype!=null&&quetype.equals("21")){
		quetype="2";
		quetypes="21";
	}*/
	if(opcodestr==null||opcodestr.equals("")){
		opcodestr="1";
	}
    
%>
<%			  
if(quetype!=null&&!quetype.equals("")&&quevalue!=null&&!quevalue.equals("")){

	if(quetype.equals("2") || quetype.equals("4") &&!quetypes.equals("21")){
		%>
		<wtc:utype name="sGetCustServNo" id="retVal3" scope="end" >
			 <wtc:uparam value="<%=quetype %>" type="STRING"/><%/*lijy add@20110726*/%>
			 <wtc:uparam value="<%=quevalue %>" type="STRING"/> 
			 <wtc:uparam value="<%=opCode %>" type="STRING"/> 
			 <wtc:uparam value="<%=work_no %>" type="STRING"/> 
			 <wtc:uparam value="<%=password %>" type="STRING"/> 			 
		</wtc:utype>
		<%	
	
		if(retVal3.getValue(0)!=null&&retVal3.getValue(0).equals("0")&&retVal3.getUtype(2)!=null&&retVal3.getSize(2)==1){
		quetypes="21";
		orderSelectId=retVal3.getValue("2.0.0");
		
		
		%>
		
		
		
		<%
		}else if(retVal3.getValue(0)!=null&&retVal3.getValue(0).equals("0")&&retVal3.getUtype(2)!=null&&retVal3.getSize(2)>1){
			valid = 0;
		    errorCode="000000";
			orderSelect=String.valueOf(retVal3.getSize(2));	
			
		%>
		
		<%
		}else{	
			
		
		}
	}
	if(quetypes.equals("21")){
		if(orderSelectId!=null&&!orderSelectId.equals("")){
			 String sername="sGetOrdeAny";
			if(opcodestr!=null&&opcodestr.equals("2")){
				sername="sGetChangAny";
			}else{
				
				%>
				<wtc:utype name="<%=sername %>" id="retVal21" scope="end" >
					   <wtc:uparam value="<%=quetype %>" type="STRING"/><%/*lijy add@20110726*/%>
				     <wtc:uparam value="<%=quevalue %>" type="STRING"/>
					 <wtc:uparam value="<%=orderSelectId %>" type="STRING"/> 
				</wtc:utype>
				<%
				if(retVal21.getSize("2.0")>0)
				{
						custname=retVal21.getValue("2.0.0");
						operater=retVal21.getValue("2.0.1");
						orderstat=retVal21.getValue("2.0.2");
				}
			}
		}	 	
	}/*lijy change @20110726 original is else if(!quetype.equals("2")){*/
	 else if(!quetype.equals("2") &&!quetype.equals("4") ){
		String sername="sGetOrderSelect";
		if(opcodestr!=null&&opcodestr.equals("2")){
			sername="sGetOrdeList";
		}else{
			
			%>
			<wtc:utype name="<%=sername %>" id="retVal" scope="end" >
			     <wtc:uparam value="<%=quetype %>" type="INT"/>
				 <wtc:uparam value="<%=quevalue %>" type="STRING"/> 
			</wtc:utype>
			
			<%
		
			if(retVal.getValue(0)!=null&&retVal.getValue(0).equals("0")&&retVal.getUtype(2)!=null&&retVal.getSize(2)>2){
					custname=retVal.getValue("2.0");
					operater=retVal.getValue("2.1");
					orderstat=retVal.getValue("2.2");		
			}
		}
		 	
	}
}
//////////////////////////////////////////////////////////////////
%>
<%=strArray%>
<%=strArray2%>
<%=strArray3%>
<%
if(!startTime.equals("") && !endTime.equals("")){
	startTime=startTime.substring(0,4)+"-"+startTime.substring(4,6)+"-"+startTime.substring(6);
	endTime=endTime.substring(0,4)+"-"+endTime.substring(4,6)+"-"+endTime.substring(6);
	System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%"+endTime);
}
if(quetype!=null&&!quetype.equals("")&&quevalue!=null&&!quevalue.equals("")&&(!(quetype.equals("2")&&!quetypes.equals("21")))||quetype2!=null&&quetype2.equals("2")){
	String parm1=quetype;
	String parm2=opcodestr;
	String parm3=quevalue;
	String sername="sGetOrdeList";
	String parmtype="INT";
	String parmtype1="INT";

	if(quetypes.equals("21")&&orderSelectId!=null&&!orderSelectId.equals("")){
		sername="sGetOrdeAnyList";		
		parm1=opcodestr;
		parm2=quevalue;
		parm3=orderSelectId;		
		parmtype="STRING";

	}	
	//String quetype2="2";
	if((opcodestr!=null&&opcodestr.equals("2"))&&quetype2!=null&&quetype2.equals("2")){
		sername="sGetArrayInfoB";		
		parm1=startTime;
		parm2=endTime;		
		parm3=optName;		
		parmtype="STRING";
		parmtype1="STRING";
		if(parm3!=null&&parm3.trim().equals("")){
			sername="sGetArrayInfo";				
		}
	}			
	
	%>

	<wtc:utype name="<%=sername %>" id="retVal" scope="end" >
	     <wtc:uparam value="<%=parm1 %>" type="<%=parmtype1 %>"/>
		 <wtc:uparam value="<%=parm2 %>" type="<%=parmtype %>"/>
		<% if(!sername.equals("sGetArrayInfo")){ %>
		 <wtc:uparam value="<%=parm3 %>" type="STRING"/> 
		 <% } %>
		 <% 
		  /*lijy add@20110726*/
		 if(sername.equals("sGetOrdeAnyList")){ %>
		 <wtc:uparam value="<%=quetype %>" type="STRING"/> 
		 <% } %>
	</wtc:utype>

	<%
	
	
	//custname=retVal.getValue("2.0");
	//operater=retVal.getValue("2.1");
	//orderstat=retVal.getValue("2.2");	
	
	if(retVal.getValue(0)!=null&&retVal.getValue(0).equals("0")&&retVal.getUtype(2)!=null&&retVal.getSize(2)>0){		
  	retInfo = retVal.getSize(2);     
		if ( retInfo == 0 ){     
        	valid = 2;
        	errorMsg = "没有找到用户信息";        	
    }else{			
			int re=retVal.getSize(2);		
			if(re<endRow){
				endRow=re;					
		  }
			if(endRow<=0){
				startRow=0;
				endRow=0;
			}else{
				startRow=((endRow-1)/recordPerPage)*recordPerPage;	
			}			
      valid = 0;
      errorCode="000000";
      strArray = CreatePlanerArray.createArray("arrMsg",endRow-startRow);				

    }
		%>
		<%=strArray%>
		<%	
		//将订单子项信息放入arrMsg数组
		String rtv="";	
		int rts=0;
		int ii=0;
		for(int i=startRow;i<endRow;i++){			
			String oid=retVal.getUtype("2").getUtype(i).getValue(0);
			for(int j = 0 ; j <retVal.getSize("2."+i) ; j ++){
				if(retVal.getUtype("2").getUtype(i).getValue(j) == null || retVal.getUtype("2").getUtype(i).getValue(j).trim().equals("")){
					//result[i][j] = "";
					rtv="";					
				}else{
					rtv=retVal.getUtype("2").getUtype(i).getValue(j).trim();			

				}				
				%>
					arrMsg[<%=ii%>][<%=j%>] = "<%=rtv %>";					
					<%	
					
			}
			ii++;
		}		
		//////////////////////////////////
		//循环每个订单子项，查询其下服务订单个数
		for(int i=startRow;i<endRow;i++){		
			String sendInfostr=retVal.getUtype("2").getUtype(i).getValue(0);
		  if(opcodestr!=null&&opcodestr.equals("2")&&(retVal.getSize("2."+i)>2)){
				sendInfostr=retVal.getUtype("2").getUtype(i).getValue(2);//客户订单子项编号
		  }	
			UType sendInfo  = new UType();  
			sendInfo.setUe("STRING", sendInfostr);

			
			%>
			<wtc:utype name="sGetArrayMarket" id="retVal2" scope="end" >
				 <wtc:uparam value="<%=sendInfo %>" type="UTYPE"/> 
			</wtc:utype>
			<%	
 
	
			rts+=retVal2.getSize("2.0");
		}	
		strArray2 = CreatePlanerArray.createArray("arrMsg2",rts);
		strArray3 = CreatePlanerArray.createArray("posArrMsg",rts);
		%>
		<%=strArray2%>
		<%=strArray3%>
		
		<%
		//////////////////////////////////
		//循环每个订单子项，将其服务订单放入数组arrMsg2，该数组的二维的第0个表示该服务订单对应的订单子项
		int kk=0;
		ii=0;
		for(int i=startRow;i<endRow;i++){	
			String sendInfostr=retVal.getUtype("2").getUtype(i).getValue(0);
			if(opcodestr!=null&&opcodestr.equals("2")&&(retVal.getSize("2."+i)>2)){
		 		sendInfostr=retVal.getUtype("2").getUtype(i).getValue(2);
			}
	
			UType sendInfo  = new UType();  
			sendInfo.setUe("STRING", sendInfostr);

			%>
			<wtc:utype name="sGetArrayMarket" id="retVal2" scope="end" >
				 <wtc:uparam value="<%=sendInfo %>" type="UTYPE"/> 
			</wtc:utype>

			<%		
			for(int j=0;j<retVal2.getSize("2.0");j++){
					for(int a=1;a<9;a++){
						String rtv2=retVal2.getUtype("2.0").getUtype(j).getUtype("0").getValue(a-1);
						%> 
						arrMsg2[<%=kk+j%>][<%=a%>] = "<%=rtv2 %>";					
						<%	
					}
				%> 
				arrMsg2[<%=kk+j%>][<%=0%>] = "<%=ii %>";					
				<%	
						System.out.println("-----------2.0.0.9----分期月份------------"+retVal2.getValue("2.0.0.9"));
%>
						posArrMsg[<%=kk+j%>][0] = "<%=retVal2.getValue("2.0."+j+".1")%>";
						posArrMsg[<%=kk+j%>][1] = "<%=retVal2.getValue("2.0."+j+".2")%>";
						posArrMsg[<%=kk+j%>][2] = "<%=retVal2.getValue("2.0."+j+".3")%>";
						posArrMsg[<%=kk+j%>][3] = "<%=retVal2.getValue("2.0."+j+".4")%>";
						posArrMsg[<%=kk+j%>][4] = "<%=retVal2.getValue("2.0."+j+".5")%>";
						posArrMsg[<%=kk+j%>][5] = "<%=retVal2.getValue("2.0."+j+".6")%>";
						posArrMsg[<%=kk+j%>][6] = "<%=retVal2.getValue("2.0."+j+".7")%>";
						posArrMsg[<%=kk+j%>][7] = "<%=retVal2.getValue("2.0."+j+".8")%>";
						posArrMsg[<%=kk+j%>][8] = "<%=retVal2.getValue("2.0."+j+".9")%>";
<%					
			}
			ii++;
			kk+=retVal2.getSize("2.0");
		}
	}
}
%>   
var response = new AJAXPacket();
response.data.add("retType","<%= retType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
response.data.add("backArrMsg",arrMsg );
response.data.add("backArrMsg2",arrMsg2 );
response.data.add("posArrMsg",posArrMsg );
response.data.add("retInfo","<%= retInfo %>");
response.data.add("custname","<%= custname %>");
response.data.add("operater","<%= operater %>");
response.data.add("orderstat","<%= orderstat %>");
response.data.add("quetype","<%= quetype %>");
response.data.add("quetype2","<%= quetype2 %>");
response.data.add("quetypes","<%= quetypes %>");
response.data.add("orderSelect","<%= orderSelect %>");
response.data.add("opc","<%= opcodestr %>");
core.ajax.receivePacket(response);


