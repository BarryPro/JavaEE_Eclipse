<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.03
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>


<%@ page import="com.sitech.util.Tools"%>
<%@ page import="com.sitech.util.getfilestring"%>

<%
        //得到输入参数   
        String path=request.getRealPath("");    
       // Logger logger = Logger.getLogger("fgetwritename_1104.jsp");
       // ArrayList retArray = new ArrayList();         
        String[][] result = new String[][]{};
 		//comImpl co=new comImpl();
	    //--------------------------
	    String retType = request.getParameter("retType"); 
 	    String region_code = request.getParameter("region_code");
 	    String sim_type = request.getParameter("sim_type");
 	    String prov_code=request.getParameter("prov_code");
 	    String card_type=request.getParameter("card_type");
 	    String card_no=request.getParameter("card_no");
 	    String sim_data=request.getParameter("sim_data");
 	    System.out.println("lcmlcmsim_data="+sim_data);
	    String s2= new String();
	    String crc=new String();
	    //返回值定义
       String retCode = "";
        String retMessage = "";
		String write_name = "";
		String ver="";
		String pass="";
        	//查询空卡信息是否正确
        	
        	/*转换sim数据*/
        	Tools tools = new Tools();        //com.sitech.util.Tools  保留
     			 	//sim_data="898600600815F3630008,460003636010008,95C73A293138079FBAC5B6B2648DD4CA,+8613800451500,1668,5678,41508426,83228098";
      		
      		System.out.println("sim_data="+sim_data);
		String simsim1=sim_data.substring(0,12);
		System.out.println("simsim1="+simsim1);
		String simsim2=sim_data.substring(13,70);
		String simsim3=sim_data.substring(71,sim_data.length());
		System.out.println("simsim2="+simsim2);
      		String simdata=simsim1+prov_code+simsim2+"+"+simsim3;
      		crc=tools.stringOfCalCRC(simdata.getBytes(), simdata.length());
      		System.out.println("crccrccrccrccrccrc="+crc);
      		String simsimdata=simdata+crc;
      		System.out.println("simsimdata="+simsimdata);
        	
        	
        	String sqcard="select card_no from dBlkCardRes where card_no='"+card_no+"' and status='0' and res_code='"+sim_type+"'";   
        System.out.println("sqcard_________________________________________________");	  
		System.out.println(sqcard);

%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqcard%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
<%
		 if(retCode1.equals("000000")||retCode1.equals("0")){
           		 //retArray = co.spubqry32("1",sqcard,"region",region_code);
           		 //result = (String[][])retArray.get(0); 
           		 if(result1.length==0)
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
									        				String sq1="select write_name,ver,pass_data from writecardcfg where sim_type='"+sim_type+"' and prov_code='"+prov_code+"' and card_type='"+card_type+"'";    
									        				 System.out.println("sq1_________________________________________________");	   
													    	 System.out.println(sq1);
									            				//retArray = co.spubqry32("3",sq1,"region",region_code);
									            				//result = (String[][])retArray.get(0);            
														//System.out.println(result[0][0]);
														//if(result==null)
														
														%>
			           								         <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
																	<wtc:sql><%=sqcard%></wtc:sql>
																	</wtc:pubselect>
																	<wtc:array id="result2" scope="end" />
			           								<%
														 if(retCode2.equals("000000")||retCode2.equals("0")){
																					if(result2.length==0)
																					{
																              					retCode="000001";
																			  		           	retMessage="写卡组件不存在！"; 			  
																					}
																					else
																					{
																              					retCode="000000";
																						  			retMessage="写卡组件查找成功！";
																						  			write_name=result2[0][0];
																						  			ver=result2[0][1];
																						  			pass=result2[0][2];
																														  			        try
																											        					{
																											        						getfilestring getstr=new getfilestring();
																											        						System.out.println(path+"/ocx/"+write_name+".dll");
																																		s2=getstr.getstring1(path+"/ocx/"+write_name+".dll");
																																		
																											        
																											        					}
																														  			   catch(Exception e){
																																		retCode="000002";
																																		retMessage="查询写卡组件配置表失败！";
																																		System.out.println("sssssssssssssssssssssss");
																											            						logger.error("Call comImpl is Failed!");
																											        					}
																					}
																                      
									        			}else{
																					retCode="000002";
																					retMessage="查询写卡组件配置表失败！";
																					System.out.println("sssssssssssssssssssssss");
																            				//logger.error("Call comImpl is Failed!");
									        			}
												  	
			  
						}
                      
        	}else{
			retCode="000002";
			retMessage="空卡资源信息不存在！";
			System.out.println("sssssssssssssssssssssss");
            		
        	}
		//查询语句
		

		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var write_name="";
var ver="";
var s2="";
var simsimdata="";
var pass="";
  
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
write_name="<%=write_name%>";
ver="<%=ver%>";
pass="<%=pass%>";
s2="<%=s2%>"
simsimdata="<%=simsimdata%>";

  
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("write_name",write_name);
response.data.add("ver",ver);
response.data.add("pass",pass);
response.data.add("s2",s2);
response.data.add("simsimdata",simsimdata);
core.ajax.receivePacket(response);

