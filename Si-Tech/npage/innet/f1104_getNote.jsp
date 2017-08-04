<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.02
update:liubo@2008.11.10
       修改资费说明提取位置。
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
        //得到输入参数
        //ArrayList retArray = new ArrayList();
        //String return_code,return_message;
        String retuncode,returnmsg;
        String detail_code="";
        String mode_note="";
        String re_adddetail="";
        String re_adddetailnote="";
        String re_funcstr="";
       
        //String[][] result = new String[][]{};
 	    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
 	    
	    String retType = request.getParameter("retType");
	    String op_code = request.getParameter("opCode");
		String regionCode = request.getParameter("regionCode");
	    String mode_code  = request.getParameter("mode_code");
	    
	    String add_detail = request.getParameter("add_detail");
	    System.out.println("add_detail==="+add_detail);
	    
	    String add_detail_tmp = request.getParameter("add_detail2");
	    
	    String[] add_detail2 = add_detail_tmp.split(",");
	    
	    for(int kk=0;kk<add_detail2.length;kk++)
	      System.out.println("add_detail2==="+add_detail2[kk]);
	        
	    
	    String funcstr=request.getParameter("funcstr");
	    String smcode=request.getParameter("smcode");
	    
	    String sqlStr = " select note from sInvNote "+
		 				"  where region_code ='"+regionCode+"'"+ 
		 				"    and op_code='"+op_code+"'";
						
		//String ret_code  = "";
		//String ret_message  = "";
		String note = "";	     
 %>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="ret_message" outnum="1">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
 <% 
        
      	//retArray = impl.sPubSelect("1",sqlStr); 
        //result = (String[][])retArray.get(0);
		int recordNum = 1;
			
if(ret_code.equals("000000")||ret_code.equals("0")){
	        System.out.println("***********************************调用服务成功  in f1104_getNote.jsp");
				if(result.length!=0){
				      if(result[0][0].equals(""))
						{
							recordNum=0;
						}else{
							recordNum = 1;
							note = result[0][0];
						}
			            if(recordNum == 1)
			            {   
			              ret_code  = "000000";
			              retuncode="000000";
			              returnmsg=ret_message;
			             }
			            else
			            {
			                ret_code = "000001";
			                retuncode="000001";
			                 returnmsg=ret_message;
			            }
				
				}
      }else{
	                    System.out.println("***********************************调用服务失败  in f1104_getNote.jsp");
				          ret_code = "000002";
				          retuncode="000002";
				          
			              ret_message = "调用服务(sPubSelect)失败！";
			               returnmsg=ret_message;
        }
		
      
     
       
         	String sqlStr1 = "select detail_code from sbillmodedetail "+
		"where region_code = '"+regionCode+"'"+ 
		" and mode_code='"+mode_code+"' and detail_type='0'";
		
System.out.println("sqlStr1    "+sqlStr1);
	//	retArray = impl.sPubSelect("1",sqlStr1); 
	//	result = (String[][])retArray.get(0);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="ret_message1" outnum="1">
<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />
<%
    if(ret_code1.equals("000000")||ret_code1.equals("0")){
     System.out.println("***********************************调用服务成功1  in f1104_getNote.jsp");
           retuncode="000000";
            returnmsg=ret_message1;
           if(result1.length!=0){
                 if(result1[0][0]==null || result1[0][0].equals(""))
			       {
					detail_code=" ";
					}else{
					detail_code=result1[0][0];
					}
           
           }
		 
    }else{
        System.out.println("***********************************调用服务失败1  in f1104_getNote.jsp");
        ret_code1 = "000002";
        retuncode="000002";
        ret_message1 = "取主资费的二次批价代码失败！";
        returnmsg=ret_message1;
  	}
		

	/*String sqlStr2 = "select a.mode_note from sBillModeDes a , "+
	"(select  region_code , mode_code,detail_code from sbillmodedetail  where region_code = '"+regionCode+"' and mode_code in ("+add_detail+")  and detail_type='0') b "+
	"where a.region_code = '"+regionCode+"'"+ 
	" and a.mode_code in ("+add_detail+") and  a.rate_code = b.detail_code(+)";
	System.out.println("sqlStr2    "+sqlStr2); */
		 
    String groupId =(String)session.getAttribute("groupId");		
%>
<wtc:service name="s9611Cfm3" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code2" retmsg="ret_message2"  outnum="4" >
    <wtc:param value="<%=op_code%>"/>
    <wtc:param value="1"/>
    <wtc:param value="2"/>
    <wtc:param value="<%=groupId%>"/>
    <wtc:params value="<%=add_detail2%>"/>
    <wtc:param value="10442"/>
    <wtc:param value="<%=regionCode%>"/>
    <wtc:param value="<%=smcode%>"/>
</wtc:service>
<wtc:array id="result2" scope="end" />	
<%
	//retArray = impl.sPubSelect("1",sqlStr2); 
	//result = (String[][])retArray.get(0);
	System.out.println("************第一次调用服务s9611Cfm2成功*******");

if(ret_code2.equals("000000")||ret_code2.equals("0")){
	 retuncode="000000";
	 returnmsg=ret_message2;
     int recordNum2 = result2.length;      		
		 for(int i=0;i<recordNum2;i++){
			re_adddetailnote=re_adddetailnote+result2[i][0]+"~";
			System.out.print("re_adddetailnote==="+re_adddetailnote);
		 }
   }
   else
	{
		System.out.println("******************第一次调用服务s9611Cfm2*****失败************");
		ret_code2 = "000002";
		retuncode="000002";
		ret_message2 = "取附加资费说明失败！";
		returnmsg=ret_message2;
	}
		
		String sqlStr3 = "select detail_code from sbillmodedetail "+
		"where region_code = '"+regionCode+"'"+ 
		" and mode_code in ("+add_detail+") and  detail_type='0'";
		//System.out.println("sqlStr3====="+sqlStr3);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code3" retmsg="ret_message3" outnum="1">
<wtc:sql><%=sqlStr3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result3" scope="end" />
<%
	//retArray = impl.sPubSelect("1",sqlStr3); 
	//result = (String[][])retArray.get(0);
	if(ret_code3.equals("000000")||ret_code3.equals("0")){
			System.out.println("***********************************调用服务3成功  in f1104_getNote.jsp");
			retuncode="000000";
			returnmsg=ret_message3;
			int recordNum3 = result3.length;   
			System.out.println("recordNum3    "+recordNum3);   		
			for(int l=0;l<recordNum3;l++){
				System.out.println("re_adddetail   "+ re_adddetail+"   "+recordNum3 );
				re_adddetail=re_adddetail+result3[l][0]+"~";
	      	}
	       }else{
				System.out.println("***********************************调用服务3失败  in f1104_getNote.jsp");
				ret_code3 = "000002";
				retuncode="000002";
				ret_message3 = "取附加资费的二次批价代码失败！";
				returnmsg=ret_message3;
		      }
		
    int inputNumber = 3;
	String   outputNumber = "6";
	String  inputParsm [] = new String[inputNumber];
	//System.out.println("detail_code"+detail_code);
	if(detail_code.trim().equals("")){
		detail_code="@@@@";
	}
	
	//inputParsm[0] = regionCode;
	//inputParsm[1] = mode_code;
	//inputParsm[2] = detail_code;
	//value = viewBean.callService("0", null, "s1270ModeNote", "7", inputParsm);
	//System.out.println("***********************************开始调用服务s1270ModeNote  in f1104_getNote.jsp");
%>
<wtc:service name="s9611Cfm3" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode4" retmsg="retMsg4"  outnum="4" >
    <wtc:param value="<%=op_code%>"/>
    <wtc:param value="1"/>
    <wtc:param value="2"/>
    <wtc:param value="<%=groupId%>"/>
    <wtc:param value="<%=mode_code%>"/>
    <wtc:param value="10442"/>
    <wtc:param value="<%=regionCode%>"/>
    <wtc:param value="<%=smcode%>"/>
</wtc:service>
<wtc:array id="initBack" scope="end" />	

<%
	//String[][] initBack=value.getData();
    //return_code = initBack[0][0];
	//String return_msg = initBack[0][1]; 
 if(retCode4.equals("000000")||retCode4.equals("0")){
 	System.out.println("**********************第二次调用服务s9611Cfm2成功*************");	
		retuncode="000000";
		returnmsg=retMsg4;
		if(initBack.length!=0){
			mode_note=initBack[0][0];
			mode_note = mode_note.replaceAll("\"","");
			mode_note = mode_note.replaceAll("\'","");
			System.out.println("mode_note==="+mode_note);
        }	
    }else{
    	  retuncode=retCode4;
    	  returnmsg=retMsg4;
  	}	      
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var note = "";
var detailcode="";
var adddetailcode=""
var adddetailcodenote=""
var re_funcstr="";

retType = "<%=retType%>";
retCode = "<%=retuncode%>";
retMessage = "<%=returnmsg%>";
note = "<%=note%>";
detailcode="<%=detail_code%>";
adddetailcode="<%=re_adddetail%>";
adddetailcodenote="<%=re_adddetailnote%>";
mode_note="<%=mode_note%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("note",note);
response.data.add("detailcode",detailcode);
response.data.add("adddetailcode",adddetailcode);
response.data.add("mode_note",mode_note);
response.data.add("adddetailcodenote",adddetailcodenote);
response.data.add("re_funcstr",re_funcstr);
core.ajax.receivePacket(response);

