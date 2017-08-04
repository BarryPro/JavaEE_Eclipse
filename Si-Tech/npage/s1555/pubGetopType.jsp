<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2008.12.31
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>	
<%@ page contentType= "text/html;charset=gbk" %>

<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>

<%@ page import="org.apache.log4j.Logger"%>
<%
        //得到输入参数      
        Logger logger = Logger.getLogger("pubGetopType.jsp");
	    String retType = request.getParameter("retType"); 
	    String awardtype = request.getParameter("awardtype"); 
 	    String awardop_code = request.getParameter("awardop_code");
  	    String cust_id=request.getParameter("cust_id");
 	    String region_code=request.getParameter("regionCode");
	    
	    //返回值定义
        String retCode = "";
        String retMessage = "";
		String sim_type = "";
        String sim_typename = "";	

		//查询语句
		//String sq1="select count(*) from dbillcustdetail a,sawardop b where a.id_no=to_number('"+cust_id+"') and a.mode_status='Y' and a.mode_flag=b.mode_flag and a.mode_code=b.mode_code and b.awardtype_code='"+awardtype+"' and b.awardop_code='"+awardop_code+"'";     
		String sq1 = "select count(*) from product_offer_instance a ,sawardop b where a.serv_id=TO_NUMBER ('"+cust_id+"') and a.state='A' and a.exp_date>sysdate and a.offer_id = b.mode_code    AND b.awardtype_code = '"+awardtype+"'  AND b.awardop_code = '"+awardop_code+"'";
		String [] paraIn = new String[2];
		paraIn[0] = "select count(*) from dbillcustdetail a,sawardop b where a.id_no=to_number(:cust_id) and a.mode_status='Y' and a.mode_flag=b.mode_flag and a.mode_code=b.mode_code and b.awardtype_code=:awardtype and b.awardop_code=:awardop_code";    
        paraIn[1] = "cust_id="+cust_id+",awardtype="+awardtype+",awardop_code="+awardop_code;
        try
        {
            //retArray = co.spubqry32("1",sq1,"region",region_code);
%>
	
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:sql><%=sq1%></wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="result" scope="end"/>
<%
        String test[][] = result;
		//System.out.println("result[0][0]====="+result[0][0]);
		//System.out.println("retCode1====="+retCode1);
		if(result[0][0].equals("0"))
		{
  			retCode="000001";
  			System.out.println("用户没有中奖");
		  	retMessage="用户不符合领奖条件!"; 			  
		}
		else
		{
			String award_time="",award_time1="",award_date="",award_date1="";
			String sq6="select nvl(max(to_char(op_time,'YYYYMMDDhh24mmss')),0) from smodeawardinfo where id_no=to_number('"+cust_id+"') and awardtype_code='"+awardtype+"' and awardop_code='"+awardop_code+"'";   
			String [] paraIn2 = new String[2];
			paraIn2[0] = "select nvl(max(to_char(op_time,'YYYYMMDDhh24mmss')),0) from smodeawardinfo where id_no=to_number(:cust_id) and awardtype_code=:awardtype and awardop_code=:awardop_code";   
	        paraIn2[1] = "cust_id="+cust_id+",awardtype="+awardtype+",awardop_code="+awardop_code;
			 try
    			{
    				//retArray = co.spubqry32("1",sq6,"region",region_code);
%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
					<wtc:sql><%=sq6%></wtc:sql>
					</wtc:pubselect>	
					<wtc:array id="result"  scope="end"/>
<%
					if(retCode2.equals("000000") && result.length>0)
    					award_date= result[0][0];
    				//System.out.println("retCode2===="+retCode2);
    				//System.out.println("sq6===="+sq6);
    			}
    			catch(Exception e){
					retCode="000004";
					retMessage="查询是否领取奖品失败！";
    				logger.error("Call comImpl is Failed2!");
				}
    		//String sq7="select nvl(to_char(begin_time,'YYYYMMDDhh24mmss'),0) from dbillcustdetail a,sawardop b where a.id_no=to_number('"+cust_id+"') and a.mode_status='Y' and a.mode_flag=b.mode_flag and a.mode_code=b.mode_code and b.awardtype_code='"+awardtype+"' and b.awardop_code='"+awardop_code+"'";     
    		String sq7 ="select NVL (TO_CHAR (a.eff_date, 'YYYYMMDDhh24mmss'), 0) from product_offer_instance a ,sawardop b where a.serv_id=TO_NUMBER ('"+cust_id+"') and a.state='A' and a.exp_date>sysdate and a.offer_id = b.mode_code    AND b.awardtype_code = '"+awardtype+"'  AND b.awardop_code = '"+awardop_code+"'";
			System.out.println(sq7); 
			String [] paraIn3 = new String[2];
			paraIn3[0] = "select nvl(to_char(begin_time,'YYYYMMDDhh24mmss'),0) from dbillcustdetail a,sawardop b where a.id_no=to_number(':cust_id') and a.mode_status='Y' and a.mode_flag=b.mode_flag and a.mode_code=b.mode_code and b.awardtype_code=:awardtype and b.awardop_code=:awardop_code";     
	        paraIn3[1] = "cust_id="+cust_id+",awardtype="+awardtype+",awardop_code="+awardop_code;
			 try
    			{
    				//retArray = co.spubqry32("1",sq7,"region",region_code);
%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode3" retmsg="retMsg3" outnum="1">			
					<wtc:sql><%=sq7%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="result" scope="end"/>
<%
    				if(retCode3.equals("000000") && result.length>0){
    					if(result.length>0)
    					award_date1 = result[0][0];
    				}
    				//System.out.println("sq7===="+sq7);
    				//System.out.println("retCode3===="+retCode3);
    			}
    			catch(Exception e){
					retCode="000005";
					retMessage="查询是否领取奖品失败！";
    				logger.error("Call comImpl is Failed!3");
				}
    			    System.out.println("award_date===="+award_date);  	
    			     System.out.println("award_date1===="+award_date1);  		
    			if(Double.parseDouble(award_date)>Double.parseDouble(award_date1)){
    			
    				retCode="000003";
          			retMessage="奖品已领取！";
    			}
    			else{
    				String sq2="select count(*) from smodeawardinfo where id_no=to_number('"+cust_id+"') and awardtype_code='"+awardtype+"' and awardop_code='"+awardop_code+"'";   
					System.out.println("sql4===="+sq2);
					String [] paraIn4 = new String[2];
					paraIn4[0] = "select count(*) from smodeawardinfo where id_no=to_number(:cust_id) and awardtype_code=:awardtype and awardop_code=:awardop_code";   
			        paraIn4[1] = "cust_id="+cust_id+",awardtype="+awardtype+",awardop_code="+awardop_code;
					  
			 	try{
					//retArray = co.spubqry32("1",sq2,"region",region_code);
%>
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_code%>" retcode="retCode4" retmsg="retMsg4" outnum="1">			
					<wtc:param value="<%=paraIn4[0]%>"/>
					<wtc:param value="<%=paraIn4[1]%>"/>
					</wtc:service>	
					<wtc:array id="result" scope="end"/>
<%
					
					System.out.println("retCode4===="+retCode4);
					if(!retCode4.equals("000000"))
					{	 
					String sq3="select nvl(trunc(months_between(sysdate,to_date(to_char(max(begin_time),'yyyymm')||'01','yyyymmdd')),0),0) from dbillcustdetail a,sawardop b where a.id_no=to_number('"+cust_id+"') and a.mode_status='N' and a.mode_flag=b.mode_flag and a.mode_code=b.mode_code and b.awardtype_code='"+awardtype+"' and b.awardop_code='"+awardop_code+"'";     
					String [] paraIn5 = new String[2];
					//paraIn5[0] = "select nvl(trunc(months_between(sysdate,to_date(to_char(max(begin_time),'yyyymm')||'01','yyyymmdd')),0),0) from dbillcustdetail a,sawardop b where a.id_no=to_number(:cust_id) and a.mode_status='N' and a.mode_flag=b.mode_flag and a.mode_code=b.mode_code and b.awardtype_code=:awardtype and b.awardop_code=:awardop_code";     
					paraIn5[0] = "select nvl(trunc(months_between(sysdate,to_date(to_char(max(begin_time),'yyyymm')||'01','yyyymmdd')),0),0)  from product_offer_instance a ,sawardop b where a.serv_id=TO_NUMBER (:cust_id) and a.state='A' and a.exp_date>sysdate and a.offer_id = b.mode_code    AND b.awardtype_code = :awardtype  AND b.awardop_code = :awardop_code";
			        paraIn5[1] = "cust_id="+cust_id+",awardtype="+awardtype+",awardop_code="+awardop_code;
					System.out.println("ppppppppppppppppppppppppppppppppppppppppppppp");
					
					try
					{
						//retArray = co.spubqry32("1",sq3,"region",region_code);
%>
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_code%>" retcode="retCode5" retmsg="retMsg5" outnum="1">			
					<wtc:param value="<%=paraIn5[0]%>"/>
					<wtc:param value="<%=paraIn5[1]%>"/>
					</wtc:service>	
					<wtc:array id="result" scope="end"/>
<%
					System.out.println("retCode5===="+retCode5);
					if(retCode5.equals("000000") && result.length>0){
						if(awardop_code.equals("0001")||awardop_code.equals("0002")||awardop_code.equals("0003")||awardop_code.equals("0004")){
							if(Integer.parseInt(result[0][0])>=1){
								retCode="000000";
  								retMessage="查询成功！";
							}else{
								retCode="000003";
  								retMessage="奖品已领取！";
							}
						}
						if(awardop_code.equals("0005")||awardop_code.equals("0006")||awardop_code.equals("0007")||awardop_code.equals("0009")){
							if(Integer.parseInt(result[0][0])>=6){
								retCode="000000";
  								retMessage="查询成功！";
							}else{
								retCode="000003";
  								retMessage="奖品已领取！";
							}
						}
						if(awardop_code.equals("0008")||awardop_code.equals("0010")){
							if(Integer.parseInt(result[0][0])>=12){
								retCode="000000";
  								retMessage="查询成功！";
							}else{
								retCode="000003";
  								retMessage="奖品已领取！";
							}

						}
					}
					}
					catch(Exception e){
						retCode="000004";
						retMessage="查询是否领取奖品失败！";
        						logger.error("Call comImpl is Failed5!");
    				}
				
      				}
      				else{
      					retCode="000000";
      					retMessage="查询成功！";
      				}
          				
          			}
          			catch(Exception e){
						retCode="000004";
						retMessage="查询是否领取奖品失败！";
        				logger.error("Call comImpl is Failed!");
    				}
    				
          		}
          	}
		  
		 // sim_type=result[0][0];
		  //sim_typename=result[0][1];
		
                  
    }catch(Exception e){
		retCode="000002";
		retMessage="查询业务类型失败！";
        logger.error("Call comImpl is Failed!");
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

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
//response.data.add("sim_type",sim_type);
//response.data.add("sim_typename",sim_typename);
core.ajax.receivePacket(response);
