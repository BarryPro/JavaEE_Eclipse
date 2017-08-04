<%
  /*
   author:zhouyg
   date:2009-2-11
　*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<% 
  response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	System.out.println("==========start=============");
		opName = "选号界面"; 
	 String  pType=request.getParameter("prodId");//产品类型 
	 String  masterServId=request.getParameter("masterServId");//产品类型
	 String  Busi_ID=request.getParameter("busiId")==null?"00":request.getParameter("busiId");//代理商ID
	 String  Staff_ID=request.getParameter("workNo");
	 String  object_ID=request.getParameter("objectId");//object_ID
	 String  gs_branchID=request.getParameter("branchNo")==null?"":request.getParameter("branchNo");//局站Id
	 String  gropFlag="0";//虚拟标志
	 String  City_ID=request.getParameter("cityId");  
	 String  Site_ID= request.getParameter("siteId");    
	 String  work_form_id=request.getParameter("workFormId");
	 String  svc_inst_id=request.getParameter("svcInstId"); 
	 String  srcNum=request.getParameter("srcNum");
	 String  vasProds=request.getParameter("vasProds");
	 String  switch_no = request.getParameter("switchNo")==null?"":request.getParameter("switchNo");
	 String  ORDER_ID=request.getParameter("orderId")==null?"":request.getParameter("orderId");

	System.out.println("pType===>" + pType);
	System.out.println("masterServId===>" + masterServId);
	System.out.println("Staff_ID===>" + Staff_ID);
	System.out.println("object_ID===>" + object_ID);
	System.out.println("gs_branchID===>" + gs_branchID);
	System.out.println("City_ID===>" + City_ID);
	System.out.println("Site_ID===>" + Site_ID);
	System.out.println("work_form_id===>" + work_form_id);
	System.out.println("svc_inst_id===>" + svc_inst_id);
	System.out.println("srcNum===>" + srcNum);	//选号个数
	System.out.println("vasProds===>" + vasProds);
	System.out.println("switch_no===>" + switch_no);
	System.out.println("ORDER_ID===>" + ORDER_ID);
	String result[][] = null;
%>
<script>
	var num_flag_022 = "1";
	$(document).ready(
		function()
		{
			var b="<%=gs_branchID%>";
			if(b=='') rdShowMessageDialog("请先选择局站!",0);
			}
	);
function free_num()
{
	var prod_id=<%=pType%>;
	if(document.all.select7.options.length > 0)
	{
		var NUM	= "";//号码串
		for(var i=0;i < document.all.select7.options.length;i++ )
  	  {
			NUM = NUM+document.all.select7.options[i].text+"~"; 
		}
		var branch_no=document.all.select3.value;
		var myPacket1 = new AJAXPacket("middle_1.jsp","正在释放号码信息，请稍候......");
		myPacket1.data.add("retType","delNum");
		myPacket1.data.add("NUM",NUM);
		myPacket1.data.add("CITY_ID","<%=City_ID.trim()%>");
		myPacket1.data.add("BRANCH_ID",branch_no);
		myPacket1.data.add("OBJECT_TYPE","1");
		myPacket1.data.add("STAFF_ID","<%=Staff_ID%>");
		myPacket1.data.add("SITE_ID","<%=Site_ID%>");
		myPacket1.data.add("NUM_TYPE","06");
		document.all.select7.options.length=0;
		core.ajax.sendPacket(myPacket1);
		myPacket1=null;	
	}
}
function fun_1()
{
document.all.select5.style.display= "";//号码头
document.all.textfield2.readOnly=false;//号码尾
document.all.select8.style.display= "none";//号码等级
document.all.select4.style.display= "none";//号码类别
document.all.textfield.readOnly=true;//手输号码
document.all.qry_num.disabled=false;//选号按钮
document.all.opFlag.value="0";
document.all.textfield2.v_must="1";//号码尾
document.all.textfield.v_must="0";//手输号码
document.all.textfield2.v_maxlength="4";//号码尾
document.all.textfield.v_maxlength="8";//手输号码
document.all.textfield2.v_minlength="1";//号码尾
document.all.textfield.v_minlength="0";//手输号码
document.all.textfield2.value="";//号码尾
document.all.textfield.value="";//手输号码
//free_num();
document.all.select7.options.length=0;
}
function fun_2()
{
document.all.select5.style.display= "none";//号码头
document.all.textfield2.readOnly=false;//号码尾
document.all.select8.style.display= "none";//号码等级
document.all.select4.style.display= "none";//号码类别
document.all.textfield.readOnly=true;//手输号码
document.all.qry_num.disabled=false;//选号按钮
document.all.opFlag.value="0";
document.all.textfield2.v_must="1";//号码尾
document.all.textfield.v_must="0";//手输号码
document.all.textfield2.v_maxlength="4";//号码尾
document.all.textfield.v_maxlength="8";//手输号码
document.all.textfield2.v_minlength="1";//号码尾
document.all.textfield.v_minlength="0";//手输号码
document.all.textfield2.value="";//号码尾
document.all.textfield.value="";//手输号码
//free_num();
document.all.select7.options.length=0;
}
function fun_3()
{
document.all.select5.style.display= "";//号码头
document.all.textfield2.readOnly=true;//号码尾
document.all.textfield.readOnly=true;//手输号码
document.all.qry_num.disabled=false;//选号按钮
document.all.opFlag.value="0";
document.all.select8.style.display= "";//号码等级
document.all.select4.style.display= "";//号码类别
document.all.textfield2.v_must="0";//号码尾
document.all.textfield.v_must="0";//手输号码
document.all.textfield2.v_maxlength="4";//号码尾
document.all.textfield.v_maxlength="8";//手输号码
document.all.textfield2.v_minlength="0";//号码尾
document.all.textfield.v_minlength="0";//手输号码
document.all.textfield2.value="";//号码尾
document.all.textfield.value="";//手输号码
//free_num();
document.all.select7.options.length=0;
}
function fun_4()
{
document.all.select5.style.display= "none";//号码头
document.all.textfield2.readOnly=true;//号码尾
document.all.select8.style.display= "none";//号码等级
document.all.select4.style.display= "none";//号码类别
document.all.textfield.readOnly=false;//手输号码
document.all.qry_num.disabled=true;//选号按钮
document.all.opFlag.value="0";
document.all.textfield2.v_must="0";//号码尾
document.all.textfield.v_must="1";//手输号码
document.all.textfield2.v_maxlength="4";//号码尾
document.all.textfield.v_maxlength="8";//手输号码
document.all.textfield2.v_minlength="0";//号码尾
document.all.textfield.v_minlength="7";//手输号码
document.all.textfield2.value="";//号码尾
document.all.textfield.value="";//手输号码
//free_num();
document.all.select7.options.length=0;
}
function fun_5()
{
document.all.select5.style.display= "";//号码头
document.all.textfield2.readOnly=false;//号码尾
document.all.textfield.readOnly=true;//手输号码
document.all.qry_num.disabled=false;//选号按钮
document.all.opFlag.value="0";
document.all.select8.style.display= "";//号码等级
document.all.select4.style.display= "";//号码类别
document.all.textfield2.v_must="1";//号码尾
document.all.textfield.v_must="0";//手输号码
document.all.textfield2.v_maxlength="4";//号码尾
document.all.textfield.v_maxlength="8";//手输号码
document.all.textfield2.v_minlength="1";//号码尾
document.all.textfield.v_minlength="0";//手输号码
document.all.textfield2.value="";//号码尾
document.all.textfield.value="";//手输号码
//free_num();
document.all.select7.options.length=0;
}
function fun_6()
{
document.all.select5.style.display="none";//号码头
document.all.textfield2.readOnly=true;//号码尾
document.all.select8.style.display= "none";//号码等级
document.all.select4.style.display= "none";//号码类别
document.all.textfield.readOnly=true;//手输号码
document.all.qry_num.disabled=false;//选号按钮
document.all.opFlag.value="1";
document.all.textfield2.v_must="0";//号码尾
document.all.textfield.v_must="0";//手输号码
document.all.textfield2.v_maxlength="4";//号码尾
document.all.textfield.v_maxlength="8";//手输号码
document.all.textfield2.v_minlength="0";//号码尾
document.all.textfield.v_minlength="0";//手输号码
document.all.textfield2.value="";//号码尾
document.all.textfield.value="";//手输号码
//free_num();
document.all.select7.options.length=0;
}
function getBH()
{
	 var prod_id="<%=pType.trim()%>";
	 if(prod_id=="3")
	 {
	 var pType="getB";
	 var sql="select distinct to_char(switch_code),switch_ser||'-->'||to_char(switch_code) from trm_br_telfore  where branch_no ='"+document.all.select3.value+"'"
	 var myPacket = new AJAXPacket("select_mulit_rpc.jsp","正在获得信息，请稍候......");
	 myPacket.data.add("retType",pType);
	 myPacket.data.add("sqlStr",sql);	
	 core.ajax.sendPacket(myPacket);	
	 myPacket=null; 
	 }
	 
	 var pType="getH";
	 var sql="select distinct tel_head,tel_head from trm_br_telfore where branch_no='"+document.all.select3.value+"'"
	 var myPacket = new AJAXPacket("select_mulit_rpc.jsp","正在获得信息，请稍候......");
	 myPacket.data.add("retType",pType);
	 myPacket.data.add("sqlStr",sql);	
	 core.ajax.sendPacket(myPacket);	
	 myPacket=null;	 
}

function qry_number()
{			
	document.all.qry_num.disabled=true;
	var branch_no=document.all.select3.value;
	var switch_no=document.all.select6.value;
	var tel_level=document.all.select8.value;
	var fee_level=document.all.select4.value;
	var tel_head=document.all.select5.value;
	var tel_tail=document.all.textfield2.value;
	var vas_prod="<%=vasProds.trim()%>";
	var op_flag= "<%=gropFlag%>";
	var city_id="<%=City_ID.trim()%>";
	var prod_id="<%=pType.trim()%>";
	
		if(branch_no=="")
		{
			rdShowMessageDialog("局站不能为空！");
    		return false;
		}
		if(switch_no=="")
		{
			if(prod_id=="3"||op_flag=="1")
			{
				rdShowMessageDialog("交换机名称不能为空！");
    			return false;
			}
		}
		
		if(document.all.r1.checked==true||document.all.r3.checked==true||document.all.r5.checked==true)
		{
			if(tel_head=="")
		    {	
				rdShowMessageDialog("号码头不能为空！请选择！");
    			return false;
		    }
		}
		else
		{
			tel_head="";
		}

		if(document.all.r3.checked==true||document.all.r5.checked==true)
		{
			if(tel_level=="" || fee_level=="")
			{
				rdShowMessageDialog("号码等级和付费等级不能为空！请选择！");
				return false;
			}

		}
		else
		{
			tel_level="";
			fee_level="";
		}
		if(check(frm1100))
		{
			/*if(document.all.select7.options.length > 0)
			{
			  	var NUM	= "";//号码串
			  	for(var i=0;i < document.all.select7.options.length;i++ )
			  	{
			  		NUM = NUM+document.all.select7.options[i].text+"~";
			  	}
			  var myPacket1 = new AJAXPacket("middle_1.jsp","正在释放号码信息，请稍候......");
				myPacket1.data.add("retType","delNum");
			
				myPacket1.data.add("NUM",NUM);
				myPacket1.data.add("CITY_ID",city_id);
				myPacket1.data.add("BRANCH_ID",'212');
				myPacket1.data.add("OBJECT_TYPE","1");
				myPacket1.data.add("STAFF_ID","<%=Staff_ID%>");
				myPacket1.data.add("SITE_ID","<%=Site_ID%>");
				if(prod_id=="1")//固话
				{
					myPacket1.data.add("NUM_TYPE","06");
				}
				else//PHS
				{
					myPacket1.data.add("NUM_TYPE","03");
				}
					
				core.ajax.sendPacket(myPacket1);
				myPacket1=null;	
				
			}*/
			
			
			var myPacket = new AJAXPacket("middle.jsp","正在获得号码信息，请稍候......");
			
			myPacket.data.add("retType","getNum");
			
			//选号服务使用
			myPacket.data.add("TEL_HEAD",tel_head);
			myPacket.data.add("TEL_LEVEL",tel_level);
			myPacket.data.add("TEL_TAIL",tel_tail);
			myPacket.data.add("OBJECT_TYPE",document.all.opFlag.value);
			myPacket.data.add("IN_PHS_SWITCH",switch_no);
			myPacket.data.add("BUSI_ID","<%=Busi_ID%>");
			myPacket.data.add("FEE_LEVEL",fee_level);
			myPacket.data.add("STAFF_ID","<%=Staff_ID%>");
			myPacket.data.add("BRANCH_NO",branch_no);
			myPacket.data.add("PRODUCT_ID",prod_id);
			myPacket.data.add("vas_prod",vas_prod);
			myPacket.data.add("masterServId","<%=masterServId%>");
			
			//占号服务用
			myPacket.data.add("work_form_id","<%=work_form_id%>");
			myPacket.data.add("city_id",city_id);
			myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
			myPacket.data.add("order_id","<%=ORDER_ID.trim()%>");
			myPacket.data.add("object_id","<%=object_ID%>");
			myPacket.data.add("reso_numb","");
			myPacket.data.add("pre_reason","");
			myPacket.data.add("addr","");
			myPacket.data.add("svc_id","");
			myPacket.data.add("SITE_ID","<%=Site_ID%>");
			myPacket.data.add("switch","");
			if(prod_id=="1")
			{
				myPacket.data.add("NUM_TYPE","06");
			}
			else
			{
				myPacket.data.add("NUM_TYPE","03");
			}
			core.ajax.sendPacket(myPacket);
	myPacket=null;
			document.all.qry_num.disabled=false;
		}
		else
		{
			document.all.qry_num.disabled=false;
		}	
}
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	if(jtrim(retType)=="getNum")	
	{
		 
		var errCode_1 = packet.data.findValueByName("errCode_1");
		var errMessage_1 = packet.data.findValueByName("errMessage_1");
		var result = packet.data.findValueByName("tri_list");
		self.status="";
		if(jtrim(errCode_1)!="000000")
		{
			rdShowMessageDialog("没有找到你需要的号码！"+'\n'+"请换一个条件重试。"+"\n 错误信息:"+errMessage_1);
			document.all.select7.options.length=0;
			return false;
		}
	
		if(jtrim(retType)=="getNum")
		{   
			document.all.select7.options.length=0;
			if(jtrim(errCode_1) != "000000")
			{
				rdShowMessageDialog("读取号码失败！");	
	   			return false;
			}
			else
			{	
				for(var i=0; i< result.length; i++)
				{
					document.all.select7.options.add(new Option(jtrim(result[i][0]),jtrim(result[i][0])+"~"+jtrim(result[i][1])+"~"+jtrim(result[i][2])+"~"+jtrim(result[i][3])+"~")); 
				}
			}
	 	}
	}
	if(jtrim(retType)=="delNum")
	{
		var errCode_1 = packet.data.findValueByName("errCode_1");
		//var errMessage_1 = packet.data.findValueByName("errMessage_1");
		if(jtrim(errCode_1)!="000000")
		{
			rdShowMessageDialog("号码释放失败,请与管理员联系！");
			return false;
		}
		else
		{
			return true;
		}
	}
	if(jtrim(retType)=="num_yz"){
		var errCode_2 = packet.data.findValueByName("errCode_2");
		//var errMessage_1 = packet.data.findValueByName("errMessage_2");
		if(jtrim(errCode_2)!="000000")
		{
			rdShowMessageDialog("号码占用失败,请与管理员联系！");
			num_flag_022 = "0";			
			return false;
		}else{
			return true;
		}
	}
	if(jtrim(retType)=="getHandNum")
	{
		var errCode_1 = packet.data.findValueByName("errCode_1");
		var errMessage_1 = packet.data.findValueByName("retMessage_1");
		//alert(errMessage_1)
		var errCode_2 = packet.data.findValueByName("errCode_2");
		var errMessage_2 = packet.data.findValueByName("retMessage_2");
		var result = packet.data.findValueByName("tri_list");
		var retVal = "";
		if(jtrim(errCode_1)!="000000"||jtrim(errCode_2)!="000000")
		{
			//alert(errCode_1+errMessage_1+'\n'+errCode_2+errMessage_2);
			rdShowMessageDialog("此号码不可用，请重新输入！"+"\n 错误信息1:"+errMessage_1+"\n 错误信息2:"+errMessage_2);
			document.all.textfield.value="";
			return false;
		}
		else
		{
			document.all.SEL_NUM.value="";
      document.all.SEL_NUM.value=document.all.SEL_NUM.value+result[0][2]+"~"+result[0][0]+"~"+result[0][1]+"~";
      document.all.SEL_NUM.value=document.all.textfield.value+"~"+document.all.SEL_NUM.value;
			retVal=document.all.SEL_NUM.value;
			window.returnValue = retVal;
			window.close();
		}
	}
	if(jtrim(retType)=="getB")
	{
		var retCode = packet.data.findValueByName("retCode");
		document.all.select6.length=0;
		if(retCode!="000000")
		{
			document.all.select6.options.add(new Option("",""));
	       	return false;
		}
		else
		{
			var mulit_list = packet.data.findValueByName("mulit_list");
			for(var i=0;i<mulit_list.length;i++)
			{
			document.all.select6.options.add(new Option(mulit_list[i][1],mulit_list[i][0])); 
			}
		}
	}
	if(jtrim(retType)=="getH")
	{
		var retCode = packet.data.findValueByName("retCode");
		document.all.select5.length=0;
		if(retCode!="000000")
		{
			document.all.select5.options.add(new Option("",""));
	       	return false;
		}
		else
		{
			var mulit_list = packet.data.findValueByName("mulit_list");
			for(var i=0;i<mulit_list.length;i++)
			{
			document.all.select5.options.add(new Option(mulit_list[i][0],mulit_list[i][1])); 
			}
		}
	}
	if(jtrim(retType)=="getType")
	{
		var retCode=packet.data.findValueByName("retCode");
		document.all.select4.length=0;
		if(retCode!="000000")
		{
			document.all.select4.options.add(new Option("",""));
	       	return false;
		}
		else
		{
			var mulit_list = packet.data.findValueByName("mulit_list");
			for(var i=0;i<mulit_list.length;i++)
			{
			document.all.select4.options.add(new Option(mulit_list[i][1],mulit_list[i][0])); 
			}
		}
	}
	if(jtrim(retType)=="getHead")
	{
		var retCode=packet.data.findValueByName("retCode");
		document.all.select5.length=0;
		if(retCode!="000000")
		{
			document.all.select5.options.add(new Option("",""));
	       	return false;
		}
		else
		{
			var mulit_list = packet.data.findValueByName("mulit_list");
			for(var i=0;i<mulit_list.length;i++)
			{
			document.all.select5.options.add(new Option(mulit_list[i][1],mulit_list[i][0])); 
			}
		}
	}
}

function quxiao()
{
	var prod_id="<%=pType.trim()%>";
	if(document.all.r4.checked == false)
	{
		if(document.all.select7.options.length > 0)
		{
	     	if(rdShowConfirmDialog("您确定要进行此操作？")==1)
			{
				/*var NUM	= "";//号码串
			  	for(var i=0;i < document.all.select7.options.length;i++ )
			  	{
					NUM = NUM+document.all.select7.options[i].text+"~";
				}
				var branch_no=document.all.select3.value;
			  var myPacket1 = new AJAXPacket("middle_1.jsp","正在释放号码信息，请稍候......");
				myPacket1.data.add("retType","delNum");
				myPacket1.data.add("NUM",NUM);
				myPacket1.data.add("CITY_ID","<%=City_ID.trim()%>");
				myPacket1.data.add("BRANCH_ID",branch_no);
				myPacket1.data.add("OBJECT_TYPE","1");
				myPacket1.data.add("STAFF_ID","<%=Staff_ID%>");
				myPacket1.data.add("SITE_ID","<%=Site_ID%>");
				myPacket1.data.add("NUM_TYPE","06");					
				core.ajax.sendPacket(myPacket1);
				myPacket1=null;	*/
				document.all.select7.options.length=0;
				window.returnValue ="";
				window.close();
			}		
		}
		else
		{
			if(rdShowConfirmDialog("您没有选号，确实要关闭吗？")==1)
			{
				window.returnValue = "";
				window.close();;
			}
		}
	}else{
		if(rdShowConfirmDialog("您确定已经选号完毕？")==1)
		{
				window.returnValue = "";
		    window.close();;
		}
	}
}

function choose()
{
	var prod_id=<%=pType%>;
	var ret_num="";
	var count=0;
	var res_num=<%=srcNum.trim()%>;
	var vas_prod="<%=vasProds.trim()%>";
	var num_flag = true;
	if(document.all.r4.checked == true)
	{
		var branch_no=document.all.select3.value;
		var switch_no=document.all.select6.value;
		var num=document.all.textfield.value;
		var op_flag= <%=gropFlag%>;
		var city_id="<%=City_ID%>";
		if(branch_no=="")
		{
			rdShowMessageDialog("局站不能为空！");
    		return false;
		}
		if(switch_no=="")
		{
			if(prod_id=="3"||op_flag=="1")
			{
				rdShowMessageDialog("交换机名称不能为空！");
    			return false;
			}
		}
		if(num=="")
		{
			rdShowMessageDialog("手输号码不能为空！");
    		return false;
		}
		else
		{
			var myPacket = new AJAXPacket("middle_2.jsp","正在校验号码信息，请稍候......");
			
			myPacket.data.add("retType","getHandNum");
			
			myPacket.data.add("NUM",num);
			myPacket.data.add("masterServId","<%=masterServId%>");
			myPacket.data.add("IN_PHS_SWITCH",switch_no);
			myPacket.data.add("BUSI_ID","<%=Busi_ID%>");			
			myPacket.data.add("STAFF_ID","<%=Staff_ID%>");
			myPacket.data.add("BRANCH_NO",branch_no);
			myPacket.data.add("PRODUCT_ID",prod_id);			
			myPacket.data.add("SITE_ID","<%=Site_ID%>");
			myPacket.data.add("work_form_id","<%=work_form_id%>");
			myPacket.data.add("city_id",city_id);
			myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
			myPacket.data.add("order_id","<%=ORDER_ID.trim()%>");
			myPacket.data.add("object_id","");
			myPacket.data.add("reso_numb","");
			myPacket.data.add("pre_reason","");
			myPacket.data.add("addr","");
			myPacket.data.add("svc_id","");
			myPacket.data.add("vas_prod",vas_prod);
			myPacket.data.add("NUM_TYPE","06");			
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
	}
	else
	{
		if(document.all.select7.options.length==0)
		{
			if(rdShowConfirmDialog("您还没有选号，是否退出选号界面？")==1)	
			{
				window.returnValue = "";
				window.close();
			}
		}
		else
		{
			var temp=false;//有没有选择号码
			for(var i = 0;i < document.all.select7.options.length;i++ )
			{
				if(document.all.select7.options[i].selected==true)
				{
					temp=true;
					//document.all.SEL_NUM.value=document.all.select7.options[i].value;
					ret_num=ret_num+document.all.select7.options[i].value.trim()+"|";	//返回以竖线分割
					count++;
				}
			}
			if(temp==false)
			{
				rdShowMessageDialog("你没有选择号码，请选择！");
    			return false;
			}
			else
			{
				if(count>res_num)
				{
					rdShowMessageDialog("您最多只能选"+res_num+"个号码");
    			return false;
				}
				if(count<res_num)
				{
					rdShowMessageDialog("您至少应该选"+res_num+"个号码");
    			return false;
				}
				/*释放其余号码 ，传递选择的号码*/
				var NUM	= "";//号码串
			  	for(var i=0;i < document.all.select7.options.length;i++ )
			  	{
			  		if(document.all.select7.options[i].selected==true)
						{
						NUM = NUM+document.all.select7.options[i].text+"~";
			  		}
				}
				var branch_no=document.all.select3.value;
				
				//占号服务用
			  var myPacket = new AJAXPacket("middle.jsp","正在预占号码信息，请稍候......");
			  myPacket.data.add("retType","num_yz");
				myPacket.data.add("OBJECT_TYPE",document.all.opFlag.value);
			myPacket.data.add("IN_PHS_SWITCH",switch_no);
			myPacket.data.add("BUSI_ID","<%=Busi_ID%>");
			myPacket.data.add("FEE_LEVEL",document.all.select4.value);
			myPacket.data.add("STAFF_ID","<%=Staff_ID%>");
			myPacket.data.add("BRANCH_NO",branch_no);
			myPacket.data.add("PRODUCT_ID",prod_id);
			myPacket.data.add("vas_prod",vas_prod);
				
			myPacket.data.add("NUM",NUM);		
			myPacket.data.add("work_form_id","<%=work_form_id%>");
			myPacket.data.add("BRANCH_ID",branch_no);
			myPacket.data.add("city_id","<%=City_ID.trim()%>");
			myPacket.data.add("svc_inst_id","<%=svc_inst_id%>");
			myPacket.data.add("order_id","<%=ORDER_ID.trim()%>");
			myPacket.data.add("object_id","<%=object_ID%>");
			myPacket.data.add("reso_numb","");
			myPacket.data.add("pre_reason","");
			myPacket.data.add("addr","");
			myPacket.data.add("svc_id","");
			myPacket.data.add("SITE_ID","<%=Site_ID%>");
			myPacket.data.add("switch","");
			if(prod_id=="1")
			{
				myPacket.data.add("NUM_TYPE","06");
			}
			else
			{
				myPacket.data.add("NUM_TYPE","03");
			}
				core.ajax.sendPacket(myPacket);
				myPacket = null;
				document.all.select7.options.length=0;	
				if(num_flag_022 == "1"){
					ret_num=ret_num.substring(0,ret_num.length-1);
				}else if(num_flag_022 == "0"){
					ret_num = "";	
				}
					window.returnValue = ret_num;//document.all.SEL_NUM.value;
					window.close();
				
			}
		}
	}
}
 
function selNum()
{
	document.all.SEL_NUM.value=document.all.select7.options[document.all.select7.selectedIndex].value;
}

function keyChoose()
{
	choose();
}

window.onbeforeunload=function LeaveWin()
{
	var prod_id="<%=pType.trim()%>";
	if(document.all.select7.options.length > 0)
	{
		/*var NUM	= "";//号码串
		for(var i=0;i < document.all.select7.options.length;i++ )
		{
			NUM = NUM+document.all.select7.options[i].text+"~"; 
		}
		var branch_no=document.all.select3.value;
		var myPacket1 = new AJAXPacket("middle_1.jsp","正在释放号码信息，请稍候......");
		myPacket1.data.add("retType","delNum");	
		myPacket1.data.add("NUM",NUM);
		myPacket1.data.add("CITY_ID","<%=City_ID.trim()%>");
		myPacket1.data.add("BRANCH_ID",branch_no);
		myPacket1.data.add("OBJECT_TYPE","1");
		myPacket1.data.add("STAFF_ID","<%=Staff_ID%>");
		myPacket1.data.add("SITE_ID","<%=Site_ID%>");
		myPacket1.data.add("NUM_TYPE","06");
  	core.ajax.sendPacket(myPacket1);
		myPacket1=null;	*/
		document.all.select7.options.length=0;
		window.returnValue ="";
	}
	else
		(!window.returnValue)&&(window.returnValue="");
}
function chg()
{
	var prod_id="<%=pType.trim()%>";
	if(prod_id!="3")
	{
		var sqlStr = "";
		var rType = "";
		var level=document.all.select8.value;
		rType = "getType";
		if(level=="")
		{
			document.all.select4.options.length=0;
			document.all.select4.options.add(new Option("--请选择--",""));
		}
		else
		{
			if(level=="01")
			{
				sqlStr = "SELECT distinct FEETYPE,FEETYPE||'-->'||NOTE FROM TRM_RA_FEETYPE WHERE substr(OBJECT_ID,1,2)=<%=object_ID.trim().substring(0, 2)%>  and feetype='00' order by FEETYPE";
			}
			else
			{
				sqlStr = "SELECT distinct FEETYPE,FEETYPE||'-->'||NOTE FROM TRM_RA_FEETYPE WHERE substr(OBJECT_ID,1,2)=<%=object_ID.trim().substring(0, 2)%>  and feetype<>'00' order by FEETYPE";
			}
			var myPacket = new AJAXPacket("select_mulit_rpc.jsp","正在获得信息，请稍候......");
			myPacket.data.add("retType",rType);
			myPacket.data.add("sqlStr",sqlStr);	
			core.ajax.sendPacket(myPacket);	
			myPacket=null;
		}
	}
}
function getHead()
{
	var busi_id="<%=Busi_ID.trim()%>";
	var sqlStr = "";
	var rType = "";
	rType = "getHead";
	sqlStr = "select distinct tel_head,tel_head from trm_br_telfore where branch_no='"+document.all.select3.value+"' and  SWITCH_CODE="+document.all.select6.value+" and busi_id='"+busi_id+"' and tel_type<>'03'";
	var myPacket = new AJAXPacket("select_mulit_rpc.jsp","正在获得信息，请稍候......");
	myPacket.data.add("retType",rType);
	myPacket.data.add("sqlStr",sqlStr);	
	core.ajax.sendPacket(myPacket);	
	myPacket=null;
}
</script>

<html>
	<head>
		<title>选号界面</title>
	</head>
	<body>
		<div id="operation">
			<form action="" name="aa" method="post" id="frm1100">
				<%@ include file="/npage/include/header_pop.jsp"%>
				<div id="operation_table">
							<div class="input">	
					<table id="tabCustInfoQry">
						<tr>
							<td colspan="4">
								<div class="title"><div class="text">
									选号方式
								</div></div>
							</td>
							<td width="38%" rowspan="11" align="justify" valign="middle"
								bordercolor="eeeeee">
								<select name="select7" multiple="multiple" size="8"
									style="font-size: 30px; color: blue; width: 100%"
									onChange="selNum()" ondblclick="choose()">
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input id="r1" type="radio" name="radiobutton" value="rb_1"
									onClick="fun_1()">
								局站+号码头+号码尾
							</td>
							<td colspan="2">
								<input id="r2" type="radio" name="radiobutton" value="rb_2"
									onClick="fun_2()">
								局站+号码尾
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input id="r3" type="radio" name="radiobutton" value="rb_3"
									onClick="fun_3()">
								局站+号码头+号码类型
							</td>
							<td colspan="2">
								<input id="r4" type="radio" name="radiobutton" value="rb_4"
									onClick="fun_4()">
								手输选号
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input id="r5" type="radio" name="radiobutton" value="rb_5"
									onClick="fun_5()">
								局站+号码头+号码尾+号码类型
							</td>
							<td colspan="2">
								<input id="r6" type="radio" name="radiobutton" value="rb_6"
									checked="true" onClick="fun_6()">
								随机选号
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="title"><div class="text">
									选号信息
								</div></div>
							</td>
						</tr>
						<tr>
							<td width="11%" align="right">
								局&nbsp;&nbsp;&nbsp;站   
							</td>
							<td colspan="3">
								<select size="1" name="select3" style="width: 300px">
									<%
										if (pType.trim().equals("3")) {
											for (int i = 0; i < result.length; i++) {
									%>
									<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
									<%
										}
										} else {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
			select branch_no,branch_no||'-->'||branch_name||'-->'||branch_ser from trm_mdf_branch where branch_no='<%=gs_branchID%>'
</wtc:sql>
									</wtc:qoption>
									<%
										}
									%>							
								</select>
							</td>
						</tr>
						<tr>
							<td width="11%" align="right">
								交换机
							</td>
							<td width="20%">
								<select name="select6" style="width: 100px" onChange="getHead()">
									<%
										if ((!pType.trim().equals("3"))) {
									%>

									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
					select distinct to_char(switch_code),switch_ser||'-->'||to_char(switch_code) from trm_br_telfore  where branch_no =<%=gs_branchID%> order by  switch_code 
             													

             							</wtc:sql>
									</wtc:qoption>

									<%
										} else {
									%>
									<%
										if (switch_no.trim().equals("")) {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
								select distinct to_char(switch_code),switch_ser||'-->'||to_char(switch_code) from trm_br_telfore  where branch_no ='<%=result[0][0].trim()%>' and tel_type='03' order by  switch_code 
										</wtc:sql>
									</wtc:qoption>
									<%
										} else {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
								select distinct to_char(switch_code),switch_ser||'-->'||to_char(switch_code) from trm_br_telfore  where switch_code =to_number('<%=switch_no.trim()%>')
										</wtc:sql>
									</wtc:qoption>
									<%
										}
										}
									%>									
								</select>
							</td>
							<td width="11%" align="right">
								号码头
							</td>
							<td width="20%">
								<select name="select5" style="width:100px;display:none">
									<%
										if (!pType.trim().equals("3")) {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
			select distinct tel_head,tel_head from trm_br_telfore where branch_no='<%=gs_branchID.trim()%>' and Busi_ID='<%=Busi_ID.trim()%>'
             				
</wtc:sql>
									</wtc:qoption>
									<%
										} else {
											if (switch_no.trim().equals("")) {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
							select distinct tel_head,tel_head from trm_br_telfore where branch_no='<%=result[0][0].trim()%>' and  SWITCH_CODE = (select distinct min(switch_code) from trm_br_telfore  where branch_no ='<%=result[0][0].trim()%>' and tel_type='03') and busi_id='<%=Busi_ID.trim()%>' and tel_type='03'
             							</wtc:sql>
									</wtc:qoption>
									<%
										} else {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
							select distinct tel_head,tel_head from trm_br_telfore where branch_no='<%=result[0][0].trim()%>' and  SWITCH_CODE= <%=switch_no.trim()%> and busi_id='<%=Busi_ID.trim()%>' and tel_type='03'
             				</wtc:sql>
									</wtc:qoption>
									<%
										}
										}
									%>	
								</select>
							</td>
						</tr>
						<tr>
							<td align="right">
								号码尾
							</td>
							<td>
								<input type="text" name="textfield2" size="14" value=""
									readonly="true" v_type="string" v_name="&nbsp;号码尾&nbsp;">
							</td>
							<td align="right">
								号码等级
							</td>
							<td>
								<select name="select8" style="width: 100px" style="display:none"
									onChange="chg()">
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
			select VALUE_ID,VALUE_ID||'-->'||VALUE from tsm_para_value where para_id='281'
             </wtc:sql>
									</wtc:qoption>	
								</select>
							</td>
						</tr>
						<tr>
							<td align="right">
								手输号码
							</td>
							<td>
								<input type="text" name="textfield" size="14" readonly="true"
									value="" onKeyDown="if(event.keyCode==13) keyChoose()"
									v_type="0_9" v_name=";&nbsp;手输号码&nbsp;">	
							</td>
							<td align="right">
								付费等级
							</td>
							<td>
						 	<select name="select4" style="width:100px" style="display:none">		
									<%
										if (pType.trim().equals("3")) {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
						SELECT distinct FEETYPE,FEETYPE||'-->'||NOTE FROM TRM_RA_FEETYPE WHERE substr(OBJECT_ID,1,2)=<%=object_ID.trim().substring(0, 2)%>  order by FEETYPE
						</wtc:sql>
									</wtc:qoption>
									<%
										} else {
									%>
									<wtc:qoption name="sPubSelect" outnum="2">
										<wtc:sql>
						SELECT distinct FEETYPE,FEETYPE||'-->'||NOTE FROM TRM_RA_FEETYPE WHERE substr(OBJECT_ID,1,2)=<%=object_ID.trim().substring(0, 2)%> and feetype='00'  order by FEETYPE
					 
					  </wtc:sql>
									</wtc:qoption>
									<%
										}
									%>
							</select>
							</td>
						</tr>
					</table>
					<div>		
				</div>				
						<div id="operation_button">
							<input name="qry_num" type="button" class="b_foot" value="选&nbsp;号" onClick="qry_number()">
							&nbsp;
							<input name="sel_num" type="button" class="b_foot" value="确&nbsp;定" onClick="choose()">
							&nbsp;
							<input name="cancel" type="button" class="b_foot" value="取&nbsp;消" onClick="quxiao()">
						</div>
						<input type="hidden" name="opFlag" value="1">
						<input type="hidden" name="SEL_NUM" value="">
						<!-- 返回值: 号码~小灵通付费等级(可能为空串)~号码类型~交换机编号 -->
				<%@ include file="/npage/include/footer.jsp"%>
			</form>
		</div>
	</body>
</html>
