<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.02
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>

<%
        //得到输入参数
        //ArrayList retArray = new ArrayList();
        //String return_code,return_message;
        String detail_code="";
        String mode_note="";
        String re_adddetail="";
        String re_adddetailnote="";
        String re_funcstr="";
       
      //  String[][] result = new String[][]{};
 //	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	   
	    String retType = request.getParameter("retType");
	    String regionCode = request.getParameter("regionCode");
	    String mode_code = request.getParameter("mode_code");
	    String pay_money = request.getParameter("pay_money");
	    String sqlStr = "select award_id from sopenlikecfg "+
		 				"where region_code = '"+regionCode+"'"+ 
		 				" and mode_code='"+mode_code+"'"+
		 				" and to_number('"+pay_money+"')>=money_beg and to_number('"+pay_money+"')<money_end";
						
		System.out.println("sqlStr999999999999999999999999999999999999=["+sqlStr+"]");
	    //String ret_code  = "";
        //    String ret_message  = "";
	    String award = "";
%>
<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="ret_message"  outnum="2" >
       <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:service>
<wtc:array id="result" scope="end" />
<%     
    
      		//retArray = impl.sPubSelect("1",sqlStr); 
             //   result = (String[][])retArray.get(0);
             
       if(ret_code.equals("0")||ret_code.equals("000000")){
		       	if(result[0][0].equals(""))
				{
					award="0";
				}else{
					award=result[0][0];
				}
					
		            ret_code = "000000";
		            ret_message = "成功！";
       
      }else{
		      	
		            ret_code = "000002";
		            ret_message = "调用服务(spubqry32)失败！";
		            
		       
      	
      	
      	}
	
            
            
       
        
        
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var award = "";


retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
award = "<%=award%>";



response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("award",award);
core.ajax.receivePacket(response);

