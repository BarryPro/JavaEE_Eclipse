<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.29
********************/
%>

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
        //得到输入参数
        //ArrayList retArray = new ArrayList();
        String[][] result = new String[][]{};
		String[][] result1 = new String[][]{};
 		//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String phoneNo = request.getParameter("phoneNo");
		String region_code = request.getParameter("region_code");
		String payCode = "";
        String payWay = "";
        String smallestPrepay = "";
        String ret_coden  = "";
        String ret_messagen  = "";
        String prepay188="";
        String good_type="";
if(!phoneNo.substring(0,3).equals("188"))
{
	  String sqlStr1 = "select mode_dxpay "+
  						 "from dgoodphoneres a, sGoodBillCfg b "+
 						 "where a.bill_code = b.mode_code "+
   						 "and b.region_code = '"+region_code+"'"+
   						 "and a.phone_no = '"+phoneNo+"' and a.bak_field='1' and b.mode_dxpay>0 ";
		String sqlStr2 = "select prepay_fee "+
						 "from dgoodphoneres a, sBillModeCode b "+
 						 "where a.bill_code = b.mode_code "+
  						 "and b.region_code = '"+region_code+"'"+
  						 "and a.phone_no = '"+phoneNo+"'";
		String sqlStr = sqlStr1 + ";" + sqlStr2;
		System.out.println("sqlstr1    "+ sqlStr1);
		System.out.println("sqlstr2    "+ sqlStr2);
		int[] colNum = new int[]{1,1};
	    
        
      
      		//retArray = impl.sPubMultiSel(colNum,sqlStr); 
          // result = (String[][])retArray.get(0);
			//result1 = (String[][])retArray.get(1);
			 System.out.println("________________________");
%>
<wtc:mutilselect name="sPubMultiSel" routerKey="region" routerValue="<%=region_code%>" id="mutillist" type="list"  retcode="ret_code" retmsg="ret_message" >

 <wtc:sql><%=sqlStr%></wtc:sql>

</wtc:mutilselect>


<%
    ret_coden=ret_code;
	ret_messagen=ret_message;
            int recordNum = 1;
          System.out.println(ret_code+"   ret_code in f1104_13.jsp");
     if(ret_code.equals("0")||ret_code.equals("000000")){
               System.out.println("________________________sPubMultiSel服务调用成功! in f1104_13.jsp");
     				  result=    (String[][])mutillist.get(0); 
                    result1= (String[][])mutillist.get(1); 
										   System.out.println("_________________________________________________________________________");
												    for(int i=0;i<result.length;i++){
												      for(int j=0;j<result[i].length;j++){
												      System.out.println("result["+i+"]["+j+"]"+"   "+result[i][j]);
												      
												      }
												    
												    
												    }
											System.out.println("_________________________________________________________________________");
						
											System.out.println("_________________________________________________________________________");
												    for(int i=0;i<result1.length;i++){
												      for(int j=0;j<result1[i].length;j++){
												      System.out.println("result1["+i+"]["+j+"]"+"   "+result1[i][j]);
												      
												      }
												    
												    
												    }
											System.out.println("_________________________________________________________________________");


			     	if(result1[0][0].equals(" "))
						{ 
						   System.out.println("recordNum=0");
							recordNum=0;
						}
						
			            if(recordNum == 1)
			            {   
			            		System.out.println("recordNum=1");
			                payCode = result[0][0];
			            
			                smallestPrepay = result1[0][0];
			                System.out.println(smallestPrepay+"  smallestPrepay in f1104_13.jsp");
			                ret_coden  = "000000";
			            }
			            else
			            {
			                ret_coden = "000001";
			               
			            }
	
     
      }else{
    	  System.out.println("________________________sPubMultiSel服务调用失败! in f1104_13.jsp");
    	      ret_coden = "000002";
            ret_messagen = "调用服务(sPubMultiSel)失败！";
            
    	
    	}
		
            
   System.out.println("smallestPrepay  in f1104_13.jsp     "+smallestPrepay);   
 }
else
{
	String sql3=" select prepay_fee,good_type from dgoodphoneres where phone_no='"+phoneNo+"' ";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMessage" outnum="2">
		<wtc:sql><%=sql3%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultm" scope="end" />
<%
	ret_coden=retCode;
	ret_messagen=retMessage;
	if(retCode.equals("0")||retCode.equals("000000"))
	{
		if(resultm.length!=0)
 		{
 			ret_coden = "000000";
 			smallestPrepay=resultm[0][0];
 			good_type=resultm[0][1];
 			if(Float.parseFloat(smallestPrepay)==99999999)
 			{
 				String sql4=" select a.prepay_fee from d188reggoodprepaycfg a,dchngroupmsg b "+
      						" where a.group_id=b.group_id and b.boss_org_code='"+region_code+"'||'99999' and b.root_distance='2' "+
      						" and a.good_type='"+good_type+"' ";
      		%>
      		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMessage" outnum="1">
			<wtc:sql><%=sql4%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultq" scope="end" />
      		<%
      			if(retCode.equals("0")||retCode.equals("000000"))
				{
      				if(resultq.length!=0)
 					{	
      					smallestPrepay=resultq[0][0];
 			
      				}
      		
 				}else
 				{
 					ret_coden = "000002";
            		ret_messagen = "调用服务(sPubMultiSel)失败！";
 				}
 			}
 			
 		}else
 			{
 			   ret_coden = "000001";
 			}
	
	}
	else
	{
			ret_coden = "000002";
            ret_messagen = "调用服务(sPubMultiSel)失败！";
	}
	
}         
 		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var payCode = "";
var goodType="";
//var payWay = "";
var smallestPrepay = "";
retType = "<%=retType%>";
retCode = "<%=ret_coden%>";
retMessage = "<%=ret_messagen%>";
payCode = "<%=payCode%>";
goodType="<%=good_type%>";

smallestPrepay = "<%=smallestPrepay%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("payCode",payCode);
response.data.add("smallestPrepay",smallestPrepay);
response.data.add("goodType",goodType);
core.ajax.receivePacket(response);

