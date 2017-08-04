<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  

 
<%
     ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfoSession = (String[][])arrSession.get(0);
		String[][] otherInfoSession = (String[][])arrSession.get(2);
		String[][] pass = (String[][])arrSession.get(4);
		
		String loginNo = baseInfoSession[0][2];
		String loginName = baseInfoSession[0][3];
		String powerCode= otherInfoSession[0][4];
		String orgCode = baseInfoSession[0][16];
		String ip_Addr = request.getRemoteAddr();
		
		String regionCode = orgCode.substring(0,2);
		String regionName = otherInfoSession[0][5];
		String loginNoPass = pass[0][0];
     
     //得到输入参数   
     String path=request.getRealPath("");   
     ArrayList retArray = new ArrayList();         
     String[][] result = new String[][]{};
     
	    String retType = request.getParameter("retType"); 
 	    String region_code = request.getParameter("region_code");
 	    String sim_type = request.getParameter("sim_type");
 	    String prov_code=request.getParameter("prov_code");
 	    String card_type=request.getParameter("card_type");
 	    String card_no=request.getParameter("card_no");
 	    String sim_data=request.getParameter("sim_data");
	    String s2= new String();
	    String crc=new String();
	    //返回值定义
      String retCode = "";
      String retMessage = "";
		  String write_name = "";
		  String ver="";
		  String passwd="";
        	//查询空卡信息是否正确
        	
			/*转换sim数据*/
			Tools tools = new Tools();
			
			
			System.out.println("sim_data="+sim_data);
			String simsim1=sim_data.substring(0,12);
			System.out.println("FGETWRITENAME simsim1="+simsim1);
			/*
			String simsim2=sim_data.substring(13,sim_data.length());
			*/
			String simsim2=sim_data.substring(13,70);  // added by ludl
			String simsim3=sim_data.substring(70,71);
			String plus="";
			if(!simsim3.equals("+")){
				plus="+";
			}
      simsim3=sim_data.substring(70,sim_data.length());

			System.out.println("FGETWRITENAME simsim2="+simsim2);
			String simdata=simsim1+prov_code+simsim2+plus+simsim3;
			System.out.println("simdata new="+simdata);
			crc=tools.stringOfCalCRC(simdata.getBytes(), simdata.length());
			System.out.println("FGETWRITENAME crccrccrccrccrccrc="+crc);
			String simsimdata=simdata+crc;
			System.out.println("FGETWRITENAME simsimdata="+simsimdata);
        	
      String sqlsimtype="select sim_type from writecardcfg where card_type = '"+card_type+"' and prov_code = '"+prov_code+"' and rownum < 2";
	  	System.out.println("FGETWRITENAME sqlsimtype="+sqlsimtype);
%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sqlsimtype%>"/>
		</wtc:service>
		<wtc:array id="result111" scope="end"/>
<%	  	
	  try{
			//String sim_type_tmp= SqlFunction.findString(sqlsimtype);
	       if(result111.length>0)
			{
				sim_type=result111[0][0];
				System.out.println("FGETWRITENAME sim_type="+sim_type);
		   }
	  }catch(Exception e)
	  {
			System.out.println(e);
			/*retCode="000007";
			retMessage="查询SIM卡类型失败！";*/
			System.out.println("FGETWRITENAME 查询SIM卡类型失败！");
	  }
      String sqcard="select card_no from dBlkCardRes where card_no='"+card_no+"' and status='0' and res_code='"+sim_type+"'";     
		  System.out.println("FGETWRITENAME sqcard="+sqcard);
		  try
      {
      %>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sqcard%>"/>
		</wtc:service>
		<wtc:array id="result1112" scope="end"/>
<%	      
				if( result1112.length>0){
	      	result = result1112;
				}
	      if(result.length==0)
				{
	          retCode="000001";
				  	retMessage="空卡资源信息不存在！"; 
				  	System.out.println(retMessage);			  
				}
				else
				{
	          retCode="000000";
				  	retMessage="空卡资源信息查找成功！";
				  	try
	        	{
		        	String sq1="select write_name,ver,PASS_DATA from writecardcfg where sim_type='"+sim_type+"' and prov_code='"+prov_code+"' and card_type='"+card_type+"'";     
							System.out.println("FGETWRITENAME sq1="+sq1);
		  				al = oneboss.getCommONESQL(regionCode,sq1,2,0);
		  				
      %>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sq1%>"/>
		</wtc:service>
		<wtc:array id="result1113" scope="end"/>
<%
		  				
							if( result1113.length>0){
				      	result = result1113;
							}
							if(result.length==0)
							{
		             	retCode="000001";
					  			retMessage="写卡组件不存在！"; 			  
							}
							else
							{
		              retCode="000000";
					  			retMessage="写卡组件查找成功！";
					  			write_name=result[0][0].trim();
					  			ver=result[0][1].trim();
					  			passwd=result[0][2].trim();
					  			try
		        			{
		        					  System.out.println(write_name);
		        						getfilestring getstr=new getfilestring();
		        						System.out.println(path+"/ocx/"+write_name+".dll");
												s2=getstr.getstring1(path+"/ocx/"+write_name+".dll");
												//System.out.println("FGETWRITENAME s2="+s2);
		        			}
					  			catch(Exception e){
									  System.out.println(e);
										retCode="000002";
										retMessage="查询写卡组件配置表失败！";
										System.out.println("FGETWRITENAME sssssssssssssssssssssss");
		        			}
							}
	                      
	        	}catch(Exception e){
					  System.out.println(e);
							retCode="000002";
							retMessage="查询写卡组件配置表失败！";
							System.out.println("FGETWRITENAME sssssssssssssssssssssss");
	        	}
				}
                      
      }catch(Exception e){
		        System.out.println(e);
				retCode="000002";
				retMessage="空卡资源信息不存在！";
				System.out.println("FGETWRITENAME sssssssssssssssssssssss");
      }
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var write_name="";
var ver="";
var s2="";
var pass="";
var simsimdata="";
  
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
write_name="<%=write_name%>";
ver="<%=ver%>";
s2="<%=s2%>";
pass="<%=passwd%>";
simsimdata="<%=simsimdata%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("write_name",write_name);
response.data.add("ver",ver);
response.data.add("s2",s2);
response.data.add("pass",pass);
response.data.add("simsimdata",simsimdata);
core.ajax.receivePacket(response);

