<%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-14 页面改造,修改样式
	********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String loginNo=(String)session.getAttribute("workNo");    //工号 
	String loginName =(String)session.getAttribute("workName");//工号名称  	
	String orgCode = (String)session.getAttribute("orgCode");      
	String regionCode = (String)session.getAttribute("regCode");    
	String ip_Addr = request.getRemoteAddr();
%>

<%
    String [][] retStr = new String[][]{};
    String  error_code = "";
    String error_msg="系统错误，请与系统管理员联系";
    int valid = 1;  //0:正确，1：系统错误，2：业务错误,3:校验网外号码在系统没有记录 不显示错误提示

    double dTotalOwe=0.00;
    String sTotalOwe="";
    
    
    
    

    String login_no = request.getParameter("loginNo");  /* 操作工号 */
    String phone_no = request.getParameter("phoneNo");
    String op_code  = request.getParameter("opCode");
    String org_code = request.getParameter("orgCode");
    String zhww     = request.getParameter("ZHWW");    //综合v网标记
    String phone_type = request.getParameter("phone_type");    //运营商
    String iRegion_Code = org_code.substring(0,2);
    if(("0".equals(phone_no.substring(0,1)))||("130".equals(phone_no.substring(0,3)))
        ||("131".equals(phone_no.substring(0,3)))||("132".equals(phone_no.substring(0,3)))
        ||("133".equals(phone_no.substring(0,3)))||("153".equals(phone_no.substring(0,3)))
        ||("155".equals(phone_no.substring(0,3)))||("156".equals(phone_no.substring(0,3)))){ //非移动号码
         
         System.out.println(phone_type);
         if("0".equals(zhww)){
             valid=2;
             error_code="-2";
             error_msg="智能网不是综合v网，不能添加非移动号码!";
         }else
         	{
         	   
         	    if("0".equals(phone_type))
         	      {
                     valid=2;
                     error_code="-4";
                     error_msg="运营商错误，不能为移动!";
               }else{
         
         	   
         	        //在dvpmnotherusermsg中是否有记录
         	        String sql="select count(*) from dvpmnotherusermsg where phone_no='"+ phone_no +"'";
         	        //String[][] result = new String[][]{};
         	        //ArrayList retArray1 = new ArrayList();
         	        int  iCountNum=0;
         	        %>
         	        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sql%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />	
         	        
         	        <%         	        
         	        //retArray1 = callView.sPubSelect("1",sql);
         	        // result = (String[][])retArray1.get(0);         	        
         	        iCountNum=Integer.parseInt(result[0][0]);
         	        if(iCountNum>0){
         	               valid=2;
                         error_code="-3";
                         error_msg="智能网非移动号码表中已经存在改号码"+phone_no+"，不能再添加!";
         	         }else{
         	              System.out.println(iCountNum);
         	              valid=3;
         	        }
         	     }
         }
        
    }else{
    	  try
           {
             /*ArrayList paramsIn = new ArrayList();
             paramsIn.add(new String[]{login_no    });
             paramsIn.add(new String[]{phone_no    });
             paramsIn.add(new String[]{op_code     });
             paramsIn.add(new String[]{org_code    });*/
             String[] paramsIn2417 = new String[4];
             paramsIn2417[0]=login_no;
             paramsIn2417[1]=phone_no  ;
             paramsIn2417[2]=op_code ;
             paramsIn2417[3]=org_code ;             
         
             //retStr = callView.callService("s2417Init", paramsIn, "38", "region", iRegion_Code);
	     %>	    
	     <wtc:service name="s2417Init" routerKey="region" routerValue=" <%=iRegion_Code%>" retcode="retCode2417" retmsg="retMsg2417" outnum="38">
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=op_code%>"/>	
		<wtc:param value="<%=org_code%>"/>			
	     </wtc:service>
	      <wtc:array id="retStrArray" scope="end" />
	      
	     
	     <%	  
	      System.out.println("retStrArray==="+retStrArray.length);
	      System.out.println("retMsg2417==="+retMsg2417);
	      System.out.println("retCode2417==="+retCode2417);
	        System.out.println("login_no==="+login_no);
	      System.out.println("phone_no==="+phone_no);
	        System.out.println("op_code==="+op_code);
	          System.out.println("org_code==="+org_code);
	      
	     for(int ii=0;ii<retStrArray.length;ii++){
	          for(int jj=0;jj<retStrArray[0].length;jj++){
	                 System.out.println("retStrArray["+ii+"]["+jj+"]==="+retStrArray[ii][jj]);
	          }
	     }
	     
	     retStr = retStrArray;	              
             error_code = retCode2417;
             error_msg=retMsg2417;                      
             ArrayList paramsIn1 = new ArrayList();
             paramsIn1.add(new String[]{"grp"    });
             paramsIn1.add(new String[]{"1"    });
             paramsIn1.add(new String[]{login_no     });
             paramsIn1.add(new String[]{op_code    });
	     paramsIn1.add(new String[]{phone_no    });
             paramsIn1.add(new String[]{""    });
             paramsIn1.add(new String[]{"s2417Init"     });
             paramsIn1.add(new String[]{"date"    });
	     paramsIn1.add(new String[]{"2"    });
             paramsIn1.add(new String[]{"1"    });
             
             if(!error_code.equals("000000")){
             paramsIn1.add(new String[]{error_msg     });
             paramsIn1.add(new String[]{""    });
	     paramsIn1.add(new String[]{""    });
	     //retStrerr = callView.callService("SoxLogCfm", paramsIn1, "2", "region", iRegion_Code);  
	     %>
	     <wtc:service name="SoxLogCfm" outnum="2" retmsg="retMsg2" retcode="retCode2" routerKey="region" routerValue="<%=iRegion_Code%>">
		<wtc:param value="grp"/>
		<wtc:param value="1"/>
		<wtc:param value="<%=login_no%>"/>	
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value=""/>
		<wtc:param value="s2417Init"/>	
		<wtc:param value="date"/>	
		<wtc:param value="2"/>	
		<wtc:param value="1"/>	
		<wtc:param value="<%=error_msg%>"/>
		<wtc:param value=""/>	
		<wtc:param value=""/>		
	     </wtc:service>
	      <wtc:array id="retStrerr" scope="end" />	     
	     <%      
             }
             //if(!retStr[5].equals("A")){
             if(!retStr[0][5].equals("A")){
             error_msg="用户状态非正常";
             paramsIn1.add(new String[]{error_msg     });
             paramsIn1.add(new String[]{""    });
	     paramsIn1.add(new String[]{""    });
              //retStrerr = callView.callService("SoxLogCfm", paramsIn1, "2", "region", iRegion_Code);
             %>
               <wtc:service name="SoxLogCfm" outnum="2" retmsg="retMsg3" retcode="retCode3" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="grp"/>
			<wtc:param value="1"/>
			<wtc:param value="<%=login_no%>"/>	
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value=""/>
			<wtc:param value="s2417Init"/>	
			<wtc:param value="date"/>	
			<wtc:param value="2"/>	
			<wtc:param value="1"/>	
			<wtc:param value="<%=error_msg%>"/>
			<wtc:param value=""/>	
			<wtc:param value=""/>	
	       </wtc:service>
	      <wtc:array id="retStrerr" scope="end" />	              
             <%
             }
             System.out.println(retStr[0][5]+"====================");
             }catch(Exception e){
               
           }
           
           if( retStr == null ){
                   valid = 1;
            }else if (!error_code.equals("000000")) {
                   valid = 2;
            }else{
                    valid = 0;
            if (Double.parseDouble(retStr[0][18]) > Double.parseDouble(retStr[0][17]))
             {
                  System.out.println("Double.parseDouble(retStr[0][17])=="+Double.parseDouble(retStr[0][17]));
                  sTotalOwe = "0.00";
             }else {
             	  System.out.println("2  retStr[0][18]=="+Double.parseDouble(retStr[0][18]));
                  dTotalOwe = Double.parseDouble(retStr[0][17])-Double.parseDouble(retStr[0][18]);
                  String tmp1 = Double.toString(dTotalOwe*100+0.5);
                  if (tmp1.indexOf(".")!=-1){
                        String tmp2 = tmp1.substring(0,tmp1.indexOf("."));
                        double tmp3 = Double.parseDouble(tmp2);
                        sTotalOwe = Double.toString(tmp3/100);
                     } 
             }
          }

    }
    
    

  
%>

<%if( valid != 0 &&  valid != 3 ){%>
<html>
<head>
<script language="JavaScript">

<!--
  function err_init()
  {
    rdShowMessageDialog("<br>错误代码:["+"<%=error_code %>]</br>"+"错误信息:["+"<%=error_msg %>"+"]");
    //alert("错误代码:["+"<%=error_code %>] "+"错误信息:["+"<%=error_msg %>"+"]");
    window.close();
  }
//-->
</script>
</head>
<body onLoad="err_init();">
</body>
</html>
<%}else if(valid==3){%>
<html>
<head>
<title>添加用户信息</title>
<script language="JavaScript">

    //定义应用全局的变量
   
    //core.loadUnit("debug");
   // core.loadUnit("rpccore");
    onload=function()
    {
        
        //core.rpc.onreceive = doProcess;
    }

    //---------1------RPC处理函数------------------
    function doProcess(packet){
        //使用RPC的时候,以下三个变量作为标准使用.
        error_code = packet.data.findValueByName("errorCode");
        error_msg =  packet.data.findValueByName("errorMsg");
        verifyType = packet.data.findValueByName("verifyType");
        backArrMsg = packet.data.findValueByName("backArrMsg");

        self.status="";

    }
    function save_to(){

        
       //if(document.frm.custName.value==""){
       	//   alert("客户姓名不能为空!");
       	//   return false;
       //	}
      // if(document.frm.idIccid.value=="") {
       //	   alert("证件号码不能为空!");
       //	   return false;
       //	 }  
        var str="";       
        str = document.frm.custName.value.trim() + "|" + document.frm.idIccid.value.trim();
         

        //alert(str);
        window.returnValue=str;
        window.close();
    }

    function quit(){
        window.close();
    }


</script>

</head>
<body>
<%
	String opCode = "3210";	
	String opName = "添加用户信息";	//header.jsp需要的参数   
%>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">添加用户信息</div>
	</div>
        <table cellspacing="0">          
          <tr>
            <td class="blue" >客户名称</td>
            <td>
            <input name="custName" type="text" class="button" id="custName" > <font color="#FF0000">可空</font>
            </td>            
          </tr>
          <tr>
            <td class="blue" >证件号码</td>
            <td >
            	<input name="idIccid" type="text" class="button" id="idIccid" > <font color="#FF0000">可空</font>
            </td>           
          </tr>           
        </table>
        <table cellspacing="0">
		<tr> 
			<td id="footer"> 
			  <input name="confirm" type="button" class="b_foot" id="confirm" value="确认" onClick="save_to()">			    		
			    		&nbsp;
			    		<input name="return" type="button" class="b_foot" id="return" value="返回" onClick="quit()">			               
			   	</td>
		</tr>
  	</table>
  	 <%@ include file="/npage/include/footer_pop.jsp" %> 
</form>
</body>
</html>

<%}else{%>
<html>
<head>
<title>用户信息</title>
<script language="JavaScript">
<!--
    //定义应用全局的变量
    var SUCC_CODE   = "0";          //自己应用程序定义
    var ERROR_CODE  = "1";          //自己应用程序定义
    var YE_SUCC_CODE = "0000";      //根据营业系统定义而修改

    var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";

    //core.loadUnit("debug");
    //core.loadUnit("rpccore");
    onload=function()
    {
        init();
        //core.rpc.onreceive = doProcess;
    }

    //---------1------RPC处理函数------------------
    function doProcess(packet){
        //使用RPC的时候,以下三个变量作为标准使用.
        error_code = packet.data.findValueByName("errorCode");
        error_msg =  packet.data.findValueByName("errorMsg");
        verifyType = packet.data.findValueByName("verifyType");
        backArrMsg = packet.data.findValueByName("backArrMsg");

        self.status="";

    }

    function init()
    {

        <%
            if( retStr.length > 0 ){
        %>
                document.frm.smName.value = "<%=retStr[0][2]%>";
                document.frm.custName.value = "<%=retStr[0][3]%>";
                document.frm.idIccid.value = "<%=retStr[0][14]%>";
                document.frm.cardname.value = "<%=retStr[0][15]%>";
                document.frm.grpbigname.value = "<%=retStr[0][16]%>";
                document.frm.totalOwe.value = "<%=sTotalOwe%>";
                document.frm.run_code.value = "<%=retStr[0][5]%>";
                
                document.frm.confirm.focus();

        <%
            }
        %>

    }

    function save_to(){

        var str="";

        str = document.frm.custName.value.trim() + "|" + document.frm.idIccid.value.trim() + "|" +
                document.frm.smCode.value + "|" + document.frm.totalOwe.value+ "|" + document.frm.run_code.value;

        //alert(str);
        window.returnValue=str;
        window.close();
    }

    function quit(){
        window.close();
    }

//-->
</script>
</head>
<body>
<%
	String opCode = "3210";	
	String opName = "用户信息";	//header.jsp需要的参数   
%>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
        <table cellspacing="0">
          <tr>
            <td  class="blue">业务类型名称</td>
            <td><input name="smName" type="text" class="InputGrey" id="smName" readonly></td>
          </tr>
          <tr>
            <td  class="blue">客户名称</td>
            <td><input name="custName" type="text" class="InputGrey" id="custName" readonly></td>
          </tr>
          <tr>
            <td  class="blue">证件号码</td>
            <td ><input name="idIccid" type="text" class="InputGrey" id="idIccid" readonly></td>
          </tr>
          <tr>
            <td  class="blue">大客户名称</td>
            <td><input name="cardname" type="text" class="InputGrey" id="cardname" readonly></td>
          </tr>
          <tr>
            <td class="blue">集团客户名称</td>
            <td><input name="grpbigname" type="text" class="InputGrey" id="grpbigname" readonly></td>
          </tr>
          <tr>
            <td class="blue">当前欠费</td>
            <td><input name="totalOwe" type="text" class="InputGrey" id="totalOwe" readonly></td>
          </tr>
          <tr>
            <td class="blue">运行状态</td>
            <td><input name="run_code" type="text" class="InputGrey" id="run_code" readonly></td>
          </tr>   
        </table>
        
         <table cellspacing="0">
		<tr> 
			<td id="footer"> 
			  <input name="confirm" type="button" class="b_foot" id="confirm" value="确认" onClick="save_to()">			    		
			    		&nbsp;
			  <input name="return" type="button" class="b_foot" id="return" value="返回" onClick="quit()">			               
			</td>
		</tr>
  	</table>

    <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
    <input type="hidden" name="loginName" id="loginName" value="">
    <input type="hidden" name="opCode" id="opCode" value="">
    <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
    <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
    <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
    <input type="hidden" name="smCode"  value="<%=retStr[0][1]%>">
     <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<%}%>
