 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-16 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String id_no = request.getParameter("id_no");
	String retType = request.getParameter("retType");
	String regionCode = request.getParameter("region_code");
	String ret_message = "";
	String ret_code = "";
	//ArrayList retArray = new ArrayList();
	String flag_1001 = "0";
	String flag_1002 = "2";//控制付费方式显示标志　1 可集团可个人　2 只能是集团
	String biz_code = "";
	int i=0;

	System.out.println("luxc fgetbizcode.jsp id_no="+id_no);


	try
	{
		String sqlSQJZ = "SELECT DECODE(trim(b.character_value),'451002',1,0)" 
			 + " FROM dproductorderdet a,dproductcharacter b "
			 + " WHERE a.product_order_id = b.product_order_id"
			 + " AND b.character_number = '1109037709'"
			 + " AND a.id_no = '" + id_no + "'";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodeSQJZ" retmsg="retMsgSQJZ" outnum="1">
			<wtc:sql><%=sqlSQJZ%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultSQJZ" scope="end" />	
		<%
System.out.println("====wanghfa==== sqlSQJZ = " + sqlSQJZ);
System.out.println("====wanghfa==== resultSQJZ.length = " + resultSQJZ.length);
	    	//String[][] result3  = null;
		String sqlStr3 = "";
		
		sqlStr3="select nvl(field_value,'') from dGrpUserMsgAdd "
			+"where field_code='YWDM0' and id_no="+id_no;
			
		//result3 = (String[][])callView.sPubSelect("1",sqlStr3).get(0);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr3%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result3" scope="end" />	
		<%
		if (result3 != null && result3.length != 0) 
		{
			biz_code = result3[0][0];
		}
		else
		{
			ret_code = "000003";
			ret_message = "查询业务代码失败,请检查产品配置dGrpUserMsgAdd!";
		}
		
		//String[][] result1  = null;
		//String[][] result2  = null;
		//String[][] result4  = null;
		//String[][] result5  = null;
		String sqlStr1 = "";
		String sqlStr2 = "";	
		String sqlStr4 = "";	
		String sqlStr5 = "";	
		String sqlStr7 ="";
		String sqlStr6 ="";
		String sqlStr8 ="";
		
		
		sqlStr1="select count(*) from dGrpUserMsgAdd a, dbvipadm.sCommonCode b where  a.field_value = '"+biz_code+"'"+
	            " and b.common_code = '1001'   and a.field_value = b.field_code1 and a.id_no = "+id_no+" and field_code='YWDM0' and field_code2='"+regionCode+"'";
			
		
		sqlStr2="select b.field_code3 from dGrpUserMsgAdd a, dbvipadm.sCommonCode b where  a.field_value = '"+biz_code+"'"+
	            " and b.common_code = '1002'   and a.field_value = b.field_code1 and a.id_no = "+id_no+" and a.field_code='YWDM0'  and b.field_code2='"+regionCode+"'";
	            
	  sqlStr7="select count(*) from dproductorderdet a,sproductspecmoderela  b,dgrpusermsg c,dpoorderrateInfo d  "
	         +" where a.id_no=c.id_no and a.productspec_number=b.productspec_number and a.product_order_id=d.poorder_id "
	         +" and b.end_time>=sysdate "
	         +" and d.rate_attrcode='X2' and d.rate_code=b.product_rateplanid  and c.region_code=b.region_code and c.id_no="+id_no;   
	         
	  sqlStr6="select c.field_code4 from dproductorderdet a,dgrpusermsg b ,dbvipadm.scommoncode c,dpoorderrateInfo d "
	         +" where a.id_no=b.id_no and trim(a.productspec_number)=c.field_code1 and c.common_code='1002' "
	         +" and b.region_code=c.field_code2 and a.product_order_id=d.poorder_id and d.rate_attrcode='X2' "
	         +" and trim(d.rate_code)=c.field_code3 and b.id_no="+id_no;      
	         
	   sqlStr8="select c.field_code4 from dproductorderdet a,dgrpusermsg b,dbvipadm.scommoncode c,dproductrateplans d "
	         +" where a.id_no = b.id_no and trim(a.productspec_number) = c.field_code1 and c.common_code = '1002' "
	         +" and b.region_code = c.field_code2 and trim(a.product_id) = d.productid and trim(d.rateplanid) = c.field_code3 "
	         +" and b.id_no ="+id_no;    
	   
	   


	          
		
		//result1 = (String[][])callView.sPubSelect("1",sqlStr1).get(0);
		System.out.println("#########################");
		System.out.println("#########################");
		System.out.println("#########################");
		System.out.println("#########################");
		System.out.println("sqlStr2:["+sqlStr2+"]");
		System.out.println("diling--sqlStr6:["+sqlStr6+"]");
		System.out.println("wuxy--sqlStr8:["+sqlStr8+"]");
		System.out.println("#########################");
		System.out.println("#########################");
		System.out.println("#########################");
		System.out.println("#########################");
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />	
		<%
		if (result1 != null && result1.length != 0) 
		{
	        
	        if(Integer.parseInt(result1[0][0])>0)
			flag_1001 = "1";
			
			if(Integer.parseInt(result1[0][0])==0){		
			
		    //sqlStr4="select count(*) from dGrpUserMsg a, dbvipadm.sCommonCode b where a.run_code='A' and"+
	      //      " b.common_code = '1001'   and a.product_code = b.field_code1 and a.id_no = "+id_no+ "and field_code2='"+regionCode+"'";
			//result4 = (String[][])callView.sPubSelect("1",sqlStr4).get(0);
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr7%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result4" scope="end" />	
			<%
				if (result4 != null && result4.length != 0) {
				 if(Integer.parseInt(result4[0][0])>0){
		
						flag_1001 = "1";
				 }
				}        
	        }
		}
		else
		{
			ret_code = "000001";
			ret_message = "查询业务代码失败,请检查产品配置dGrpUserMsgAdd!";
		}
		
		
		//result2 = (String[][])callView.sPubSelect("1",sqlStr2).get(0);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr6%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />	

		<%
		if (result2 != null && result2.length != 0) 
		{
		    if(!"".equals(result2[0][0])){
		    		/*
						if(resultSQJZ != null && resultSQJZ.length != 0 && resultSQJZ[0][0].equals("1")) {
							flag_1002 = "4";
						} else {
							flag_1002 = result2[0][0].trim();
						}*/
						flag_1002 = result2[0][0].trim();
						System.out.println("diling-1-flag_1002="+flag_1002);
		    
	        }else if("".equals(result2[0][0])){
		          %>
			      <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			         <wtc:sql><%=sqlStr6%></wtc:sql>
			      </wtc:pubselect>
			      <wtc:array id="result5" scope="end" />	
			      <%
			      if (result5 != null && result5.length != 0){
			            if("".equals(result5[0][0])){
			                flag_1002 = "4";
			                System.out.println("diling-2-flag_1002="+flag_1002);
			            }else{
			                flag_1002 = result5[0][0].trim();
			                System.out.println("diling-3-flag_1002="+flag_1002);
			            }
				    }else{
				        flag_1002 = "4";
				        System.out.println("diling-4-flag_1002="+flag_1002);
				    }
		    }
		}else{	
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr8%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result8" scope="end" />	
			<%
			if(result8 != null && result8.length != 0) 
			{
			    if("".equals(result8[0][0])){
			    
			    		flag_1002 = "4";
			            System.out.println("wuxy-2-flag_1002="+flag_1002);
			   }else{
			   		flag_1002 = result8[0][0].trim();
			                System.out.println("wuxy-3-flag_1002="+flag_1002);
			   	}
			    
			}else{
				flag_1002 = "4";
				System.out.println("wuxy-4-flag_1002="+flag_1002);
				}

			System.out.println("diling-5-flag_1002="+flag_1002);
		}	
		System.out.println("diling-6-flag_1002="+flag_1002);
		
		ret_code = "000000";
		System.out.println("luxc fgetbizcode.jsp biz_code="+biz_code);
		
		ret_code = "000000";
		System.out.println("luxc fgetbizcode.jsp flag_1001="+flag_1001);
		System.out.println("luxc fgetbizcode.jsp flag_1002="+flag_1002);
	}
	
	catch(Exception e)
	{
	    e.printStackTrace();
		ret_code = "000001";
		ret_message = "查询产品业务代码失败2dGrpUserMsgAdd biz_code,请检查产品配置!";
	}
	%>


	var response = new AJAXPacket();
	
	var retType = "";
	var retCode = "";
	var retMessage = "";
	var flag_1001 = "";
	var flag_1002 = "";
	var biz_code = "";
	
	retType = "<%=retType%>";
	retCode = "<%=ret_code%>";
	retMessage = "<%=ret_message%>";
	flag_1001 = "<%=flag_1001%>";
	flag_1002 = "<%=flag_1002%>";
	biz_code = "<%=biz_code%>";
	response.data.add("retType",retType);
	response.data.add("retCode",retCode);
	response.data.add("retMessage",retMessage);
	response.data.add("flag_1001",flag_1001);
	response.data.add("flag_1002",flag_1002);
	response.data.add("biz_code",biz_code);
	core.ajax.receivePacket(response);

