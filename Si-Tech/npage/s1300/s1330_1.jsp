<%
	/********************
	 version v2.0
	������: si-tech
	update:zhaoht@2009-03-10 ҳ�����,�޸���ʽ
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
	//String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	
	
	String orgcode = (String)session.getAttribute("orgCode");//��������
	String regioncode = (String)session.getAttribute("regCode");
	String storetp1= request.getParameter("optype");
	System.out.println("storetp1==="+storetp1);
	String opcd=storetp1.substring(1);
	String storetp=storetp1.substring(0,1);
	String opCode = opcd;
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-�мۿ����ۼ�����</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--

var carry = 0;                              //��¼��λ
onload=function()
{		
	form_load1();
}
function doProcess(packet)
{

	//alert("=====doprocess.............");
	//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
	var error_code = packet.data.findValueByName("iErrorNo");
	var error_msg =  packet.data.findValueByName("sErrorMessage");
	var verifyType = packet.data.findValueByName("verifyType");
	var return_msg = packet.data.findValueByName("return_msg");
	var tmpObj="";
	var i=0;
	var j=0;
	var ret_code=0;
	var tmpstr="";
		
	//alert("111111111111111111111111" +error_code ); 
	//alert("111111111111111111111111" +error_msg ); 
	//alert("111111111111111111111111----------"+ return_msg ); 
	
	ret_code =  parseInt(error_code);
	//alert("ret_code="+ret_code);
	//alert("ret_code="+ret_code);
	
	if( ret_code == 0 )
	{	
		//alert("ifififif");
		tmpstr = return_msg.length;
		//alert("tmpstr="+tmpstr);
		if(tmpstr!=0){
			rdShowMessageDialog("��У����"+return_msg+"!",0);
			rdShowMessageDialog("���������뿨��!");
			document.form.comp.disabled=true;
			return false;		
		}else{
			rdShowMessageDialog("У��ɹ�",2);
			document.form.comp.disabled=false;
		}

	}else{
		//alert("elseelse");
		rdShowMessageDialog("У����������Ϣ:["+error_code+"]"+error_msg+"!",0);
		document.form.comp.disabled=true;
		return false;				
	}
}
function query2()
  {
     if(document.form.billdate.value=="")
     {
      rdShowMessageDialog("�������ڲ���Ϊ��!<br>������YYYYMMDD��ʽ�����ڣ�");
      document.form.billdate.focus();
	  return false;
     }
	 else
      if(document.form.optype.value=="2"&&document.form.water_number.value=="")
       { 
		   rdShowMessageDialog("��ֵ�����˵���ˮ�Ų���Ϊ�գ�");
		   
           document.form.water_number.focus();
		   return false;
         }
    else
      if(document.form.card_price.value=="0")
         {
           rdShowMessageDialog("��ֵ����Ϊ�գ���˲�2!");
           
           document.form.card_price.focus();
		   return false;
         }
    else
      if(document.form.real_price.value=="")
         {
           rdShowMessageDialog("ʵ�۲���Ϊ�գ���˲�2!");
          
           document.form.real_price.select();
		   return false;
         }
	else
      if(document.form.card_number.value=="")
         {
           rdShowMessageDialog("����������Ϊ�գ���˲�2!");
          
           document.form.card_number.select();
		   return false;
         }
	else
      if(parseInt(document.form.card_number.value,10)<=0)
         {
           rdShowMessageDialog("�������������0����˲�!");
          
           document.form.card_number.select();
		   return false;
         }	

	else{
    		
		 document.form.sure.disabled=false;
		 return true;
       }
      
  }
  
function query()
{

if (typeof(form.real_price.length) == "undefined" || parseInt(form.lines.value)==1){
	if (query2())
	return true;
	else {
		document.form.sure.disabled=true;
		return false;
		}
}else{
	for (var i=0;i< document.form.real_price.length;i++) {
		for (var j=i+1;j< document.form.real_price.length;j++) {
		if (document.form.card_price[i].value==document.form.card_price[j].value)
		       {   rdShowMessageDialog("ͬһ�ֿ�����ֻ����һ�У�");
      			  document.form.card_price[j].focus();
				  document.form.sure.disabled=true;
				  return false; }   
		}
		}
	
     for (var i=0;i< document.form.real_price.length;i++) {   
      if(document.form.billdate.value=="")
     {
      rdShowMessageDialog("�������ڲ���Ϊ��!<br>������YYYYMMDD��ʽ�����ڣ�");
      document.form.billdate.focus();
	  document.form.sure.disabled=true;
	  return false;
     }
	 else
      if(document.form.optype.value=="2"&&document.form.water_number.value=="")
       { 
		   rdShowMessageDialog("��ֵ�����˵���ˮ�Ų���Ϊ�գ�");
           document.form.water_number.focus();
		   document.form.sure.disabled=true;
		   return false;
         }
    else
      if(document.form.card_price[i].value=="0")
         {
           rdShowMessageDialog("��ֵ����Ϊ�գ���˲�!");
           document.form.card_price[i].focus();
		   document.form.sure.disabled=true;
		   return false;
         }
    else
      if(document.form.real_price[i].value=="")
         {
           rdShowMessageDialog("ʵ�۲���Ϊ�գ���˲�!");
           document.form.real_price[i].select();
		   document.form.sure.disabled=true;
		   return false;
         }
	else
      if(document.form.card_number[i].value=="")
         {
           rdShowMessageDialog("����������Ϊ�գ���˲�!");
           document.form.card_number[i].select();
		   document.form.sure.disabled=true;
		   return false;
         }
	else
      if(parseInt(document.form.card_number[i].value,10)<=0)
         {
           rdShowMessageDialog("�������������0����˲�!");
           document.form.card_number[i].select();
		   document.form.sure.disabled=true;
		   return false;
         }
     
         	
    }
		 return true;
     }
     
  }
  
function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else 
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('���������븺ֵ,����������!');
		    return false;
		}
		else
			  return false;
    }       
}
function check_fee2()
{
   var v_fee = document.form.real_price.value;  
   var pay_message="ʵ�۽���С��0!"; 
   var null_message="ʵ�۽���Ϊ��!"; 
   var NaN_message="ʵ�۽��ӦΪ������!"; 
   var pos;

   if(v_fee == null || v_fee == "") 
   {        
	    rdShowMessageDialog(null_message); 
	    document.form.real_price.select(); 
		return false; 
   }        
   if(isNaN(parseFloat(v_fee)))   
   {        
		rdShowMessageDialog(NaN_message); 
	    document.form.real_price.select(); 
	    return false; 
   }
   if(v_fee>9999999999.99)
   {
		rdShowMessageDialog("ʵ�۽��ܴ���9999999999.99");
		document.form.real_price.select(); 
		return false;
   }
   pos=v_fee.indexOf(".");
   if(pos!=-1)
   {
		if(pos>10)
		{
			rdShowMessageDialog("ʵ�۽��С����ǰ���ܴ���10λ��");
			document.form.real_price.select(); 
			return false;
		}
		if(v_fee.length-pos>3)
		{
			rdShowMessageDialog("ʵ�۽��С������ܴ���2λ��");
			document.form.real_price.select(); 
			return false;
		}
   }
   else
   {
		if(v_fee.length>10)
		{
			rdShowMessageDialog("ʵ�۽��С����ǰ���ܴ���10λ��");
			document.form.real_price.select(); 
			return false;
		}
   }
   
document.form.action="s1330_2.jsp";
form.submit();
form.comp.disabled=true;
form.sure.disabled=true;
form.reset.disabled=true;
}
  
function check_fee()
{
	getAfterPrompt();
	if (typeof(document.form.real_price.length)=="undefined" || parseInt(form.lines.value)==1){
	if (check_fee2()) {
	form.comp.disabled=true;
	form.sure.disabled=true;
	document.form.action="s1330_2.jsp";
	form.submit();
	return true; }
	else {
		form.sure.disabled=true;
		return false; }
	}else {
   for (var i=0;i< document.form.real_price.length;i++) {
   
   var v_fee = document.form.real_price[i].value;  
   var pay_message="ʵ�۽���С��0!"; 
   var null_message="ʵ�۽���Ϊ��!"; 
   var NaN_message="ʵ�۽��ӦΪ������!"; 
   var pos;

   if(v_fee == null || v_fee == "") 
   {        
	    rdShowMessageDialog(null_message); 
	    document.form.real_price[i].select(); 
		form.sure.disabled=true;
		return false; 
   }        
   if(isNaN(parseFloat(v_fee)))   
   {        
		rdShowMessageDialog(NaN_message); 
	    document.form.real_price[i].select(); 
	    form.sure.disabled=true;
	    return false; 
   }
   if(v_fee>9999999999.99)
   {
		rdShowMessageDialog("ʵ�۽��ܴ���9999999999.99");
		document.form.real_price[i].select(); 
		form.sure.disabled=true;
		return false;
   }
   pos=v_fee.indexOf(".");
   if(pos!=-1)
   {
		if(pos>10)
		{
			rdShowMessageDialog("ʵ�۽��С����ǰ���ܴ���10λ��");
			document.form.real_price[i].select(); 
			form.sure.disabled=true;
			return false;
		}
		if(v_fee.length-pos>3)
		{
			rdShowMessageDialog("ʵ�۽��С������ܴ���2λ��");
			document.form.real_price[i].select(); 
			form.sure.disabled=true;
			return false;
		}
   }
   else
   {
		if(v_fee.length>10)
		{
			rdShowMessageDialog("ʵ�۽��С����ǰ���ܴ���10λ��");
			document.form.real_price[i].select(); 
			form.sure.disabled=true;
			return false;
		}
   }
  }//end for 
form.comp.disabled=true;
form.sure.disabled=true;
form.reset.disabled=true;
document.form.action="s1330_2.jsp";
form.submit();
}
}
function compsum2()
{
	dynDelRow2();
	//Ӧ�պϼ�
	form.should_sum.value=
	parseFloat(form.card_price.value.substring(2),10)*parseInt(form.card_number.value,10)
	//ʵ��
	form.real_income.value=
	parseFloat(form.real_price.value,10)*parseInt(form.card_number.value,10)
	
	form.card_end_no.value = genEndCardNo(form.card_begin_no.value,form.card_number.value);
	
	//�ܼƽ���ж�
	form.infilling_number.value=form.card_number.value;
	form.infilling_price.value=form.should_sum.value;
	form.infilling_income.value=form.real_income.value;
	//ʵ�ս���ж�
	if (parseInt(form.real_income.value)>parseInt(form.should_sum.value))
	{
		rdShowMessageDialog("ʵ��ӦС��Ӧ�պϼ�,��˲�ʵ�۽��!");
	          
	           document.form.real_price.select();
			   document.form.real_price.value="";
			   return false;
	}
	if (form.infilling_number.value==""||form.infilling_price.value==""||form.infilling_income.value=="" ||
		isNaN(form.infilling_number.value)||isNaN(form.infilling_price.value)||isNaN(form.infilling_income.value))
	{
			rdShowMessageDialog("��������������˲飡");
			return false;
			}
	else
	{
	/* wangmei delete 20060331
	if(document.form.card_price.value.substring(0,2)=="f0")
      	{
		rdShowMessageDialog("������꿨"+document.form.card_number.value+"��:Ӧ���͵������"+document.form.card_number.value+"��");
			
      
      }
    
	 form.sure.disabled=false;	
	 return true;
	*/
	}
}

function compsum()
{
if ( parseInt(form.lines.value)==1){
	if (compsum2())
	{
		return true;
	}
	else
	{
		return false;
	}
}
else
{
	var infilling_number = 0;
	var infilling_price = 0;
	var infilling_income = 0;
	for (var i=0;i< document.form.real_price.length;i++) {
		//Ӧ�պϼ�
		form.should_sum[i].value=
		parseFloat(form.card_price[i].value.substring(2),10)*parseInt(form.card_number[i].value,10)
		//ʵ��
		form.real_income[i].value=
		parseFloat(form.real_price[i].value,10)*parseInt(form.card_number[i].value,10)
		
		//��������
		form.card_end_no[i].value = genEndCardNo(form.card_begin_no[i].value,form.card_number[i].value);
	
		//ʵ�ս���ж�
		if (parseInt(form.real_income[i].value)>parseInt(form.should_sum[i].value))
		{
			rdShowMessageDialog("ʵ��ӦС��Ӧ�պϼ�,��˲�ʵ�۽��!");
		    document.form.real_price[i].select();
			document.form.real_price[i].value="";
			return false;
		}
	/* wangmei delete 20060331
	 if(document.form.card_price[i].value.substring(0,2)=="f0")
	      	{
			rdShowMessageDialog("������꿨"+document.form.card_number[i].value+"��:Ӧ���͵������"+document.form.card_number[i].value+"��");
				
	      
	      }
	*/
		infilling_number = infilling_number +parseInt(form.card_number[i].value);
		infilling_price = infilling_price+parseFloat(form.should_sum[i].value);
		infilling_income = infilling_income+parseFloat(form.real_income[i].value);
	}//end for

	//�ܼƽ���ж�
	form.infilling_number.value=infilling_number
	form.infilling_price.value=infilling_price
	form.infilling_income.value=infilling_income
	if (form.infilling_number.value==""||form.infilling_price.value==""||form.infilling_income.value=="" ||
		isNaN(form.infilling_number.value)||isNaN(form.infilling_price.value)||isNaN(form.infilling_income.value))
	{
		rdShowMessageDialog("��������������˲飡");
		return false;
	}
	else
	{   
		form.sure.disabled=false;
		return true;
	}
} //end of else
} //end of function

function change(a) { 
			
	var h=480;
	var w=650;
	var str;
	var bb=form.lines.value;
	var aa=parseInt(a.parentElement.parentElement.parentElement.rowIndex)-1;
	var store_type;
	if (parseInt(bb) > 1) {
		if (document.form.card_price[aa].value=="0"){ document.form.real_price[aa].value="";return false;}	
	}
	else {
		if (document.form.card_price.value=="0"){ document.form.real_price.value="";return false;}
	}
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	if (parseInt(bb) > 1){
		str=window.showModalDialog('getprice.jsp?regioncode=<%=regioncode%>&card_price='+document.form.card_price[aa].value,"",prop);
		
	}else{ 
		str=window.showModalDialog('getprice.jsp?regioncode=<%=regioncode%>&card_price='+document.form.card_price.value,"",prop);
	}
	if( typeof(str) != "undefined" ){
		if (parseInt(str)==0)
	   		rdShowMessageDialog("û���ҵ���Ӧ��ʵ�ۣ�",0);
	   	else
	   		if (parseInt(bb) >1)
			document.form.real_price[aa].value = str;
			else 
			document.form.real_price.value = str;
	}
	
	if (parseInt(bb) > 1){
		for (var i=0;i<parseInt(bb);i++) {
			//alert("i="+i);
			if (document.form.card_price[i].value.substring(0,1)=="k")
			{  
				rdShowMessageDialog("���۲�����������ֻ������һ�����ۼ�¼��������ѡ�����۵Ŀ����ͣ���");   
				dynDelRow();
				document.form.inp.disabled = true;
				document.form.card_check.disabled=false;
				document.form.comp.disabled=true;
			}else{
				document.form.card_check[i].disabled=true;
				document.form.comp.disabled=false;
				document.form.inp.disabled = false;

			}
		}
	}else{
		if (document.form.card_price.value.substring(0,1)=="k")
		{  
			document.form.inp.disabled = true;
			document.form.comp.disabled=true;
			document.form.card_check.disabled=false;
		}else{
			document.form.inp.disabled = false;
			document.form.comp.disabled=false;
			document.form.card_check.disabled=true;
		}
	}
}

function genEndCardNo(beginNo,CardNum)
{
	var card_head="";
	var card_tail="";
	var card_head2="";
	var card_tail2="";
	
	//��λλ��ʼ��
	carry = 0;
	
	if(CardNum.length > 10)
	{
		alert("һ�����۵Ŀ���������");
		return "";
	}
	
	if(beginNo.length > 10 )
	{
		card_tail = beginNo.substring(beginNo.length-10,beginNo.length);
		card_head = beginNo.substring(0,beginNo.length-10);
	}
	else
	{
		card_head = "";
		card_tail = beginNo;
	}
	
	card_tail2 = calc(card_tail,CardNum,0);
	
	if(card_head != "")
	{
		card_head2 = calc(card_head,1,carry);
	}
	
	return card_head2+card_tail2;
}

function calc(beginNo,num,CarryFlag)
{
	var zeroNum=0;                            //��¼��ͷ0�ĸ���
	var beginLen=beginNo.length;              //��ʼ���ŵĳ���
	var endNo="";
	
	var nozeroBeginNo=beginNo;                //�����0��ͷ����ֵ
/*
	for(var i=0; i< beginLen; i++)
	{
		alert("["+i+"]["+document.all.beginNo.value.substring(i,i+1)+"]");
	}
*/
	for(zeroNum=0 ;(zeroNum < beginLen - 1) && beginNo.substring(zeroNum,zeroNum+1) == "0";zeroNum++)
	{
		nozeroBeginNo = beginNo.substring(zeroNum+1,beginLen);
	}
	
	endNo = parseInt(nozeroBeginNo) + parseInt(num) - 1 + CarryFlag;
	
	endNo = endNo.toString();
	
	//�н�λ
	if(endNo.substring(0,1) < nozeroBeginNo.substring(0,1) )
	{
		carry=1;
		endNo = endNo.substring(endNo.length-nozeroBeginNo.length,endNo.length);
	}
	
	if(zeroNum > 0)
	{
		endNo = beginNo.substring(0,zeroNum-1) + carry + endNo;
		carry = 0;
	}
	//document.all.endNo.value = endNo;
	return endNo;
}

function dynDelRow2(){
var bb=parseInt(form.lines.value);
if( bb<=1) 
           {
			rdShowMessageDialog("������ɣ���˲����ݣ���");   
			
	           return false;
          }
else {
	
	}
}
function dynDelRow(){
	var bb=parseInt(form.lines.value);
	if( bb<=1) 
    {
		rdShowMessageDialog("���һ�в���ɾ������");     
		return false;
    }
	else 
	{
		dyntb.deleteRow(); 
		document.form.inp.disabled=false;
		document.form.lines.value=bb-1;
		
	}
}

function dynAddRow(){
			form.lines.value=parseInt(form.lines.value)+1;
			var tr1=dyntb.insertRow();
	        tr1.id="tr";
	        tr1.insertCell().innerHTML = '<td> <div align=center><input type=button name=del_line size=4 value=�� onClick="dynDelRow()"></div></td>';
	        var tempCellStr = '<td><div align=center><select name=card_price class=button  onChange="change(this)"><option class=button value=0 selected></option>';
	        <%
	        int recordNum2=0;
	        try{
      		String [][] result = new String[][]{};
      		String sqlStr ="select store_type||store_money,store_type||'--'||store_name from sStoreType where store_type like '"+storetp+"%' and allow_flag=1 order by store_type";
      		//System.out.println(sqlStr);      		
      		//retArray = callView.s1330Query("2",sqlStr);
      		//recordNum2 = Integer.parseInt((String)retArray.get(0));
      		%>
      		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regioncode%>" outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1Temp" scope="end" />
			<%
		      		result = result1Temp;
		      		for(int i=0;i<result.length;i++){
		        		out.print("tempCellStr+='<option class=button value=" + result[i][0] + ">" + result[i][1] + "</option>';");
		      		}
		     	}catch(Exception e){
		       		//System.out.println("Call queryView Failed!");
		     	}          
			%>
			tempCellStr+='</select></div></td>';
			tr1.insertCell().innerHTML = tempCellStr;
            tr1.insertCell().innerHTML = '<td> <div align=center><input type=text name=real_price size=14 class=button  onKeyPress="return isKeyNumberdot(1)"></div></td>';
            tr1.insertCell().innerHTML = '<td> <div align=center><input type=text name=card_begin_no size=0 class=button maxlength=20 onKeyPress="return isKeyNumberdot(0)"></div></td>';
            tr1.insertCell().innerHTML = '<td> <div align=center><input type=text name=card_number size=6 class=button maxlength=5 onKeyPress="return isKeyNumberdot(0)"></div></td>';
            tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name=card_end_no size=20 class=button maxlength=20></div></td>';
            tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name=should_sum size=14 class=button></div></td><td>';
            tr1.insertCell().innerHTML = '<td> <div align=center><input type=text name=real_income size=14 class=button readonly></div></td>';
            tr1.insertCell().innerHTML = '<td> <div align=center><input type=button name=card_check  class="b_text" value=У�� disabled onClick="check_do(this)"  ></div></td>';
            if (parseInt(max_lines)<=parseInt(form.lines.value)){
				document.form.inp.disabled=true;
				}
}
var max_lines = <%=recordNum2%>;
function form_load1()
{
	form.sure.disabled=true;
	dynAddRow();
}
function gohome()
{
	document.location.replace("s1330.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
}
function doclear()
{
	document.location.replace("s1330_1.jsp?optype=<%=storetp1%>&opName=<%=opName%>");
}
function check_do(a)
{
	var bb=form.lines.value;
	var aa=parseInt(a.parentElement.parentElement.parentElement.rowIndex)-1;
	var begin_no = "";
	var	card_num = "";
	//alert("---aa = "+aa);
	//alert("ssssssss");
	if (parseInt(bb) > 1) {
		if (document.form.card_begin_no[aa].value==""||document.form.card_begin_no[aa].value.length!=13)
		{ 
			rdShowMessageDialog("��ʼ���ű������룬���ȱ���Ϊ13λ��");
			document.form.card_begin_no[aa].value="";
			document.form.card_begin_no[aa].focus();
			document.form.sure.disabled=true;
		    return false;
		}
		if (document.form.card_number[aa].value.length==0)
		{ 
			rdShowMessageDialog("�������������룡");
			document.form.card_number[aa].value="";
			document.form.card_number[aa].focus();
			document.form.sure.disabled=true;
		    return false;
		}
		
		begin_no = document.form.card_begin_no[aa].value;
		card_num = document.form.card_number[aa].value;
	}
	else {
		if (document.form.card_begin_no.value==""||document.form.card_begin_no.value.length!=13)
		{ 
			rdShowMessageDialog("��ʼ���ű������룬���ȱ���Ϊ13λ��");
			document.form.card_begin_no.value="";
			document.form.card_begin_no.focus();
			document.form.sure.disabled=true;
		    return false;
		}
		if (document.form.card_number.value.length==0)
		{ 
			rdShowMessageDialog("�������������룡");
			document.form.card_number.value="";
			document.form.card_number.focus();
			document.form.sure.disabled=true;
		    return false;
		}
		begin_no = document.form.card_begin_no.value;
		card_num = document.form.card_number.value;
	}
	document.form.comp.disabled=false;
	
	var myPacket = new AJAXPacket("CardCheck.jsp","У�������������Ϣ�����Ժ�......");
	myPacket.data.add("verifyType","1");
	myPacket.data.add("begin_no",begin_no);
	myPacket.data.add("card_num",card_num);
	core.ajax.sendPacket(myPacket);
	myPacket=null;		

}
// -->
</script>
</HEAD>
<BODY>
<FORM action="s1330_2.jsp" method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">������Ϣ</div>
		</div>
<input type="hidden" name="lines" value="0">
<input type="hidden" name="billdate" value="<%=dateStr%>">
<input type="hidden" name="opcode" value="<%=opcd%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="optype" value="1">

            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td class="blue">��������</td>
                <td>
      <% 
            try{
      		String [][] result = new String[][]{};
      		String sqlStr ="select op_name from sStoreTypeOp where store_type='"+storetp+"' and op_code='"+opcd+"' order by store_type";
      		//System.out.println(sqlStr);      		
      		//retArray = callView.s1330Query("1",sqlStr);
      %>
      		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regioncode%>" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2Temp" scope="end" />
      <%
      		//int recordNum = Integer.parseInt((String)retArray.get(0));
      		result = result2Temp;
      		for(int i=0;i<result.length;i++){
        		out.print(result[i][0]);
      		}
     	}catch(Exception e){
       		//System.out.println("Call queryView Failed!");
     	}          
%>
                </td>
                <td>����<%=orgcode%></td>
              </tr>
              </tbody> 
            </table>
      </div>
        <div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
            <table id="dyntb" cellspacing="0">
              <tbody> 
              <tr> 
                 <th>
                <input type="button" name="inp" class="b_text" id="inp" value="���" onClick="dynAddRow()">
            	</th>
                <th nowrap> 
                  <div align="center">��ֵ</div>
                </th>
                <th nowrap> 
                  <div align="center">ʵ��</div>
                </th>
                <th nowrap> 
                  <div align="center">��ʼ����</div>
                </th>
                <th nowrap> 
                  <div align="center">������</div>
                </th>
                <th nowrap> 
                  <div align="center">��������</div>
                </th>
                <th nowrap> 
                  <div align="center">Ӧ�պϼ�</div>
                </th>
                <th nowrap> 
                  <div align="center">ʵ��</div>
                </th>
				<th nowrap> 
                  <div align="center">У��</div>
                </th>
               	
              </tr>
              </tbody> 
            </table>
            
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">������Ϣ</div>
</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td> 
                    <div align="center">��ֵ�������� 
                      <input type="text" readonly name="infilling_number" size="14" class="InputGrey">
                    </div>
                  </td>
                  <td> 
                    <div align="center">��ֵ������ֵ 
                      <input type="text" readonly name="infilling_price" size="14" class="InputGrey">
                    </div>
                  </td>
                  <td> 
                    <div align="center">��ֵ����ʵ�� 
                      <input type="text" readonly name="infilling_income" size="14" class="InputGrey">
                    </div>
                  </td>
                </tr>
                </tbody> 
              </table>
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td id="footer"> 
                  <input class="b_foot" name="comp" type=button value=���� onclick="if(query()) if(compsum());">
				  <input class="b_foot" name="clear" type=reset value=��� onclick="doclear()">
                  <input class="b_foot" name="sure" type=button value=ȷ��  onclick="if(query()) if(check_fee());">
				  <input class="b_foot" name="reset" type=button value=���� onClick="gohome()">
                </td>
              </tr>
              </tbody> 
            </table>
          <%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</BODY></HTML>
