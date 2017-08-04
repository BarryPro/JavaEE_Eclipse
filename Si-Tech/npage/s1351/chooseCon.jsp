<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	 
      response.setHeader("Pragma","No-Cache"); 
	    response.setHeader("Cache-Control","No-Cache");
      response.setDateHeader("Expires", 0); 
%>
<%
  String opCode = "xxxx";
	String opName = "xxxx";
	String phoneNo = request.getParameter("phoneno");
	String show_mode=request.getParameter("show_mode");
	String outNum = "5";
  String feeCodeArr[][];
	System.out.println(phoneNo);
	/*
	String inParas[] = {"select to_char(a.contract_no),a.bank_cust from dConMsg a,dCustMsg b, dConUserMsg c where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='"+phoneNo+"' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no" };
	*/
    String inParas[] = {"select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,to_char(a.owe_fee),to_char(b.id_no) from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no  and b.phone_no='"+phoneNo+"' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code"};

	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
 	//CallRemoteResultValue value=  viewBean.callService("0",null,"TlsPubSelBoss",outNum, inParas); 
 	//String result[][]  = value.getData();
  //System.out.println("aaaaaaaaaaaaaa"+result.length);   
%>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
	<wtc:sql><%=inParas[0]%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
 	String sqlStr="select fee_code,fee_name from sfeecode where fee_code!='*'";
			
%>
		<wtc:pubselect name="TlsPubSelBoss"  outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="retList" scope="end" />
<%
      feeCodeArr =retList;
     String sqlStr1="select to_char(a.contract_no),d.bank_cust,c.fee_name,f.detail_name from test_zhangss a,dcustmsg b,sfeecode c,dconmsg d ,dConUserMsg e,sfeecodedetail f where a.fee_code=f.fee_code and a.detail_code=f.detail_code and a.id_no=e.id_no and a.contract_no=d.contract_no and d.contract_no=e.contract_no and a.id_no=b.id_no and a.fee_code=c.fee_code and a.show_mode='"+show_mode+"' and b.phone_no="+phoneNo;
     System.out.println("====="+sqlStr1);
      
 %>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg3" outnum="4">
	<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
    String sqlStr2="select to_char(a.contract_no),d.bank_cust,c.fee_name,'*' from test_zhangss a,dcustmsg b,sfeecode c,dconmsg d ,dConUserMsg e where  a.detail_code='*' and a.id_no=e.id_no and a.contract_no=d.contract_no and d.contract_no=e.contract_no and a.id_no=b.id_no and a.fee_code=c.fee_code and a.show_mode='"+show_mode+"' and b.phone_no="+phoneNo;
     System.out.println("====="+sqlStr2);
 %>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg3" outnum="4">
	<wtc:sql><%=sqlStr2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
			

 
	if(result==null||result.length==0)
	{
%>
      <SCRIPT LANGUAGE="JavaScript">
      <!--
       		  window.close();
       //-->
      </SCRIPT>
<%
	
    }
else
  {
%>
 

<HTML><HEAD><TITLE>黑龙江BOSS</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="../../js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>

<script language="JavaScript">
	
window.returnValue='';
	core.loadUnit("rpccore");
	onload=function()
	{
		core.rpc.onreceive = doProcess;//为function()函数设立监听器
	}
	
	//---------------------------获取rpc返回的用户信息--------------------------------
	function doProcess(myPacket)
	{
		var errCode    = myPacket.data.findValueByName("errCode");

		var retFlag    = myPacket.data.findValueByName("retFlag");
				
		if (errCode==000000)
		{  
			
			 if(retFlag=="getFeeCodeDetail")
			{
				var fcd = myPacket.data.findValueByName("fcd");
				var fcd_value = myPacket.data.findValueByName("fcd_value");
				var i = myPacket.data.findValueByName("iPos");
				var feeCodeDetail = 'detailcode'+i;
			
				selectChange(null,frm[eval('feeCodeDetail')],fcd_value,fcd);			
			}
		}
		
		//-----如果返回错误代码-----
		if(errCode!=000000)
		{
		
				rdShowMessageDialog(retMessage);	
			
		}
	}
		//-----实现动态的选择列表-------------
	function selectChange(control, controlToPopulate, itemArray, valueArray)
	{	   	
	   	// Empty the second drop down box of any choices

	   for (var q=controlToPopulate.options.length;q>=0;q--)
	      controlToPopulate.options[q]=null;

	   	for ( var j = 0 ; j < itemArray.length; j++)
	   	{
	   	     var option =new Option(valueArray[j]+"->"+itemArray[j],valueArray[j]+","+itemArray[j]);  
	   	     controlToPopulate.add(option);   
	   	}
	}//end selectChange()
function selAccount(count,contractno1)
{	
     var str="";

	    var i=count;
	    var contractno=contractno1;
	    var feeCodeDetail = 'detailcode'+i;
	   	var feeCode = 'feecode'+i;
	      var font = 'font'+i;
	   	var j=(frm[eval('feeCodeDetail')].value).indexOf(",");
	   	var detailname=frm[eval('feeCodeDetail')].value.substring(j+1);
	    var detailcode=frm[eval('feeCodeDetail')].value.substring(0,j);
	    str=contractno+","+detailname+","+frm[eval('feeCode')].value+","+detailcode+","+frm[eval('font')].value+",|";
	   // alert(str);
	   document.frm.str.value=str;
	  
		 frm.submit();
	   
 //	alert(str1);
	 
		//window.close(); 
}
	
 function getFeeCodeDetail(count)
{
		var i =count;
		
		
		var feeCode = 'feecode'+i;
		
		var myPacket = new RPCPacket("f2760getFeeCodeDetail_rpc.jsp","正在获得信息，请稍候......");
		myPacket.data.add("feeCode",frm[eval('feeCode')].value);		
		myPacket.data.add("iPos",i);												    
		core.rpc.sendPacket(myPacket);
		delete(myPacket); 
}

 </script>

</head>

<BODY leftmargin="0" topmargin="0">
<form name="frm" method="post" action="confirmModual.jsp">
	  	<%@ include file="/npage/include/header.jsp" %>

	    <input type="hidden" name="str" value="">
			<input type="hidden" name="phoneno" value="<%=phoneNo%>">
			<input type="hidden" name="show_mode" value="<%=show_mode%>">
      
  
     
       <table  cellSpacing="0">
          <tr bgcolor="#649ECC"> 
         <td height="25" width="20%"> 
        <div align="center">帐号</div>
      </td>
      <td height="25"> 
        <div align="center">帐户名称</div>
      </td>

      <td height="25"> 
        <div align="center">一级账目名称</div>
      </td>

	  <td height="25"> 
        <div align="center">二级账目名称</div>
      </td>
      </tr> 
      
      
        <%  if(result1.length>0){ 
        for(int i=0; i < result1.length  ; i++)
	{
	  
		%>
            <tr bgcolor="#F5F5F5"> 
          <td height="25"> 
				<div align="center"><%=result1[i][0]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=result1[i][1]%></div>
			  </td>
			    <td height="25"> 
				<div align="center"><%=result1[i][2]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=result1[i][3]%></div>
			  </td>
            </tr> 
      <%
      }
      }
      %>
      <%  if(result2.length>0){ 
          for(int j=0; j < result2.length  ; j++)
	{
	  
		%>
            <tr bgcolor="#F5F5F5"> 
          <td height="25"> 
				<div align="center"><%=result2[j][0]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=result2[j][1]%></div>
			  </td>
			    <td height="25"> 
				<div align="center"><%=result2[j][2]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=result2[j][3]%></div>
			  </td>
            </tr> 
      <%
      }
      }
      %>
      </table>
   

  <table cellSpacing="0">
    <tr bgcolor="#649ECC"> 
     
      <td height="25" width="20%"> 
        <div align="center">帐号</div>
      </td>
      <td height="25"> 
        <div align="center">帐户名称</div>
      </td>

      <td height="25"> 
        <div align="center">一级账目项</div>
      </td>

	  <td height="25"> 
        <div align="center">二级账目项</div>
      </td>
      <td height="25"> 
        <div align="center">字体</div>
      </td>
	  <td height="25"> 
        <div align="center">操作</div>
      </td> 

    </tr>
    <% for(int i=0; i < result.length  ; i++)
	{
	  String feecode="feecode"+i;
	   String detailcode="detailcode"+i;
	   String font="font"+i;
		%>
			<tr bgcolor="#F5F5F5"> 
			 
			  <td height="25"> 
				<div align="center"><%=result[i][0]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=result[i][2]%></div>
			  </td>
			  
			   <td height="25"> 
				<div align="center">
				<select name="<%=feecode%>" onchange=getFeeCodeDetail(<%=i%>)>
					<option value="">请选择</option>
			        	
			        	<%for(int j = 0;j<feeCodeArr.length;j++)
			        	{
			        		out.print("<option value="+feeCodeArr[j][0]+">" );
			        		out.print(feeCodeArr[j][0]+"->"+feeCodeArr[j][1].trim());
			        		out.print("</option>");
			        	}%>
			      
				</select>
				</div>
			  </td>
			    <td height="25"> 
				<div align="center">
				<select name="<%=detailcode%>">
						<option>请选择</option>
				</select>
				</div>
			</td>
			     <td height="25">   
				            <div align="center">
				        &nbsp;字体大小
				        <select name="<%=font%>" style="width:35px"   >
		        		<%
		        		for(int h=6;h<13;h++)
		        		{
		        		%>
			        	<option value = "<%=h%>" ><%=h%></option>
			        <%}%>
			        <option value =20 >20</option>
			       </select>
				     </div>
				     </td >  
			 
			  <td height="25"> 
				<div align="center">
					 
			  <input type="button" name="confirm" value="增加" class="b_foot" onClick="selAccount(<%=i%>,<%=result[i][0]%>)">
				</select>
				</div>
			  </td>
			</tr>
		
    <%}%>
 
    <tr> 
      <td bgcolor="#EEEEEE" colspan="6"> 
        <div align="center"> 
      
          <input class="b_foot" type="button" name="return" value="返回" onClick="javascript:document.location.href('f1353.jsp');">
        </div>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
  	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>
<%}%>

