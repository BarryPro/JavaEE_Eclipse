<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>

<%
	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               //��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String workno = baseInfo[0][2]; 
	String workname = baseInfo[0][3]; 
	

	
	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //��½����
	
	String op_name = "�ʵ�ģ��";
	
	Logger logger = Logger.getLogger("makeModual.jsp");

//�õ�ҳ�����
	String result2 [][]= new String[][]{};				//2	ģ������
	String result3 [][]=new String[][]{};					//3	ģ��������
	String result4 [][] = new String[][]{};				//4	��ʾID
	String result5 [][]= new String[][]{};				//5	��ʾ���к�
	String result6 [][]=new String[][]{};					//6	��ʾ����
	String result7 [][] = new String[][]{};				//7	��ʾ����
	String result8 [][]= new String[][]{};				//8	��ʾ����
	String result9 [][]=new String[][]{};					//9	�����С
	String result10 [][] = new String[][]{};			//10	��ʾ����
	String result11 [][]= new String[][]{};				//11	������ʶ
	String result12 [][]=new String[][]{};				//12	����ģ���
	String result13 [][] = new String[][]{};			//13	�ֶ�����
	String result14 [][]= new String[][]{};				//14	��ֵ��̬��־
	String result15 [][]=new String[][]{};				//15	��ƫ����
	String result16 [][] = new String[][]{};			//16	��ƫ����
	String result17 [][]= new String[][]{};				//17	��̬����ʶ
	String result18 [][]=new String[][]{};				//18	��̬��ID
	String result19 [][] = new String[][]{};			//19	��̬��ID
	String result20 [][]= new String[][]{};				//20	��С������ֵ
	String result21 [][]=new String[][]{};				//21	��С������ֵ
	String result22 [][] = new String[][]{};			//22	���������
	String result23 [][]= new String[][]{};				//23	���������
	String result24 [][]= new String[][]{};				//24	������
	
	String action=request.getParameter("action");//�ύ����ҳ��
	
	int nextFlag=1;
	
	String sqlStr = "";
	
	String show_mode = "";
	String modetype="";
	String region="";
	String[][] colNameArr  = new String[][]{};//�ֶ������б�

	if (action!=null&&action.equals("select")){
	
			show_mode = request.getParameter("show_mode");//ģ����
			modetype = request.getParameter("modetype");//ģ������
			region=request.getParameter("region");
			SPubCallSvrImpl callView = new SPubCallSvrImpl();
		 	String paramsIn[] = new String[2];
		 	
		 	paramsIn[0]=show_mode;
			paramsIn[1]=modetype;
			 	
			ArrayList acceptList = new ArrayList();
				   
			acceptList = callView.callFXService("sQueryShowMode2", paramsIn, "25");
			callView.printRetValue();
			
			int errCode = callView.getErrCode();
			String errMsg = callView.getErrMsg();
		
			if(errCode == 139785)
			{
				%>        
			    <script language=javascript>
			    	if(confirm("����û�д��ʵ�ģ�壬�Ƿ��½���")) 
			    	{
			    		var returnValue =window.showModalDialog("addDeModual.jsp?show_mode=<%=show_mode%>&modetype=<%=modetype%>&region=<%=region%>","","dialogHeight:160px; dialogWidth:300px; status:no; help:no; scroll:no");
			    	  if(returnValue="confirm")
			    	  {
			    	  	 	document.location.href="queryDeModual.jsp";
			    	  	}
			    	 	document.location.href ="makeDeModual.jsp?action=select&show_mode=<%=show_mode%>&modetype=<%=modetype%>";
			   	 	}
		      </script>
		         
				<% 
				
			}	
			
			if(errCode == 139786)
			{
				%>        
			    <script language=javascript>
			       rdShowMessageDialog("��ģ�����ѱ�ռ��,���������룡" ,0);
			       history.go(-1);
		      </script> 
		         
				<%  
			}	
			
			if(errCode !=0&&errCode!=139785&&errCode!=139786)
			{
				%>        
			    <script language='jscript'>
			       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			       history.go(-1);
		      </script> 
		         
				<%  
			}			
		
			if(errCode == 0)
			{
				nextFlag = 2;
				
				result2 	= (String[][])acceptList.get(2);
				result3  	= (String[][])acceptList.get(3);
				result4 	= (String[][])acceptList.get(4);
				result5 	= (String[][])acceptList.get(5);
				result6 	= (String[][])acceptList.get(6);
				result7 	= (String[][])acceptList.get(7);
				result8 	= (String[][])acceptList.get(8);
				result9 	= (String[][])acceptList.get(9);
				result10	= (String[][])acceptList.get(10);
				result11  = (String[][])acceptList.get(11);
				result12	= (String[][])acceptList.get(12);
				result13	= (String[][])acceptList.get(13);
				result14	= (String[][])acceptList.get(14);
				result15	= (String[][])acceptList.get(15);
				result16  = (String[][])acceptList.get(16);
				result17	= (String[][])acceptList.get(17);
				result18	= (String[][])acceptList.get(18);
				result19	= (String[][])acceptList.get(19);
				result20	= (String[][])acceptList.get(20);
				result21	= (String[][])acceptList.get(21);
				result22	= (String[][])acceptList.get(22);
				result23	= (String[][])acceptList.get(23);
				result24	= (String[][])acceptList.get(24);
				
				//System.out.println("aaaaaaaaaaaaaaaaaaa");
				//System.out.println("result20[0][0]="+result20[0][0]);
				
				//��ѯ�ֶ������б�dDefineCol
				sqlStr= "select col_name,trim(col_attr)||'->'||trim(col_note) from dDefineCol where func_name like 'cust%' ";
						
			//	colNameArr = (String[][])callView.sPubSelect("2",sqlStr).get(0);
				 %>
		<wtc:pubselect name="TlsPubSelBoss"  outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="colNameArr1" scope="end" />
             <%
			               colNameArr=colNameArr1;
			} // end if(errCode == 0)
		
		}//end if (action!=null&&action.equals("select"))
	%>	
	
<html>
<head>
<base target="_self">
<title>����ģ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">

<script type="text/javascript" src="../../js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script language=javascript>

 function doQuery()
	{
		if(!check(form))
		return false;
		
		if(document.form.show_mode.value.length<8)
		{
			rdShowMessageDialog("ģ����ӦΪ8λ��",0);
			return false;
		}
		document.form.action = "makeDeModual.jsp?action=select";
		document.form.submit(); 
	}

<%
	if (nextFlag==2){
	%>
	core.loadUnit("rpccore");
	onload=function()
	{
		<%
		for(int i=0;i<result4.length;i++)
		{
			if(result11[i][0].equals("1"))
			{
		%>
		var i = <%=i%>;
		var col_name_td='col_name_td'+i;
		document.all[eval('col_name_td')].style.display="none";
		<%}
		}%>
		core.rpc.onreceive = doProcess;//Ϊfunction()��������������
	}
	
	//---------------------------��ȡrpc���ص��û���Ϣ--------------------------------
	function doProcess(myPacket)
	{
		var errCode    = myPacket.data.findValueByName("errCode");
		var retMessage = myPacket.data.findValueByName("errMsg");//�������ص���Ϣ
		var retFlag    = myPacket.data.findValueByName("retFlag");
				
		if (errCode==000000)
		{  
			if(retFlag=="mod")
			{			
				rdShowMessageDialog("�����ɹ���");
				//window.location.reload();
			}
			else if(retFlag=="add")
			{			
				rdShowMessageDialog("�����ɹ���");
				document.location.href ="makeDeModual.jsp?action=select&show_mode=<%=show_mode%>&modetype=<%=modetype%>";
			}
			else if(retFlag=="del")
			{			
				rdShowMessageDialog("�����ɹ���");
				var currRowIndex    = myPacket.data.findValueByName("currRowIndex");
				dyntb.deleteRow(currRowIndex);  
			}
			
		}
		
		//-----������ش������-----
		if(errCode!=000000)
		{
			rdShowMessageDialog(retMessage);	
		}
	}

	var addflag = <%=result4.length%>;
	
	function dynAddRow(){
			
			var show_name = 'show_name'+addflag;
			var line = 'line'+addflag;
			var list = 'list'+addflag;
			var font_num = 'font_num'+addflag;
			var var_flag = 'var_flag'+addflag;
			var col_name = 'col_name'+addflag;
			var col_name_td = 'col_name_td'+addflag;
			
			var tr1=dyntb.insertRow();
	        tr1.id="tr";
	        tr1.bgcolor="#ffffff";
	        tr1.align="center";
	        tr1.insertCell().innerHTML = '<td><input type=button class=button style=cursor:hand name=modbutton maxlength=10 value=����  onClick=addRow('+addflag+')>&nbsp;&nbsp;<input type=button class=button style=cursor:hand name=delbutton maxlength=10 value=ɾ��  onClick=dynDelRow(this,'+addflag+')></td>';
	 				tr1.insertCell().innerHTML = '<td><input type=text disabled size=25 name='+show_name+' maxlength=256 value= ></td>';
	 				tr1.insertCell().innerHTML = '<td><input type=text  size=5 v_name="����" v_type="int" name='+line+' maxlength=5 value=  ></td>';
	 				tr1.insertCell().innerHTML = '<td><input type=text  size=5 v_name="����" v_type="int" name='+list+' maxlength=5 value= ></td>';
	 				tr1.insertCell().innerHTML = '<td><select name='+font_num+'><%for(int z=6;z<13;z++){%><option value = "<%=z%>" ><%=z%></option><%}%><option value =20 >20</option></select></td>';
	 				tr1.insertCell().innerHTML = '<td><select name='+var_flag+' onchange=changeColName('+addflag+')><option value=0>��̬</option><option value=1 >��̬</option></select></td>';
	 				tr1.insertCell().innerHTML = '<div id='+col_name_td+' ><td  style=display:none>	<select name='+col_name+' ><option></option> <%for(int j = 0;j<colNameArr.length;j++){out.print("<option value="+colNameArr[j][0]+">" );out.print(colNameArr[j][1].trim());out.print("</option>");}%></select></td></div>';
	addflag++;
	}
		 
		
	function dynDelRow(){
		
		if(confirm("ȷ��ɾ��?"))
		{
			//��ҳ��ɾ
			var args=dynDelRow.arguments[0];
			var objTD =args.parentElement;
			var objTR =objTD.parentElement;
			var currRowIndex = objTR.rowIndex;
			
			//������ɾ
			var i =dynDelRow.arguments[1];
			
			var show_id = 'show_id'+i;
			var show_name = 'show_name'+i;
			var col_name = 'col_name'+i;
			var line = 'line'+i;
			var list = 'list'+i;
			var font_num = 'font_num'+i;
			var var_flag = 'var_flag'+i;
			
			if(form[eval('show_id')]==undefined)	//ɾ���½��Ŀ���
			{
				rdShowMessageDialog("�����ɹ���");
				dyntb.deleteRow(currRowIndex);  
			}
			else{
			
			var myPacket = new RPCPacket("f2760Cfm_del_rpc.jsp?show_name="+form[eval('show_name')].value,"���ڻ����Ϣ�����Ժ�......");
			myPacket.data.add("workNo","<%=workNo%>");															//����                                           
			myPacket.data.add("nopass","<%=nopass%>");                             	//����                                           
			myPacket.data.add("org_code","<%=org_code%>");                          //��������                                       
			myPacket.data.add("op_code","2760");                        						//��������                                       
			myPacket.data.add("op_type","2");//add-0,mod-1,del-2                    ��������(���� '0' ,�޸� '1',ɾ�� '2')          
			                                                                                                           
			myPacket.data.add("show_id",form[eval('show_id')].value);                //��ʾID                                        
			myPacket.data.add("col_name",form[eval('col_name')].value);              //�ֶ�����                                                                                                         
			myPacket.data.add("line",form[eval('line')].value);                      //��ʾ����                                      
			myPacket.data.add("list",form[eval('list')].value);                      //��ʾ����                                      
			myPacket.data.add("font_num",form[eval('font_num')].value);              //�����С                                      
			myPacket.data.add("var_flag",form[eval('var_flag')].value);              //������ʶ                                      
			myPacket.data.add("show_mode",form.show_mode.value);                     //����ģ���                                    
	 		                                                                                                          
			myPacket.data.add("lenth","1");                    											 //��ʾ���� 	                                 
			myPacket.data.add("show_order","0");          													 //��ʾ���к�         
	 		myPacket.data.add("noval_flag","0");           												   // ��ֵ��̬��־                                 
	 		myPacket.data.add("line_off","0");             													 // ��ƫ����                                     
	 		myPacket.data.add("list_off","0");             												 	 // ��ƫ����    
			myPacket.data.add("dym_flag","1");             												   //��̬����ʶ 
			myPacket.data.add("dym_id","0");               													 //��̬ID  
		 	
		 	myPacket.data.add("currRowIndex",currRowIndex);													//������   
			core.rpc.sendPacket(myPacket);
			delete(myPacket);
			}
		}	
	}
		
	function addRow(){
		
		var i =addRow.arguments[0];
		
		var show_name = 'show_name'+i;
		var col_name = 'col_name'+i;
		var line = 'line'+i;
		var list = 'list'+i;
		var font_num = 'font_num'+i;
		var var_flag = 'var_flag'+i;
		
		//���������ڿ�ʼ���򣬽������������֮��
		var minline = "<%=result20[0][0]%>";
		var maxline = "<%=result22[0][0]%>";
		
		if(!forInt(form[eval('line')]))
		{
			return false;
		}
		
		if(!forInt(form[eval('list')]))
		{
			return false;
		}
		
		if(parseInt(form[eval('line')].value) > parseInt(minline) &&  parseInt(form[eval('line')].value) < parseInt(maxline))
		{
			rdShowMessageDialog("���������ڿ�ʼ���򣬽������������֮��",0);
			return false;
		}
		
		var myPacket = new RPCPacket("f2760Cfm_add_rpc.jsp?show_name="+form[eval('show_name')].value,"���ڻ����Ϣ�����Ժ�......");
		myPacket.data.add("workNo","<%=workNo%>");															 //����                                           
		myPacket.data.add("nopass","<%=nopass%>");                             	 //����                                           
		myPacket.data.add("org_code","<%=org_code%>");                           //��������                                       
		myPacket.data.add("op_code","2760");                       						   //��������                                       
		myPacket.data.add("op_type","0");//add-0,mod-1,del-2                     ��������(���� '0' ,�޸� '1',ɾ�� '2')          
		 
 		myPacket.data.add("col_name",form[eval('col_name')].value);              //�ֶ�����                                                                                                         
		myPacket.data.add("line",form[eval('line')].value);                      //��ʾ����                                      
		myPacket.data.add("list",form[eval('list')].value);                      //��ʾ����                                      
		myPacket.data.add("font_num",form[eval('font_num')].value);              //�����С                                      
		myPacket.data.add("var_flag",form[eval('var_flag')].value);              //������ʶ                                      
		myPacket.data.add("show_mode",form.show_mode.value);                     //����ģ���                                    
	 	                                                                                                          
		myPacket.data.add("lenth","1");                    											 //��ʾ���� 	                                 
		myPacket.data.add("show_order","0");          													 //��ʾ���к�         
	 	myPacket.data.add("noval_flag","0");           												   // ��ֵ��̬��־                                 
	 	myPacket.data.add("line_off","0");             													 // ��ƫ����                                     
	 	myPacket.data.add("list_off","0");             												 	 // ��ƫ����    
		myPacket.data.add("dym_flag","1");             												   //��̬����ʶ 
		myPacket.data.add("dym_id","0");               													 //��̬ID                                 
	 	core.rpc.sendPacket(myPacket);
		delete(myPacket);
	 		
	}
	
	
	function dynModRow(){
	
	var i = dynModRow.arguments[0];
	
	var show_id = 'show_id'+i;
	var show_name = 'show_name'+i;
	var col_name = 'col_name'+i;
	var line = 'line'+i;
	var list = 'list'+i;
	var font_num = 'font_num'+i;
	var var_flag = 'var_flag'+i;

	//���������ڿ�ʼ���򣬽������������֮��
		var minline = "<%=result20[0][0]%>";
		var maxline = "<%=result22[0][0]%>";
		
		if(!forInt(form[eval('line')]))
		{
			return false;
		}
		
		if(!forInt(form[eval('list')]))
		{
			return false;
		}
		
		if(parseInt(form[eval('line')].value) > parseInt(minline) &&  parseInt(form[eval('line')].value) < parseInt(maxline))
		{
			rdShowMessageDialog("���������ڿ�ʼ���򣬽������������֮��",0);
			return false;
		}
		
	var myPacket = new RPCPacket("f2760Cfm_mod_rpc.jsp?show_name="+form[eval('show_name')].value,"���ڻ����Ϣ�����Ժ�......");
	myPacket.data.add("workNo","<%=workNo%>");															//����                                           
	myPacket.data.add("nopass","<%=nopass%>");                             	//����                                           
	myPacket.data.add("org_code","<%=org_code%>");                          //��������                                       
	myPacket.data.add("op_code","2760");                        						//��������                                       
	myPacket.data.add("op_type","1");//add-0,mod-1,del-2                    ��������(���� '0' ,�޸� '1',ɾ�� '2')          
	                                                                                                           
	myPacket.data.add("show_id",form[eval('show_id')].value);                //��ʾID                                        
 	myPacket.data.add("col_name",form[eval('col_name')].value);              //�ֶ�����                                                                                                         
	myPacket.data.add("line",form[eval('line')].value);                      //��ʾ����                                      
	myPacket.data.add("list",form[eval('list')].value);                      //��ʾ����                                      
	myPacket.data.add("font_num",form[eval('font_num')].value);              //�����С                                      
	myPacket.data.add("var_flag",form[eval('var_flag')].value);              //������ʶ                                      
	myPacket.data.add("show_mode",form.show_mode.value);                     //����ģ���                                    
	                                                                                                          
	myPacket.data.add("lenth","1");                    											 //��ʾ���� 	                                 
	myPacket.data.add("show_order","0");          													 //��ʾ���к�         
	myPacket.data.add("noval_flag","0");           												   // ��ֵ��̬��־                                 
	myPacket.data.add("line_off","0");             													 // ��ƫ����                                     
	myPacket.data.add("list_off","0");             												 	 // ��ƫ����    
	myPacket.data.add("dym_flag","1");             												   //��̬����ʶ 
	myPacket.data.add("dym_id","0");               													 //��̬ID          
	core.rpc.sendPacket(myPacket);
	delete(myPacket);
	
	}
	 
	 function open_blank(str)
	 {
	 		var str = str;
	 		var str2 = form.show_mode.value;
	 		var win = window.open('f2760_dyn_main.jsp?dym_id='+str+'&show_mode='+str2,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	 }
	

	 
	 function print_xls()
	 {
	 	window.open('f2760_prtxls.jsp?show_mode=<%=show_mode%>');
	}
/*
	 function pre_print()
	 {
	 	window.open('f2760_print.jsp?show_mode=<%=show_mode%>');
	 }

	function print()
	 {
	 	window.open('f2760_print1.jsp?show_mode=<%=show_mode%>');
	 }
*/	 
	 function changeColName()
	 {
	 	var i = changeColName.arguments[0];
	 	var var_flag = 'var_flag'+i;
	 	var col_name_td = 'col_name_td'+i;
		var show_name = 'show_name'+i;
	 	var c = document.getElementById(col_name_td);
	 	
	 	if(form[eval('var_flag')].value=="0")//��̬
	 	{
	 		eval(c).style.display="";
	 		form[eval('show_name')].value="";
	 		form[eval('show_name')].disabled = true;
	 			
	 	}
		else//��̬
		{
			eval(c).style.display="none";
			form[eval('show_name')].disabled = false;
		}
	 }
	
	//��һ��
	function previouStep(){
		document.location.href="<%=request.getContextPath()%>/npage/s1351/queryDeModual.jsp";
	}
<%}%>
</script>

</head>

<body  text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
    
<form action="" name="form"  method="post">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
  <tr>
      <td background="<%=request.getContextPath()%>/images/jl_background_1.gif" bgcolor="#E8E8E8">
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" width="45%">
            <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">���ţ�<%=workno%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">����Ա��<%=workname%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
            <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                 <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>ģ�����</b></font></td>
                     <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
		<TABLE  width=98%  align="center"  bgcolor="#FFFFFF" cellspacing="1" border="0" >
		 <input type="hidden" name="op_code" value="2731">
		<input type="hidden" name="modetype" value="0">
		  <TR bgcolor="#F5F5F5" id="line_1" align="center"> 
		  
		  	<td>���У�</td>
         <td align="left" colspan="20"> 
               <select size="1" name="region" >
                <%
			
        sqlStr = "select to_char(region_code),region_name from sregioncode order by region_code";
                try
 				{
				  	%>
		<wtc:pubselect name="TlsPubSelBoss"  outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
	
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
         <%
				
				
					for(int i=0;i<result1.length;i++){
						out.print("<option class=button value=" + result1[i][0] + ">" + result1[i][1] + "</option>");
					}
				}catch(Exception e){
					//System.out.println("Call queryView Failed!");
				}
				%>
              </select>
         </td>
		  	 <td>ģ���ţ�</td>
         <td align="left" colspan="20"> 
             <input type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="ģ����"  name="show_mode" value="<%=show_mode%>" maxlength="8"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%>>
             <input class="button" name=sure22 type=button value=��ѯ onClick="doQuery();" style="cursor:hand" <%if(nextFlag==2){out.print("disabled");}%>>
         </td>
      </TR>
     
 
   <%
   if(nextFlag==2)//��ѯ����
   {
   %>
     <TR bgcolor="#F5F5F5" id="line_1" align="center"> 
     		 <TD>&nbsp;</TD>
     		 <TD align="left" colspan="20">&nbsp;</TD>      	
         <TD>ģ�����ƣ�</TD>
          <td align="left" colspan="20"> 
          	<input type="text"    name="mode_name" maxlength=14  <% if(nextFlag==2){out.println("value="+result2[0][0]);}%> readonly>
          </td>
      </TR>
      <!--
      <TR bgcolor="#F5F5F5" id="line_1" align="center">   	
         <TD width="40%" colspan="2">�ʵ�������</TD>
          <td align="left" colspan="20">
          	  <input type="text"   name="accout_rows" maxlength=14 <% if(nextFlag==2){out.println("value="+result3[0][0]);} %> readonly>
          </td>
      </TR>
      -->
 	</table>
 	 <TABLE width="100%" border="0"  cellspacing="1" id=dyntb  bgcolor="#F5F5F5" align="center">
     <TR bgcolor="#E8E8E8" id="line_1" align="center">       	
         <TD width="16%">����</TD>
         <TD width="16%">��ʾ����</TD>
         <TD width="10%">��</TD>
         <TD width="10%">��</TD>
         <TD width="10%">�����С</TD>
         <TD width="10%">������ʶ</TD>
         <TD width="16%">�ֶ�����</TD>
     </TR>
     
     <%
     for(int i=0;i<result4.length;i++)
     {
     %>
     <TR bgcolor="#F5F5F5" id="line_1"  align="center">  
          <TD align="center">
          	<input type="button" class="button" style="cursor:hand" name="modbutton" maxlength=10 value="�޸�"  onClick="dynModRow(<%=i%>)">&nbsp;
          	<input type="button" class="button" style="cursor:hand" name="delbutton" maxlength=10 value="ɾ��"  onClick="dynDelRow(this,<%=i%>)">
          </TD>
          	  <input type="hidden"   name="show_id<%=i%>" maxlength=10 value="<%=result4[i][0].trim()%>" >
          <TD align="center"> 
          	<%
          	if(result11[i][0].trim().equals("0"))
          	{%>
          	<input type="text"  size=25 name="show_name<%=i%>"  disabled>
          	<%
          	}
          else{
          	%>
         			<input type="text"  size=25 name="show_name<%=i%>" maxlength=256 value="<%=result6[i][0].trim()%>" >
          <%}%>
          </TD>
          <TD>
          	  <input type="text"   name="line<%=i%>" size=5 v_name="����" v_type="int" maxlength=5 value="<%=result7[i][0].trim()%>" >
          </TD>
          <TD>
          	  <input type="text"   name="list<%=i%>" size=5 v_name="����" v_type="int" maxlength=5 value="<%=result8[i][0].trim()%>" >
          </TD>
          <TD>
          	<select name=font_num<%=i%>>
		        		<%
		        		for(int z=6;z<13;z++)
		        		{
		        			if(result9[i][0].trim().equals(Integer.toString(z)))
		        			{	%>
		        			<option value = "<%=z%>" selected><%=z%></option>
		        		<%}
		        		else
		        			{%>
		        			<option value = "<%=z%>" ><%=z%></option>
		        		<%}%>
			        <%}
			        if((result9[i][0].trim().equals("20")))
			        {%>
			        <option value =20 selected>20</option>
			        <%}
			      else
			      	{%>
			      	<option value =20 >20</option>
			      	<%}%>
			      </select>	
          </TD>
          <TD>
          	<select name=var_flag<%=i%> onchange='changeColName(<%=i%>)'>
          		<option value='0' <%if(result11[i][0].trim().equals("0"))out.println("selected");%> >��̬</option>
							<option value='1' <%if(result11[i][0].trim().equals("1"))out.println("selected");%>>��̬</option>
          	</select>
          </TD>
          <TD align="left" id="col_name_td<%=i%>" style >
          	<select name="col_name<%=i%>">
          	<%	
          		out.println("<option></option>" );
          		for(int j = 0;j<colNameArr.length;j++)
          		{
          			
          			if(colNameArr[j][0].equals(result13[i][0].trim()))
          			{
          				out.println("<option value="+colNameArr[j][0]+" selected >" );
          			}
          			else{
          				out.println("<option value="+colNameArr[j][0]+">" );
          			}
          			out.println(colNameArr[j][1].trim());
          			out.println("</option>");
          		}
          	%>
          	</select>
          </TD>
         
     </TR>

      <%
      }//end for(int i=0;i<result4.length;i++)
      %>
     </TABLE>
     <TABLE width="100%" border=0 align=center cellpadding="4" cellSpacing=1>
     
   
       </TABLE>
		       <TABLE width="100%" border=0 align=center cellpadding="4" cellSpacing=1>
		          <TBODY>
		            <TR bgcolor="E8E8E8">
		              <TD align=center bgcolor="#EEEEEE">
		             <input class="button" name="previous" style="cursor:hand" type=button value="��һ��" onclick="previouStep()">&nbsp;&nbsp;
								 <input name="addbutton" class="button"  type=button value="����һ��" onclick="dynAddRow()" style="cursor:hand">&nbsp;&nbsp;
						<!-- 
								 <input name="printbutton" class="button"  type=button value="��ӡ" onclick="print()" style="cursor:hand">&nbsp;&nbsp;
								 <input class="button" name="previous"  type=button value="Ԥ��" onclick="pre_print()" style="cursor:hand">&nbsp; &nbsp;
						-->
						  
								 <input class="button" name="prtxls"  type=button value="Ԥ��" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
					       <input class="button" name="kkkk"  onClick="window.close()" type=button value="�� ��" style="cursor:hand">
		              </TD>
		            </TR>
		          </TBODY>
		       </TABLE>
<%
 }//end   if(nextFlag==2)    
%>

  <%
   if(nextFlag==1)//��ѯ����
   {
   %>
   				</TABLE>
		       <TABLE width="98%" border=0 align=center cellpadding="4" cellSpacing=0>
		          <TBODY>
		            <TR bgcolor="F5F5F5">
		              <TD align=center bgcolor="#F5F5F5">
		             <input class="button" name="previous" type=button value="���" onclick="form.reset()">&nbsp;&nbsp;
								 <input  class="button"  type=button value="�ر�" onclick="window.close()" style="cursor:hand">&nbsp;&nbsp;
		              </TD>
		            </TR>
		            
		          </TBODY>
		       </TABLE>
   <%}%>
  
  
 </form>
</body>
</html>

                                                                                                                                                               